package com.java2nb.novel.entity;

import java.util.Date;
import lombok.Data;

@Data
public class OpenApiNotifyTask {
    private Long id;
    private String appId;
    private String notifyUrl;
    private String externalOrderNo;
    private Long outTradeNo;
    private Integer amount;
    private String tradeNo;
    private String attach;
    private Byte status;
    private Integer retryCount;
    private Integer maxRetry;
    private Date nextRetryTime;
    private String lastError;
    private Date createTime;
    private Date updateTime;
}
