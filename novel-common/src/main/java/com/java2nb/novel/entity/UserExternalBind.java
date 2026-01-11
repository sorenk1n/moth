package com.java2nb.novel.entity;

import java.util.Date;
import lombok.Data;

@Data
public class UserExternalBind {
    private Long id;
    private Long userId;
    private String externalAppId;
    private String externalUserId;
    private String alipayUserId;
    private String alipayAccount;
    private String alipayRealName;
    private Date createTime;
    private Date updateTime;
}
