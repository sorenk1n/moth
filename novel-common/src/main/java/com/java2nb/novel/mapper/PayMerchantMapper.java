package com.java2nb.novel.mapper;

import com.java2nb.novel.entity.PayMerchant;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface PayMerchantMapper {

    @Select("select id, merchant_no as merchantNo, alipay_merchant_no as alipayMerchantNo, name, status, is_default as isDefault, md5_key as md5Key, aes_key as aesKey, remark, create_time as createTime, update_time as updateTime "
        + "from pay_merchant where status in (1,2) order by id")
    List<PayMerchant> listActive();

    @Select("select id, merchant_no as merchantNo, alipay_merchant_no as alipayMerchantNo, name, status, is_default as isDefault, md5_key as md5Key, aes_key as aesKey, remark, create_time as createTime, update_time as updateTime "
        + "from pay_merchant order by is_default desc, id")
    List<PayMerchant> listAll();

    @Select("select id, merchant_no as merchantNo, alipay_merchant_no as alipayMerchantNo, name, status, is_default as isDefault, md5_key as md5Key, aes_key as aesKey, remark, create_time as createTime, update_time as updateTime "
        + "from pay_merchant where is_default = 1 limit 1")
    PayMerchant findDefault();

    @Insert("insert into pay_merchant (merchant_no, alipay_merchant_no, name, status, is_default, md5_key, aes_key, remark) "
        + "values (#{merchantNo}, #{alipayMerchantNo}, #{name}, #{status}, #{isDefault}, #{md5Key}, #{aesKey}, #{remark})")
    int insert(PayMerchant merchant);

    @Update("update pay_merchant set status = #{status} where id = #{id}")
    int updateStatus(Long id, Byte status);

    @Update("update pay_merchant set is_default = 0")
    int clearDefault();

    @Update("update pay_merchant set is_default = 1 where id = #{id}")
    int setDefault(Long id);

    @Delete("delete from pay_merchant where id = #{id}")
    int deleteById(Long id);
}
