package com.java2nb.novel.controller;

import com.java2nb.novel.core.config.AlipayProperties;
import com.java2nb.novel.core.enums.ResponseStatus;
import com.java2nb.novel.entity.OpenApiApp;
import com.java2nb.novel.entity.OpenApiOrder;
import com.java2nb.novel.mapper.OpenApiOrderMapper;
import com.java2nb.novel.openapi.OpenApiOrderResult;
import com.java2nb.novel.openapi.OpenApiPayRequest;
import com.java2nb.novel.openapi.OpenApiPayService;
import io.github.xxyopen.model.resp.RestResult;
import jakarta.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/openapi/pay")
@RequiredArgsConstructor
public class OpenApiPayController {

    private static final String ATTR_APP = "openapi_app";

    private final OpenApiPayService openApiPayService;
    private final OpenApiOrderMapper openApiOrderMapper;
    private final AlipayProperties alipayProperties;

    @PostMapping("/alipay/create")
    public RestResult<?> createAlipayOrder(
        @RequestParam("external_order_no") String externalOrderNo,
        @RequestParam("external_user_id") String externalUserId,
        @RequestParam(value = "alipay_user_id", required = false) String alipayUserId,
        @RequestParam(value = "alipay_account", required = false) String alipayAccount,
        @RequestParam(value = "alipay_real_name", required = false) String alipayRealName,
        @RequestParam("amount") Integer amount,
        @RequestParam("subject") String subject,
        @RequestParam(value = "body", required = false) String body,
        @RequestParam(value = "notify_url", required = false) String notifyUrl,
        @RequestParam(value = "return_url", required = false) String returnUrl,
        @RequestParam(value = "attach", required = false) String attach,
        @RequestParam(value = "type_index", required = false) String typeIndex,
        @RequestParam(value = "goods_type", required = false) String goodsType,
        HttpServletRequest request) {

        OpenApiApp app = (OpenApiApp) request.getAttribute(ATTR_APP);
        if (app == null) {
            return RestResult.fail(ResponseStatus.OPENAPI_AUTH_FAIL);
        }

        OpenApiPayRequest payRequest = new OpenApiPayRequest();
        payRequest.setExternalOrderNo(externalOrderNo);
        payRequest.setExternalUserId(externalUserId);
        payRequest.setAlipayUserId(alipayUserId);
        payRequest.setAlipayAccount(alipayAccount);
        payRequest.setAlipayRealName(alipayRealName);
        payRequest.setAmount(amount);
        payRequest.setSubject(subject);
        payRequest.setBody(body);
        payRequest.setNotifyUrl(notifyUrl);
        payRequest.setReturnUrl(returnUrl);
        payRequest.setAttach(attach);
        payRequest.setTypeIndex(typeIndex);
        payRequest.setGoodsType(goodsType);
        payRequest.setGatewayUrl(alipayProperties.getGatewayUrl());

        OpenApiOrderResult result = openApiPayService.createOrder(payRequest, app, resolveClientIp(request));
        return RestResult.ok(result);
    }

    @GetMapping("/order/query")
    public RestResult<?> queryOrder(@RequestParam("external_order_no") String externalOrderNo,
        HttpServletRequest request) {
        OpenApiApp app = (OpenApiApp) request.getAttribute(ATTR_APP);
        if (app == null) {
            return RestResult.fail(ResponseStatus.OPENAPI_AUTH_FAIL);
        }
        OpenApiOrder order = openApiOrderMapper.findByAppAndExternalOrderNo(app.getAppId(), externalOrderNo);
        if (order == null) {
            return RestResult.fail(ResponseStatus.OPENAPI_PARAM_ERROR);
        }
        Map<String, Object> data = new HashMap<>();
        data.put("order_no", String.valueOf(order.getOutTradeNo()));
        data.put("external_order_no", order.getExternalOrderNo());
        data.put("status", order.getStatus());
        data.put("amount", order.getAmount());
        return RestResult.ok(data);
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
}
