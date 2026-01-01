package com.java2nb.novel.service;

import com.java2nb.novel.entity.PayMerchant;
import java.util.List;

public interface PayMerchantService {

    /**
     * 查询启用的商户列表
     */
    List<PayMerchant> listActive();

    /**
     * 查询全部商户
     */
    List<PayMerchant> listAll();

    /**
     * 查询默认商户
     */
    PayMerchant getDefault();

    /**
     * 新增商户
     */
    void create(PayMerchant merchant);

    /**
     * 更新商户状态
     */
    void updateStatus(Long id, Byte status);

    /**
     * 设置默认商户
     */
    void setDefault(Long id);

    /**
     * 删除商户
     */
    void delete(Long id);
}
