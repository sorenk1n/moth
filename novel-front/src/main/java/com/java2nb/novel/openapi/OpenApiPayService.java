package com.java2nb.novel.openapi;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.java2nb.novel.core.enums.ResponseStatus;
import com.java2nb.novel.entity.OpenApiApp;
import com.java2nb.novel.entity.OpenApiOrder;
import com.java2nb.novel.entity.PayMerchant;
import com.java2nb.novel.entity.User;
import com.java2nb.novel.entity.UserExternalBind;
import com.java2nb.novel.mapper.FrontUserMapper;
import com.java2nb.novel.mapper.OpenApiOrderMapper;
import com.java2nb.novel.mapper.UserExternalBindMapper;
import com.java2nb.novel.service.OrderService;
import com.java2nb.novel.service.PayMerchantService;
import io.github.xxyopen.util.IdWorker;
import io.github.xxyopen.util.MD5Util;
import io.github.xxyopen.web.exception.BusinessException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.TreeMap;
import java.util.UUID;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class OpenApiPayService {

    public static final byte STATUS_CREATED = 0;
    public static final byte STATUS_PAID = 1;

    private final OpenApiOrderMapper openApiOrderMapper;
    private final UserExternalBindMapper userExternalBindMapper;
    private final PayMerchantService payMerchantService;
    private final OrderService orderService;
    private final FrontUserMapper userMapper;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final IdWorker idWorker = IdWorker.INSTANCE;

    public OpenApiOrderResult createOrder(OpenApiPayRequest request, OpenApiApp app, String clientIp) {
        if (StringUtils.isAnyBlank(request.getExternalOrderNo(), request.getExternalUserId(), request.getSubject())
            || request.getAmount() == null || request.getAmount() <= 0) {
            throw new BusinessException(ResponseStatus.OPENAPI_PARAM_ERROR);
        }

        OpenApiOrder existed = openApiOrderMapper.findByAppAndExternalOrderNo(app.getAppId(),
            request.getExternalOrderNo());
        if (existed != null) {
            return buildResult(existed);
        }

        Long userId = ensureUserBinding(app.getAppId(), request);

        Long outTradeNo = orderService.createPayOrder((byte) 1, request.getAmount(), userId);

        PayMerchant merchant = payMerchantService.getDefault();
        if (merchant == null || StringUtils.isAnyBlank(merchant.getMd5Key(), merchant.getAesKey())) {
            throw new BusinessException(ResponseStatus.OPENAPI_PARAM_ERROR);
        }

        String timeStamp = String.valueOf(System.currentTimeMillis());
        String visitAuth = buildVisitAuth(timeStamp, merchant.getMd5Key(), merchant.getAesKey());

        String externalId = Optional.ofNullable(merchant.getMerchantNo()).filter(StringUtils::isNotBlank)
            .orElse("888007");
        String typeIndex = StringUtils.defaultIfBlank(request.getTypeIndex(), "2");
        String goodsType = StringUtils.defaultIfBlank(request.getGoodsType(), "9");

        String notifyUrl = Optional.ofNullable(request.getNotifyUrl()).filter(StringUtils::isNotBlank)
            .orElse(app.getNotifyUrl());
        String returnUrl = Optional.ofNullable(request.getReturnUrl()).filter(StringUtils::isNotBlank)
            .orElse(app.getReturnUrl());

        Map<String, String> params = new TreeMap<>();
        params.put("merTradeNo", String.valueOf(outTradeNo));
        params.put("payMethodType", "ALIPAY_CN");
        params.put("typeIndex", typeIndex);
        params.put("externalId", externalId);
        if (StringUtils.isNotBlank(merchant.getGroupExternalId())) {
            params.put("groupExternalId", merchant.getGroupExternalId().trim());
        }
        BigDecimal amountYuan = BigDecimal.valueOf(request.getAmount()).movePointLeft(2);
        params.put("totalAmount", amountYuan.setScale(1, RoundingMode.HALF_UP).toPlainString());
        params.put("merSubject", request.getSubject());
        params.put("goodsType", goodsType);
        if (StringUtils.isNotBlank(notifyUrl)) {
            params.put("merPayNotifyUrl", notifyUrl);
        }
        if (StringUtils.isNotBlank(clientIp)) {
            params.put("clientIp", clientIp);
        }
        if (StringUtils.isNotBlank(returnUrl)) {
            params.put("returnUrl", returnUrl);
        }

        String sign = buildProviderSign(params, visitAuth, merchant.getAesKey());
        params.put("sign", sign);

        String body = buildFormBody(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("timeStamp", timeStamp);
        headers.put("visitAuth", visitAuth);

        OpenApiOrder order = new OpenApiOrder();
        order.setAppId(app.getAppId());
        order.setExternalOrderNo(request.getExternalOrderNo());
        order.setOutTradeNo(outTradeNo);
        order.setUserId(userId);
        order.setAmount(request.getAmount());
        order.setStatus(STATUS_CREATED);
        order.setNotifyUrl(notifyUrl);
        order.setReturnUrl(returnUrl);
        order.setAttach(request.getAttach());
        order.setGatewayUrl(request.getGatewayUrl());
        order.setPayBody(body);
        try {
            order.setPayHeaders(objectMapper.writeValueAsString(headers));
        } catch (Exception ex) {
            order.setPayHeaders("{}");
        }
        Date now = new Date();
        order.setCreateTime(now);
        order.setUpdateTime(now);
        openApiOrderMapper.insert(order);

        return buildResult(order);
    }

    private OpenApiOrderResult buildResult(OpenApiOrder order) {
        OpenApiOrderResult result = new OpenApiOrderResult();
        result.setOrderNo(String.valueOf(order.getOutTradeNo()));
        result.setExternalOrderNo(order.getExternalOrderNo());
        result.setStatus(order.getStatus() == STATUS_PAID ? "PAID" : "CREATED");
        result.setPayType("alipay");
        OpenApiOrderResult.PayData payData = new OpenApiOrderResult.PayData();
        payData.setGatewayUrl(StringUtils.defaultString(order.getGatewayUrl()));
        payData.setBody(StringUtils.defaultString(order.getPayBody()));
        try {
            @SuppressWarnings("unchecked")
            Map<String, String> headers = objectMapper.readValue(StringUtils.defaultString(order.getPayHeaders()),
                Map.class);
            payData.setHeaders(headers);
        } catch (Exception ex) {
            payData.setHeaders(new HashMap<>());
        }
        result.setPayData(payData);
        result.setUserId(order.getUserId());
        return result;
    }

    private Long ensureUserBinding(String appId, OpenApiPayRequest request) {
        String externalUserId = request.getExternalUserId();
        String alipayUserId = StringUtils.trimToNull(request.getAlipayUserId());
        String alipayAccount = StringUtils.trimToNull(request.getAlipayAccount());
        String alipayRealName = StringUtils.trimToNull(request.getAlipayRealName());

        UserExternalBind bind = userExternalBindMapper.findByAppAndExternalUserId(appId, externalUserId);
        if (bind != null) {
            if (StringUtils.isNotBlank(alipayUserId) && StringUtils.isNotBlank(bind.getAlipayUserId())
                && !StringUtils.equals(alipayUserId, bind.getAlipayUserId())) {
                throw new BusinessException(ResponseStatus.OPENAPI_ALIPAY_CONFLICT);
            }
            if (StringUtils.isNotBlank(alipayUserId) && StringUtils.isBlank(bind.getAlipayUserId())) {
                UserExternalBind conflict = userExternalBindMapper.findByAlipayUserId(alipayUserId);
                if (conflict != null && !conflict.getUserId().equals(bind.getUserId())) {
                    throw new BusinessException(ResponseStatus.OPENAPI_ALIPAY_CONFLICT);
                }
                bind.setAlipayUserId(alipayUserId);
                bind.setAlipayAccount(alipayAccount);
                bind.setAlipayRealName(alipayRealName);
                bind.setUpdateTime(new Date());
                userExternalBindMapper.updateAlipayInfo(bind);
            }
            return bind.getUserId();
        }

        if (StringUtils.isNotBlank(alipayUserId)) {
            UserExternalBind conflict = userExternalBindMapper.findByAlipayUserId(alipayUserId);
            if (conflict != null) {
                throw new BusinessException(ResponseStatus.OPENAPI_ALIPAY_CONFLICT);
            }
        }

        if (StringUtils.isNotBlank(alipayAccount)) {
            UserExternalBind accountBind = userExternalBindMapper.findByAlipayAccount(alipayAccount);
            if (accountBind != null) {
                return createBind(appId, externalUserId, accountBind.getUserId(), alipayUserId,
                    alipayAccount, alipayRealName);
            }
        }

        Long userId = createLocalUser(appId, externalUserId);
        createBind(appId, externalUserId, userId, alipayUserId, alipayAccount, alipayRealName);
        return userId;
    }

    private Long createLocalUser(String appId, String externalUserId) {
        User user = new User();
        Long id = idWorker.nextId();
        String username = "ext_" + DigestUtils.md5Hex(appId + ":" + externalUserId);
        user.setId(id);
        user.setUsername(username);
        user.setNickName("外部用户_" + username.substring(username.length() - 6));
        String randomPassword = UUID.randomUUID().toString();
        user.setPassword(MD5Util.MD5Encode(randomPassword, StandardCharsets.UTF_8.name()));
        Date now = new Date();
        user.setCreateTime(now);
        user.setUpdateTime(now);
        userMapper.insertSelective(user);
        return id;
    }

    private Long createBind(String appId, String externalUserId, Long userId, String alipayUserId,
        String alipayAccount, String alipayRealName) {
        UserExternalBind bind = new UserExternalBind();
        bind.setUserId(userId);
        bind.setExternalAppId(appId);
        bind.setExternalUserId(externalUserId);
        bind.setAlipayUserId(alipayUserId);
        bind.setAlipayAccount(alipayAccount);
        bind.setAlipayRealName(alipayRealName);
        Date now = new Date();
        bind.setCreateTime(now);
        bind.setUpdateTime(now);
        userExternalBindMapper.insert(bind);
        return userId;
    }

    private String buildVisitAuth(String timeStamp, String md5Key, String aesKey) {
        String md5 = DigestUtils.md5Hex(md5Key + ":" + timeStamp);
        return encryptAes(md5, aesKey);
    }

    private String encryptAes(String data, String key) {
        try {
            SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "AES");
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, keySpec);
            return Base64.getEncoder().encodeToString(cipher.doFinal(data.getBytes(StandardCharsets.UTF_8)));
        } catch (Exception ex) {
            throw new IllegalStateException("encrypt error", ex);
        }
    }

    private String buildProviderSign(Map<String, String> params, String visitAuth, String aesKey) {
        StringBuilder builder = new StringBuilder();
        for (Map.Entry<String, String> entry : params.entrySet()) {
            if (builder.length() > 0) {
                builder.append("&");
            }
            builder.append(entry.getKey()).append("=").append(entry.getValue());
        }
        String aesPrefix = StringUtils.defaultString(aesKey);
        if (aesPrefix.length() > 12) {
            aesPrefix = aesPrefix.substring(0, 12);
        }
        String raw = builder + StringUtils.defaultString(visitAuth) + aesPrefix;
        return DigestUtils.md5Hex(raw);
    }

    private String buildFormBody(Map<String, String> params) {
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
}
