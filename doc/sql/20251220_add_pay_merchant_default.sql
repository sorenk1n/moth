ALTER TABLE `pay_merchant`
  ADD COLUMN `is_default` TINYINT NOT NULL DEFAULT 0 COMMENT '是否默认商户 1默认 0非默认';

UPDATE `pay_merchant` SET is_default = 1 WHERE merchant_no = '888007';
