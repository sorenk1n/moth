package com.java2nb.novel.mapper;

import com.java2nb.novel.entity.PayMerchant;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface PayMerchantMapper {

    @Select("select id, merchant_no as merchantNo, name, status, remark, create_time as createTime, update_time as updateTime "
        + "from pay_merchant where status = 1 order by id")
    List<PayMerchant> listActive();
}
