package com.java2nb.novel.controller;

import com.java2nb.novel.entity.PayMerchant;
import com.java2nb.novel.service.PayMerchantService;
import io.github.xxyopen.model.resp.RestResult;
import io.github.xxyopen.model.resp.SysResultCode;
import java.util.Map;
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
    private static final Map<String, String> SORT_BY_WHITELIST = Map.of(
        "merchant_no", "merchant_no",
        "name", "name",
        "aes_key", "aes_key",
        "group_external_id", "group_external_id",
        "create_time", "create_time"
    );

    @GetMapping("/default")
    public RestResult<PayMerchant> getDefault() {
        return RestResult.ok(payMerchantService.getDefault());
    }

    @GetMapping("/list")
    public RestResult<?> listAll(
        @RequestParam(required = false, name = "sort_by") String sortBy,
        @RequestParam(required = false, name = "sort_order") String sortOrder) {
        String normalizedSortBy = StringUtils.trimToNull(sortBy);
        String normalizedSortOrder = StringUtils.trimToNull(sortOrder);
        if (normalizedSortBy != null || normalizedSortOrder != null) {
            String mappedSortBy = SORT_BY_WHITELIST.get(normalizedSortBy);
            if (mappedSortBy == null) {
                return RestResult.fail(SysResultCode.PARAM_ERROR);
            }
            String orderLower = normalizedSortOrder == null ? null : normalizedSortOrder.toLowerCase();
            if (!"asc".equals(orderLower) && !"desc".equals(orderLower)) {
                return RestResult.fail(SysResultCode.PARAM_ERROR);
            }
            return RestResult.ok(payMerchantService.listAll(mappedSortBy, orderLower));
        }
        return RestResult.ok(payMerchantService.listAll(null, null));
    }

    @PostMapping("/create") // 接收创建商户的 POST 请求，路径为 /merchant/create
    public RestResult<Void> create(
        @RequestParam String merchantNo, // 必填：商户号
        @RequestParam String name, // 必填：商户名称
        @RequestParam(required = false) String alipayMerchantNo, // 可选：支付宝商户号
        @RequestParam(required = false) String groupExternalId, // 可选：商户分组外部标识
        @RequestParam(required = false) String remark, // 可选：备注
        @RequestParam(required = false) Byte status) 
        { // 可选：状态
        if (StringUtils.isAnyBlank(merchantNo, name)) { // 必填参数校验
            return RestResult.fail(SysResultCode.PARAM_ERROR); // 返回参数错误
        }
        PayMerchant merchant = new PayMerchant(); // 构造实体对象
        merchant.setMerchantNo(merchantNo.trim()); // 去除首尾空格并赋值商户号
        merchant.setName(name.trim()); // 去除首尾空格并赋值名称
        merchant.setAlipayMerchantNo(StringUtils.trimToNull(alipayMerchantNo)); // 空串转 null 后赋值
        merchant.setGroupExternalId(StringUtils.trimToNull(groupExternalId)); // 空串转 null 后赋值
        merchant.setRemark(StringUtils.trimToNull(remark)); // 空串转 null 后赋值备注
        merchant.setStatus(status); // 直接设置状态，允许为空
        payMerchantService.create(merchant); // 交给服务层保存
        return RestResult.ok(); // 返回成功响应
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
