package com.java2nb.novel.controller;

import com.java2nb.novel.entity.PayMerchant;
import com.java2nb.novel.service.PayMerchantService;
import io.github.xxyopen.model.resp.RestResult;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 支付商户信息接口
 */
@RestController
@RequestMapping("/pay/merchants")
@RequiredArgsConstructor
public class PayMerchantController {

    private final PayMerchantService payMerchantService;

    @GetMapping
    public RestResult<List<PayMerchant>> listMerchants() {
        return RestResult.ok(payMerchantService.listActive());
    }
}
