package com.java2nb.novel.mapper;

import com.java2nb.novel.entity.OpenApiOrder;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface OpenApiOrderMapper {

    @Select("select id, app_id as appId, external_order_no as externalOrderNo, out_trade_no as outTradeNo, "
        + "user_id as userId, amount, status, notify_url as notifyUrl, return_url as returnUrl, attach, "
        + "gateway_url as gatewayUrl, pay_body as payBody, pay_headers as payHeaders, "
        + "create_time as createTime, update_time as updateTime "
        + "from openapi_order where app_id = #{appId} and external_order_no = #{externalOrderNo} limit 1")
    OpenApiOrder findByAppAndExternalOrderNo(String appId, String externalOrderNo);

    @Select("select id, app_id as appId, external_order_no as externalOrderNo, out_trade_no as outTradeNo, "
        + "user_id as userId, amount, status, notify_url as notifyUrl, return_url as returnUrl, attach, "
        + "gateway_url as gatewayUrl, pay_body as payBody, pay_headers as payHeaders, "
        + "create_time as createTime, update_time as updateTime "
        + "from openapi_order where out_trade_no = #{outTradeNo} limit 1")
    OpenApiOrder findByOutTradeNo(Long outTradeNo);

    @Insert("insert into openapi_order (app_id, external_order_no, out_trade_no, user_id, amount, status, "
        + "notify_url, return_url, attach, gateway_url, pay_body, pay_headers, create_time, update_time) "
        + "values (#{appId}, #{externalOrderNo}, #{outTradeNo}, #{userId}, #{amount}, #{status}, "
        + "#{notifyUrl}, #{returnUrl}, #{attach}, #{gatewayUrl}, #{payBody}, #{payHeaders}, #{createTime}, #{updateTime})")
    int insert(OpenApiOrder order);

    @Update("update openapi_order set status = #{status}, update_time = #{updateTime} where id = #{id}")
    int updateStatus(OpenApiOrder order);
}
