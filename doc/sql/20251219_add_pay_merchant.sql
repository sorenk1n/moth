-- 1. 如果表已存在则删除
DROP TABLE IF EXISTS `pay_merchant`;

-- 2. 创建表：包含所有基础字段及新增的密钥、默认标识字段
CREATE TABLE `pay_merchant` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_no` VARCHAR(64) NOT NULL COMMENT '商户号，用于 externalId',
  `alipay_merchant_no` VARCHAR(64) DEFAULT NULL COMMENT '支付宝商户号',
  `group_external_id` VARCHAR(64) DEFAULT NULL COMMENT '商户分组外部标识',
  `name` VARCHAR(128) NOT NULL COMMENT '商户名称',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态 1启用 0禁用',
  `is_default` TINYINT NOT NULL DEFAULT 0 COMMENT '是否默认商户 1默认 0非默认',
  `md5_key` VARCHAR(64) DEFAULT NULL COMMENT 'MD5密钥',
  `aes_key` VARCHAR(64) DEFAULT NULL COMMENT 'AES密钥',
  `remark` VARCHAR(255) DEFAULT NULL COMMENT '备注',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_merchant_no` (`merchant_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付商户配置';

-- 3. 初始化数据
-- 逻辑：
-- - 所有记录的 md5_key 和 aes_key 统一赋值
-- - 仅商户号 '888007' 的 is_default 设为 1，其余为 0
INSERT INTO `pay_merchant` 
(merchant_no, alipay_merchant_no, name, status, is_default, md5_key, aes_key, remark) 
VALUES
('888002', '2088180740486453', '杭州芝音科技有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '芝音科技'),
('888003', '2088180741995600', '深圳市迪迦传媒科技有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '迪加传媒'),
('888004', '2088180721005093', '深圳市宏芯橙网络科技有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '宏芯科技'),
('888005', '2088180723811522', '广西柳州市美全网络科技有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '美全科技'),
('888006', '2088180723408643', '广西杰淦贸易有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '杰淦贸易'),
('888007', '2088180665259943', '内蒙古新开始科技有限公司', 1, 1, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '新开始科技'),
('888008', '2088180674111894', '广州巳嬴科技有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '巳嬴科技'),
('888009', '2088180720587105', '广西吉汇安商贸有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '吉汇安商贸'),
('888010', '2088180664479285', '广州巳蠃科技有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '巳蠃科技'),
('888011', '2088180668331543', '深圳市秋龙文化传媒有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '秋龙科技'),
('888012', '2088180671091584', '惠州市主角文化传播有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '主角科技'),
('888013', '2088180493305485', '广州已嬴科技有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '已嬴科技'),
('888014', '2088180497525911', '广州己羸科技有限公司', 1, 0, 'cxTWgAyMrtTiYEiH', 'cxTWgAyMrtTiYEiH', '己羸科技');