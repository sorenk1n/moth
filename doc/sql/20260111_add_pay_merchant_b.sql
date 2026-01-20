DROP TABLE IF EXISTS `pay_merchant_b`;
CREATE TABLE `pay_merchant_b` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_no` varchar(32) NOT NULL COMMENT '商户号',
  `alipay_merchant_no` varchar(64) DEFAULT NULL COMMENT '支付宝商户号',
  `name` varchar(64) NOT NULL COMMENT '商户名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1启用 2风控 0禁用',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认商户',
  `md5_key` varchar(64) DEFAULT NULL COMMENT 'MD5密钥',
  `aes_key` varchar(64) DEFAULT NULL COMMENT 'AES密钥',
  `group_external_id` varchar(64) DEFAULT NULL COMMENT '商户分组外部标识',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付商户配置B';

INSERT INTO `pay_merchant_b` (
  `merchant_no`, 
  `alipay_merchant_no`, 
  `name`, 
  `status`, 
  `remark`, 
  `create_time`, 
  `update_time`, 
  `is_default`, 
  `md5_key`, 
  `aes_key`
) VALUES (
  '888088', 
  NULL,               -- 如果有对应的支付宝商户号请在此填入
  '百琤网络', 
  1,                  -- 默认启用状态
  '百琤网络',          -- 备注存放公司简称
  NOW(), 
  NOW(), 
  1,                  -- 默认商户
  'gk4hq3NvtR%', 
  'RjqZYa4KwbkX1V5DbE9fhkDz'
);