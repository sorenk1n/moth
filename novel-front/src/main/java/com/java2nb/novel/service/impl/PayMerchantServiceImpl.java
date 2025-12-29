package com.java2nb.novel.service.impl;

import com.java2nb.novel.entity.PayMerchant;
import com.java2nb.novel.mapper.PayMerchantMapper;
import com.java2nb.novel.service.PayMerchantService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PayMerchantServiceImpl implements PayMerchantService {

    private final PayMerchantMapper payMerchantMapper;

    @Override
    public List<PayMerchant> listActive() {
        return payMerchantMapper.listActive();
    }
}
