package com.java2nb.novel.service;

import com.java2nb.novel.entity.PayMerchant;
import java.util.List;

public interface PayMerchantService {

    /**
     * 查询启用的商户列表
     */
    List<PayMerchant> listActive();
}
