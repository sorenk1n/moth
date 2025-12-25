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

import java.net.URLEncoder;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
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
    public void aliPay(BigDecimal payAmount, HttpServletRequest request, HttpServletResponse httpResponse) {

        if (!verifyVisitAuth(request, httpResponse)) {
            return;
        }
        if (payAmount == null || payAmount.compareTo(BigDecimal.ZERO) <= 0) {
            httpResponse.sendError(HttpServletResponse.SC_BAD_REQUEST, "payAmount is required");
            return;
        }

        // 下单自定义字段（供透传或日志使用，未参与支付宝金额计算）
        String merchantSubjectParam = request.getParameter("merchantSubject");
        String merchantSubject = null;
        String body = Optional.ofNullable(request.getParameter("body")).orElse("fireflynovel");
        String passbackParams = buildPassbackParams(request);
        String returnUrl = alipayConfig.getReturnUrl();
        // 透传前端的验签数据，后续提交到网关时一并带上
        String timeStampHeader = request.getHeader("timeStamp");
        String visitAuthHeader = request.getHeader("visitAuth");
        // 外部商户标识（网关必填），前端传递或使用默认值
        String externalId = Optional.ofNullable(request.getParameter("externalId"))
            .filter(StringUtils::isNotBlank)
            .orElse("888007");
        // 支付渠道，默认 1 表示支付宝
        String payChannel = Optional.ofNullable(request.getParameter("payChannel"))
            .filter(StringUtils::isNotBlank)
            .orElse("1");
        // 业务类型索引，网关必填，默认 2
        String typeIndex = Optional.ofNullable(request.getParameter("typeIndex"))
            .filter(StringUtils::isNotBlank)
            .orElse("2");
        // 商户单号（由系统生成，确保唯一）
        String merchantTradeNo = Optional.ofNullable(request.getParameter("merchantTradeNo"))
            .filter(StringUtils::isNotBlank)
            .orElse(null);
        // 商品类型
        String externalGoodsType = Optional.ofNullable(request.getParameter("externalGoodsType"))
            .filter(StringUtils::isNotBlank)
            .orElse("9");
        // 客户端 IP，优先取入参，否则取请求头/remoteAddr
        String clientIp = Optional.ofNullable(request.getParameter("clientIp"))
            .filter(StringUtils::isNotBlank)
            .orElseGet(() -> resolveClientIp(request));
        // 通知/回跳/退出地址（可根据实际调整，默认使用演示地址）
        String merchantPayNotifyUrl = Optional.ofNullable(request.getParameter("merchantPayNotifyUrl"))
            .filter(StringUtils::isNotBlank)
            .orElse("http://chatim.natapp1.cc/pay/notify"); // 业务支付结果异步通知
        String riskControlNotifyUrl = Optional.ofNullable(request.getParameter("riskControlNotifyUrl"))
            .filter(StringUtils::isNotBlank)
            .orElse("http://chatim.natapp1.cc/pay/riskNotify"); // 风控通知回调
        String quitUrl = Optional.ofNullable(request.getParameter("quitUrl"))
            .filter(StringUtils::isNotBlank)
            .orElse("http://sxds.natapp1.cc/quit"); // 用户取消/退出时回跳地址
        // 使用配置文件中的 return-url
        returnUrl = alipayConfig.getReturnUrl();
        // 自定义总金额（如网关需要 totalAmount 字段），默认等于 payAmount
        String totalAmount = Optional.ofNullable(request.getParameter("totalAmount"))
            .filter(StringUtils::isNotBlank)
            .orElse(null);

        UserDetails userDetails = getUserDetails(request);
        if (userDetails == null) {
            //未登录，跳转到登录页面
            httpResponse.sendRedirect("/user/login.html?originUrl=/pay/index.html");
        } else {
            //创建充值订单
            BigDecimal amountYuan = payAmount.setScale(2, RoundingMode.HALF_UP);
            int amountCent = amountYuan.movePointRight(2).intValueExact();
            Long outTradeNo = orderService.createPayOrder((byte) 1, amountCent, userDetails.getId());
            // 统一使用订单号作为商户单号，保证唯一性、可对账
            merchantTradeNo = String.valueOf(outTradeNo);
            // 充值描述：尾号aaaa用户充值b屋币
            String maskedPhone = Optional.ofNullable(userDetails.getUsername())
                .filter(StringUtils::isNotBlank)
                .map(str -> {
                    String digits = str.replaceAll("\\D", "");
                    if (digits.length() >= 4) {
                        return digits.substring(digits.length() - 4);
                    }
                    return "****";
                }).orElse("****");
            String coinAmount = amountYuan.multiply(BigDecimal.valueOf(100)).toPlainString();
            String subjectTemplate = "尾号" + maskedPhone + "用户充值" + coinAmount + "屋币";
            merchantSubject = Optional.ofNullable(merchantSubjectParam)
                .filter(StringUtils::isNotBlank)
                .orElse(subjectTemplate);
            //获得初始化的AlipayClient
            AlipayClient alipayClient = new DefaultAlipayClient(alipayConfig.getGatewayUrl(),
                alipayConfig.getAppId(), alipayConfig.getMerchantPrivateKey(), "json", alipayConfig.getCharset(),
                alipayConfig.getPublicKey(), alipayConfig.getSignType());
            String form;
            if (isMobilePay(request)) {
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
                form = injectVisitAuth(payResponse.getBody(), timeStampHeader, visitAuthHeader);
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
                form = injectVisitAuth(payResponse.getBody(), timeStampHeader, visitAuthHeader);

            }

            // 直接由服务端以 POST 方式转发到网关，携带 timeStamp/visitAuth 头部，返回结果给前端
            proxyPostToGateway(form, timeStampHeader, visitAuthHeader, externalId, payChannel, typeIndex,
                merchantTradeNo, externalGoodsType, merchantPayNotifyUrl, riskControlNotifyUrl, quitUrl, returnUrl,
                clientIp, Optional.ofNullable(totalAmount).orElse(amountYuan.toPlainString()), merchantSubject,
                httpResponse);
        }


    }

    private boolean isMobilePay(HttpServletRequest request) {
        String templateDir = ThreadLocalUtil.getTemplateDir();
        if (StringUtils.isNotBlank(templateDir) && templateDir.contains("mobile")) {
            return true;
        }
        String ua = Optional.ofNullable(request.getHeader("User-Agent")).orElse("").toLowerCase();
        return ua.contains("mobile")
            || ua.contains("android")
            || ua.contains("iphone")
            || ua.contains("ipad")
            || ua.contains("ipod")
            || ua.contains("windows phone");
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

        // 服务端按照与前端完全一致的算法重算 expected，与 visitAuth 比较
        String expected = buildVisitAuth(timeStamp); // md5(md5Key:timeStamp) 后 AES/ECB/PKCS5Padding，加密结果 Base64
        if (!StringUtils.equals(visitAuth, expected)) {                              // 不一致则拒绝
            httpResponse.sendError(HttpServletResponse.SC_UNAUTHORIZED, "invalid visitAuth");
            return false;
        }
        return true; // 验签通过
    }

    /**
     * 生成 visitAuth（与前端 pay.js 中 buildVisitAuth 保持一致）：
     * 1) md5(md5Key:timeStamp) 生成 32 位小写 hex。
     * 2) 用 aesKey 做 AES/ECB/PKCS5Padding 加密，输出 Base64。
     */
    private String buildVisitAuth(String timeStamp) throws Exception {
        // 前后端统一的签名算法：
        // 1) 计算 md5(md5Key:timeStamp)，得到 32 位小写 hex 字符串；
        // 2) 用 aesKey 做 AES/ECB/PKCS5Padding 加密 md5 串，输出 Base64。
        String md5 = DigestUtils.md5Hex(alipayConfig.getMd5Key() + ":" + timeStamp);
        // 使用与前端 CryptoJS 相同的输出：AES/ECB/PKCS5Padding 后 Base64 字符串
        return encryptAes(md5, alipayConfig.getAesKey());
    }

    private String encryptAes(String data, String key) throws Exception {
        return Base64.getEncoder().encodeToString(encryptAesBytes(data, key));
    }

    private byte[] encryptAesBytes(String data, String key) throws Exception {
        SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "AES");
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, keySpec);
        return cipher.doFinal(data.getBytes(StandardCharsets.UTF_8));
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

    /**
     * 将 timeStamp 和 visitAuth 作为隐藏字段注入到表单，确保提交到网关时同样携带。
     */
    private String injectVisitAuth(String formHtml, String timeStamp, String visitAuth) {
        if (StringUtils.isAnyBlank(formHtml, timeStamp, visitAuth)) {
            return formHtml;
        }
        String result = formHtml;

        // 0) 强制使用 application/x-www-form-urlencoded 的 POST 提交（表单默认就是该 Content-Type）
        // 将 method="get" 调整为 method="post"，如果未声明 method 则追加
        if (result.contains("method=\"get\"")) {
            result = result.replaceFirst("method=\"get\"", "method=\"post\"");
        } else if (!result.contains("method=\"post\"")) {
            result = result.replaceFirst("<form", "<form method=\"post\"");
        }
        // 移除可能的 multipart 声明，避免非表单格式
        if (result.contains("enctype=\"multipart/form-data\"")) {
            result = result.replace("enctype=\"multipart/form-data\"", "");
        }
        // 将 action 里的查询串剥离，避免再次作为 GET 参数拼接（只保留基础网关地址）
        int actionIdx = result.indexOf("action=\"");
        if (actionIdx >= 0) {
            int start = actionIdx + "action=\"".length();
            int end = result.indexOf("\"", start);
            if (end > start) {
                String actionUrl = result.substring(start, end);
                String base = actionUrl.contains("?") ? actionUrl.substring(0, actionUrl.indexOf("?")) : actionUrl;
                result = result.substring(0, start) + base + result.substring(end);
            }
        }

        // 1) 给表单追加隐藏字段（适用于 POST/GET 表单）
        String hidden = "<input type=\"hidden\" name=\"timeStamp\" value=\"" + timeStamp + "\"/>"
            + "<input type=\"hidden\" name=\"visitAuth\" value=\"" + visitAuth + "\"/>";
        if (result.contains("</form>")) {
            result = result.replaceFirst("</form>", hidden + "</form>");
        }

        return result;
    }

    private String urlEncode(String value) {
        try {
            return URLEncoder.encode(value, StandardCharsets.UTF_8.toString());
        } catch (Exception e) {
            return value;
        }
    }

    /**
     * 获取客户端 IP，优先从代理头获取，回退到 remoteAddr
     */
    private String resolveClientIp(HttpServletRequest request) {
        String[] headerCandidates = {
            "X-Forwarded-For", "Proxy-Client-IP", "WL-Proxy-Client-IP",
            "HTTP_CLIENT_IP", "HTTP_X_FORWARDED_FOR"
        };
        for (String header : headerCandidates) {
            String ip = request.getHeader(header);
            if (StringUtils.isNotBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
                // 可能存在逗号分隔的多级代理，取第一个
                return ip.split(",")[0].trim();
            }
        }
        return request.getRemoteAddr();
    }

    /**
     * 将 SDK 生成的表单解析为 key/value，并由服务端 POST 到网关，附带 timeStamp/visitAuth 头
     */
    private void proxyPostToGateway(String formHtml, String timeStamp, String visitAuth, String externalId,
        String payChannel, String typeIndex, String merchantTradeNo, String externalGoodsType,
        String merchantPayNotifyUrl, String riskControlNotifyUrl, String quitUrl, String returnUrl, String clientIp,
        String totalAmount, String merchantSubject, HttpServletResponse httpResponse) throws Exception {
        // 解析 action
        String action = extractFormAction(formHtml);
        Map<String, String> params = extractFormInputs(formHtml);

        // 兜底：如解析失败则返回原表单
        if (StringUtils.isBlank(action) || params.isEmpty()) {
            httpResponse.setContentType("text/html;charset=utf-8");
            httpResponse.getWriter().write(formHtml);
            httpResponse.getWriter().flush();
            httpResponse.getWriter().close();
            return;
        }

        // 构造表单 body
        StringBuilder bodyBuilder = new StringBuilder();
        // 确保 externalId 传递给网关
        if (StringUtils.isNotBlank(externalId)) {
            params.putIfAbsent("externalId", externalId);
        }
        if (StringUtils.isNotBlank(payChannel)) {
            params.putIfAbsent("payChannel", payChannel);
        }
        if (StringUtils.isNotBlank(typeIndex)) {
            params.putIfAbsent("typeIndex", typeIndex);
        }
        if (StringUtils.isNotBlank(merchantTradeNo)) {
            params.put("merchantTradeNo", merchantTradeNo);
        }
        if (StringUtils.isNotBlank(externalGoodsType)) {
            params.putIfAbsent("externalGoodsType", externalGoodsType);
        }
        if (StringUtils.isNotBlank(merchantPayNotifyUrl)) {
            params.put("merchantPayNotifyUrl", merchantPayNotifyUrl);
        }
        if (StringUtils.isNotBlank(riskControlNotifyUrl)) {
            params.put("riskControlNotifyUrl", riskControlNotifyUrl);
        }
        if (StringUtils.isNotBlank(quitUrl)) {
            params.put("quitUrl", quitUrl);
        }
        if (StringUtils.isNotBlank(returnUrl)) {
            params.put("returnUrl", returnUrl);
        }
        if (StringUtils.isNotBlank(clientIp)) {
            params.put("clientIp", clientIp);
        }
        if (StringUtils.isNotBlank(totalAmount)) {
            params.put("totalAmount", totalAmount);
        }
        if (StringUtils.isNotBlank(merchantSubject)) {
            params.put("merchantSubject", merchantSubject);
        }
        for (Map.Entry<String, String> entry : params.entrySet()) {
            if (bodyBuilder.length() > 0) {
                bodyBuilder.append("&");
            }
            bodyBuilder.append(urlEncode(entry.getKey())).append("=").append(urlEncode(entry.getValue()));
        }

        HttpClient client = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(10)).build();
        HttpRequest.Builder reqBuilder = HttpRequest.newBuilder()
            .uri(java.net.URI.create(action))
            .timeout(Duration.ofSeconds(30))
            .header("Content-Type", "application/x-www-form-urlencoded");
        if (StringUtils.isNotBlank(timeStamp)) {
            reqBuilder.header("timeStamp", timeStamp);
        }
        if (StringUtils.isNotBlank(visitAuth)) {
            reqBuilder.header("visitAuth", visitAuth);
        }
        HttpRequest req = reqBuilder.POST(HttpRequest.BodyPublishers.ofString(bodyBuilder.toString())).build();

        HttpResponse<String> gatewayResp = client.send(req, HttpResponse.BodyHandlers.ofString());
        httpResponse.setStatus(gatewayResp.statusCode());
        // 根据网关返回内容类型透传，便于前端正确解析 JSON
        String respContentType = gatewayResp.headers().firstValue("Content-Type").orElse("");
        if (respContentType.toLowerCase().contains("application/json")) {
            httpResponse.setContentType("application/json;charset=utf-8");
        } else {
            httpResponse.setContentType("text/html;charset=utf-8");
        }
        httpResponse.getWriter().write(gatewayResp.body());
        httpResponse.getWriter().flush();
        httpResponse.getWriter().close();
    }

    private String extractFormAction(String formHtml) {
        Matcher m = Pattern.compile("action=\"([^\"]+)\"").matcher(formHtml);
        if (m.find()) {
            return m.group(1);
        }
        return null;
    }

    private Map<String, String> extractFormInputs(String formHtml) {
        Map<String, String> map = new HashMap<>();
        Pattern p = Pattern.compile("<input[^>]*name=\"([^\"]+)\"[^>]*value=\"([^\"]*)\"[^>]*/?>");
        Matcher m = p.matcher(formHtml);
        while (m.find()) {
            map.put(m.group(1), m.group(2));
        }
        return map;
    }
}
