package com.java2nb.novel.controller;

import com.alibaba.fastjson.JSONObject;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.alipay.api.response.AlipayTradePagePayResponse;
import com.alipay.api.response.AlipayTradeWapPayResponse;
import com.java2nb.novel.core.bean.UserDetails;
import com.java2nb.novel.core.config.AlipayProperties;
import com.java2nb.novel.core.utils.ThreadLocalUtil;
import com.java2nb.novel.service.OrderService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.TreeMap;
import java.util.Base64;

/**
 * @author 11797
 */
@Controller
@RequestMapping("pay")
@RequiredArgsConstructor
@Slf4j
public class PayController extends BaseController {


    private final AlipayProperties alipayConfig; // 支付宝配置（网关、密钥、回调等）

    private final OrderService orderService;    // 充值订单服务


    /**
     * 支付宝支付
     */
    @SneakyThrows
    @PostMapping("aliPay")
    public void aliPay(Integer payAmount, HttpServletRequest request, HttpServletResponse httpResponse) {

        if (!verifyVisitAuth(request, httpResponse)) {
            return;
        }
        if (payAmount == null || payAmount <= 0) {
            httpResponse.sendError(HttpServletResponse.SC_BAD_REQUEST, "payAmount is required");
            return;
        }

        // 下单自定义字段（供透传或日志使用，未参与支付宝金额计算）
        String merchantSubject = Optional.ofNullable(request.getParameter("merchantSubject")).orElse("fireflynovel");
        String body = Optional.ofNullable(request.getParameter("body")).orElse("fireflynovel");
        String passbackParams = buildPassbackParams(request);
        String returnUrl = StringUtils.isNotBlank(request.getParameter("returnUrl")) ? request.getParameter("returnUrl")
            : alipayConfig.getReturnUrl();

        UserDetails userDetails = getUserDetails(request);
        if (userDetails == null) {
            //未登录，跳转到登录页面
            httpResponse.sendRedirect("/user/login.html?originUrl=/pay/index.html");
        } else {
            //创建充值订单
            Long outTradeNo = orderService.createPayOrder((byte) 1, payAmount, userDetails.getId());
            //获得初始化的AlipayClient
            AlipayClient alipayClient = new DefaultAlipayClient(alipayConfig.getGatewayUrl(),
                alipayConfig.getAppId(), alipayConfig.getMerchantPrivateKey(), "json", alipayConfig.getCharset(),
                alipayConfig.getPublicKey(), alipayConfig.getSignType());
            String form;
            if (ThreadLocalUtil.getTemplateDir().contains("mobile")) {
                // 手机站
                AlipayTradeWapPayRequest alipayRequest = new AlipayTradeWapPayRequest();
                alipayRequest.setReturnUrl(returnUrl);
                //在公共参数中设置回跳和通知地址
                alipayRequest.setNotifyUrl(alipayConfig.getNotifyUrl());
                /******必传参数******/
                JSONObject bizContent = new JSONObject();
                //商户订单号，商家自定义，保持唯一性
                bizContent.put("out_trade_no", outTradeNo);
                //支付金额，最小值0.01元
                bizContent.put("total_amount", payAmount);
                //订单标题，不可使用特殊符号
                bizContent.put("subject", merchantSubject);
                bizContent.put("body", body);
                bizContent.put("passback_params", passbackParams);

                /******可选参数******/
                //手机网站支付默认传值FAST_INSTANT_TRADE_PAY
                bizContent.put("product_code", "QUICK_WAP_WAY");

                alipayRequest.setBizContent(bizContent.toString());
                AlipayTradeWapPayResponse payResponse = alipayClient.pageExecute(alipayRequest);
                form = payResponse.getBody();
            } else {
                // 电脑站
                //创建API对应的request
                AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
                alipayRequest.setReturnUrl(returnUrl);
                //在公共参数中设置回跳和通知地址
                alipayRequest.setNotifyUrl(alipayConfig.getNotifyUrl());
                //填充业务参数
                alipayRequest.setBizContent("{" +
                    "    \"out_trade_no\":\"" + outTradeNo + "\"," +
                    "    \"product_code\":\"FAST_INSTANT_TRADE_PAY\"," +
                    "    \"total_amount\":" + payAmount + "," +
                    "    \"subject\":\"" + merchantSubject + "\"," +
                    "    \"body\":\"" + body + "\"," +
                    "    \"passback_params\":\"" + passbackParams + "\"" +
                    "  }");
                //调用SDK生成表单
                AlipayTradePagePayResponse payResponse = alipayClient.pageExecute(alipayRequest);
                form = payResponse.getBody();

            }

            httpResponse.setContentType("text/html;charset=utf-8");
            //直接将完整的表单html输出到页面
            httpResponse.getWriter().write(form);
            httpResponse.getWriter().flush();
            httpResponse.getWriter().close();
        }


    }

    /**
     * 支付宝支付通知
     */
    @SneakyThrows
    @RequestMapping("aliPay/notify")
    public void aliPayNotify(HttpServletRequest request, HttpServletResponse httpResponse) {

        PrintWriter out = httpResponse.getWriter();

        //获取支付宝POST过来的信息
        Map<String, String> params = new HashMap<>();
        Map<String, String[]> requestParams = request.getParameterMap();
        for (String name : requestParams.keySet()) {
            String[] values = requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                    : valueStr + values[i] + ",";
            }
            params.put(name, valueStr);
        }

        //验证签名
        boolean signVerified = AlipaySignature.rsaCheckV1(params, alipayConfig.getPublicKey(),
            alipayConfig.getCharset(), alipayConfig.getSignType());

        if (signVerified) {
            //验证成功
            //商户订单号
            String outTradeNo = new String(request.getParameter("out_trade_no").getBytes(StandardCharsets.ISO_8859_1),
                StandardCharsets.UTF_8);

            //支付宝交易号
            String tradeNo = new String(request.getParameter("trade_no").getBytes(StandardCharsets.ISO_8859_1),
                StandardCharsets.UTF_8);

            //交易状态
            String tradeStatus = new String(request.getParameter("trade_status").getBytes(StandardCharsets.ISO_8859_1),
                StandardCharsets.UTF_8);

            if ("TRADE_SUCCESS".equals(tradeStatus)) {
                //支付成功
                orderService.updatePayOrder(Long.parseLong(outTradeNo), tradeNo, 1);
            }

            out.println("success");

        } else {//验证失败
            out.println("fail");

        }

    }

    /**
     * 基于自定义对称校验的防刷防伪逻辑：
     * 1) 前端用 md5Key 构造 md5(md5Key:timeStamp)，再用 aesKey 加密得到 visitAuth。
     * 2) 后端用相同算法反推 expected，与请求头的 visitAuth 比对。
     * 目的：确保请求来自受控前端，避免任意脚本直接 POST /pay/aliPay。
     */
    private boolean verifyVisitAuth(HttpServletRequest request, HttpServletResponse httpResponse) throws Exception {
        String timeStamp = request.getHeader("timeStamp");   // 由前端生成的时间戳，参与摘要计算
        String visitAuth = request.getHeader("visitAuth");   // 由前端计算的加密签名
        if (StringUtils.isAnyBlank(timeStamp, visitAuth)) {  // 缺少头部直接视为非法请求
            httpResponse.sendError(HttpServletResponse.SC_BAD_REQUEST, "missing timeStamp/visitAuth");
            return false;
        }
        if (StringUtils.isAnyBlank(alipayConfig.getMd5Key(), alipayConfig.getAesKey())) { // 配置不全无法验签
            httpResponse.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "pay secret is not configured");
            return false;
        }

        // 服务端按照同一算法重算 expected，与 visitAuth 比较
        String md5 = DigestUtils.md5Hex(alipayConfig.getMd5Key() + ":" + timeStamp); // 第一步：md5(md5Key:timeStamp)
        String expected = encryptAes(md5, alipayConfig.getAesKey());                 // 第二步：用 aesKey 加密 md5 串
        if (!StringUtils.equals(visitAuth, expected)) {                              // 不一致则拒绝
            httpResponse.sendError(HttpServletResponse.SC_UNAUTHORIZED, "invalid visitAuth");
            return false;
        }
        return true; // 验签通过
    }

    private String encryptAes(String data, String key) throws Exception {
        SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "AES");
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, keySpec);
        byte[] encrypted = cipher.doFinal(data.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(encrypted);
    }

    /**
     * 将请求中的附加字段透传到 passback_params，便于异步通知时取回
     */
    private String buildPassbackParams(HttpServletRequest request) {
        // 按字典序，便于排查
        Map<String, String> extra = new TreeMap<>();
        addIfPresent(extra, "payChannel", request.getParameter("payChannel"));
        addIfPresent(extra, "typeIndex", request.getParameter("typeIndex"));
        addIfPresent(extra, "isUseFundAuth", request.getParameter("isUseFundAuth"));
        addIfPresent(extra, "cyclePayAuthAgreementNo", request.getParameter("cyclePayAuthAgreementNo"));
        addIfPresent(extra, "externalId", request.getParameter("externalId"));
        addIfPresent(extra, "merchantTradeNo", request.getParameter("merchantTradeNo"));
        addIfPresent(extra, "externalGoodsType", request.getParameter("externalGoodsType"));
        addIfPresent(extra, "timeExpire", request.getParameter("timeExpire"));
        addIfPresent(extra, "buyerId", request.getParameter("buyerId"));
        addIfPresent(extra, "buyerMinAge", request.getParameter("buyerMinAge"));
        addIfPresent(extra, "merchantPayNotifyUrl", request.getParameter("merchantPayNotifyUrl"));
        addIfPresent(extra, "quitUrl", request.getParameter("quitUrl"));
        addIfPresent(extra, "returnUrl", request.getParameter("returnUrl"));
        addIfPresent(extra, "qrPayMode", request.getParameter("qrPayMode"));
        addIfPresent(extra, "qrcodeWidth", request.getParameter("qrcodeWidth"));
        addIfPresent(extra, "accountName", request.getParameter("accountName"));
        addIfPresent(extra, "accountPhone", request.getParameter("accountPhone"));
        addIfPresent(extra, "clientIp", request.getParameter("clientIp"));
        addIfPresent(extra, "riskControlNotifyUrl", request.getParameter("riskControlNotifyUrl"));
        addIfPresent(extra, "body", request.getParameter("body"));
        addIfPresent(extra, "merchantSubject", request.getParameter("merchantSubject"));
        try {
            return java.net.URLEncoder.encode(JSONObject.toJSONString(extra), StandardCharsets.UTF_8);
        } catch (Exception e) {
            return "{}";
        }
    }

    private void addIfPresent(Map<String, String> map, String key, String value) {
        if (StringUtils.isNotBlank(value)) {
            map.put(key, value);
        }
    }
}
