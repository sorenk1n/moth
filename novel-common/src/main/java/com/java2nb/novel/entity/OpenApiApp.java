package com.java2nb.novel.entity;

import java.util.Date;
import lombok.Data;

@Data
public class OpenApiApp {
    private Long id;
    private String appId;
    private String appSecret;
    private String notifyUrl;
    private String returnUrl;
    private String ipWhitelist;
    private Integer maxQps;
    private Integer dayLimit;
    private Byte status;
    private Date createTime;
    private Date updateTime;
}
