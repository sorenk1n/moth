package com.java2nb.novel.core.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.java2nb.novel.core.cache.CacheService;
import com.java2nb.novel.core.enums.ResponseStatus;
import com.java2nb.novel.core.utils.OpenApiSignUtil;
import com.java2nb.novel.entity.OpenApiApp;
import com.java2nb.novel.mapper.OpenApiAppMapper;
import io.github.xxyopen.model.resp.RestResult;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.Instant;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
@RequiredArgsConstructor
public class OpenApiAuthInterceptor implements HandlerInterceptor {

    private static final long TIMESTAMP_TOLERANCE_MS = 5 * 60 * 1000L;
    private static final long NONCE_TTL_SECONDS = 5 * 60L;
    private static final String ATTR_APP = "openapi_app";

    private final OpenApiAppMapper openApiAppMapper;
    private final CacheService cacheService;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
        throws Exception {
        String appId = getValue(request, "app_id");
        String timestamp = getValue(request, "timestamp");
        String nonce = getValue(request, "nonce");
        String sign = getValue(request, "sign");

        if (StringUtils.isAnyBlank(appId, timestamp, nonce, sign)) {
            writeError(response, ResponseStatus.OPENAPI_AUTH_FAIL, HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }

        OpenApiApp app = openApiAppMapper.findByAppId(appId);
        if (app == null || app.getStatus() == null || app.getStatus() != 1) {
            writeError(response, ResponseStatus.OPENAPI_APP_DISABLED, HttpServletResponse.SC_FORBIDDEN);
            return false;
        }

        if (!checkTimestamp(timestamp)) {
            writeError(response, ResponseStatus.OPENAPI_TIMESTAMP_EXPIRED, HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }

        if (!checkNonce(appId, nonce)) {
            writeError(response, ResponseStatus.OPENAPI_NONCE_REPLAY, 429);
            return false;
        }

        if (!checkIpWhitelist(app, resolveClientIp(request))) {
            writeError(response, ResponseStatus.OPENAPI_APP_DISABLED, HttpServletResponse.SC_FORBIDDEN);
            return false;
        }

        if (!checkRateLimit(appId, app)) {
            writeError(response, ResponseStatus.OPENAPI_RATE_LIMIT, 429);
            return false;
        }

        if (!verifySign(request, app.getAppSecret(), appId, timestamp, nonce, sign)) {
            writeError(response, ResponseStatus.OPENAPI_SIGN_ERROR, HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }

        request.setAttribute(ATTR_APP, app);
        return true;
    }

    private boolean verifySign(HttpServletRequest request, String secret, String appId, String timestamp,
        String nonce, String sign) {
        Map<String, String> params = new HashMap<>();
        request.getParameterMap().forEach((key, values) -> {
            if (values != null && values.length > 0) {
                params.put(key, values[0]);
            }
        });
        params.putIfAbsent("app_id", appId);
        params.putIfAbsent("timestamp", timestamp);
        params.putIfAbsent("nonce", nonce);
        params.remove("sign");
        String canonical = OpenApiSignUtil.buildCanonicalString(params);
        String expected = OpenApiSignUtil.hmacSha256(secret, canonical);
        return StringUtils.equalsIgnoreCase(expected, sign);
    }

    private boolean checkTimestamp(String timestamp) {
        long ts;
        try {
            ts = Long.parseLong(timestamp);
        } catch (NumberFormatException ex) {
            return false;
        }
        if (ts < 1000000000000L) {
            ts = ts * 1000L;
        }
        long now = Instant.now().toEpochMilli();
        return Math.abs(now - ts) <= TIMESTAMP_TOLERANCE_MS;
    }

    private boolean checkNonce(String appId, String nonce) {
        String key = "openapi:nonce:" + appId + ":" + nonce;
        if (cacheService.contains(key)) {
            return false;
        }
        cacheService.set(key, "1", NONCE_TTL_SECONDS);
        return true;
    }

    private boolean checkRateLimit(String appId, OpenApiApp app) {
        Integer maxQps = app.getMaxQps();
        if (maxQps != null && maxQps > 0) {
            String secondKey = "openapi:limit:qps:" + appId + ":" + Instant.now().getEpochSecond();
            int count = safeIncrement(secondKey, 2);
            if (count > maxQps) {
                return false;
            }
        }
        Integer dayLimit = app.getDayLimit();
        if (dayLimit != null && dayLimit > 0) {
            String day = LocalDate.now().format(DateTimeFormatter.BASIC_ISO_DATE);
            String dayKey = "openapi:limit:day:" + appId + ":" + day;
            int count = safeIncrement(dayKey, 2 * 24 * 3600);
            if (count > dayLimit) {
                return false;
            }
        }
        return true;
    }

    private int safeIncrement(String key, long ttlSeconds) {
        String value = cacheService.get(key);
        int count = 0;
        if (StringUtils.isNotBlank(value)) {
            try {
                count = Integer.parseInt(value);
            } catch (NumberFormatException ex) {
                count = 0;
            }
        }
        count += 1;
        cacheService.set(key, String.valueOf(count), ttlSeconds);
        return count;
    }

    private boolean checkIpWhitelist(OpenApiApp app, String clientIp) {
        String whitelist = StringUtils.trimToEmpty(app.getIpWhitelist());
        if (StringUtils.isBlank(whitelist)) {
            return true;
        }
        String[] ips = whitelist.split(",");
        for (String ip : ips) {
            if (StringUtils.equals(StringUtils.trim(ip), clientIp)) {
                return true;
            }
        }
        return false;
    }

    private String getValue(HttpServletRequest request, String key) {
        String value = request.getHeader(key);
        if (StringUtils.isBlank(value)) {
            value = request.getParameter(key);
        }
        return StringUtils.trimToNull(value);
    }

    private String resolveClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (StringUtils.isNotBlank(ip)) {
            return ip.split(",")[0].trim();
        }
        ip = request.getHeader("X-Real-IP");
        if (StringUtils.isNotBlank(ip)) {
            return ip.trim();
        }
        return request.getRemoteAddr();
    }

    private void writeError(HttpServletResponse response, ResponseStatus status, int httpStatus) throws Exception {
        response.setStatus(httpStatus);
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(objectMapper.writeValueAsString(RestResult.fail(status)));
        response.getWriter().flush();
    }
}
