package com.java2nb.novel.mapper;

import com.java2nb.novel.entity.OpenApiNotifyTask;
import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface OpenApiNotifyTaskMapper {

    @Insert("insert into openapi_notify_task (app_id, notify_url, external_order_no, out_trade_no, amount, trade_no, "
        + "attach, status, retry_count, max_retry, next_retry_time, last_error, create_time, update_time) "
        + "values (#{appId}, #{notifyUrl}, #{externalOrderNo}, #{outTradeNo}, #{amount}, #{tradeNo}, "
        + "#{attach}, #{status}, #{retryCount}, #{maxRetry}, #{nextRetryTime}, #{lastError}, #{createTime}, #{updateTime})")
    int insert(OpenApiNotifyTask task);

    @Select("select id, app_id as appId, notify_url as notifyUrl, external_order_no as externalOrderNo, "
        + "out_trade_no as outTradeNo, amount, trade_no as tradeNo, attach, status, retry_count as retryCount, "
        + "max_retry as maxRetry, next_retry_time as nextRetryTime, last_error as lastError, "
        + "create_time as createTime, update_time as updateTime "
        + "from openapi_notify_task where status = 0 and next_retry_time <= #{now} order by id limit #{limit}")
    List<OpenApiNotifyTask> findDueTasks(@Param("now") Date now, @Param("limit") int limit);

    @Update("update openapi_notify_task set status = 1, update_time = #{now} where id = #{id} and status = 0")
    int markProcessing(@Param("id") Long id, @Param("now") Date now);

    @Update("update openapi_notify_task set status = 2, update_time = #{now}, last_error = null where id = #{id}")
    int markSuccess(@Param("id") Long id, @Param("now") Date now);

    @Update("update openapi_notify_task set status = #{task.status}, retry_count = #{task.retryCount}, "
        + "next_retry_time = #{task.nextRetryTime}, last_error = #{task.lastError}, update_time = #{now} "
        + "where id = #{task.id}")
    int updateRetry(@Param("task") OpenApiNotifyTask task, @Param("now") Date now);

    @Select("select id, app_id as appId, notify_url as notifyUrl, external_order_no as externalOrderNo, "
        + "out_trade_no as outTradeNo, amount, trade_no as tradeNo, attach, status, retry_count as retryCount, "
        + "max_retry as maxRetry, next_retry_time as nextRetryTime, last_error as lastError, "
        + "create_time as createTime, update_time as updateTime "
        + "from openapi_notify_task where (#{status} is null or status = #{status}) "
        + "order by id desc limit #{offset}, #{limit}")
    List<OpenApiNotifyTask> list(@Param("status") Integer status, @Param("offset") int offset,
        @Param("limit") int limit);

    @Select("select count(1) from openapi_notify_task where (#{status} is null or status = #{status})")
    int count(@Param("status") Integer status);

    @Update("update openapi_notify_task set status = 0, next_retry_time = #{now}, update_time = #{now} "
        + "where id = #{id}")
    int resetForRetry(@Param("id") Long id, @Param("now") Date now);
}
