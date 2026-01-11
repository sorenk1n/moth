package com.java2nb.novel.openapi;

import lombok.Data;

@Data
public class OpenApiPayRequest {
    private String externalOrderNo;
    private String externalUserId;
    private String alipayUserId;
    private String alipayAccount;
    private String alipayRealName;
    private Integer amount;
    private String subject;
    private String body;
    private String notifyUrl;
    private String returnUrl;
    private String attach;
    private String typeIndex;
    private String goodsType;
    private String gatewayUrl;
}
