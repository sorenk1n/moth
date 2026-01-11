package com.java2nb.novel.mapper;

import com.java2nb.novel.entity.OpenApiApp;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface OpenApiAppMapper {

    @Select("select id, app_id as appId, app_secret as appSecret, notify_url as notifyUrl, "
        + "return_url as returnUrl, ip_whitelist as ipWhitelist, max_qps as maxQps, day_limit as dayLimit, "
        + "status, create_time as createTime, update_time as updateTime "
        + "from openapi_app where app_id = #{appId} limit 1")
    OpenApiApp findByAppId(String appId);
}
