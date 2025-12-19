package com.java2nb.novel.entity;

import java.util.Date;
import lombok.Data;

/**
 * 支付商户配置
 */
@Data
public class PayMerchant {

    private Long id;

    /** 商户号，用于 externalId */
    private String merchantNo;

    /** 商户名称 */
    private String name;

    /** 状态 1启用 0禁用 */
    private Byte status;

    private String remark;

    private Date createTime;

    private Date updateTime;
}
