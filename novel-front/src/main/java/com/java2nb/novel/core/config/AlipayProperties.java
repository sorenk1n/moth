package com.java2nb.novel.core.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author 11797
 */
@Data
@Component
@ConfigurationProperties(prefix="alipay") // 绑定 application-*.yml 中 alipay.* 配置
public class AlipayProperties {

    private String appId;                // 支付宝 AppId
    private String merchantPrivateKey;   // 商户私钥（应用私钥）
    private String publicKey;            // 支付宝公钥
    private String notifyUrl;            // 支付宝异步通知回调地址
    private String returnUrl;            // 支付成功同步回跳地址
    private String signType;             // 签名算法类型（如 RSA2）
    private String charset;              // 编码格式（如 utf-8）
    private String gatewayUrl;           // 支付宝网关地址
    /**
     * 自定义验签：md5(md5Key:timeStamp) 后再用 AES 加密得到 visitAuth
     */
    private String md5Key;               // 前后端共享的自定义 MD5 密钥
    private String aesKey;               // 用于加密 visitAuth 的 AES 密钥
}
