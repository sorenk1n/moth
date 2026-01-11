package com.java2nb.novel.openapi;

import com.java2nb.novel.core.utils.OpenApiSignUtil;
import com.java2nb.novel.entity.OpenApiApp;
import com.java2nb.novel.entity.OpenApiNotifyTask;
import com.java2nb.novel.entity.OpenApiOrder;
import com.java2nb.novel.mapper.OpenApiAppMapper;
import com.java2nb.novel.mapper.OpenApiNotifyTaskMapper;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class OpenApiNotifyService {

    private final OpenApiNotifyTaskMapper notifyTaskMapper;
    private final OpenApiAppMapper openApiAppMapper;

    public OpenApiNotifyService(OpenApiNotifyTaskMapper notifyTaskMapper, OpenApiAppMapper openApiAppMapper) {
        this.notifyTaskMapper = notifyTaskMapper;
        this.openApiAppMapper = openApiAppMapper;
    }

    public void enqueue(OpenApiOrder order, OpenApiApp app, String tradeNo) {
        String notifyUrl = StringUtils.defaultIfBlank(order.getNotifyUrl(), app.getNotifyUrl());
        if (StringUtils.isBlank(notifyUrl)) {
            return;
        }
        OpenApiNotifyTask task = new OpenApiNotifyTask();
        task.setAppId(app.getAppId());
        task.setNotifyUrl(notifyUrl);
        task.setExternalOrderNo(order.getExternalOrderNo());
        task.setOutTradeNo(order.getOutTradeNo());
        task.setAmount(order.getAmount());
        task.setTradeNo(tradeNo);
        task.setAttach(order.getAttach());
        task.setStatus((byte) 0);
        task.setRetryCount(0);
        task.setMaxRetry(5);
        Date now = new Date();
        task.setNextRetryTime(now);
        task.setCreateTime(now);
        task.setUpdateTime(now);
        notifyTaskMapper.insert(task);
    }

    public void processDueTasks(int limit) {
        Date now = new Date();
        for (OpenApiNotifyTask task : notifyTaskMapper.findDueTasks(now, limit)) {
            if (notifyTaskMapper.markProcessing(task.getId(), now) == 0) {
                continue;
            }
            handleTask(task);
        }
    }

    private void handleTask(OpenApiNotifyTask task) {
        OpenApiApp app = openApiAppMapper.findByAppId(task.getAppId());
        if (app == null || app.getStatus() == null || app.getStatus() != 1) {
            markFailure(task, "app_disabled");
            return;
        }
        boolean success = sendOnce(task.getNotifyUrl(), task, app);
        if (success) {
            notifyTaskMapper.markSuccess(task.getId(), new Date());
        } else {
            markRetry(task, "notify_failed");
        }
    }

    private boolean sendOnce(String notifyUrl, OpenApiNotifyTask task, OpenApiApp app) {
        try {
            Map<String, String> payload = new HashMap<>();
            payload.put("app_id", app.getAppId());
            payload.put("external_order_no", task.getExternalOrderNo());
            payload.put("order_no", String.valueOf(task.getOutTradeNo()));
            payload.put("amount", String.valueOf(task.getAmount()));
            payload.put("trade_no", StringUtils.defaultString(task.getTradeNo()));
            payload.put("status", "1");
            payload.put("attach", StringUtils.defaultString(task.getAttach()));
            payload.put("timestamp", String.valueOf(System.currentTimeMillis()));
            payload.put("nonce", UUID.randomUUID().toString().replace("-", ""));
            String canonical = OpenApiSignUtil.buildCanonicalString(payload);
            payload.put("sign", OpenApiSignUtil.hmacSha256(app.getAppSecret(), canonical));

            String body = buildBody(payload);
            HttpClient client = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(10)).build();
            HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create(notifyUrl))
                .timeout(Duration.ofSeconds(30))
                .header("Content-Type", "application/x-www-form-urlencoded")
                .POST(HttpRequest.BodyPublishers.ofString(body))
                .build();
            HttpResponse<String> resp = client.send(req, HttpResponse.BodyHandlers.ofString());
            return resp.statusCode() >= 200 && resp.statusCode() < 300;
        } catch (Exception ex) {
            log.warn("openapi notify failed: {}", notifyUrl, ex);
            return false;
        }
    }

    private String buildBody(Map<String, String> params) {
        StringBuilder bodyBuilder = new StringBuilder();
        for (Map.Entry<String, String> entry : params.entrySet()) {
            if (bodyBuilder.length() > 0) {
                bodyBuilder.append("&");
            }
            bodyBuilder.append(urlEncode(entry.getKey())).append("=").append(urlEncode(entry.getValue()));
        }
        return bodyBuilder.toString();
    }

    private String urlEncode(String value) {
        try {
            return java.net.URLEncoder.encode(value, StandardCharsets.UTF_8.toString());
        } catch (Exception e) {
            return value;
        }
    }

    private void markRetry(OpenApiNotifyTask task, String error) {
        int retryCount = task.getRetryCount() == null ? 0 : task.getRetryCount();
        int maxRetry = task.getMaxRetry() == null ? 5 : task.getMaxRetry();
        retryCount += 1;
        task.setRetryCount(retryCount);
        task.setLastError(error);
        task.setStatus(retryCount >= maxRetry ? (byte) 3 : (byte) 0);
        task.setNextRetryTime(nextRetryTime(retryCount));
        notifyTaskMapper.updateRetry(task, new Date());
    }

    private void markFailure(OpenApiNotifyTask task, String error) {
        task.setLastError(error);
        task.setStatus((byte) 3);
        notifyTaskMapper.updateRetry(task, new Date());
    }

    private Date nextRetryTime(int retryCount) {
        int[] delays = {1, 5, 15, 30, 60};
        int index = Math.min(retryCount - 1, delays.length - 1);
        return new Date(System.currentTimeMillis() + delays[index] * 1000L);
    }
}
