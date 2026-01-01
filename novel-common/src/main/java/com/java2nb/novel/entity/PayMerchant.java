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

    /** 支付宝商户号 */
    private String alipayMerchantNo;

    /** 商户名称 */
    private String name;

    /** 状态 1启用 0禁用 */
    private Byte status;

    /** 是否默认商户 1默认 0非默认 */
    private Byte isDefault;

    private String remark;

    private Date createTime;

    private Date updateTime;
}
