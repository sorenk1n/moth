package com.java2nb.novel.mapper;

import com.java2nb.novel.entity.UserExternalBind;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface UserExternalBindMapper {

    @Select("select id, user_id as userId, external_app_id as externalAppId, external_user_id as externalUserId, "
        + "alipay_user_id as alipayUserId, alipay_account as alipayAccount, alipay_real_name as alipayRealName, "
        + "create_time as createTime, update_time as updateTime "
        + "from user_external_bind where external_app_id = #{appId} and external_user_id = #{externalUserId} limit 1")
    UserExternalBind findByAppAndExternalUserId(String appId, String externalUserId);

    @Select("select id, user_id as userId, external_app_id as externalAppId, external_user_id as externalUserId, "
        + "alipay_user_id as alipayUserId, alipay_account as alipayAccount, alipay_real_name as alipayRealName, "
        + "create_time as createTime, update_time as updateTime "
        + "from user_external_bind where alipay_user_id = #{alipayUserId} limit 1")
    UserExternalBind findByAlipayUserId(String alipayUserId);

    @Select("select id, user_id as userId, external_app_id as externalAppId, external_user_id as externalUserId, "
        + "alipay_user_id as alipayUserId, alipay_account as alipayAccount, alipay_real_name as alipayRealName, "
        + "create_time as createTime, update_time as updateTime "
        + "from user_external_bind where alipay_account = #{alipayAccount} limit 1")
    UserExternalBind findByAlipayAccount(String alipayAccount);

    @Insert("insert into user_external_bind (user_id, external_app_id, external_user_id, alipay_user_id, "
        + "alipay_account, alipay_real_name, create_time, update_time) "
        + "values (#{userId}, #{externalAppId}, #{externalUserId}, #{alipayUserId}, "
        + "#{alipayAccount}, #{alipayRealName}, #{createTime}, #{updateTime})")
    int insert(UserExternalBind bind);

    @Update("update user_external_bind set alipay_user_id = #{alipayUserId}, alipay_account = #{alipayAccount}, "
        + "alipay_real_name = #{alipayRealName}, update_time = #{updateTime} where id = #{id}")
    int updateAlipayInfo(UserExternalBind bind);
}
