DROP TABLE IF EXISTS `pay_merchant`;
CREATE TABLE IF NOT EXISTS `pay_merchant` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_no` VARCHAR(64) NOT NULL COMMENT '商户号，用于 externalId',
  `alipay_merchant_no` VARCHAR(64) DEFAULT NULL COMMENT '支付宝商户号',
  `name` VARCHAR(128) NOT NULL COMMENT '商户名称',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态 1启用 0禁用',
  `remark` VARCHAR(255) DEFAULT NULL COMMENT '备注',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_merchant_no` (`merchant_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付商户配置';

-- 初始化商户数据（商户号与名称一一对应，remark 为简称）
INSERT INTO `pay_merchant` (merchant_no, alipay_merchant_no, name, status, remark) VALUES
('888002', '2088180740486453', '杭州芝音科技有限公司', 1, '芝音科技'),
('888003', '2088180741995600', '深圳市迪迦传媒科技有限公司', 1, '迪加传媒'),
('888004', '2088180721005093', '深圳市宏芯橙网络科技有限公司', 1, '宏芯科技'),
('888005', '2088180723811522', '广西柳州市美全网络科技有限公司', 1, '美全科技'),
('888006', '2088180723408643', '广西杰淦贸易有限公司', 1, '杰淦贸易'),
('888007', '2088180665259943', '内蒙古新开始科技有限公司', 1, '新开始科技'),
('888008', '2088180674111894', '广州巳嬴科技有限公司', 1, '巳嬴科技'),
('888009', '2088180720587105', '广西吉汇安商贸有限公司', 1, '吉汇安商贸'),
('888010', '2088180664479285', '广州巳蠃科技有限公司', 1, '巳蠃科技'),
('888011', '2088180668331543', '深圳市秋龙文化传媒有限公司', 1, '秋龙科技'),
('888012', '2088180671091584', '惠州市主角文化传播有限公司', 1, '主角科技'),
('888013', '2088180493305485', '广州已嬴科技有限公司', 1, '已嬴科技'),
('888014', '2088180497525911', '广州己羸科技有限公司', 1, '己羸科技');
