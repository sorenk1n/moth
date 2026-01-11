package com.java2nb.novel.entity;

import java.util.Date;
import lombok.Data;

@Data
public class OpenApiOrder {
    private Long id;
    private String appId;
    private String externalOrderNo;
    private Long outTradeNo;
    private Long userId;
    private Integer amount;
    private Byte status;
    private String notifyUrl;
    private String returnUrl;
    private String attach;
    private String gatewayUrl;
    private String payBody;
    private String payHeaders;
    private Date createTime;
    private Date updateTime;
}
