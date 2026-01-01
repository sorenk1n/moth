package com.java2nb.novel.controller;

import com.java2nb.novel.entity.PayMerchant;
import com.java2nb.novel.service.PayMerchantService;
import io.github.xxyopen.model.resp.RestResult;
import io.github.xxyopen.model.resp.SysResultCode;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 商户管理接口（前台全局配置）
 */
@RestController
@RequestMapping("/merchant")
@RequiredArgsConstructor
public class PayMerchantManageController {

    private final PayMerchantService payMerchantService;

    @GetMapping("/default")
    public RestResult<PayMerchant> getDefault() {
        return RestResult.ok(payMerchantService.getDefault());
    }

    @GetMapping("/list")
    public RestResult<List<PayMerchant>> listAll() {
        return RestResult.ok(payMerchantService.listAll());
    }

    @PostMapping("/create")
    public RestResult<Void> create(@RequestParam String merchantNo,
        @RequestParam String name,
        @RequestParam(required = false) String alipayMerchantNo,
        @RequestParam(required = false) String remark,
        @RequestParam(required = false) Byte status) {
        if (StringUtils.isAnyBlank(merchantNo, name)) {
            return RestResult.fail(SysResultCode.PARAM_ERROR);
        }
        PayMerchant merchant = new PayMerchant();
        merchant.setMerchantNo(merchantNo.trim());
        merchant.setName(name.trim());
        merchant.setAlipayMerchantNo(StringUtils.trimToNull(alipayMerchantNo));
        merchant.setRemark(StringUtils.trimToNull(remark));
        merchant.setStatus(status);
        payMerchantService.create(merchant);
        return RestResult.ok();
    }

    @PostMapping("/updateStatus")
    public RestResult<Void> updateStatus(@RequestParam Long id, @RequestParam Byte status) {
        if (id == null || status == null) {
            return RestResult.fail(SysResultCode.PARAM_ERROR);
        }
        payMerchantService.updateStatus(id, status);
        return RestResult.ok();
    }

    @PostMapping("/setDefault")
    public RestResult<Void> setDefault(@RequestParam Long id) {
        if (id == null) {
            return RestResult.fail(SysResultCode.PARAM_ERROR);
        }
        payMerchantService.setDefault(id);
        return RestResult.ok();
    }

    @PostMapping("/delete")
    public RestResult<Void> delete(@RequestParam Long id) {
        if (id == null) {
            return RestResult.fail(SysResultCode.PARAM_ERROR);
        }
        payMerchantService.delete(id);
        return RestResult.ok();
    }
}
