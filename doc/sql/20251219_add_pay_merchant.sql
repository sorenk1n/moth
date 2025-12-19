CREATE TABLE IF NOT EXISTS `pay_merchant` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_no` VARCHAR(64) NOT NULL COMMENT '商户号，用于 externalId',
  `name` VARCHAR(128) NOT NULL COMMENT '商户名称',
  `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态 1启用 0禁用',
  `remark` VARCHAR(255) DEFAULT NULL COMMENT '备注',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_merchant_no` (`merchant_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付商户配置';

-- 初始化商户数据（商户号与名称一一对应，remark 为简称）
INSERT INTO `pay_merchant` (merchant_no, name, status, remark) VALUES
('888002', '广州已嬴科技有限公司', 1, '已嬴科技'),
('888003', '广州己羸科技有限公司', 1, '己羸科技'),
('888004', '惠州市主角文化传播有限公司', 1, '主角科技'),
('888005', '深圳市秋龙文化传媒有限公司', 1, '秋龙科技'),
('888006', '广州巳蠃科技有限公司', 1, '巳蠃科技'),
('888007', '广西吉汇安商贸有限公司', 1, '吉汇安商贸'),
('888008', '广州巳嬴科技有限公司', 1, '巳嬴科技'),
('888009', '内蒙古新开始科技有限公司', 1, '新开始科技'),
('888010', '广西杰淦贸易有限公司', 1, '杰淦贸易'),
('888011', '广西柳州市美全网络科技有限公司', 1, '美全科技'),
('888012', '深圳市宏芯橙网络科技有限公司', 1, '宏芯科技'),
('888013', '杭州芝音科技有限公司', 1, '芝音科技'),
('888014', '深圳市迪迦传媒科技有限公司', 1, '迪加传媒');
