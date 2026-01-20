package com.java2nb.novel.mapper;

import java.util.Map;
import org.apache.commons.lang3.StringUtils;

public class PayMerchantSqlProvider {

    public String listAllSorted(Map<String, Object> params) {
        String sortBy = (String) params.get("sortBy");
        String sortOrder = (String) params.get("sortOrder");
        String baseSql = "select id, merchant_no as merchantNo, alipay_merchant_no as alipayMerchantNo, "
            + "name, status, is_default as isDefault, md5_key as md5Key, aes_key as aesKey, "
            + "group_external_id as groupExternalId, remark, create_time as createTime, update_time as updateTime "
            + "from pay_merchant_b";
        if (StringUtils.isBlank(sortBy) || StringUtils.isBlank(sortOrder)) {
            return baseSql + " order by is_default desc, id";
        }
        String order = "desc".equalsIgnoreCase(sortOrder) ? "desc" : "asc";
        String orderBy;
        if ("create_time".equals(sortBy)) {
            orderBy = " order by (" + sortBy + " is null) asc, " + sortBy + " " + order;
        } else {
            orderBy = " order by (" + sortBy + " is null or " + sortBy + " = '') asc, " + sortBy + " " + order;
        }
        return baseSql + orderBy;
    }
}
