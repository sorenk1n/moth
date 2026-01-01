package com.java2nb.novel.service.impl;

import com.java2nb.novel.entity.PayMerchant;
import com.java2nb.novel.mapper.PayMerchantMapper;
import com.java2nb.novel.service.PayMerchantService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class PayMerchantServiceImpl implements PayMerchantService {

    private final PayMerchantMapper payMerchantMapper;

    @Override
    public List<PayMerchant> listActive() {
        return payMerchantMapper.listActive();
    }

    @Override
    public List<PayMerchant> listAll() {
        return payMerchantMapper.listAll();
    }

    @Override
    public PayMerchant getDefault() {
        return payMerchantMapper.findDefault();
    }

    @Override
    public void create(PayMerchant merchant) {
        if (merchant.getStatus() == null) {
            merchant.setStatus((byte) 1);
        }
        if (merchant.getIsDefault() == null) {
            merchant.setIsDefault((byte) 0);
        }
        payMerchantMapper.insert(merchant);
    }

    @Override
    public void updateStatus(Long id, Byte status) {
        payMerchantMapper.updateStatus(id, status);
    }

    @Override
    @Transactional
    public void setDefault(Long id) {
        payMerchantMapper.clearDefault();
        payMerchantMapper.setDefault(id);
    }

    @Override
    public void delete(Long id) {
        payMerchantMapper.deleteById(id);
    }
}
