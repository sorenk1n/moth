package com.java2nb.novel.openapi;

import com.java2nb.novel.entity.OpenApiApp;
import com.java2nb.novel.entity.OpenApiOrder;
import com.java2nb.novel.mapper.OpenApiAppMapper;
import com.java2nb.novel.mapper.OpenApiOrderMapper;
import java.util.Date;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class OpenApiOrderService {

    private final OpenApiOrderMapper openApiOrderMapper;
    private final OpenApiAppMapper openApiAppMapper;
    private final OpenApiNotifyService openApiNotifyService;

    public void handlePaySuccess(Long outTradeNo, String tradeNo) {
        OpenApiOrder order = openApiOrderMapper.findByOutTradeNo(outTradeNo);
        if (order == null) {
            return;
        }
        if (order.getStatus() != null && order.getStatus() == OpenApiPayService.STATUS_PAID) {
            return;
        }
        order.setStatus(OpenApiPayService.STATUS_PAID);
        order.setUpdateTime(new Date());
        openApiOrderMapper.updateStatus(order);

        OpenApiApp app = openApiAppMapper.findByAppId(order.getAppId());
        if (app == null) {
            return;
        }
        openApiNotifyService.enqueue(order, app, tradeNo);
    }
}
