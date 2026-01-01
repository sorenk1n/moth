ALTER TABLE `pay_merchant`
  ADD COLUMN `is_default` TINYINT NOT NULL DEFAULT 0 COMMENT '是否默认商户 1默认 0非默认',
  ADD COLUMN `md5_key` VARCHAR(64) DEFAULT NULL COMMENT 'MD5密钥',
  ADD COLUMN `aes_key` VARCHAR(64) DEFAULT NULL COMMENT 'AES密钥';

UPDATE `pay_merchant` SET is_default = 1 WHERE merchant_no = '888007';
UPDATE `pay_merchant` SET md5_key = 'cxTWgAyMrtTiYEiH', aes_key = 'cxTWgAyMrtTiYEiH';
