-- openapi app config
DROP TABLE IF EXISTS `openapi_app`;
CREATE TABLE `openapi_app` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) NOT NULL COMMENT '接入方标识',
  `app_secret` varchar(128) NOT NULL COMMENT '接入方密钥',
  `notify_url` varchar(255) DEFAULT NULL COMMENT '默认异步回调地址',
  `return_url` varchar(255) DEFAULT NULL COMMENT '默认同步跳转地址',
  `ip_whitelist` varchar(512) DEFAULT NULL COMMENT 'IP白名单，逗号分隔',
  `max_qps` int DEFAULT NULL COMMENT '每秒限流阈值',
  `day_limit` int DEFAULT NULL COMMENT '每日限额',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_app_id` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='openapi接入方配置';

-- external user bind
DROP TABLE IF EXISTS `user_external_bind`;
CREATE TABLE `user_external_bind` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '本地用户ID',
  `external_app_id` varchar(64) NOT NULL COMMENT '接入方ID',
  `external_user_id` varchar(128) NOT NULL COMMENT '接入方用户ID',
  `alipay_user_id` varchar(64) DEFAULT NULL COMMENT '支付宝用户UID',
  `alipay_account` varchar(128) DEFAULT NULL COMMENT '支付宝账号',
  `alipay_real_name` varchar(64) DEFAULT NULL COMMENT '支付宝实名',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_app_user` (`external_app_id`, `external_user_id`),
  UNIQUE KEY `uq_alipay_user` (`alipay_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='外部用户绑定表';

-- openapi order mapping
DROP TABLE IF EXISTS `openapi_order`;
CREATE TABLE `openapi_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) NOT NULL COMMENT '接入方ID',
  `external_order_no` varchar(64) NOT NULL COMMENT '接入方订单号',
  `out_trade_no` bigint NOT NULL COMMENT '本地订单号',
  `user_id` bigint NOT NULL COMMENT '本地用户ID',
  `amount` int NOT NULL COMMENT '金额(分)',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0创建 1已支付 2失败',
  `notify_url` varchar(255) DEFAULT NULL,
  `return_url` varchar(255) DEFAULT NULL,
  `attach` varchar(500) DEFAULT NULL,
  `gateway_url` varchar(255) DEFAULT NULL,
  `pay_body` text COMMENT '支付body',
  `pay_headers` text COMMENT '支付headers(JSON)',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_app_order` (`app_id`, `external_order_no`),
  KEY `idx_out_trade_no` (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='openapi订单映射表';

-- openapi notify task
DROP TABLE IF EXISTS `openapi_notify_task`;
CREATE TABLE `openapi_notify_task` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) NOT NULL COMMENT '接入方ID',
  `notify_url` varchar(255) NOT NULL COMMENT '回调地址',
  `external_order_no` varchar(64) NOT NULL COMMENT '接入方订单号',
  `out_trade_no` bigint NOT NULL COMMENT '本地订单号',
  `amount` int NOT NULL COMMENT '金额(分)',
  `trade_no` varchar(64) DEFAULT NULL COMMENT '支付交易号',
  `attach` varchar(500) DEFAULT NULL COMMENT '透传字段',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0待处理 1处理中 2成功 3失败',
  `retry_count` int NOT NULL DEFAULT '0' COMMENT '已重试次数',
  `max_retry` int NOT NULL DEFAULT '5' COMMENT '最大重试次数',
  `next_retry_time` datetime DEFAULT NULL COMMENT '下次重试时间',
  `last_error` varchar(500) DEFAULT NULL COMMENT '最后一次错误',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_status_time` (`status`, `next_retry_time`),
  KEY `idx_app_order` (`app_id`, `external_order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='openapi回调任务表';
