-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               8.0.40 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.14.0.7165
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for novel_plus
DROP DATABASE IF EXISTS `novel_plus`;
CREATE DATABASE IF NOT EXISTS `novel_plus` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `novel_plus`;

-- Dumping structure for table novel_plus.author
DROP TABLE IF EXISTS `author`;
CREATE TABLE IF NOT EXISTS `author` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `invite_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邀请码',
  `pen_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '笔名',
  `tel_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手机号码',
  `chat_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'QQ或微信账号',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '电子邮箱',
  `work_direction` tinyint DEFAULT NULL COMMENT '作品方向，0：男频，1：女频',
  `status` tinyint DEFAULT '0' COMMENT '0：正常，1：封禁',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='作者表';

-- Dumping data for table novel_plus.author: ~21 rows (approximately)
DELETE FROM `author`;
INSERT INTO `author` (`id`, `user_id`, `invite_code`, `pen_name`, `tel_phone`, `chat_account`, `email`, `work_direction`, `status`, `create_time`) VALUES
	(1, NULL, 'reerer', 'abc', '13560487656', '23484388', '23484388@qq.com', 0, 0, NULL),
	(2, 1255060328322027520, 'rwrr445554', '梦入神机', '13560421324', '1179705413', 'reerer@qq.com', 0, 0, '2020-05-13 14:01:31'),
	(3, 1997843516947996672, 'kktt', 'kk', '13456789076', '13456789076', '13456789076@qq.com', 0, 0, '2025-12-08 09:47:35'),
	(9001, NULL, 'demoA', '青云客', NULL, NULL, NULL, 0, 0, '2025-12-08 18:54:01'),
	(9002, NULL, 'demoB', '南风骨', NULL, NULL, NULL, 0, 0, '2025-12-08 18:54:01'),
	(9010, NULL, 'demoC', '北庭墨', NULL, NULL, NULL, 0, 0, '2025-12-08 18:57:29'),
	(9011, NULL, 'demoD', '长夜灯', NULL, NULL, NULL, 0, 0, '2025-12-08 18:57:29'),
	(9012, NULL, 'demoE', '江上风', NULL, NULL, NULL, 0, 0, '2025-12-08 18:57:29'),
	(9013, NULL, 'demoF', '听雨僧', NULL, NULL, NULL, 1, 0, '2025-12-08 18:57:29'),
	(9101, NULL, 'demo9101', '北冥舟', NULL, NULL, NULL, 0, 0, '2025-12-09 11:07:17'),
	(9102, NULL, 'demo9102', '明月楼', NULL, NULL, NULL, 0, 0, '2025-12-09 11:07:17'),
	(9201, NULL, NULL, '风雪客', NULL, NULL, NULL, 0, 0, '2025-12-09 11:18:41'),
	(9202, NULL, NULL, '顾长清', NULL, NULL, NULL, 0, 0, '2025-12-09 11:18:41'),
	(9203, NULL, NULL, '南山远', NULL, NULL, NULL, 0, 0, '2025-12-09 11:18:41'),
	(9204, NULL, NULL, '白衣渡江', NULL, NULL, NULL, 0, 0, '2025-12-09 11:18:41'),
	(9205, NULL, NULL, '青檀', NULL, NULL, NULL, 0, 0, '2025-12-09 11:18:41'),
	(9206, NULL, NULL, '江月', NULL, NULL, NULL, 0, 0, '2025-12-09 11:18:41'),
	(9207, NULL, NULL, '林间鹤', NULL, NULL, NULL, 0, 0, '2025-12-09 11:18:41'),
	(9208, NULL, NULL, '北城', NULL, NULL, NULL, 0, 0, '2025-12-09 11:18:41'),
	(9209, NULL, NULL, '星海', NULL, NULL, NULL, 0, 0, '2025-12-09 11:18:41'),
	(9210, NULL, NULL, '时野', NULL, NULL, NULL, 0, 0, '2025-12-09 11:18:41');

-- Dumping structure for table novel_plus.author_code
DROP TABLE IF EXISTS `author_code`;
CREATE TABLE IF NOT EXISTS `author_code` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `invite_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邀请码',
  `validity_time` datetime DEFAULT NULL COMMENT '有效时间',
  `is_use` tinyint(1) DEFAULT '0' COMMENT '是否使用过，0：未使用，1:使用过',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建人ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_code` (`invite_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='作家邀请码表';

-- Dumping data for table novel_plus.author_code: ~4 rows (approximately)
DELETE FROM `author_code`;
INSERT INTO `author_code` (`id`, `invite_code`, `validity_time`, `is_use`, `create_time`, `create_user_id`) VALUES
	(3, 'reerer', '2020-05-27 22:43:45', 1, '2020-05-13 11:40:56', 1),
	(4, '123456', '2020-05-28 00:00:00', 0, '2020-05-13 14:09:55', 1),
	(5, 'ww34343', '2020-05-21 00:00:00', 0, '2020-05-13 14:18:58', 1),
	(6, 'kktt', '2025-12-31 00:00:00', 1, '2025-12-08 09:47:28', 1);

-- Dumping structure for table novel_plus.author_income
DROP TABLE IF EXISTS `author_income`;
CREATE TABLE IF NOT EXISTS `author_income` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `author_id` bigint NOT NULL COMMENT '作家ID',
  `book_id` bigint NOT NULL COMMENT '作品ID',
  `income_month` date NOT NULL COMMENT '收入月份',
  `pre_tax_income` bigint NOT NULL DEFAULT '0' COMMENT '税前收入（分）',
  `after_tax_income` bigint NOT NULL DEFAULT '0' COMMENT '税后收入（分）',
  `pay_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '支付状态，0：待支付，1：已支付',
  `confirm_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '稿费确认状态，0：待确认，1：已确认',
  `detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '详情',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='稿费收入统计表';

-- Dumping data for table novel_plus.author_income: ~0 rows (approximately)
DELETE FROM `author_income`;

-- Dumping structure for table novel_plus.author_income_detail
DROP TABLE IF EXISTS `author_income_detail`;
CREATE TABLE IF NOT EXISTS `author_income_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `author_id` bigint NOT NULL COMMENT '作家ID',
  `book_id` bigint NOT NULL DEFAULT '0' COMMENT '作品ID,0表示全部作品',
  `income_date` date NOT NULL COMMENT '收入日期',
  `income_account` int NOT NULL DEFAULT '0' COMMENT '订阅总额',
  `income_count` int NOT NULL DEFAULT '0' COMMENT '订阅次数',
  `income_number` int NOT NULL DEFAULT '0' COMMENT '订阅人数',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='稿费收入明细统计表';

-- Dumping data for table novel_plus.author_income_detail: ~1 rows (approximately)
DELETE FROM `author_income_detail`;
INSERT INTO `author_income_detail` (`id`, `user_id`, `author_id`, `book_id`, `income_date`, `income_account`, `income_count`, `income_number`, `create_time`) VALUES
	(1, 1255060328322027520, 2, 0, '2025-11-20', 0, 0, 0, '2025-11-21 09:53:13');

-- Dumping structure for table novel_plus.book
DROP TABLE IF EXISTS `book`;
CREATE TABLE IF NOT EXISTS `book` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `work_direction` tinyint(1) DEFAULT NULL COMMENT '作品方向，0：男频，1：女频''',
  `cat_id` int DEFAULT NULL COMMENT '分类ID',
  `cat_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '分类名',
  `pic_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '小说封面',
  `book_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '小说名',
  `author_id` bigint DEFAULT NULL COMMENT '作者id',
  `author_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '作者名',
  `book_desc` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '书籍描述',
  `score` float NOT NULL COMMENT '评分，预留字段',
  `book_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '书籍状态，0：连载中，1：已完结',
  `visit_count` bigint DEFAULT '103' COMMENT '点击量',
  `word_count` int DEFAULT NULL COMMENT '总字数',
  `comment_count` int DEFAULT '0' COMMENT '评论数',
  `last_index_id` bigint DEFAULT NULL COMMENT '最新目录ID',
  `last_index_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '最新目录名',
  `last_index_update_time` datetime DEFAULT NULL COMMENT '最新目录更新时间',
  `is_vip` tinyint(1) DEFAULT '0' COMMENT '是否收费，1：收费，0：免费',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态，0：入库，1：上架',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `crawl_source_id` int DEFAULT NULL COMMENT '爬虫源站ID',
  `crawl_book_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '抓取的源站小说ID',
  `crawl_last_time` datetime DEFAULT NULL COMMENT '最后一次的抓取时间',
  `crawl_is_stop` tinyint(1) DEFAULT '0' COMMENT '是否已停止更新，0：未停止，1：已停止',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_bookName_authorName` (`book_name`,`author_name`) USING BTREE,
  KEY `key_lastIndexUpdateTime` (`last_index_update_time`) USING BTREE,
  KEY `key_createTime` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1262260513468559361 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说表';

-- Dumping data for table novel_plus.book: ~8 rows (approximately)
DELETE FROM `book`;
INSERT INTO `book` (`id`, `work_direction`, `cat_id`, `cat_name`, `pic_url`, `book_name`, `author_id`, `author_name`, `book_desc`, `score`, `book_status`, `visit_count`, `word_count`, `comment_count`, `last_index_id`, `last_index_name`, `last_index_update_time`, `is_vip`, `status`, `update_time`, `create_time`, `crawl_source_id`, `crawl_book_id`, `crawl_last_time`, `crawl_is_stop`) VALUES
	(202601020100000001, 0, 1, '玄幻奇幻', '/images/default.gif', '银河破晓', NULL, '云上观星', '远古星门再启，少年踏入失落星域，开启一段跨越诸天的修行之旅。', 9.2, 0, 35601, 520000, 12, 202601020200000001, '第1章 星门初启', '2026-01-02 20:10:00', 0, 1, '2026-01-02 20:10:00', '2026-01-02 20:10:00', NULL, NULL, NULL, 0),
	(202601020100000002, 0, 2, '武侠仙侠', '/images/default.gif', '剑影归途', NULL, '墨竹', '江湖风雨骤起，少年持剑入世，以侠义照破迷雾。', 8.9, 1, 28902, 430000, 8, 202601020200000002, '第1章 初入江湖', '2026-01-02 20:10:00', 0, 1, '2026-01-02 20:10:00', '2026-01-02 20:10:00', NULL, NULL, NULL, 0),
	(202601020100000003, 0, 3, '都市言情', '/images/default.gif', '心动微光', NULL, '苏念', '从误会到相知，她与他在都市霓虹中找到彼此的答案。', 9.1, 0, 41200, 300000, 20, 202601020200000003, '第1章 重逢', '2026-01-02 20:10:00', 0, 1, '2026-01-02 20:10:00', '2026-01-02 20:10:00', NULL, NULL, NULL, 0),
	(202601020100000004, 0, 4, '历史军事', '/images/default.gif', '烽火边城', NULL, '长风', '边城烽火起，青年将军以热血书写乱世传奇。', 8.7, 0, 19800, 610000, 5, 202601020200000004, '第1章 边城风起', '2026-01-02 20:10:00', 0, 1, '2026-01-02 20:10:00', '2026-01-02 20:10:00', NULL, NULL, NULL, 0),
	(202601020100000005, 0, 5, '科幻灵异', '/images/default.gif', '深空回声', NULL, '林岚', '宇宙深处传来神秘信号，探索队踏上未知征程。', 9, 1, 50300, 280000, 14, 202601020200000005, '第1章 信号', '2026-01-02 20:10:00', 0, 1, '2026-01-02 20:10:00', '2026-01-02 20:10:00', NULL, NULL, NULL, 0),
	(202601020100000006, 0, 6, '网游竞技', '/images/default.gif', '全服第一', NULL, '夜行者', '普通玩家逆袭成神，带队冲击联赛巅峰。', 8.8, 0, 26700, 350000, 9, 202601020200000006, '第1章 归来', '2026-01-02 20:10:00', 0, 1, '2026-01-02 20:10:00', '2026-01-02 20:10:00', NULL, NULL, NULL, 0),
	(202601020100000007, 1, 7, '女生频道', '/images/default.gif', '花信风', NULL, '晚棠', '她在四季花信中重拾自我，与他携手共赴远方。', 9.3, 0, 37800, 240000, 18, 202601020200000007, '第1章 春风起', '2026-01-02 20:10:00', 0, 1, '2026-01-02 20:10:00', '2026-01-02 20:10:00', NULL, NULL, NULL, 0),
	(202601020100000008, 0, 1, '玄幻奇幻', '/images/default.gif', '苍穹之上', NULL, '北冥', '少年觉醒天赋，踏上苍穹之上的征途。', 8.6, 0, 22500, 410000, 6, 202601020200000008, '第1章 觉醒', '2026-01-02 20:10:00', 0, 1, '2026-01-02 20:10:00', '2026-01-02 20:10:00', NULL, NULL, NULL, 0);

-- Dumping structure for table novel_plus.book_author
DROP TABLE IF EXISTS `book_author`;
CREATE TABLE IF NOT EXISTS `book_author` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `invite_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邀请码',
  `pen_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '笔名',
  `tel_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手机号码',
  `chat_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'QQ或微信账号',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '电子邮箱',
  `work_direction` tinyint DEFAULT NULL COMMENT '作品方向，0：男频，1：女频',
  `status` tinyint DEFAULT NULL COMMENT '0：待审核，1：审核通过，正常，2：审核不通过',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '申请人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1254957873655066625 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='作者表';

-- Dumping data for table novel_plus.book_author: ~0 rows (approximately)
DELETE FROM `book_author`;

-- Dumping structure for table novel_plus.book_category
DROP TABLE IF EXISTS `book_category`;
CREATE TABLE IF NOT EXISTS `book_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `work_direction` tinyint(1) DEFAULT NULL COMMENT '作品方向，0：男频，1：女频''',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名',
  `sort` tinyint NOT NULL DEFAULT '10' COMMENT '排序',
  `create_user_id` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_user_id` bigint DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说类别表';

-- Dumping data for table novel_plus.book_category: ~7 rows (approximately)
DELETE FROM `book_category`;
INSERT INTO `book_category` (`id`, `work_direction`, `name`, `sort`, `create_user_id`, `create_time`, `update_user_id`, `update_time`) VALUES
	(1, 0, '玄幻奇幻', 10, NULL, NULL, NULL, NULL),
	(2, 0, '武侠仙侠', 11, NULL, NULL, NULL, NULL),
	(3, 0, '都市言情', 12, NULL, NULL, NULL, NULL),
	(4, 0, '历史军事', 13, NULL, NULL, NULL, NULL),
	(5, 0, '科幻灵异', 14, NULL, NULL, NULL, NULL),
	(6, 0, '网游竞技', 15, NULL, NULL, NULL, NULL),
	(7, 1, '女生频道', 16, NULL, NULL, NULL, NULL);

-- Dumping structure for table novel_plus.book_comment
DROP TABLE IF EXISTS `book_comment`;
CREATE TABLE IF NOT EXISTS `book_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `book_id` bigint DEFAULT NULL COMMENT '小说ID',
  `comment_content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '评价内容',
  `reply_count` int DEFAULT '0' COMMENT '回复数量',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '审核状态，0：待审核，1：审核通过，2：审核不通过',
  `create_time` datetime DEFAULT NULL COMMENT '评价时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '评价人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_bookid_userid` (`book_id`,`create_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说评论表';

-- Dumping data for table novel_plus.book_comment: ~2 rows (approximately)
DELETE FROM `book_comment`;
INSERT INTO `book_comment` (`id`, `book_id`, `comment_content`, `reply_count`, `audit_status`, `create_time`, `create_user_id`) VALUES
	(11, 1254678892443795456, '好书呀，值得一看', 0, 0, '2020-04-28 17:04:56', 1255060328322027520),
	(12, 1254954626689150976, 'ffgfgfffffffffff', 0, 0, '2020-04-30 08:35:53', 1255060328322027520);

-- Dumping structure for table novel_plus.book_comment_reply
DROP TABLE IF EXISTS `book_comment_reply`;
CREATE TABLE IF NOT EXISTS `book_comment_reply` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `comment_id` bigint DEFAULT NULL COMMENT '评论ID',
  `reply_content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '回复内容',
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '地理位置',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '审核状态，0：待审核，1：审核通过，2：审核不通过',
  `create_time` datetime DEFAULT NULL COMMENT '回复用户ID',
  `create_user_id` bigint DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说评论回复表';

-- Dumping data for table novel_plus.book_comment_reply: ~0 rows (approximately)
DELETE FROM `book_comment_reply`;

-- Dumping structure for table novel_plus.book_content
DROP TABLE IF EXISTS `book_content`;
CREATE TABLE IF NOT EXISTS `book_content` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3347742 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content: ~77 rows (approximately)
DELETE FROM `book_content`;
INSERT INTO `book_content` (`id`, `index_id`, `content`) VALUES
	(3347665, 3100000000000000001, '【苍穹行者】第一章 穿越。主角在实验事故中踏入异世，灵气扑面而来……'),
	(3347666, 3100000000000000002, '【苍穹行者】第二章 灵域初醒。第一道灵纹亮起，异能觉醒。'),
	(3347667, 3100000000000000003, '【苍穹行者】第三章 天穹试炼。进入试炼塔，迎战幻境巨兽。'),
	(3347668, 3100000000000000010, '【重启1999】第一章 重启。程序员重生回到拨号上网年代。'),
	(3347669, 3100000000000000011, '【重启1999】第二章 团队雏形。拉上老友，组建最早的创业小队。'),
	(3347670, 3100000000000000012, '【重启1999】第三章 首个产品。通宵写出第一个可上线的原型。'),
	(3347671, 3100000000000000020, '【星门守望】第一章 裂隙预警。太空监测站发现异常能量波动。'),
	(3347672, 3100000000000000021, '【星门守望】第二章 星舰集结。舰队准备跃迁，灵能者随行。'),
	(3347673, 3100000000000000022, '【星门守望】第三章 前哨星。登陆前哨星，发现未知文明遗迹。'),
	(3347674, 3300000000000000001, '【诸天道火】异火初醒，胸口一颗火种将他带入诸天试炼。'),
	(3347675, 3300000000000000002, '【诸天道火】炼道初试，他以灵火淬炼骨血。'),
	(3347676, 3300000000000000003, '【诸天道火】火种试炼，幻境巨兽扑来。'),
	(3347677, 3300000000000000011, '【剑气长河】江湖夜雨，三尺青锋出鞘。'),
	(3347678, 3300000000000000012, '【剑气长河】客栈争锋，刀光剑影间识得故人。'),
	(3347679, 3300000000000000013, '【剑气长河】三尺青锋破局，风云再起。'),
	(3347680, 3300000000000000021, '【氪金人生】系统到账，投资加成开启。'),
	(3347681, 3300000000000000022, '【氪金人生】第一单投资，风险与收益共舞。'),
	(3347682, 3300000000000000023, '【氪金人生】第一桶金到手，团队逐渐成型。'),
	(3347683, 3300000000000000031, '【铁血王庭】黑火试炼，火药与铁骑的碰撞。'),
	(3347684, 3300000000000000032, '【铁血王庭】火炮雏形初现，王庭震动。'),
	(3347685, 3300000000000000033, '【铁血王庭】黑火试阵，敌军溃退。'),
	(3347686, 3300000000000000041, '【星舰余烬】残骸苏醒，AI 第一声问候。'),
	(3347687, 3300000000000000042, '【星舰余烬】协议草案，与人类并肩的前哨计划。'),
	(3347688, 3300000000000000043, '【星舰余烬】前哨协议签订，星门即将开启。'),
	(3347689, 3300000000000000051, '【明月盼卿】小镇鼓点，少女的第一次排练。'),
	(3347690, 3300000000000000052, '【明月盼卿】练团初见，乐团默契初成。'),
	(3347691, 3300000000000000053, '【明月盼卿】初舞台，灯光下的勇气与泪水。'),
	(3347692, 3400000000000000001, '【星渊行者】坠落异星，主角醒来时星空坠火。'),
	(3347693, 3400000000000000002, '【星渊行者】灵能初醒，掌心浮现微光纹路。'),
	(3347694, 3400000000000000003, '【星渊行者】星舰遗迹开启，旧时代的 AI 苏醒。'),
	(3347695, 3400000000000000011, '【重启芯时代】重生 2010，错过的节点再次出现。'),
	(3347696, 3400000000000000012, '【重启芯时代】初创团队组建，车库里的第一台测试机。'),
	(3347697, 3400000000000000013, '【重启芯时代】第一片流片成功，风险投资上门。'),
	(3347698, 3400000000000000021, '【剑落江湖】初入江湖，一剑入世。'),
	(3347699, 3400000000000000022, '【剑落江湖】山门问剑，剑气纵横。'),
	(3347700, 3400000000000000023, '【剑落江湖】问剑山门，旧怨新仇并起。'),
	(3347701, 3400000000000000031, '【前哨协议】前哨站监测到异常能量波动。'),
	(3347702, 3400000000000000032, '【前哨协议】深空信号追踪，频段异常。'),
	(3347703, 3400000000000000033, '【前哨协议】信号解码，未知文明初现。'),
	(3347704, 3500000000000000001, '【苍穹裂隙】异星降临，裂隙开启。'),
	(3347705, 3500000000000000002, '【苍穹裂隙】星魂初醒，掌心微光。'),
	(3347706, 3500000000000000003, '【苍穹裂隙】裂隙试炼，旧舰苏醒。'),
	(3347707, 3500000000000000011, '【剑开天门】问剑天门，风雷交加。'),
	(3347708, 3500000000000000012, '【剑开天门】夜雨江湖，故人重逢。'),
	(3347709, 3500000000000000013, '【剑开天门】天门试剑，一剑惊鸿。'),
	(3347710, 3500000000000000021, '【重启蓝星】重启节点，再遇 2010。'),
	(3347711, 3500000000000000022, '【重启蓝星】车库雏形，团队集结。'),
	(3347712, 3500000000000000023, '【重启蓝星】创业雏形，初获关注。'),
	(3347713, 3500000000000000031, '【前哨迷航】前哨异常，深空信号。'),
	(3347714, 3500000000000000032, '【前哨迷航】深空信号，频段异常。'),
	(3347715, 3500000000000000033, '【前哨迷航】信号解码，未知文明。'),
	(3347716, 3500000000000000041, '【铁衣风雷】铁衣出鞘，战鼓雷动。'),
	(3347717, 3500000000000000042, '【铁衣风雷】黑火雏形，火器初成。'),
	(3347718, 3500000000000000043, '【铁衣风雷】黑火初试，敌军溃退。'),
	(3347719, 3500000000000000051, '【无限战场】登录战场，队伍集结。'),
	(3347720, 3500000000000000052, '【无限战场】团队集结，首次磨合。'),
	(3347721, 3500000000000000053, '【无限战场】首胜而归，士气大振。'),
	(3347722, 3500000000000000061, '【灵域之心】灵心现世，各族窥伺。'),
	(3347723, 3500000000000000062, '【灵域之心】诸族汇聚，暗流涌动。'),
	(3347724, 3500000000000000063, '【灵域之心】灵心试炼，天赋显露。'),
	(3347725, 3500000000000000071, '【星门守望】星门召唤，前哨戒备。'),
	(3347726, 3500000000000000072, '【星门守望】前哨集结，舰队待发。'),
	(3347727, 3500000000000000073, '【星门守望】星门初启，未知来客。'),
	(3347728, 3500000000000000081, '【九州问剑】问剑九州，四方震动。'),
	(3347729, 3500000000000000082, '【九州问剑】旧怨新仇并起。'),
	(3347730, 3500000000000000083, '【九州问剑】九剑一问，名动江湖。'),
	(3347731, 3500000000000000091, '【光影剧本】剧本开场，光影交错。'),
	(3347732, 3500000000000000092, '【光影剧本】反转伏笔埋下。'),
	(3347733, 3500000000000000093, '【光影剧本】剧本反转，命运改写。'),
	(3347734, 202601020200000001, '这是示例章节内容，用于本地展示。'),
	(3347735, 202601020200000002, '这是示例章节内容，用于本地展示。'),
	(3347736, 202601020200000003, '这是示例章节内容，用于本地展示。'),
	(3347737, 202601020200000004, '这是示例章节内容，用于本地展示。'),
	(3347738, 202601020200000005, '这是示例章节内容，用于本地展示。'),
	(3347739, 202601020200000006, '这是示例章节内容，用于本地展示。'),
	(3347740, 202601020200000007, '这是示例章节内容，用于本地展示。'),
	(3347741, 202601020200000008, '这是示例章节内容，用于本地展示。');

-- Dumping structure for table novel_plus.book_content0
DROP TABLE IF EXISTS `book_content0`;
CREATE TABLE IF NOT EXISTS `book_content0` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content0: ~0 rows (approximately)
DELETE FROM `book_content0`;

-- Dumping structure for table novel_plus.book_content1
DROP TABLE IF EXISTS `book_content1`;
CREATE TABLE IF NOT EXISTS `book_content1` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=406 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content1: ~0 rows (approximately)
DELETE FROM `book_content1`;

-- Dumping structure for table novel_plus.book_content2
DROP TABLE IF EXISTS `book_content2`;
CREATE TABLE IF NOT EXISTS `book_content2` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content2: ~0 rows (approximately)
DELETE FROM `book_content2`;

-- Dumping structure for table novel_plus.book_content3
DROP TABLE IF EXISTS `book_content3`;
CREATE TABLE IF NOT EXISTS `book_content3` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content3: ~0 rows (approximately)
DELETE FROM `book_content3`;

-- Dumping structure for table novel_plus.book_content4
DROP TABLE IF EXISTS `book_content4`;
CREATE TABLE IF NOT EXISTS `book_content4` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1188 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content4: ~0 rows (approximately)
DELETE FROM `book_content4`;

-- Dumping structure for table novel_plus.book_content5
DROP TABLE IF EXISTS `book_content5`;
CREATE TABLE IF NOT EXISTS `book_content5` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content5: ~0 rows (approximately)
DELETE FROM `book_content5`;

-- Dumping structure for table novel_plus.book_content6
DROP TABLE IF EXISTS `book_content6`;
CREATE TABLE IF NOT EXISTS `book_content6` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content6: ~0 rows (approximately)
DELETE FROM `book_content6`;

-- Dumping structure for table novel_plus.book_content7
DROP TABLE IF EXISTS `book_content7`;
CREATE TABLE IF NOT EXISTS `book_content7` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content7: ~0 rows (approximately)
DELETE FROM `book_content7`;

-- Dumping structure for table novel_plus.book_content8
DROP TABLE IF EXISTS `book_content8`;
CREATE TABLE IF NOT EXISTS `book_content8` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content8: ~0 rows (approximately)
DELETE FROM `book_content8`;

-- Dumping structure for table novel_plus.book_content9
DROP TABLE IF EXISTS `book_content9`;
CREATE TABLE IF NOT EXISTS `book_content9` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `index_id` bigint DEFAULT NULL COMMENT '目录ID',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '小说章节内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_indexId` (`index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=415 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说内容表';

-- Dumping data for table novel_plus.book_content9: ~0 rows (approximately)
DELETE FROM `book_content9`;

-- Dumping structure for table novel_plus.book_index
DROP TABLE IF EXISTS `book_index`;
CREATE TABLE IF NOT EXISTS `book_index` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `book_id` bigint NOT NULL COMMENT '小说ID',
  `index_num` int NOT NULL COMMENT '目录号',
  `index_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '目录名',
  `word_count` int DEFAULT NULL COMMENT '字数',
  `is_vip` tinyint DEFAULT '0' COMMENT '是否收费，1：收费，0：免费',
  `book_price` int DEFAULT '0' COMMENT '章节费用（屋币）',
  `storage_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'db' COMMENT '存储方式',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_bookId_indexNum` (`book_id`,`index_num`) USING BTREE,
  KEY `key_bookId` (`book_id`) USING BTREE,
  KEY `key_indexNum` (`index_num`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3500000000000000094 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说目录表';

-- Dumping data for table novel_plus.book_index: ~77 rows (approximately)
DELETE FROM `book_index`;
INSERT INTO `book_index` (`id`, `book_id`, `index_num`, `index_name`, `word_count`, `is_vip`, `book_price`, `storage_type`, `create_time`, `update_time`) VALUES
	(202601020200000001, 202601020100000001, 1, '第1章 星门初启', 1200, 0, 0, 'db', '2026-01-02 20:10:00', '2026-01-02 20:10:00'),
	(202601020200000002, 202601020100000002, 1, '第1章 初入江湖', 1100, 0, 0, 'db', '2026-01-02 20:10:00', '2026-01-02 20:10:00'),
	(202601020200000003, 202601020100000003, 1, '第1章 重逢', 980, 0, 0, 'db', '2026-01-02 20:10:00', '2026-01-02 20:10:00'),
	(202601020200000004, 202601020100000004, 1, '第1章 边城风起', 1300, 0, 0, 'db', '2026-01-02 20:10:00', '2026-01-02 20:10:00'),
	(202601020200000005, 202601020100000005, 1, '第1章 信号', 1050, 0, 0, 'db', '2026-01-02 20:10:00', '2026-01-02 20:10:00'),
	(202601020200000006, 202601020100000006, 1, '第1章 归来', 1150, 0, 0, 'db', '2026-01-02 20:10:00', '2026-01-02 20:10:00'),
	(202601020200000007, 202601020100000007, 1, '第1章 春风起', 1000, 0, 0, 'db', '2026-01-02 20:10:00', '2026-01-02 20:10:00'),
	(202601020200000008, 202601020100000008, 1, '第1章 觉醒', 1080, 0, 0, 'db', '2026-01-02 20:10:00', '2026-01-02 20:10:00'),
	(3100000000000000001, 2100000000000000001, 1, '第一章 穿越', 3200, 0, 0, 'db', '2025-12-08 18:54:01', '2025-12-08 18:54:01'),
	(3100000000000000002, 2100000000000000001, 2, '第二章 灵域初醒', 3100, 0, 0, 'db', '2025-12-08 18:54:01', '2025-12-08 18:54:01'),
	(3100000000000000003, 2100000000000000001, 3, '第三章 天穹试炼', 3400, 0, 0, 'db', '2025-12-08 18:54:01', '2025-12-08 18:54:01'),
	(3100000000000000010, 2100000000000000002, 1, '第一章 重启', 3000, 0, 0, 'db', '2025-12-08 18:54:01', '2025-12-08 18:54:01'),
	(3100000000000000011, 2100000000000000002, 2, '第二章 团队雏形', 2900, 0, 0, 'db', '2025-12-08 18:54:01', '2025-12-08 18:54:01'),
	(3100000000000000012, 2100000000000000002, 3, '第三章 首个产品', 2800, 0, 0, 'db', '2025-12-08 18:54:01', '2025-12-08 18:54:01'),
	(3100000000000000020, 2100000000000000003, 1, '第一章 裂隙预警', 3300, 0, 0, 'db', '2025-12-08 18:54:01', '2025-12-08 18:54:01'),
	(3100000000000000021, 2100000000000000003, 2, '第二章 星舰集结', 3200, 0, 0, 'db', '2025-12-08 18:54:01', '2025-12-08 18:54:01'),
	(3100000000000000022, 2100000000000000003, 3, '第三章 前哨星', 3100, 0, 0, 'db', '2025-12-08 18:54:01', '2025-12-08 18:54:01'),
	(3300000000000000001, 2200000000000000001, 1, '第一章 异火初醒', 3200, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000002, 2200000000000000001, 2, '第二章 炼道初试', 3300, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000003, 2200000000000000001, 3, '第三章 火种试炼', 3500, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000011, 2200000000000000002, 1, '第一章 江湖夜雨', 3000, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000012, 2200000000000000002, 2, '第二章 客栈争锋', 2900, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000013, 2200000000000000002, 3, '第三章 三尺青锋', 3100, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000021, 2200000000000000003, 1, '第一章 系统到账', 2800, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000022, 2200000000000000003, 2, '第二章 第一单投资', 2700, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000023, 2200000000000000003, 3, '第三章 第一桶金', 2600, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000031, 2200000000000000004, 1, '第一章 黑火试炼', 3300, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000032, 2200000000000000004, 2, '第二章 火炮雏形', 3200, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000033, 2200000000000000004, 3, '第三章 黑火试阵', 3100, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000041, 2200000000000000005, 1, '第一章 残骸苏醒', 3400, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000042, 2200000000000000005, 2, '第二章 协议草案', 3300, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000043, 2200000000000000005, 3, '第三章 前哨协议', 3200, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000051, 2200000000000000006, 1, '第一章 小镇鼓点', 2600, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000052, 2200000000000000006, 2, '第二章 练团初见', 2500, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3300000000000000053, 2200000000000000006, 3, '第三章 初舞台', 2400, 0, 0, 'db', '2025-12-08 18:57:29', '2025-12-08 18:57:29'),
	(3400000000000000001, 2300000000000000001, 1, '第一章 异星坠落', 3000, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000002, 2300000000000000001, 2, '第二章 灵能初醒', 3100, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000003, 2300000000000000001, 3, '第三章 星舰遗迹', 3200, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000011, 2300000000000000002, 1, '第一章 重启2010', 2800, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000012, 2300000000000000002, 2, '第二章 初创团队', 2700, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000013, 2300000000000000002, 3, '第三章 第一片流片', 2600, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000021, 2300000000000000003, 1, '第一章 入世', 2900, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000022, 2300000000000000003, 2, '第二章 山门问剑', 3000, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000023, 2300000000000000003, 3, '第三章 问剑山门', 3100, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000031, 2300000000000000004, 1, '第一章 前哨异常', 3100, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000032, 2300000000000000004, 2, '第二章 信号追踪', 3200, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3400000000000000033, 2300000000000000004, 3, '第三章 信号解码', 3300, 0, 0, 'db', '2025-12-09 11:12:32', '2025-12-09 11:12:32'),
	(3500000000000000001, 2400000000000000001, 1, '第一章 异星降临', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000002, 2400000000000000001, 2, '第二章 星魂初醒', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000003, 2400000000000000001, 3, '第三章 裂隙试炼', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000011, 2400000000000000002, 1, '第一章 问剑天门', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000012, 2400000000000000002, 2, '第二章 夜雨江湖', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000013, 2400000000000000002, 3, '第三章 天门试剑', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000021, 2400000000000000003, 1, '第一章 重启节点', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000022, 2400000000000000003, 2, '第二章 车库雏形', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000023, 2400000000000000003, 3, '第三章 创业雏形', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000031, 2400000000000000004, 1, '第一章 前哨异常', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000032, 2400000000000000004, 2, '第二章 深空信号', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000033, 2400000000000000004, 3, '第三章 信号解码', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000041, 2400000000000000005, 1, '第一章 铁衣出鞘', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000042, 2400000000000000005, 2, '第二章 黑火雏形', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000043, 2400000000000000005, 3, '第三章 黑火初试', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000051, 2400000000000000006, 1, '第一章 登录战场', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000052, 2400000000000000006, 2, '第二章 团队集结', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000053, 2400000000000000006, 3, '第三章 首胜', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000061, 2400000000000000007, 1, '第一章 灵心现世', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000062, 2400000000000000007, 2, '第二章 诸族汇聚', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000063, 2400000000000000007, 3, '第三章 灵心试炼', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000071, 2400000000000000008, 1, '第一章 星门召唤', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000072, 2400000000000000008, 2, '第二章 前哨集结', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000073, 2400000000000000008, 3, '第三章 星门初启', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000081, 2400000000000000009, 1, '第一章 问剑九州', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000082, 2400000000000000009, 2, '第二章 旧怨新仇', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000083, 2400000000000000009, 3, '第三章 九剑一问', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000091, 2400000000000000010, 1, '第一章 剧本开场', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000092, 2400000000000000010, 2, '第二章 反转伏笔', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41'),
	(3500000000000000093, 2400000000000000010, 3, '第三章 剧本反转', 3000, 0, 0, 'db', '2025-12-09 11:18:41', '2025-12-09 11:18:41');

-- Dumping structure for table novel_plus.book_screen_bullet
DROP TABLE IF EXISTS `book_screen_bullet`;
CREATE TABLE IF NOT EXISTS `book_screen_bullet` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content_id` bigint NOT NULL COMMENT '小说内容ID',
  `screen_bullet` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '小说弹幕内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `key_contentId` (`content_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='小说弹幕表';

-- Dumping data for table novel_plus.book_screen_bullet: ~0 rows (approximately)
DELETE FROM `book_screen_bullet`;

-- Dumping structure for table novel_plus.book_setting
DROP TABLE IF EXISTS `book_setting`;
CREATE TABLE IF NOT EXISTS `book_setting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `book_id` bigint DEFAULT NULL COMMENT '小说ID',
  `sort` tinyint DEFAULT NULL COMMENT '排序号',
  `type` tinyint(1) DEFAULT NULL COMMENT '类型，0：轮播图，1：顶部小说栏设置，2：本周强推，3：热门推荐，4：精品推荐',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='首页小说设置表';

-- Dumping data for table novel_plus.book_setting: ~51 rows (approximately)
DELETE FROM `book_setting`;
INSERT INTO `book_setting` (`id`, `book_id`, `sort`, `type`, `create_time`, `create_user_id`, `update_time`, `update_user_id`) VALUES
	(32, 1254674114481422336, 1, 0, '2020-04-27 15:45:58', NULL, '2020-04-27 15:46:03', NULL),
	(33, 1254674171310047232, 2, 0, '2020-04-27 15:46:21', NULL, '2020-04-27 15:46:24', NULL),
	(34, 1254674255883993088, 3, 0, '2020-04-27 15:47:06', NULL, '2020-04-27 15:47:09', NULL),
	(35, 1254674396451897344, 4, 0, '2020-04-27 15:47:24', NULL, '2020-04-27 15:47:27', NULL),
	(36, 1254674613117059072, 1, 1, NULL, NULL, NULL, NULL),
	(37, 1254680030366859264, 2, 1, NULL, NULL, NULL, NULL),
	(38, 1254677251162308608, 3, 1, NULL, NULL, NULL, NULL),
	(39, 1254677745226153984, 4, 1, NULL, NULL, NULL, NULL),
	(40, 1254677887534694400, 5, 1, NULL, NULL, NULL, NULL),
	(41, 1254675594315759616, 1, 2, NULL, NULL, NULL, NULL),
	(42, 1254675739140882432, 2, 2, NULL, NULL, NULL, NULL),
	(43, 1254675826696978432, 3, 2, NULL, NULL, NULL, NULL),
	(44, 1254676309448785920, 4, 2, NULL, NULL, NULL, NULL),
	(45, 1254676443012202496, 5, 2, NULL, NULL, NULL, NULL),
	(46, 1254676564366000128, 6, 2, NULL, NULL, NULL, NULL),
	(47, 1254676970567565312, 1, 3, NULL, NULL, NULL, NULL),
	(48, 1254677251162308608, 2, 3, NULL, NULL, NULL, NULL),
	(49, 1254677745226153984, 3, 3, NULL, NULL, NULL, NULL),
	(50, 1254677887534694400, 4, 3, NULL, NULL, NULL, NULL),
	(51, 1254675826696978432, 5, 3, NULL, NULL, NULL, NULL),
	(52, 1254676970567565312, 6, 3, NULL, NULL, NULL, NULL),
	(53, 1254681827219275776, 1, 4, NULL, NULL, NULL, NULL),
	(54, 1254681178427555840, 2, 4, NULL, NULL, NULL, NULL),
	(55, 1254681827219275776, 3, 4, NULL, NULL, NULL, NULL),
	(56, 1254681753466634240, 4, 4, NULL, NULL, NULL, NULL),
	(57, 1254682148440047616, 5, 4, NULL, NULL, NULL, NULL),
	(58, 1254682422076440576, 6, 4, NULL, NULL, NULL, NULL),
	(59, 1254674794009001984, 6, 1, NULL, NULL, NULL, NULL),
	(60, 1254678892443795456, 7, 1, NULL, NULL, NULL, NULL),
	(61, 1254681753466634240, 8, 1, NULL, NULL, NULL, NULL),
	(62, 1254681071191785472, 9, 1, NULL, NULL, NULL, NULL),
	(63, 1254677745226153984, 10, 1, NULL, NULL, NULL, NULL),
	(64, 202601020100000001, 1, 0, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(65, 202601020100000002, 2, 0, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(66, 202601020100000003, 3, 0, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(67, 202601020100000004, 1, 1, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(68, 202601020100000005, 2, 1, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(69, 202601020100000006, 3, 1, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(70, 202601020100000007, 4, 1, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(71, 202601020100000001, 1, 2, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(72, 202601020100000004, 2, 2, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(73, 202601020100000005, 3, 2, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(74, 202601020100000008, 4, 2, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(75, 202601020100000002, 1, 3, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(76, 202601020100000003, 2, 3, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(77, 202601020100000006, 3, 3, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(78, 202601020100000007, 4, 3, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(79, 202601020100000003, 1, 4, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(80, 202601020100000005, 2, 4, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(81, 202601020100000007, 3, 4, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL),
	(82, 202601020100000008, 4, 4, '2026-01-02 20:10:00', NULL, '2026-01-02 20:10:00', NULL);

-- Dumping structure for table novel_plus.crawl_batch_task
DROP TABLE IF EXISTS `crawl_batch_task`;
CREATE TABLE IF NOT EXISTS `crawl_batch_task` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_id` int DEFAULT NULL COMMENT '爬虫源ID',
  `crawl_count_success` int DEFAULT NULL COMMENT '成功抓取数量',
  `crawl_count_target` int DEFAULT NULL COMMENT '目标抓取数量',
  `task_status` tinyint(1) DEFAULT '1' COMMENT '任务状态，1：正在运行，0已停止',
  `start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='批量抓取任务表';

-- Dumping data for table novel_plus.crawl_batch_task: ~0 rows (approximately)
DELETE FROM `crawl_batch_task`;

-- Dumping structure for table novel_plus.crawl_single_task
DROP TABLE IF EXISTS `crawl_single_task`;
CREATE TABLE IF NOT EXISTS `crawl_single_task` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_id` int DEFAULT NULL COMMENT '爬虫源ID',
  `source_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '爬虫源名',
  `source_book_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '源站小说ID',
  `cat_id` int DEFAULT NULL COMMENT '分类ID',
  `book_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '爬取的小说名',
  `author_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '爬取的小说作者名',
  `task_status` tinyint(1) DEFAULT '2' COMMENT '任务状态，0：失败，1：成功，2；未执行',
  `exc_count` tinyint DEFAULT '0' COMMENT '已经执行次数，最多执行5次',
  `crawl_chapters` int DEFAULT '0' COMMENT '采集章节数量',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='抓取单本小说任务表';

-- Dumping data for table novel_plus.crawl_single_task: ~2 rows (approximately)
DELETE FROM `crawl_single_task`;
INSERT INTO `crawl_single_task` (`id`, `source_id`, `source_name`, `source_book_id`, `cat_id`, `book_name`, `author_name`, `task_status`, `exc_count`, `crawl_chapters`, `create_time`) VALUES
	(6, 2, '百书斋', '1', 1, '1', '1', 0, 5, 0, '2020-06-15 14:36:07'),
	(7, 5, '笔趣阁', '108_108291', 1, '衍天志之不朽仙', '白衣少年丶', 1, 1, 0, '2020-06-15 14:46:08');

-- Dumping structure for table novel_plus.crawl_source
DROP TABLE IF EXISTS `crawl_source`;
CREATE TABLE IF NOT EXISTS `crawl_source` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `source_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '源站名',
  `crawl_rule` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '爬取规则（json串）',
  `source_status` tinyint(1) DEFAULT '0' COMMENT '爬虫源状态，0：关闭，1：开启',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='爬虫源表';

-- Dumping data for table novel_plus.crawl_source: ~4 rows (approximately)
DELETE FROM `crawl_source`;
INSERT INTO `crawl_source` (`id`, `source_name`, `crawl_rule`, `source_status`, `create_time`, `update_time`) VALUES
	(2, '百书斋', '{\r\n	"bookListUrl": "https://m.baishuzhai.com/blhb/{catId}/{page}.html",\r\n	"catIdRule": {\r\n		"catId1": "1",\r\n		"catId2": "2",\r\n		"catId3": "3",\r\n		"catId4": "4",\r\n		"catId5": "5",\r\n		"catId6": "6",\r\n		"catId7": "7"\r\n	},\r\n	"bookIdPatten": "href=\\"/ibook/(\\\\d+/\\\\d+)/\\"",\r\n	"pagePatten": "value=\\"(\\\\d+)/\\\\d+\\"",\r\n	"totalPagePatten": "value=\\"\\\\d+/(\\\\d+)\\"",\r\n	"bookDetailUrl": "https://m.baishuzhai.com/ibook/{bookId}/",\r\n	"bookNamePatten": "<span class=\\"title\\">([^/]+)</span>",\r\n	"authorNamePatten": ">作者：([^/]+)<",\r\n	"picUrlPatten": "<img src=\\"([^>]+)\\"\\\\s+onerror=\\"this.src=",\r\n	"statusPatten": "状态：([^/]+)</li>",\r\n	"bookStatusRule": {\r\n		"连载": 0,\r\n		"完成": 1\r\n	},\r\n	"scorePatten": "<em>([^<]+)</em>",\r\n	"descStart": "<p class=\\"review\\">",\r\n	"descEnd": "</p>",\r\n	"upadateTimePatten": "更新：(\\\\d+-\\\\d+-\\\\d+)</li>",\r\n	"upadateTimeFormatPatten": "yy-MM-dd",\r\n	"bookIndexUrl": "https://m.baishuzhai.com/ibook/{bookId}/all.html",\r\n	"indexIdPatten": "<a\\\\s+style=\\"\\"\\\\s+href=\\"/ibook/\\\\d+/\\\\d+/(\\\\d+)\\\\.html\\">[^/]+</a>",\r\n	"indexNamePatten": "<a\\\\s+style=\\"\\"\\\\s+href=\\"/ibook/\\\\d+/\\\\d+/\\\\d+\\\\.html\\">([^/]+)</a>",\r\n	"bookContentUrl": "https://baishuzhai.com/ibook/{bookId}/{indexId}.html",\r\n	"contentStart": "id=\\"content\\">",\r\n	"contentEnd": "<script>"\r\n}', 0, '2020-05-01 14:22:50', '2020-05-01 14:22:50'),
	(3, '书包网', '{\r\n	"bookListUrl": "https://www.bookbao8.com/booklist-p_{page}-c_{catId}-t_0-o_0.html",\r\n	"catIdRule": {\r\n		"catId1": "5",\r\n		"catId2": "4",\r\n		"catId3": "8",\r\n		"catId4": "9",\r\n		"catId5": "3",\r\n		"catId6": "7"\r\n	},\r\n	"bookIdPatten": "href=\\"/book/(\\\\d+/\\\\d+/id_[^.]+).html\\"",\r\n	"pagePatten": "<span\\\\s+class=\\"current\\">([^<]+)</span>",\r\n	"totalPagePatten": "/共(\\\\d+)页",\r\n	"bookDetailUrl": "https://www.bookbao8.com/book/{bookId}.html",\r\n	"bookNamePatten": "<div\\\\s+id=\\"info\\">\\\\s*<h1>([^<]+)</h1>",\r\n	"authorNamePatten": "<p>作者：<a\\\\s+href=\\"/Search/[^\\"]+\\"\\\\s+target=\\"_blank\\">([^<]+)</a></p>",\r\n	"picUrlPatten": "<div\\\\s+id=\\"fmimg\\">\\\\s*<img\\\\s+alt=\\"[^\\"]+\\"\\\\s+src=\\"([^\\"]+)\\"",\r\n	"statusPatten": "<p>状态：([^<]+)</p>",\r\n	"bookStatusRule": {\r\n		"连载中": 0,\r\n		"已完结": 1\r\n	},\r\n	"visitCountPatten": "<em\\\\s+id=\\"hits\\">(\\\\d+)</em>",\r\n	"descStart": "<div class=\\"infocontent\\">",\r\n	"descEnd": "</div>",\r\n	"upadateTimePatten": "<p>更新时间：(\\\\d+-\\\\d+-\\\\d+\\\\s\\\\d+:\\\\d+:\\\\d+)</p>",\r\n	"upadateTimeFormatPatten": "yyyy-MM-dd HH:mm:ss",\r\n	"bookIndexUrl": "https://www.bookbao8.com/book/{bookId}.html",\r\n	"indexIdPatten": "<li>\\\\s*<a\\\\s+href=\\"/views/\\\\d+/\\\\d+/id_[^_]+_(\\\\d+).html\\"\\\\s+target=\\"_blank\\">",\r\n	"indexNamePatten": "<li>\\\\s*<a\\\\s+href=\\"/views/\\\\d+/\\\\d+/id_[^_]+_\\\\d+.html\\"\\\\s+target=\\"_blank\\">([^<]+)</a>",\r\n	"bookContentUrl": "https://www.bookbao8.com/views/{bookId}_{indexId}.html",\r\n	"contentStart": "<dd id=\\"contents\\">",\r\n	"contentEnd": "</dd>"\r\n}', 0, '2020-05-04 17:42:22', '2020-05-04 17:42:22'),
	(4, '书趣阁', '{\n	"bookListUrl": "http://m.shuquge.com/sort/{catId}/0_{page}.html",\n	"catIdRule": {\n		"catId1": "1",\n		"catId2": "2",\n		"catId3": "3",\n		"catId4": "4",\n		"catId5": "7",\n		"catId6": "6",\n		"catId7": "8"\n	},\n	"bookIdPatten": "href=\\"/s/(\\\\d+)\\\\.html\\"",\n	"pagePatten": "第(\\\\d+)/\\\\d+页",\n	"totalPagePatten": "第\\\\d+/(\\\\d+)页",\n	"bookDetailUrl": "http://m.shuquge.com/s/{bookId}.html",\n	"bookNamePatten": "<a\\\\s+href=\\"/s/\\\\d+\\\\.html\\"><h2>([^/]+)</h2></a>",\n	"authorNamePatten": "<p>作者：([^/]+)</p>",\n	"picUrlPatten": "src=\\"(http://www.shuquge.com/files/article/image/\\\\d+/\\\\d+/\\\\d+s\\\\.jpg)\\"",\n	"statusPatten": "<p>状态：([^/]+)</p>",\n	"bookStatusRule": {\n		"连载中": 0,\n		"完本": 1\n	},\n	"descStart": "<div class=\\"intro_info\\">",\n	"descEnd": "最新章节推荐地址",\n	"bookIndexUrl": "http://www.shuquge.com/txt/{bookId}/index.html",\n	"bookIndexStart": "<dt>《",\n	"indexIdPatten": "<dd><a\\\\s+href=\\"(\\\\d+)\\\\.html\\">[^/]+</a></dd>",\n	"indexNamePatten": "<dd><a\\\\s+href=\\"\\\\d+\\\\.html\\">([^/]+)</a></dd>",\n	"bookContentUrl": "http://www.shuquge.com/txt/{bookId}/{indexId}.html",\n	"contentStart": "<div id=\\"content\\" class=\\"showtxt\\">",\n	"contentEnd": "http://www.shuquge.com"\n}', 1, '2020-05-18 12:02:34', '2020-05-18 12:02:34'),
	(5, '笔趣阁', '{"bookListUrl":"http://m.mcmssc.com/xclass/{catId}/{page}.html","catIdRule":{"catId1":"1","catId2":"2","catId3":"3","catId4":"4","catId5":"5","catId6":"6","catId7":"7"},"bookIdPatten":"href=\\"/(\\\\d+_\\\\d+)/\\"","pagePatten":"class=\\"page_txt\\"\\\\s+value=\\"(\\\\d+)/\\\\d+\\"\\\\s+size=","totalPagePatten":"class=\\"page_txt\\"\\\\s+value=\\"\\\\d+/(\\\\d+)\\"\\\\s+size=","bookDetailUrl":"http://m.mcmssc.com/{bookId}/","bookNamePatten":"<span\\\\s+class=\\"title\\">([^/]+)</span>","authorNamePatten":"<a\\\\s+href=\\"/author/\\\\d+/\\">([^/]+)</a>","picUrlPatten":"<img\\\\s+src=\\"([^>]+)\\"\\\\s+onerror=","picUrlPrefix":"http://m.mcmssc.com/","statusPatten":">状态：([^/]+)<","bookStatusRule":{"连载":0,"全本":1},"visitCountPatten":">点击：(\\\\d+)<","descStart":"<p class=\\"review\\">","descEnd":"</p>","bookIndexUrl":"http://m.mcmssc.com/{bookId}/all.html","indexIdPatten":"<a\\\\s+href=\\"/\\\\d+_\\\\d+/(\\\\d+)\\\\.html\\">[^/]+</a>","indexNamePatten":"<a\\\\s+href=\\"/\\\\d+_\\\\d+/\\\\d+\\\\.html\\">([^/]+)</a>","bookContentUrl":"http://www.mcmssc.com/{bookId}/{indexId}.html","contentStart":"</p>","contentEnd":"<div align=\\"center\\">"}', 1, '2020-05-18 15:57:41', '2020-05-18 15:57:41');

-- Dumping structure for table novel_plus.friend_link
DROP TABLE IF EXISTS `friend_link`;
CREATE TABLE IF NOT EXISTS `friend_link` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `link_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接名',
  `link_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接url',
  `sort` tinyint NOT NULL DEFAULT '11' COMMENT '排序号',
  `is_open` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开启，0：不开启，1：开启',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新者用户id',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table novel_plus.friend_link: ~1 rows (approximately)
DELETE FROM `friend_link`;
INSERT INTO `friend_link` (`id`, `link_name`, `link_url`, `sort`, `is_open`, `create_user_id`, `create_time`, `update_user_id`, `update_time`) VALUES
	(5, '小说精品屋', '', 11, 1, NULL, NULL, NULL, NULL);

-- Dumping structure for table novel_plus.news
DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cat_id` int DEFAULT NULL COMMENT '类别ID',
  `cat_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '分类名',
  `source_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '来源',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '内容',
  `create_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '发布人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='新闻表';

-- Dumping data for table novel_plus.news: ~2 rows (approximately)
DELETE FROM `news`;
INSERT INTO `news` (`id`, `cat_id`, `cat_name`, `source_name`, `title`, `content`, `create_time`, `create_user_id`, `update_time`, `update_user_id`) VALUES
	(1, 1, '行业', '未知', '阅文推“单本可选新合同”：授权分级、免费或付费自选', '阅文推“单本可选新合同”：授权分级、免费或付费自选', '2020-04-27 15:42:21', NULL, '2020-04-27 15:42:26', NULL),
	(2, 3, '资讯', '全媒派公众号', 'AI小说悄然流行：人类特有的创作力，已经被AI复制？', 'AI小说悄然流行：人类特有的创作力，已经被AI复制？', '2020-04-28 15:44:07', NULL, '2020-04-28 15:44:12', NULL);

-- Dumping structure for table novel_plus.news_category
DROP TABLE IF EXISTS `news_category`;
CREATE TABLE IF NOT EXISTS `news_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名',
  `sort` tinyint NOT NULL DEFAULT '10' COMMENT '排序',
  `create_user_id` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_user_id` bigint DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='新闻类别表';

-- Dumping data for table novel_plus.news_category: ~2 rows (approximately)
DELETE FROM `news_category`;
INSERT INTO `news_category` (`id`, `name`, `sort`, `create_user_id`, `create_time`, `update_user_id`, `update_time`) VALUES
	(1, '行业', 10, NULL, NULL, NULL, NULL),
	(3, '资讯', 11, NULL, NULL, NULL, NULL);

-- Dumping structure for table novel_plus.order_pay
DROP TABLE IF EXISTS `order_pay`;
CREATE TABLE IF NOT EXISTS `order_pay` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `out_trade_no` bigint NOT NULL COMMENT '商户订单号',
  `trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '支付宝/微信交易号',
  `pay_channel` tinyint(1) NOT NULL DEFAULT '1' COMMENT '支付渠道，1：支付宝，2：微信',
  `total_amount` int NOT NULL COMMENT '交易金额(单位元)',
  `user_id` bigint NOT NULL COMMENT '支付用户ID',
  `pay_status` tinyint(1) DEFAULT '2' COMMENT '支付状态：0：支付失败，1：支付成功，2：待支付',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='充值订单';

-- Dumping data for table novel_plus.order_pay: ~137 rows (approximately)
DELETE FROM `order_pay`;
INSERT INTO `order_pay` (`id`, `out_trade_no`, `trade_no`, `pay_channel`, `total_amount`, `user_id`, `pay_status`, `create_time`, `update_time`) VALUES
	(15, 202512162015076608, NULL, 1, 10, 1997843516947996672, 2, '2025-12-16 20:15:08', '2025-12-16 20:15:08'),
	(16, 202512162015423966, NULL, 1, 30, 1997843516947996672, 2, '2025-12-16 20:15:42', '2025-12-16 20:15:42'),
	(17, 202512162016007350, NULL, 1, 10, 1997843516947996672, 2, '2025-12-16 20:16:01', '2025-12-16 20:16:01'),
	(18, 202512162041475129, NULL, 1, 10, 1997843516947996672, 2, '2025-12-16 20:41:48', '2025-12-16 20:41:48'),
	(19, 202512162042085303, NULL, 1, 10, 1997843516947996672, 2, '2025-12-16 20:42:09', '2025-12-16 20:42:09'),
	(20, 202512162043434404, NULL, 1, 10, 1997843516947996672, 2, '2025-12-16 20:43:43', '2025-12-16 20:43:43'),
	(21, 202512162133436763, NULL, 1, 10, 1997843516947996672, 2, '2025-12-16 21:33:44', '2025-12-16 21:33:44'),
	(22, 202512162139545674, NULL, 1, 30, 1997843516947996672, 2, '2025-12-16 21:39:55', '2025-12-16 21:39:55'),
	(23, 202512162142264876, NULL, 1, 10, 1997843516947996672, 2, '2025-12-16 21:42:26', '2025-12-16 21:42:26'),
	(24, 202512170446318891, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 04:46:32', '2025-12-17 04:46:32'),
	(25, 202512170446434724, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 04:46:43', '2025-12-17 04:46:43'),
	(26, 202512170446484116, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 04:46:48', '2025-12-17 04:46:48'),
	(27, 202512170447088265, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 04:47:09', '2025-12-17 04:47:09'),
	(28, 202512170556197827, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 05:56:20', '2025-12-17 05:56:20'),
	(29, 202512170613403276, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 06:13:40', '2025-12-17 06:13:40'),
	(30, 202512170615402073, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 06:15:40', '2025-12-17 06:15:40'),
	(31, 202512170616507666, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 06:16:51', '2025-12-17 06:16:51'),
	(32, 202512170627001308, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 06:27:00', '2025-12-17 06:27:00'),
	(33, 202512170630326578, '2025121722001475280507017585', 1, 10, 1997843516947996672, 1, '2025-12-17 06:30:33', '2025-12-17 06:30:46'),
	(34, 202512170657534944, NULL, 1, 30, 1997843516947996672, 2, '2025-12-17 06:57:53', '2025-12-17 06:57:53'),
	(35, 202512170658599793, '2025121722001475280507010133', 1, 30, 1997843516947996672, 1, '2025-12-17 06:59:00', '2025-12-17 06:59:17'),
	(36, 202512170700373322, '2025121722001475280507014542', 1, 10, 1997843516947996672, 1, '2025-12-17 07:00:37', '2025-12-17 07:00:51'),
	(37, 202512170718016222, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 07:18:02', '2025-12-17 07:18:02'),
	(38, 202512170834563877, NULL, 1, 10, 1997843516947996672, 2, '2025-12-17 08:34:56', '2025-12-17 08:34:56'),
	(39, 202512170844208394, '2025121722001475280507019222', 1, 1, 1997843516947996672, 1, '2025-12-17 08:44:21', '2025-12-17 08:44:46'),
	(40, 202512170845143631, NULL, 1, 30, 1997843516947996672, 2, '2025-12-17 08:45:14', '2025-12-17 08:45:14'),
	(41, 202512170845190259, NULL, 1, 30, 1997843516947996672, 2, '2025-12-17 08:45:19', '2025-12-17 08:45:19'),
	(42, 202512170845244180, NULL, 1, 50, 1997843516947996672, 2, '2025-12-17 08:45:24', '2025-12-17 08:45:24'),
	(43, 202512170845362457, NULL, 1, 50, 1997843516947996672, 2, '2025-12-17 08:45:36', '2025-12-17 08:45:36'),
	(44, 202512170845433306, NULL, 1, 500, 1997843516947996672, 2, '2025-12-17 08:45:43', '2025-12-17 08:45:43'),
	(45, 202512180838332659, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 08:38:33', '2025-12-18 08:38:33'),
	(46, 202512180904362109, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 09:04:36', '2025-12-18 09:04:36'),
	(47, 202512180905140543, NULL, 1, 30, 1997843516947996672, 2, '2025-12-18 09:05:14', '2025-12-18 09:05:14'),
	(48, 202512182121034096, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 21:21:03', '2025-12-18 21:21:03'),
	(49, 202512182121587340, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 21:21:59', '2025-12-18 21:21:59'),
	(50, 202512182130476723, NULL, 1, 30, 1997843516947996672, 2, '2025-12-18 21:30:48', '2025-12-18 21:30:48'),
	(51, 202512182130580871, NULL, 1, 30, 1997843516947996672, 2, '2025-12-18 21:30:58', '2025-12-18 21:30:58'),
	(52, 202512182135453365, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 21:35:45', '2025-12-18 21:35:45'),
	(53, 202512182138031971, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 21:38:03', '2025-12-18 21:38:03'),
	(54, 202512182141017710, NULL, 1, 30, 1997843516947996672, 2, '2025-12-18 21:41:02', '2025-12-18 21:41:02'),
	(55, 202512182146271927, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 21:46:27', '2025-12-18 21:46:27'),
	(56, 202512182149122554, NULL, 1, 30, 1997843516947996672, 2, '2025-12-18 21:49:12', '2025-12-18 21:49:12'),
	(57, 202512182149494942, NULL, 1, 30, 1997843516947996672, 2, '2025-12-18 21:49:49', '2025-12-18 21:49:49'),
	(58, 202512182149565438, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 21:49:57', '2025-12-18 21:49:57'),
	(59, 202512182232105418, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 22:32:11', '2025-12-18 22:32:11'),
	(60, 202512182241225183, NULL, 1, 30, 1997843516947996672, 2, '2025-12-18 22:41:23', '2025-12-18 22:41:23'),
	(61, 202512182247535383, NULL, 1, 500, 1997843516947996672, 2, '2025-12-18 22:47:54', '2025-12-18 22:47:54'),
	(62, 202512182247580014, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 22:47:58', '2025-12-18 22:47:58'),
	(63, 202512182309232946, NULL, 1, 30, 1997843516947996672, 2, '2025-12-18 23:09:23', '2025-12-18 23:09:23'),
	(64, 202512182309348109, NULL, 1, 30, 1997843516947996672, 2, '2025-12-18 23:09:35', '2025-12-18 23:09:35'),
	(65, 202512182311038629, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 23:11:04', '2025-12-18 23:11:04'),
	(66, 202512182314307795, NULL, 1, 10, 1997843516947996672, 2, '2025-12-18 23:14:31', '2025-12-18 23:14:31'),
	(67, 202512190302212508, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 03:02:21', '2025-12-19 03:02:21'),
	(68, 202512190303334499, NULL, 1, 30, 1997843516947996672, 2, '2025-12-19 03:03:33', '2025-12-19 03:03:33'),
	(69, 202512190520007131, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 05:20:01', '2025-12-19 05:20:01'),
	(70, 202512190538521807, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 05:38:52', '2025-12-19 05:38:52'),
	(71, 202512190540254992, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 05:40:25', '2025-12-19 05:40:25'),
	(72, 202512190652418744, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 06:52:42', '2025-12-19 06:52:42'),
	(73, 202512190707019435, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 07:07:02', '2025-12-19 07:07:02'),
	(74, 202512190707156591, NULL, 1, 1, 1997843516947996672, 2, '2025-12-19 07:07:16', '2025-12-19 07:07:16'),
	(75, 202512190915277767, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 09:15:28', '2025-12-19 09:15:28'),
	(76, 202512190920100235, NULL, 1, 30, 1997843516947996672, 2, '2025-12-19 09:20:10', '2025-12-19 09:20:10'),
	(77, 202512190924379505, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 09:24:38', '2025-12-19 09:24:38'),
	(78, 202512190924511965, NULL, 1, 30, 1997843516947996672, 2, '2025-12-19 09:24:51', '2025-12-19 09:24:51'),
	(79, 202512190925139554, NULL, 1, 30, 1997843516947996672, 2, '2025-12-19 09:25:14', '2025-12-19 09:25:14'),
	(80, 202512190944068757, NULL, 1, 30, 1997843516947996672, 2, '2025-12-19 09:44:07', '2025-12-19 09:44:07'),
	(81, 202512191007306473, NULL, 1, 200, 1997843516947996672, 2, '2025-12-19 10:07:31', '2025-12-19 10:07:31'),
	(82, 202512191007466189, NULL, 1, 200, 1997843516947996672, 2, '2025-12-19 10:07:47', '2025-12-19 10:07:47'),
	(83, 202512191008384474, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 10:08:38', '2025-12-19 10:08:38'),
	(84, 202512191941311420, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 19:41:31', '2025-12-19 19:41:31'),
	(85, 202512191941374767, NULL, 1, 30, 1997843516947996672, 2, '2025-12-19 19:41:37', '2025-12-19 19:41:37'),
	(86, 202512191941411841, NULL, 1, 200, 1997843516947996672, 2, '2025-12-19 19:41:41', '2025-12-19 19:41:41'),
	(87, 202512191951111388, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 19:51:11', '2025-12-19 19:51:11'),
	(88, 202512192000080081, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 20:00:08', '2025-12-19 20:00:08'),
	(89, 202512192011040324, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 20:11:04', '2025-12-19 20:11:04'),
	(90, 202512192016169833, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 20:16:17', '2025-12-19 20:16:17'),
	(91, 202512192023090567, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 20:23:09', '2025-12-19 20:23:09'),
	(92, 202512192026296090, NULL, 1, 30, 1997843516947996672, 2, '2025-12-19 20:26:30', '2025-12-19 20:26:30'),
	(93, 202512192032364597, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 20:32:36', '2025-12-19 20:32:36'),
	(94, 202512192041198993, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 20:41:20', '2025-12-19 20:41:20'),
	(95, 202512192043176276, NULL, 1, 30, 1997843516947996672, 2, '2025-12-19 20:43:18', '2025-12-19 20:43:18'),
	(96, 202512192043243181, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 20:43:24', '2025-12-19 20:43:24'),
	(97, 202512192046580136, NULL, 1, 200, 1997843516947996672, 2, '2025-12-19 20:46:58', '2025-12-19 20:46:58'),
	(98, 202512192048195694, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 20:48:20', '2025-12-19 20:48:20'),
	(99, 202512192052261143, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 20:52:26', '2025-12-19 20:52:26'),
	(100, 202512192055220166, NULL, 1, 1, 1997843516947996672, 2, '2025-12-19 20:55:22', '2025-12-19 20:55:22'),
	(101, 202512192057321257, NULL, 1, 1, 1997843516947996672, 2, '2025-12-19 20:57:32', '2025-12-19 20:57:32'),
	(102, 202512192103242194, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 21:03:24', '2025-12-19 21:03:24'),
	(103, 202512192110451001, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 21:10:45', '2025-12-19 21:10:45'),
	(104, 202512192120118731, NULL, 1, 10, 1997843516947996672, 2, '2025-12-19 21:20:12', '2025-12-19 21:20:12'),
	(105, 202601021935464856, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:35:46', '2026-01-02 19:35:46'),
	(106, 202601021936212572, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:36:21', '2026-01-02 19:36:21'),
	(107, 202601021937214071, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:37:21', '2026-01-02 19:37:21'),
	(108, 202601021937324292, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:37:32', '2026-01-02 19:37:32'),
	(109, 202601021937453983, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:37:45', '2026-01-02 19:37:45'),
	(110, 202601021937523821, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:37:52', '2026-01-02 19:37:52'),
	(111, 202601021942582565, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:42:58', '2026-01-02 19:42:58'),
	(112, 202601021944060978, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:44:06', '2026-01-02 19:44:06'),
	(113, 202601021944341244, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:44:34', '2026-01-02 19:44:34'),
	(114, 202601021944394913, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:44:39', '2026-01-02 19:44:39'),
	(115, 202601021944588634, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:44:59', '2026-01-02 19:44:59'),
	(116, 202601021946352098, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:46:35', '2026-01-02 19:46:35'),
	(117, 202601021947013068, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:47:01', '2026-01-02 19:47:01'),
	(118, 202601021948277491, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:48:28', '2026-01-02 19:48:28'),
	(119, 202601021948351889, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:48:35', '2026-01-02 19:48:35'),
	(120, 202601021948570452, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:48:57', '2026-01-02 19:48:57'),
	(121, 202601021949272726, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:49:27', '2026-01-02 19:49:27'),
	(122, 202601021949495566, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:49:50', '2026-01-02 19:49:50'),
	(123, 202601021950288378, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:50:29', '2026-01-02 19:50:29'),
	(124, 202601021951105641, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:51:11', '2026-01-02 19:51:11'),
	(125, 202601021957566342, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 19:57:57', '2026-01-02 19:57:57'),
	(126, 202601022004102424, NULL, 1, 1000, 2005809307752456192, 2, '2026-01-02 20:04:10', '2026-01-02 20:04:10'),
	(127, 202601022005206939, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:05:21', '2026-01-02 20:05:21'),
	(128, 202601022005319828, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:05:32', '2026-01-02 20:05:32'),
	(129, 202601022015579554, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:15:58', '2026-01-02 20:15:58'),
	(130, 202601022016349057, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:16:35', '2026-01-02 20:16:35'),
	(131, 202601022017001148, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:17:00', '2026-01-02 20:17:00'),
	(132, 202601022017202966, NULL, 1, 100, 1997843516947996672, 2, '2026-01-02 20:17:20', '2026-01-02 20:17:20'),
	(133, 202601022018022778, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:18:02', '2026-01-02 20:18:02'),
	(134, 202601022020044135, NULL, 1, 10, 1997843516947996672, 2, '2026-01-02 20:20:04', '2026-01-02 20:20:04'),
	(135, 202601022020248853, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:20:25', '2026-01-02 20:20:25'),
	(136, 202601022020311346, NULL, 1, 10, 1997843516947996672, 2, '2026-01-02 20:20:31', '2026-01-02 20:20:31'),
	(137, 202601022020560253, NULL, 1, 10, 1997843516947996672, 2, '2026-01-02 20:20:56', '2026-01-02 20:20:56'),
	(138, 202601022021223393, NULL, 1, 10, 1997843516947996672, 2, '2026-01-02 20:21:22', '2026-01-02 20:21:22'),
	(139, 202601022029331736, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:29:33', '2026-01-02 20:29:33'),
	(140, 202601022030322398, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:30:32', '2026-01-02 20:30:32'),
	(141, 202601022034091894, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:34:09', '2026-01-02 20:34:09'),
	(142, 202601022035194936, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-02 20:35:19', '2026-01-02 20:35:19'),
	(143, 202601031055294422, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-03 10:55:29', '2026-01-03 10:55:29'),
	(144, 202601041513476676, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-04 15:13:48', '2026-01-04 15:13:48'),
	(145, 202601041948517253, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-04 19:48:52', '2026-01-04 19:48:52'),
	(146, 202601101714256463, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-10 17:14:26', '2026-01-10 17:14:26'),
	(147, 202601101714280289, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-10 17:14:28', '2026-01-10 17:14:28'),
	(148, 202601101719074716, NULL, 1, 3000, 1997843516947996672, 2, '2026-01-10 17:19:07', '2026-01-10 17:19:07'),
	(149, 202601101725185719, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-10 17:25:19', '2026-01-10 17:25:19'),
	(150, 202601101726077881, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-10 17:26:08', '2026-01-10 17:26:08'),
	(151, 202601101732004272, NULL, 1, 1000, 1997843516947996672, 2, '2026-01-10 17:32:00', '2026-01-10 17:32:00');

-- Dumping structure for table novel_plus.pay_merchant
DROP TABLE IF EXISTS `pay_merchant`;
CREATE TABLE IF NOT EXISTS `pay_merchant` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_no` varchar(64) NOT NULL COMMENT '商户号，用于 externalId',
  `alipay_merchant_no` varchar(64) DEFAULT NULL COMMENT '支付宝商户号',
  `name` varchar(128) NOT NULL COMMENT '商户名称',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_default` tinyint NOT NULL DEFAULT '0' COMMENT '是否默认商户 1默认 0非默认',
  `md5_key` varchar(64) DEFAULT NULL COMMENT 'MD5密钥',
  `aes_key` varchar(64) DEFAULT NULL COMMENT 'AES密钥',
  `group_external_id` varchar(100) DEFAULT 'group001',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_merchant_no` (`merchant_no`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='支付商户配置';

-- Dumping data for table novel_plus.pay_merchant: ~49 rows (approximately)
DELETE FROM `pay_merchant`;
INSERT INTO `pay_merchant` (`id`, `merchant_no`, `alipay_merchant_no`, `name`, `status`, `remark`, `create_time`, `update_time`, `is_default`, `md5_key`, `aes_key`, `group_external_id`) VALUES
	(15, '888001', 'm00001', '啊啊啊科技有限公司', 1, '啊啊啊科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(16, '888002', 'm00002', '杭州芝音科技有限公司', 1, '芝音科技', '2026-01-02 18:16:11', '2026-01-02 20:35:15', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group002'),
	(17, '888003', 'm00003', '深圳市迪迦传媒科技有限公司', 1, '迪加传媒', '2026-01-02 18:16:11', '2026-01-02 20:23:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group002'),
	(18, '888004', 'm00004', '深圳市宏芯橙网络科技有限公司', 1, '宏芯科技', '2026-01-02 18:16:11', '2026-01-02 19:59:58', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group002'),
	(19, '888005', 'm00005', '广西柳州市美全网络科技有限公司', 1, '美全科技', '2026-01-02 18:16:11', '2026-01-02 20:00:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group002'),
	(20, '888006', 'm00006', '广西杰淦贸易有限公司', 1, '杰淦贸易', '2026-01-02 18:16:11', '2026-01-02 20:00:05', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group002'),
	(21, '888007', 'm00007', '内蒙古新开始科技有限公司', 1, '新开始科技', '2026-01-02 18:16:11', '2026-01-02 19:37:28', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(22, '888008', 'm00008', '广州巳嬴科技有限公司', 1, '巳嬴科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(23, '888009', 'm00009', '广西吉汇安商贸有限公司', 1, '吉汇安商贸', '2026-01-02 18:16:11', '2026-01-02 20:34:06', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(24, '888010', 'm00010', '广州巳蠃科技有限公司', 1, '巳蠃科技', '2026-01-02 18:16:11', '2026-01-02 20:35:15', 1, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(25, '888011', 'm00011', '深圳市秋龙文化传媒有限公司', 1, '秋龙科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(26, '888012', 'm00012', '惠州市主角文化传播有限公司', 1, '主角科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(27, '888013', 'm00013', '广州已嬴科技有限公司', 1, '已嬴科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(28, '888014', 'm00014', '广州己羸科技有限公司', 1, '己羸科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(29, '888015', 'm00015', '广州朝理科技有限公司', 1, '朝理科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(30, '888016', 'm00016', '广州朝波科技有限公司', 1, '朝波科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(31, '888017', 'm00017', '广州序本科技有限公司', 1, '序本科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(32, '888018', 'm00018', '长沙市承肃昌商贸有限公司', 1, '承肃昌商贸', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(33, '888019', 'm00019', '广州承岳商贸商行（个人独资）', 1, '承岳商贸', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(34, '888020', 'm00020', '深圳市嘉易业科技有限公司', 1, '嘉易业科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(35, '888021', 'm00021', '广州蓝袄科技有限公司', 1, '蓝袄科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(36, '888022', 'm00022', '广州篮戊科技有限公司', 1, '篮戊科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(37, '888023', 'm00023', '化州市鼎赢科技有限公司', 1, '鼎赢科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(38, '888024', 'm00024', '广州朝明科技有限公司', 1, '朝明科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(39, '888025', 'm00025', '深圳市微音乐网络科技有限公司', 1, '微音乐科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(40, '888026', 'm00026', '广州朝韵科技有限公司', 1, '朝韵科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(41, '888027', 'm00027', '广州文佑科技有限公司', 1, '文佑科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(42, '888028', 'm00028', '广州壹竣商贸有限公司', 1, '壹竣商贸', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(43, '888029', 'm00029', '广州詹标科技有限公司', 1, '詹标科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(44, '888030', 'm00030', '广州标掌科技有限公司', 1, '标掌科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(45, '888031', 'm00031', '广州篮祇科技有限公司', 1, '篮祇科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(46, '888032', 'm00032', '广州己赢科技有限公司', 1, '己赢科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(47, '888033', 'm00033', '广州篮祗科技有限公司', 1, '篮祗科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(48, '888034', 'm00034', '广州已赢科技有限公司', 1, '已赢科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(49, '888035', 'm00035', '广州蓝祇科技有限公司', 1, '蓝祇科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(50, '888036', 'm00036', '广州已羸科技有限公司', 1, '已羸科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(51, '888037', 'm00037', '广州咚婕科技有限公司', 1, '咚婕科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(52, '888038', 'm00038', '广州齐风科技有限公司', 1, '齐风科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(53, '888039', 'm00039', '博罗县园洲镇义顺达汽车维修服务部', 1, '义顺汽车', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(54, '888040', 'm00040', '茂名市鑫东数字科技有限公司', 1, '鑫东科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(55, '888041', 'm00041', '广州蓝祗科技有限公司', 1, '蓝祗科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(56, '888042', 'm00042', '广州悦之星科技有限公司', 1, '悦之星科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(57, '888043', 'm00043', '广州已蠃科技有限公司', 1, '已蠃科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(58, '888044', 'm00044', '广州己蠃科技有限公司', 1, '己蠃科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(59, '888045', 'm00045', '深圳市国浩云启贸易有限责任公司', 1, '国浩科技', '2026-01-02 18:16:11', '2026-01-02 18:51:01', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(60, '888046', 'm00046', '广州壹页科技有限公司', 1, '壹页科技', '2026-01-02 20:53:25', '2026-01-02 20:53:25', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(61, '888047', 'm00047', '沈阳会赢科技有限公司', 1, '会赢科技', '2026-01-02 20:53:25', '2026-01-02 20:53:25', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(62, '888048', 'm00048', '石家庄妙景商贸有限公司', 1, '妙景商贸', '2026-01-02 20:53:25', '2026-01-02 20:53:25', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001'),
	(63, '888049', 'm00049', '贺州市美福商贸有限公司', 1, '美福商贸', '2026-01-02 20:53:25', '2026-01-02 20:53:25', 0, 'dywtNuTc5K$', 'YG7J4Lpidg457CziIY1nRZn3', 'group001');

-- Dumping structure for table novel_plus.sys_data_perm
DROP TABLE IF EXISTS `sys_data_perm`;
CREATE TABLE IF NOT EXISTS `sys_data_perm` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '权限名称',
  `table_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '数据表名称',
  `module_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '所属模块',
  `crl_attr_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户权限控制属性名',
  `crl_column_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '数据表权限控制列名',
  `perm_code` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '权限code，all_开头表示查看所有数据的权限，sup_开头表示查看下级数据的权限，own_开头表示查看本级数据的权限',
  `order_num` int DEFAULT NULL COMMENT '排序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='数据权限管理';

-- Dumping data for table novel_plus.sys_data_perm: ~6 rows (approximately)
DELETE FROM `sys_data_perm`;
INSERT INTO `sys_data_perm` (`id`, `name`, `table_name`, `module_name`, `crl_attr_name`, `crl_column_name`, `perm_code`, `order_num`, `gmt_create`, `gmt_modified`) VALUES
	(210, '查看用户表全部数据', 'sys_user', '用户管理', 'deptId', 'dept_id', 'all_dept_sys_user', 1, NULL, NULL),
	(211, '查看用户表下级部门数据', 'sys_user', '用户管理', 'deptId', 'dept_id', 'sup_dept_sys_user', 2, NULL, NULL),
	(212, '查看用户表本部门数据', 'sys_user', '用户管理', 'deptId', 'dept_id', 'own_dept_sys_user', 3, NULL, NULL),
	(213, '查看用户表个人数据', 'sys_user', '用户管理', 'userId', 'user_id', 'own_user_sys_user', 4, NULL, NULL),
	(214, '查看下级部门订单数据', 'fb_order', '订单管理', 'deptId', 'dept_id', 'sup_dept_fb_order', 2, NULL, NULL),
	(215, '查看本部门订单数据', 'fb_order', '订单管理', 'deptId', 'dept_id', 'own_dept_fb_order', 3, NULL, NULL);

-- Dumping structure for table novel_plus.sys_dept
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE IF NOT EXISTS `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '部门名称',
  `order_num` int DEFAULT NULL COMMENT '排序',
  `del_flag` tinyint DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='部门管理';

-- Dumping data for table novel_plus.sys_dept: ~4 rows (approximately)
DELETE FROM `sys_dept`;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `name`, `order_num`, `del_flag`) VALUES
	(13, 0, '测试部', 5, 1),
	(14, 13, '测试一部', 1, 1),
	(15, 13, '测试二部', 2, 1),
	(16, 13, '测试三部', 13, 1);

-- Dumping structure for table novel_plus.sys_dict
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE IF NOT EXISTS `sys_dict` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '标签名',
  `value` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '数据值',
  `type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '类型',
  `description` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '描述',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `parent_id` bigint DEFAULT '0' COMMENT '父级编号',
  `create_by` int DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_value` (`value`) USING BTREE,
  KEY `sys_dict_label` (`name`) USING BTREE,
  KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='字典表';

-- Dumping data for table novel_plus.sys_dict: ~130 rows (approximately)
DELETE FROM `sys_dict`;
INSERT INTO `sys_dict` (`id`, `name`, `value`, `type`, `description`, `sort`, `parent_id`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES
	(1, '正常', '0', 'del_flag', '删除标记', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(3, '显示', '1', 'show_hide', '显示/隐藏', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(4, '隐藏', '0', 'show_hide', '显示/隐藏', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(5, '是', '1', 'yes_no', '是/否', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(6, '否', '0', 'yes_no', '是/否', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(7, '红色', 'red', 'color', '颜色值', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(8, '绿色', 'green', 'color', '颜色值', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(9, '蓝色', 'blue', 'color', '颜色值', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(10, '黄色', 'yellow', 'color', '颜色值', 40, 0, 1, NULL, 1, NULL, NULL, '0'),
	(11, '橙色', 'orange', 'color', '颜色值', 50, 0, 1, NULL, 1, NULL, NULL, '0'),
	(12, '默认主题', 'default', 'theme', '主题方案', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(13, '天蓝主题', 'cerulean', 'theme', '主题方案', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(14, '橙色主题', 'readable', 'theme', '主题方案', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(15, '红色主题', 'united', 'theme', '主题方案', 40, 0, 1, NULL, 1, NULL, NULL, '0'),
	(16, 'Flat主题', 'flat', 'theme', '主题方案', 60, 0, 1, NULL, 1, NULL, NULL, '0'),
	(17, '国家', '1', 'sys_area_type', '区域类型', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(18, '省份、直辖市', '2', 'sys_area_type', '区域类型', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(19, '地市', '3', 'sys_area_type', '区域类型', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(20, '区县', '4', 'sys_area_type', '区域类型', 40, 0, 1, NULL, 1, NULL, NULL, '0'),
	(21, '公司', '1', 'sys_office_type', '机构类型', 60, 0, 1, NULL, 1, NULL, NULL, '0'),
	(22, '部门', '2', 'sys_office_type', '机构类型', 70, 0, 1, NULL, 1, NULL, NULL, '0'),
	(23, '小组', '3', 'sys_office_type', '机构类型', 80, 0, 1, NULL, 1, NULL, NULL, '0'),
	(24, '其它', '4', 'sys_office_type', '机构类型', 90, 0, 1, NULL, 1, NULL, NULL, '0'),
	(25, '综合部', '1', 'sys_office_common', '快捷通用部门', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(26, '开发部', '2', 'sys_office_common', '快捷通用部门', 40, 0, 1, NULL, 1, NULL, NULL, '0'),
	(27, '人力部', '3', 'sys_office_common', '快捷通用部门', 50, 0, 1, NULL, 1, NULL, NULL, '0'),
	(28, '一级', '1', 'sys_office_grade', '机构等级', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(29, '二级', '2', 'sys_office_grade', '机构等级', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(30, '三级', '3', 'sys_office_grade', '机构等级', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(31, '四级', '4', 'sys_office_grade', '机构等级', 40, 0, 1, NULL, 1, NULL, NULL, '0'),
	(32, '所有数据', '1', 'sys_data_scope', '数据范围', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(33, '所在公司及以下数据', '2', 'sys_data_scope', '数据范围', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(34, '所在公司数据', '3', 'sys_data_scope', '数据范围', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(35, '所在部门及以下数据', '4', 'sys_data_scope', '数据范围', 40, 0, 1, NULL, 1, NULL, NULL, '0'),
	(36, '所在部门数据', '5', 'sys_data_scope', '数据范围', 50, 0, 1, NULL, 1, NULL, NULL, '0'),
	(37, '仅本人数据', '8', 'sys_data_scope', '数据范围', 90, 0, 1, NULL, 1, NULL, NULL, '0'),
	(38, '按明细设置', '9', 'sys_data_scope', '数据范围', 100, 0, 1, NULL, 1, NULL, NULL, '0'),
	(39, '系统管理', '1', 'sys_user_type', '用户类型', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(40, '部门经理', '2', 'sys_user_type', '用户类型', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(41, '普通用户', '3', 'sys_user_type', '用户类型', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(42, '基础主题', 'basic', 'cms_theme', '站点主题', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(43, '蓝色主题', 'blue', 'cms_theme', '站点主题', 20, 0, 1, NULL, 1, NULL, NULL, '1'),
	(44, '红色主题', 'red', 'cms_theme', '站点主题', 30, 0, 1, NULL, 1, NULL, NULL, '1'),
	(45, '文章模型', 'article', 'cms_module', '栏目模型', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(46, '图片模型', 'picture', 'cms_module', '栏目模型', 20, 0, 1, NULL, 1, NULL, NULL, '1'),
	(47, '下载模型', 'download', 'cms_module', '栏目模型', 30, 0, 1, NULL, 1, NULL, NULL, '1'),
	(48, '链接模型', 'link', 'cms_module', '栏目模型', 40, 0, 1, NULL, 1, NULL, NULL, '0'),
	(49, '专题模型', 'special', 'cms_module', '栏目模型', 50, 0, 1, NULL, 1, NULL, NULL, '1'),
	(50, '默认展现方式', '0', 'cms_show_modes', '展现方式', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(51, '首栏目内容列表', '1', 'cms_show_modes', '展现方式', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(52, '栏目第一条内容', '2', 'cms_show_modes', '展现方式', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(53, '发布', '0', 'cms_del_flag', '内容状态', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(54, '删除', '1', 'cms_del_flag', '内容状态', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(55, '审核', '2', 'cms_del_flag', '内容状态', 15, 0, 1, NULL, 1, NULL, NULL, '0'),
	(56, '首页焦点图', '1', 'cms_posid', '推荐位', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(57, '栏目页文章推荐', '2', 'cms_posid', '推荐位', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(58, '咨询', '1', 'cms_guestbook', '留言板分类', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(59, '建议', '2', 'cms_guestbook', '留言板分类', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(60, '投诉', '3', 'cms_guestbook', '留言板分类', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(61, '其它', '4', 'cms_guestbook', '留言板分类', 40, 0, 1, NULL, 1, NULL, NULL, '0'),
	(62, '公休', '1', 'oa_leave_type', '请假类型', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(63, '病假', '2', 'oa_leave_type', '请假类型', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(64, '事假', '3', 'oa_leave_type', '请假类型', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(65, '调休', '4', 'oa_leave_type', '请假类型', 40, 0, 1, NULL, 1, NULL, NULL, '0'),
	(66, '婚假', '5', 'oa_leave_type', '请假类型', 60, 0, 1, NULL, 1, NULL, NULL, '0'),
	(67, '接入日志', '1', 'sys_log_type', '日志类型', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(68, '异常日志', '2', 'sys_log_type', '日志类型', 40, 0, 1, NULL, 1, NULL, NULL, '0'),
	(69, '请假流程', 'leave', 'act_type', '流程类型', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(70, '审批测试流程', 'test_audit', 'act_type', '流程类型', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(71, '分类1', '1', 'act_category', '流程分类', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(72, '分类2', '2', 'act_category', '流程分类', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(73, '增删改查', 'crud', 'gen_category', '代码生成分类', 10, 0, 1, NULL, 1, NULL, NULL, '1'),
	(74, '增删改查（包含从表）', 'crud_many', 'gen_category', '代码生成分类', 20, 0, 1, NULL, 1, NULL, NULL, '1'),
	(75, '树结构', 'tree', 'gen_category', '代码生成分类', 30, 0, 1, NULL, 1, NULL, NULL, '1'),
	(76, '=', '=', 'gen_query_type', '查询方式', 10, 0, 1, NULL, 1, NULL, NULL, '1'),
	(77, '!=', '!=', 'gen_query_type', '查询方式', 20, 0, 1, NULL, 1, NULL, NULL, '1'),
	(78, '&gt;', '&gt;', 'gen_query_type', '查询方式', 30, 0, 1, NULL, 1, NULL, NULL, '1'),
	(79, '&lt;', '&lt;', 'gen_query_type', '查询方式', 40, 0, 1, NULL, 1, NULL, NULL, '1'),
	(80, 'Between', 'between', 'gen_query_type', '查询方式', 50, 0, 1, NULL, 1, NULL, NULL, '1'),
	(81, 'Like', 'like', 'gen_query_type', '查询方式', 60, 0, 1, NULL, 1, NULL, NULL, '1'),
	(82, 'Left Like', 'left_like', 'gen_query_type', '查询方式', 70, 0, 1, NULL, 1, NULL, NULL, '1'),
	(83, 'Right Like', 'right_like', 'gen_query_type', '查询方式', 80, 0, 1, NULL, 1, NULL, NULL, '1'),
	(84, '文本框', 'input', 'gen_show_type', '字段生成方案', 10, 0, 1, NULL, 1, NULL, NULL, '1'),
	(85, '文本域', 'textarea', 'gen_show_type', '字段生成方案', 20, 0, 1, NULL, 1, NULL, NULL, '1'),
	(86, '下拉框', 'select', 'gen_show_type', '字段生成方案', 30, 0, 1, NULL, 1, NULL, NULL, '1'),
	(87, '复选框', 'checkbox', 'gen_show_type', '字段生成方案', 40, 0, 1, NULL, 1, NULL, NULL, '1'),
	(88, '单选框', 'radiobox', 'gen_show_type', '字段生成方案', 50, 0, 1, NULL, 1, NULL, NULL, '1'),
	(89, '日期选择', 'dateselect', 'gen_show_type', '字段生成方案', 60, 0, 1, NULL, 1, NULL, NULL, '1'),
	(90, '人员选择', 'userselect', 'gen_show_type', '字段生成方案', 70, 0, 1, NULL, 1, NULL, NULL, '1'),
	(91, '部门选择', 'officeselect', 'gen_show_type', '字段生成方案', 80, 0, 1, NULL, 1, NULL, NULL, '1'),
	(92, '区域选择', 'areaselect', 'gen_show_type', '字段生成方案', 90, 0, 1, NULL, 1, NULL, NULL, '1'),
	(93, 'String', 'String', 'gen_java_type', 'Java类型', 10, 0, 1, NULL, 1, NULL, NULL, '1'),
	(94, 'Long', 'Long', 'gen_java_type', 'Java类型', 20, 0, 1, NULL, 1, NULL, NULL, '1'),
	(95, '仅持久层', 'dao', 'gen_category', '代码生成分类', 40, 0, 1, NULL, 1, NULL, NULL, '1'),
	(96, '男', '1', 'sex', '性别', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(97, '女', '2', 'sex', '性别', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(98, 'Integer', 'Integer', 'gen_java_type', 'Java类型', 30, 0, 1, NULL, 1, NULL, NULL, '1'),
	(99, 'Double', 'Double', 'gen_java_type', 'Java类型', 40, 0, 1, NULL, 1, NULL, NULL, '1'),
	(100, 'Date', 'java.util.Date', 'gen_java_type', 'Java类型', 50, 0, 1, NULL, 1, NULL, NULL, '1'),
	(104, 'Custom', 'Custom', 'gen_java_type', 'Java类型', 90, 0, 1, NULL, 1, NULL, NULL, '1'),
	(105, '会议通告', '1', 'oa_notify_type', '通知通告类型', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(106, '奖惩通告', '2', 'oa_notify_type', '通知通告类型', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(107, '活动通告', '3', 'oa_notify_type', '通知通告类型', 30, 0, 1, NULL, 1, NULL, NULL, '0'),
	(108, '草稿', '0', 'oa_notify_status', '通知通告状态', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(109, '发布', '1', 'oa_notify_status', '通知通告状态', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(110, '未读', '0', 'oa_notify_read', '通知通告状态', 10, 0, 1, NULL, 1, NULL, NULL, '0'),
	(111, '已读', '1', 'oa_notify_read', '通知通告状态', 20, 0, 1, NULL, 1, NULL, NULL, '0'),
	(112, '草稿', '0', 'oa_notify_status', '通知通告状态', 10, 0, 1, NULL, 1, NULL, '', '0'),
	(113, '删除', '1', 'del_flag', '删除标记', NULL, NULL, NULL, NULL, NULL, NULL, '', ''),
	(121, '编码', 'code', 'hobby', '爱好', NULL, NULL, NULL, NULL, NULL, NULL, '', ''),
	(122, '绘画', 'painting', 'hobby', '爱好', NULL, NULL, NULL, NULL, NULL, NULL, '', ''),
	(123, 'Integer', 'Integer', 'java_type', 'Java数据类型', 1, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(124, 'Long', 'Long', 'java_type', 'Java数据类型', 2, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(125, 'Float', 'Float', 'java_type', 'Java数据类型', 3, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(126, 'Double', 'Double', 'java_type', 'Java数据类型', 4, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(127, 'BigDecimal', 'BigDecimal', 'java_type', 'Java数据类型', 5, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(128, 'Boolean', 'Boolean', 'java_type', 'Java数据类型', 6, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(129, 'String', 'String', 'java_type', 'Java数据类型', 7, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(130, 'Date', 'Date', 'java_type', 'Java数据类型', 8, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(131, '文本框', '1', 'page_type', '页面显示类型', 1, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(132, '下拉框', '2', 'page_type', '页面显示类型', 2, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(133, '数值', '3', 'page_type', '页面显示类型', 3, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(134, '日期', '4', 'page_type', '页面显示类型', 4, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(135, '文本域', '5', 'page_type', '页面显示类型', 5, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(136, '富文本', '6', 'page_type', '页面显示类型', 6, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(137, '上传图片【单文件】', '7', 'page_type', '页面显示类型', 7, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(138, '隐藏域', '11', 'page_type', '页面显示类型', 11, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(139, '不显示', '12', 'page_type', '页面显示类型', 12, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(140, '男频', '0', 'work_direction', '作品方向', 0, NULL, NULL, NULL, NULL, NULL, '', NULL),
	(141, '女频', '1', 'work_direction', '作品方向', 1, NULL, NULL, NULL, NULL, NULL, '', NULL);

-- Dumping structure for table novel_plus.sys_file
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE IF NOT EXISTS `sys_file` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` int DEFAULT NULL COMMENT '文件类型',
  `url` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='文件上传';

-- Dumping data for table novel_plus.sys_file: ~41 rows (approximately)
DELETE FROM `sys_file`;
INSERT INTO `sys_file` (`id`, `type`, `url`, `create_date`) VALUES
	(142, 0, '/files/658554ff-cd62-4ca2-936d-62e35f8af5ef.png', '2019-11-01 16:13:39'),
	(143, 0, '/files/de40bb48-c278-4360-9ee6-80b464419255.png', '2019-11-01 16:14:24'),
	(144, 0, '/files/8b0737fb-e68d-4162-a066-05f1f3f66b0f.png', '2019-11-02 19:42:03'),
	(145, 0, '/files/1006a87c-ee4e-4e97-8bcd-2b5cf861b826.png', '2019-11-02 19:42:28'),
	(146, 0, '/files/d7834c20-0e29-4c92-8d0a-9b1297b6e5b8.png', '2019-11-02 19:43:05'),
	(147, 0, '/files/6e5d38de-4366-459a-a498-7e418e746f62.png', '2019-11-02 19:45:59'),
	(148, 0, '/files/e34d60a9-6bde-48c0-ac4c-64a5ddffcdd4.jpg', '2019-11-02 19:54:49'),
	(149, 0, '/files/545579fa-ab81-42e2-8bfa-13ebdc7a137d.png', '2019-11-09 10:39:05'),
	(150, 1, '/files/fe0fe8db-495f-4c23-8c74-744399f5c1af.txt', '2019-11-09 17:28:31'),
	(151, 99, '/files/1a710af4-a766-4ed8-b8e9-2ec5ef25df6b.sql', '2019-11-09 17:42:59'),
	(152, 99, '/files/3a984623-4d2c-4122-9b47-6054eb670dc9.sql', '2019-11-09 17:43:04'),
	(153, 0, '/files/2019/11/09/44eddafe-1c58-4710-a2ba-3f88d0e77958.png', '2019-11-09 18:29:26'),
	(154, 0, '/files/2019/11/23/f0dfac47-7fc4-43e3-aab9-f5f2276ac550.png', '2019-11-23 11:29:03'),
	(155, 0, '/files/2019/11/23/c7ed1b36-63dc-4259-bb31-e2f8d86234de.png', '2019-11-23 11:29:06'),
	(156, 0, '/files/2019/11/23/4c772801-5cce-40ce-bd3c-603bb30d5ff4.png', '2019-11-23 13:18:11'),
	(157, 0, '/files/2019/11/23/3878019f-6799-4ac4-9a6b-4c709cca5610.png', '2019-11-23 13:18:50'),
	(158, 0, '/files/2019/11/23/94bac082-7358-4d84-a3e2-ae8ce31cc427.png', '2019-11-23 13:30:38'),
	(159, 0, '/files/2019/11/23/d5ae3fa2-deae-4703-93b8-723d372895a6.png', '2019-11-23 13:31:09'),
	(160, 0, '/files/2019/11/23/7b7beb05-9c02-40a1-b25f-db2366d76c87.png', '2019-11-23 13:33:04'),
	(161, 0, '/files/2019/11/23/b9deb454-b243-4685-8c69-ae2f302a079f.png', '2019-11-23 14:29:52'),
	(162, 0, '/files/2019/11/23/b33b6601-7578-4c58-86bf-d4099d53e752.png', '2019-11-23 14:30:32'),
	(163, 0, '/files/2019/11/23/16ed3b6a-c5c8-442e-a166-3f43f45cfc0f.png', '2019-11-23 14:33:53'),
	(164, 0, '/files/2019/11/23/9b768a28-d720-4f00-a019-9f3136f61ac4.png', '2019-11-23 14:34:22'),
	(165, 0, '/files/2019/11/23/51efde05-3096-4eda-a07e-fc44a939e909.png', '2019-11-23 15:15:13'),
	(166, 0, '/files/2019/11/23/eb590e78-f1e3-4d6a-879c-02f9e5028519.png', '2019-11-23 15:22:34'),
	(167, 0, '/files/2019/11/23/2d974db3-1292-47e8-8d37-5696d63fd737.png', '2019-11-23 15:23:11'),
	(168, 0, '/files/2019/11/23/afbf87aa-1ee9-4244-8f3c-a06dc75b950a.png', '2019-11-23 15:24:06'),
	(169, 0, '/files/2019/11/23/e1d27b6b-9c45-4309-9861-9bdb77dbea4c.png', '2019-11-23 15:34:14'),
	(170, 0, '/files/2019/11/23/25f40d3b-965d-4564-b153-052139446149.png', '2019-11-23 15:34:59'),
	(171, 0, '/files/2019/11/23/01c6e8ea-e25c-4191-b12c-0884391157c5.png', '2019-11-23 15:50:06'),
	(172, 0, '/files/2019/11/23/3a230ea3-93dc-4bf7-9037-94a013b3408c.png', '2019-11-23 15:51:04'),
	(173, 0, '/files/2019/11/23/4b6994ad-7629-48dc-9c15-c2cf01900b96.png', '2019-11-23 15:58:25'),
	(174, 0, '/files/2019/11/23/298fb24b-3e1f-4e97-88d7-2df41acffb8d.png', '2019-11-23 15:59:26'),
	(175, 0, '/files/2019/11/23/8e314673-ed11-4b58-942c-68ac34ade62d.png', '2019-11-23 16:10:07'),
	(176, 0, '/files/2019/11/23/4497dc84-518e-4b4f-b5f1-a38922827c00.png', '2019-11-23 16:11:19'),
	(177, 0, '/files/2019/11/23/81215d73-5922-4d99-8134-710d8a1505f5.png', '2019-11-23 16:59:39'),
	(178, 0, '/files/2019/11/23/22be71d0-e2e4-4c80-9db3-0955acf3a3b4.png', '2019-11-23 17:00:00'),
	(179, 0, '/files/2019/11/23/c92a51b2-0ee1-4f9a-aa9f-18da61d07e8f.png', '2019-11-23 17:13:28'),
	(180, 0, '/files/2019/11/23/eb3f9286-a8b2-46a1-9d1d-54d1b2170b0d.png', '2019-11-23 17:14:16'),
	(181, 0, '/files/2019/11/23/912af35f-8514-408d-9b21-f226e52f8611.png', '2019-11-23 17:33:16'),
	(182, 0, '/files/2019/11/23/ff9e2850-6d60-4a6b-a93a-d0e58b5dc21c.png', '2019-11-23 17:34:09');

-- Dumping structure for table novel_plus.sys_gen_columns
DROP TABLE IF EXISTS `sys_gen_columns`;
CREATE TABLE IF NOT EXISTS `sys_gen_columns` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `table_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '表名',
  `column_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '列名',
  `column_type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '映射java类型',
  `column_comment` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '列注释',
  `column_sort` tinyint DEFAULT NULL COMMENT '列排序（升序）',
  `column_label` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '鍒楁爣绛惧悕',
  `page_type` tinyint DEFAULT '1' COMMENT '页面显示类型：1、文本框 2、下拉框 3、数值4、日期 5、文本域6、富文本 7、上传图片【单文件】 8、上传图片【多文件】9、上传文件【单文件】 10、上传文件【多文件】11、隐藏域 12、不显示',
  `is_required` tinyint(1) DEFAULT NULL COMMENT '是否必填',
  `dict_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT '' COMMENT '页面显示为下拉时使用，字典类型从字典表中取出',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=815 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table novel_plus.sys_gen_columns: ~73 rows (approximately)
DELETE FROM `sys_gen_columns`;
INSERT INTO `sys_gen_columns` (`id`, `table_name`, `column_name`, `column_type`, `java_type`, `column_comment`, `column_sort`, `column_label`, `page_type`, `is_required`, `dict_type`) VALUES
	(452, 'sys_user', 'username', 'varchar', 'String', '用户名', 2, '用户名', 1, 0, NULL),
	(453, 'sys_user', 'name', 'varchar', 'String', '', 3, '真实姓名', 6, 0, NULL),
	(454, 'sys_user', 'password', 'varchar', 'String', '密码', 4, '密码', 3, 0, NULL),
	(455, 'sys_user', 'dept_id', 'bigint', 'Long', '', 5, '部门', 1, 0, NULL),
	(456, 'sys_user', 'email', 'varchar', 'String', '邮箱', 6, '邮箱', 1, 0, NULL),
	(457, 'sys_user', 'mobile', 'varchar', 'String', '手机号', 7, '手机号', 1, 0, NULL),
	(458, 'sys_user', 'status', 'tinyint', 'Integer', '状态 0:禁用，1:正常', 8, '状态 0:禁用，1:正常', 2, 0, 'yes_no'),
	(459, 'sys_user', 'user_id_create', 'bigint', 'Long', '创建用户id', 9, '创建用户id', 1, 0, NULL),
	(460, 'sys_user', 'gmt_create', 'datetime', 'Date', '创建时间', 10, '创建时间', 4, 0, NULL),
	(461, 'sys_user', 'gmt_modified', 'datetime', 'Date', '修改时间', 11, '修改时间', 4, 0, NULL),
	(462, 'sys_user', 'sex', 'bigint', 'Long', '性别', 12, '性别', 1, 0, NULL),
	(463, 'sys_user', 'birth', 'datetime', 'Date', '出身日期', 13, '出身日期', 4, 0, NULL),
	(464, 'sys_user', 'pic_id', 'bigint', 'Long', '', 14, '', 1, 0, NULL),
	(465, 'sys_user', 'live_address', 'varchar', 'String', '现居住地', 50, '现居住地', 6, 0, NULL),
	(466, 'sys_user', 'hobby', 'varchar', 'String', '爱好', 16, '爱好', 7, 0, NULL),
	(467, 'sys_user', 'province', 'varchar', 'String', '省份', 17, '省份', 2, 0, 'theme'),
	(468, 'sys_user', 'city', 'varchar', 'String', '所在城市', 18, '所在城市', 1, 0, NULL),
	(469, 'sys_user', 'district', 'varchar', 'String', '所在地区', 19, '所在地区', 7, 0, NULL),
	(730, 'sys_role_data_perm', 'role_id', 'bigint', 'Long', '角色ID', 2, '角色ID', 1, 0, NULL),
	(731, 'sys_role_data_perm', 'perm_id', 'bigint', 'Long', '权限ID', 3, '权限ID', 1, 0, NULL),
	(732, 'sys_data_perm', 'name', 'varchar', 'String', '权限名称', 2, '权限名称', 1, 1, NULL),
	(733, 'sys_data_perm', 'table_name', 'varchar', 'String', '数据表名称', 3, '数据表名称', 1, 1, NULL),
	(734, 'sys_data_perm', 'module_name', 'varchar', 'String', '所属模块', 4, '所属模块', 1, 1, NULL),
	(735, 'sys_data_perm', 'crl_attr_name', 'varchar', 'String', '用户权限控制属性名', 5, '用户权限控制属性名', 1, 1, NULL),
	(736, 'sys_data_perm', 'crl_column_name', 'varchar', 'String', '数据表权限控制列名', 6, '数据表权限控制列名', 1, 1, NULL),
	(737, 'sys_data_perm', 'perm_code', 'varchar', 'String', '权限code，all_开头表示查看所有数据的权限，sup_开头表示查看下级数据的权限，own_开头表示查看本级数据的权限', 7, '权限code', 1, 1, NULL),
	(738, 'sys_data_perm', 'order_num', 'int', 'Integer', '排序', 8, '排序', 3, 0, NULL),
	(739, 'sys_data_perm', 'gmt_create', 'datetime', 'Date', '创建时间', 9, '创建时间', 12, 0, NULL),
	(740, 'sys_data_perm', 'gmt_modified', 'datetime', 'Date', '修改时间', 10, '修改时间', 12, 0, NULL),
	(771, 'fb_order', 'fb_merchant_code', 'varchar', 'String', '付呗商户号', 4, '付呗商户号', 1, 0, 'del_flag'),
	(772, 'fb_order', 'merchant_order_sn', 'varchar', 'String', '第三方商户的订单号', 5, '第三方商户的订单号', 1, 0, 'del_flag'),
	(773, 'fb_order', 'order_sn', 'varchar', 'String', '付呗订单号', 6, '付呗订单号', 2, 0, 'color'),
	(774, 'fb_order', 'platform_order_no', 'varchar', 'String', '平台方订单号', 7, '平台方订单号', 2, 0, 'oa_leave_type'),
	(775, 'fb_order', 'trade_no', 'varchar', 'String', '商户单号', 8, '商户单号', 6, 0, 'del_flag'),
	(776, 'fb_order', 'order_state', 'tinyint', 'Integer', '订单状态，1：未支付，2：支付成功，3：支付失败，4：支付取消', 9, '订单状态，1：未支付，2：支付成功，3：支付失败，4：支付取消', 2, 0, 'yes_no'),
	(777, 'fb_order', 'fn_coupon', 'decimal', 'Double', '蜂鸟优惠卷抵扣', 10, '蜂鸟优惠卷抵扣', 3, 0, 'del_flag'),
	(778, 'fb_order', 'red_packet', 'decimal', 'BigDecimal', '红包抵扣', 11, '红包抵扣', 3, 0, 'del_flag'),
	(779, 'fb_order', 'total_fee', 'decimal', 'BigDecimal', '实收金额(元)', 12, '实收金额(元)', 3, 0, 'del_flag'),
	(780, 'fb_order', 'order_price', 'decimal', 'BigDecimal', '订单金额', 13, '订单金额', 3, 0, 'del_flag'),
	(781, 'fb_order', 'fee', 'decimal', 'BigDecimal', '手续费(元)', 14, '手续费(元)', 3, 0, 'del_flag'),
	(782, 'fb_order', 'body', 'varchar', 'String', '对商品或交易的描述', 15, '对商品或交易的描述', 7, 0, 'del_flag'),
	(783, 'fb_order', 'attach', 'varchar', 'String', '附加数据', 16, '附加数据', 6, 0, 'del_flag'),
	(784, 'fb_order', 'store_id', 'bigint', 'Long', '付呗系统的门店id', 17, '付呗系统的门店id', 3, 0, 'del_flag'),
	(785, 'fb_order', 'cashier_id', 'bigint', 'Long', '付呗系统的收银员id', 18, '付呗系统的收银员id', 3, 0, 'del_flag'),
	(786, 'fb_order', 'device_no', 'varchar', 'String', '设备终端号', 19, '设备终端号', 1, 0, 'del_flag'),
	(787, 'fb_order', 'user_id', 'varchar', 'String', '微信顾客支付授权的“open_id”或者支付宝顾客的“buyer_user_id”', 20, '微信顾客支付授权的“open_id”或者支付宝顾客的“buyer_user_id”', 1, 0, 'del_flag'),
	(788, 'fb_order', 'user_logon_id', 'varchar', 'String', '支付宝顾客的账号', 21, '支付宝顾客的账号', 5, 0, 'del_flag'),
	(789, 'fb_order', 'pay_time', 'datetime', 'Date', '交易成功的时间', 22, '交易成功的时间', 4, 0, 'del_flag'),
	(790, 'fb_order', 'pay_channel', 'tinyint', 'Integer', '支付通道:1微信、2支付宝、3银联', 23, '支付通道:1微信、2支付宝、3银联', 2, 0, 'del_flag'),
	(791, 'fb_order', 'no_cash_coupon_fee', 'decimal', 'BigDecimal', '免充值代金券金额(元)', 24, '免充值代金券金额(元)', 3, 0, 'del_flag'),
	(792, 'fb_order', 'cash_coupon_fee', 'decimal', 'BigDecimal', '预充值代金券金额(元)', 25, '预充值代金券金额(元)', 3, 0, 'yes_no'),
	(793, 'fb_order', 'cash_fee', 'decimal', 'BigDecimal', '顾客实际支付金额(元)', 26, '顾客实际支付金额(元)', 3, 0, 'del_flag'),
	(794, 'fb_order', 'sign', 'varchar', 'String', '签名', 27, '签名', 2, 0, 'theme'),
	(795, 'fb_order', 'options', 'varchar', 'String', '其它选项', 28, '其它选项', 7, 0, 'del_flag'),
	(796, 'fb_order', 'create_time', 'datetime', 'Date', '创建时间', 29, '创建时间', 4, 0, 'del_flag'),
	(797, 'fb_order', 'push_time', 'datetime', 'Date', '推送时间', 30, '推送时间', 4, 0, 'del_flag'),
	(798, 'fb_order', 'push_ip', 'varchar', 'String', '推送IP', 31, '推送IP', 6, 0, 'del_flag'),
	(799, 'fb_order', 'mcht_id', 'bigint', 'BigDecimal', '商户id', 90, '商户id', 3, 0, 'theme'),
	(800, 'fb_order', 'sn', 'char', 'String', 'QR编号', 100, 'QR编号', 1, 0, 'del_flag'),
	(801, 'author', 'user_id', 'bigint', 'Long', '用户ID', 2, '用户ID', 1, 0, NULL),
	(802, 'author', 'invite_code', 'varchar', 'String', '邀请码', 3, '邀请码', 1, 0, NULL),
	(803, 'author', 'pen_name', 'varchar', 'String', '笔名', 4, '笔名', 1, 0, NULL),
	(804, 'author', 'tel_phone', 'varchar', 'String', '手机号码', 5, '手机号码', 1, 0, NULL),
	(805, 'author', 'chat_account', 'varchar', 'String', 'QQ或微信账号', 6, 'QQ或微信账号', 1, 0, NULL),
	(806, 'author', 'email', 'varchar', 'String', '电子邮箱', 7, '电子邮箱', 1, 0, NULL),
	(807, 'author', 'work_direction', 'tinyint', 'Integer', '作品方向，0：男频，1：女频', 8, '作品方向，0：男频，1：女频', 2, 0, 'work_direction'),
	(808, 'author', 'status', 'tinyint', 'Integer', '0：正常，1：封禁', 10, '0：正常，1：封禁', 1, 0, NULL),
	(809, 'author', 'create_time', 'datetime', 'Date', '创建时间', 9, '入驻时间', 4, 0, NULL),
	(810, 'author_code', 'invite_code', 'varchar', 'String', '邀请码', 2, '邀请码', 1, 1, NULL),
	(811, 'author_code', 'validity_time', 'datetime', 'Date', '有效时间', 3, '有效时间', 4, 1, NULL),
	(812, 'author_code', 'is_use', 'tinyint', 'Integer', '是否使用过，0：未使用，1:使用过', 4, '是否使用过，0：未使用，1:使用过', 1, 0, NULL),
	(813, 'author_code', 'create_time', 'datetime', 'Date', '创建时间', 5, '创建时间', 4, 0, NULL),
	(814, 'author_code', 'create_user_id', 'bigint', 'Long', '创建人ID', 6, '创建人ID', 1, 0, NULL);

-- Dumping structure for table novel_plus.sys_gen_table
DROP TABLE IF EXISTS `sys_gen_table`;
CREATE TABLE IF NOT EXISTS `sys_gen_table` (
  `id` bigint NOT NULL COMMENT '主键',
  `table_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表名',
  `class_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '实体类名称',
  `comments` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '表说明',
  `category` tinyint(1) NOT NULL DEFAULT '0' COMMENT '分类：0：数据表，1：树表',
  `package_name` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成功能名，用于类描述',
  `function_name_simple` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成功能名（简写），用于功能提示，如“保存xx成功”',
  `author` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `src_dir` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'src目录',
  `options` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` bigint NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` bigint NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='代码生成表';

-- Dumping data for table novel_plus.sys_gen_table: ~1 rows (approximately)
DELETE FROM `sys_gen_table`;
INSERT INTO `sys_gen_table` (`id`, `table_name`, `class_name`, `comments`, `category`, `package_name`, `module_name`, `sub_module_name`, `function_name`, `function_name_simple`, `author`, `src_dir`, `options`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`) VALUES
	(1, '表名', '1', '1', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2019-10-24 18:21:24', 1, '2019-10-24 18:21:35', NULL);

-- Dumping structure for table novel_plus.sys_gen_table_column
DROP TABLE IF EXISTS `sys_gen_table_column`;
CREATE TABLE IF NOT EXISTS `sys_gen_table_column` (
  `id` bigint NOT NULL COMMENT '主键',
  `table_id` bigint NOT NULL COMMENT '表id',
  `column_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '列名',
  `column_sort` decimal(10,0) DEFAULT NULL COMMENT '列排序（升序）',
  `column_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '类型',
  `column_label` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '列标签名',
  `comments` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '列备注说明',
  `attr_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '类的属性名',
  `attr_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '类的属性类型',
  `is_pk` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否主键',
  `is_null` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否插入字段',
  `is_update` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否更新字段',
  `is_list` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '查询方式',
  `is_edit` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '是否编辑字段',
  `show_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '表单类型',
  `options` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '其它生成选项',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_gen_table_column_tn` (`table_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='代码生成表列';

-- Dumping data for table novel_plus.sys_gen_table_column: ~0 rows (approximately)
DELETE FROM `sys_gen_table_column`;

-- Dumping structure for table novel_plus.sys_log
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE IF NOT EXISTS `sys_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户操作',
  `time` int DEFAULT NULL COMMENT '响应时间',
  `method` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'IP地址',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1436 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='系统日志';

-- Dumping data for table novel_plus.sys_log: ~24 rows (approximately)
DELETE FROM `sys_log`;
INSERT INTO `sys_log` (`id`, `user_id`, `username`, `operation`, `time`, `method`, `params`, `ip`, `gmt_create`) VALUES
	(1412, -1, '获取用户信息为空', '登录', 20, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2025-11-21 09:02:58'),
	(1413, -1, '获取用户信息为空', '登录', 3, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2025-11-21 09:03:01'),
	(1414, -1, '获取用户信息为空', '登录', 13, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2025-11-21 09:03:07'),
	(1415, -1, '获取用户信息为空', '登录', 10, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2025-11-21 09:04:46'),
	(1416, -1, '获取用户信息为空', '登录', 13, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2025-11-21 09:08:06'),
	(1417, 1, 'admin', '登录', 291, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2025-11-21 09:12:17'),
	(1418, 1, 'admin', '请求访问主页', 108, 'com.java2nb.system.controller.LoginController.index()', NULL, '127.0.0.1', '2025-11-21 09:12:18'),
	(1419, 1, 'admin', '登录', 105, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2025-11-21 09:13:34'),
	(1420, 1, 'admin', '请求访问主页', 26, 'com.java2nb.system.controller.LoginController.index()', NULL, '127.0.0.1', '2025-11-21 09:13:34'),
	(1421, -1, '获取用户信息为空', '登录', 1747, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '172.19.96.1', '2025-12-08 09:24:32'),
	(1422, 1, 'admin', '登录', 297, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '172.19.96.1', '2025-12-08 09:25:04'),
	(1423, 1, 'admin', '请求访问主页', 126, 'com.java2nb.system.controller.LoginController.index()', NULL, '172.19.96.1', '2025-12-08 09:25:04'),
	(1424, 1, 'admin', '登录', 61, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '172.19.96.1', '2025-12-08 09:35:02'),
	(1425, 1, 'admin', '请求访问主页', 30, 'com.java2nb.system.controller.LoginController.index()', NULL, '172.19.96.1', '2025-12-08 09:35:02'),
	(1426, 1, 'admin', '登录', 72, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '172.19.96.1', '2025-12-08 09:47:09'),
	(1427, 1, 'admin', '请求访问主页', 34, 'com.java2nb.system.controller.LoginController.index()', NULL, '172.19.96.1', '2025-12-08 09:47:09'),
	(1428, -1, '获取用户信息为空', '登录', 144, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '172.19.96.1', '2025-12-08 18:29:07'),
	(1429, -1, '获取用户信息为空', '登录', 7, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '172.19.96.1', '2025-12-08 18:29:11'),
	(1430, 1, 'admin', '登录', 156, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '172.19.96.1', '2025-12-08 18:29:16'),
	(1431, 1, 'admin', '请求访问主页', 69, 'com.java2nb.system.controller.LoginController.index()', NULL, '172.19.96.1', '2025-12-08 18:29:17'),
	(1432, 1, 'admin', '请求访问主页', 3192, 'com.java2nb.system.controller.LoginController.index()', NULL, '172.19.96.1', '2025-12-08 18:38:28'),
	(1433, -1, '获取用户信息为空', '登录', 5, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '172.19.96.1', '2025-12-16 20:13:55'),
	(1434, 1, 'admin', '登录', 843, 'com.java2nb.system.controller.LoginController.ajaxLogin()', NULL, '172.19.96.1', '2025-12-16 20:14:04'),
	(1435, 1, 'admin', '请求访问主页', 375, 'com.java2nb.system.controller.LoginController.index()', NULL, '172.19.96.1', '2025-12-16 20:14:05');

-- Dumping structure for table novel_plus.sys_menu
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE IF NOT EXISTS `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT,
  `parent_id` bigint DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '菜单图标',
  `order_num` int DEFAULT NULL COMMENT '排序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='菜单管理';

-- Dumping data for table novel_plus.sys_menu: ~65 rows (approximately)
DELETE FROM `sys_menu`;
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`, `gmt_create`, `gmt_modified`) VALUES
	(1, 0, '基础管理', '', '', 0, 'fa fa-bars', 0, '2017-08-09 22:49:47', NULL),
	(2, 3, '系统菜单', 'sys/menu/', 'sys:menu:menu', 1, 'fa fa-th-list', 2, '2017-08-09 22:55:15', NULL),
	(3, 0, '系统管理', NULL, NULL, 0, 'fa fa-desktop', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43'),
	(6, 3, '用户管理', 'sys/user/', 'sys:user:user', 1, 'fa fa-user', 0, '2017-08-10 14:12:11', NULL),
	(7, 3, '角色管理', 'sys/role', 'sys:role:role', 1, 'fa fa-paw', 1, '2017-08-10 14:13:19', NULL),
	(12, 6, '新增', '', 'sys:user:add', 2, '', 0, '2017-08-14 10:51:35', NULL),
	(13, 6, '编辑', '', 'sys:user:edit', 2, '', 0, '2017-08-14 10:52:06', NULL),
	(14, 6, '删除', NULL, 'sys:user:remove', 2, NULL, 0, '2017-08-14 10:52:24', NULL),
	(15, 7, '新增', '', 'sys:role:add', 2, '', 0, '2017-08-14 10:56:37', NULL),
	(20, 2, '新增', '', 'sys:menu:add', 2, '', 0, '2017-08-14 10:59:32', NULL),
	(21, 2, '编辑', '', 'sys:menu:edit', 2, '', 0, '2017-08-14 10:59:56', NULL),
	(22, 2, '删除', '', 'sys:menu:remove', 2, '', 0, '2017-08-14 11:00:26', NULL),
	(24, 6, '批量删除', '', 'sys:user:batchRemove', 2, '', 0, '2017-08-14 17:27:18', NULL),
	(25, 6, '停用', NULL, 'sys:user:disable', 2, NULL, 0, '2017-08-14 17:27:43', NULL),
	(26, 6, '重置密码', '', 'sys:user:resetPwd', 2, '', 0, '2017-08-14 17:28:34', NULL),
	(27, 91, '系统日志', 'common/log', 'common:log', 1, 'fa fa-warning', 0, '2017-08-14 22:11:53', NULL),
	(28, 27, '刷新', NULL, 'sys:log:list', 2, NULL, 0, '2017-08-14 22:30:22', NULL),
	(29, 27, '删除', NULL, 'sys:log:remove', 2, NULL, 0, '2017-08-14 22:30:43', NULL),
	(30, 27, '清空', NULL, 'sys:log:clear', 2, NULL, 0, '2017-08-14 22:31:02', NULL),
	(48, 77, '代码生成', 'common/generator', 'common:generator', 1, 'fa fa-code', 3, NULL, NULL),
	(55, 7, '编辑', '', 'sys:role:edit', 2, '', NULL, NULL, NULL),
	(56, 7, '删除', '', 'sys:role:remove', 2, NULL, NULL, NULL, NULL),
	(57, 91, '运行监控', '/druid/index.html', '', 1, 'fa fa-caret-square-o-right', 1, NULL, NULL),
	(61, 2, '批量删除', '', 'sys:menu:batchRemove', 2, NULL, NULL, NULL, NULL),
	(62, 7, '批量删除', '', 'sys:role:batchRemove', 2, NULL, NULL, NULL, NULL),
	(71, 1, '文件管理', '/common/sysFile', 'common:sysFile:sysFile', 1, 'fa fa-folder-open', 2, NULL, NULL),
	(73, 3, '部门管理', '/system/sysDept', 'system:sysDept:sysDept', 1, 'fa fa-users', 3, NULL, NULL),
	(74, 73, '增加', '/system/sysDept/add', 'system:sysDept:add', 2, NULL, 1, NULL, NULL),
	(75, 73, '刪除', 'system/sysDept/remove', 'system:sysDept:remove', 2, NULL, 2, NULL, NULL),
	(76, 73, '编辑', '/system/sysDept/edit', 'system:sysDept:edit', 2, NULL, 3, NULL, NULL),
	(77, 0, '研发工具', '', '', 0, 'fa fa-gear', 5, NULL, NULL),
	(78, 1, '数据字典', '/common/dict', 'common:dict:dict', 1, 'fa fa-book', 1, NULL, NULL),
	(79, 78, '增加', '/common/dict/add', 'common:dict:add', 2, NULL, 2, NULL, NULL),
	(80, 78, '编辑', '/common/dict/edit', 'common:dict:edit', 2, NULL, 2, NULL, NULL),
	(81, 78, '删除', '/common/dict/remove', 'common:dict:remove', 2, '', 3, NULL, NULL),
	(83, 78, '批量删除', '/common/dict/batchRemove', 'common:dict:batchRemove', 2, '', 4, NULL, NULL),
	(91, 0, '系统监控', '', '', 0, 'fa fa-video-camera', 4, NULL, NULL),
	(92, 91, '在线用户', 'sys/online', '', 1, 'fa fa-user', NULL, NULL, NULL),
	(104, 77, 'swagger', '/swagger-ui.html', '', 1, '', NULL, NULL, NULL),
	(202, 0, '测试管理', '', '', 0, 'fa fa-s15', 12, NULL, NULL),
	(203, 202, '订单管理', 'test/order', 'test:order:order', 1, '', 1, NULL, NULL),
	(204, 203, '新增', '', 'test:order:add', 2, '', NULL, NULL, NULL),
	(205, 203, '编辑', '', 'test:order:edit', 2, '', NULL, NULL, NULL),
	(206, 203, '删除', '', 'test:order:remove', 2, '', NULL, NULL, NULL),
	(207, 203, '批量删除', '', 'test:order:batchRemove', 2, '', NULL, NULL, NULL),
	(208, 203, '详情', '', 'test:order:detail', 2, '', 0, NULL, NULL),
	(209, 3, '数据权限', 'system/dataPerm', 'system:dataPerm:dataPerm', 1, 'fa', 6, NULL, NULL),
	(210, 209, '查看', NULL, 'system:dataPerm:detail', 2, NULL, 6, NULL, NULL),
	(211, 209, '新增', NULL, 'system:dataPerm:add', 2, NULL, 6, NULL, NULL),
	(212, 209, '修改', NULL, 'system:dataPerm:edit', 2, NULL, 6, NULL, NULL),
	(213, 209, '删除', NULL, 'system:dataPerm:remove', 2, NULL, 6, NULL, NULL),
	(214, 209, '批量删除', NULL, 'system:dataPerm:batchRemove', 2, NULL, 6, NULL, NULL),
	(221, 0, '作家管理', '', '', 0, 'fa fa-user-o', 10, NULL, NULL),
	(222, 221, '作者列表', 'novel/author', 'novel:author:author', 1, 'fa', 6, NULL, NULL),
	(223, 222, '查看', NULL, 'novel:author:detail', 2, NULL, 6, NULL, NULL),
	(224, 222, '新增', NULL, 'novel:author:add', 2, NULL, 6, NULL, NULL),
	(225, 222, '修改', NULL, 'novel:author:edit', 2, NULL, 6, NULL, NULL),
	(226, 222, '删除', NULL, 'novel:author:remove', 2, NULL, 6, NULL, NULL),
	(227, 222, '批量删除', NULL, 'novel:author:batchRemove', 2, NULL, 6, NULL, NULL),
	(228, 221, '邀请码管理', 'novel/authorCode', 'novel:authorCode:authorCode', 1, 'fa', 3, NULL, NULL),
	(229, 228, '查看', NULL, 'novel:authorCode:detail', 2, NULL, 6, NULL, NULL),
	(230, 228, '新增', NULL, 'novel:authorCode:add', 2, NULL, 6, NULL, NULL),
	(231, 228, '修改', NULL, 'novel:authorCode:edit', 2, NULL, 6, NULL, NULL),
	(232, 228, '删除', NULL, 'novel:authorCode:remove', 2, NULL, 6, NULL, NULL),
	(233, 228, '批量删除', NULL, 'novel:authorCode:batchRemove', 2, NULL, 6, NULL, NULL);

-- Dumping structure for table novel_plus.sys_role
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE IF NOT EXISTS `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '角色名称',
  `role_sign` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '角色标识',
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '备注',
  `user_id_create` bigint DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='角色';

-- Dumping data for table novel_plus.sys_role: ~1 rows (approximately)
DELETE FROM `sys_role`;
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_sign`, `remark`, `user_id_create`, `gmt_create`, `gmt_modified`) VALUES
	(1, '超级用户角色', 'admin', '拥有最高权限', 2, '2017-08-12 00:43:52', '2017-08-12 19:14:59');

-- Dumping structure for table novel_plus.sys_role_data_perm
DROP TABLE IF EXISTS `sys_role_data_perm`;
CREATE TABLE IF NOT EXISTS `sys_role_data_perm` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `perm_id` bigint DEFAULT NULL COMMENT '权限ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='角色与数据权限对应关系';

-- Dumping data for table novel_plus.sys_role_data_perm: ~11 rows (approximately)
DELETE FROM `sys_role_data_perm`;
INSERT INTO `sys_role_data_perm` (`id`, `role_id`, `perm_id`) VALUES
	(60, 60, 211),
	(61, 60, -1),
	(62, 60, 1199170283966787584),
	(71, 1, 214),
	(72, 1, 213),
	(73, 1, 212),
	(74, 1, 211),
	(75, 1, 210),
	(76, 1, 1260412100929482752),
	(77, 1, -1),
	(78, 1, 1260412099998347264);

-- Dumping structure for table novel_plus.sys_role_menu
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE IF NOT EXISTS `sys_role_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4830 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='角色与菜单对应关系';

-- Dumping data for table novel_plus.sys_role_menu: ~375 rows (approximately)
DELETE FROM `sys_role_menu`;
INSERT INTO `sys_role_menu` (`id`, `role_id`, `menu_id`) VALUES
	(367, 44, 1),
	(368, 44, 32),
	(369, 44, 33),
	(370, 44, 34),
	(371, 44, 35),
	(372, 44, 28),
	(373, 44, 29),
	(374, 44, 30),
	(375, 44, 38),
	(376, 44, 4),
	(377, 44, 27),
	(378, 45, 38),
	(379, 46, 3),
	(380, 46, 20),
	(381, 46, 21),
	(382, 46, 22),
	(383, 46, 23),
	(384, 46, 11),
	(385, 46, 12),
	(386, 46, 13),
	(387, 46, 14),
	(388, 46, 24),
	(389, 46, 25),
	(390, 46, 26),
	(391, 46, 15),
	(392, 46, 2),
	(393, 46, 6),
	(394, 46, 7),
	(598, 50, 38),
	(632, 38, 42),
	(737, 51, 38),
	(738, 51, 39),
	(739, 51, 40),
	(740, 51, 41),
	(741, 51, 4),
	(742, 51, 32),
	(743, 51, 33),
	(744, 51, 34),
	(745, 51, 35),
	(746, 51, 27),
	(747, 51, 28),
	(748, 51, 29),
	(749, 51, 30),
	(750, 51, 1),
	(1064, 54, 53),
	(1095, 55, 2),
	(1096, 55, 6),
	(1097, 55, 7),
	(1098, 55, 3),
	(1099, 55, 50),
	(1100, 55, 49),
	(1101, 55, 1),
	(1856, 53, 28),
	(1857, 53, 29),
	(1858, 53, 30),
	(1859, 53, 27),
	(1860, 53, 57),
	(1861, 53, 71),
	(1862, 53, 48),
	(1863, 53, 72),
	(1864, 53, 1),
	(1865, 53, 7),
	(1866, 53, 55),
	(1867, 53, 56),
	(1868, 53, 62),
	(1869, 53, 15),
	(1870, 53, 2),
	(1871, 53, 61),
	(1872, 53, 20),
	(1873, 53, 21),
	(1874, 53, 22),
	(2084, 56, 68),
	(2085, 56, 60),
	(2086, 56, 59),
	(2087, 56, 58),
	(2088, 56, 51),
	(2089, 56, 50),
	(2090, 56, 49),
	(2243, 48, 72),
	(2247, 63, -1),
	(2248, 63, 84),
	(2249, 63, 85),
	(2250, 63, 88),
	(2251, 63, 87),
	(2252, 64, 84),
	(2253, 64, 89),
	(2254, 64, 88),
	(2255, 64, 87),
	(2256, 64, 86),
	(2257, 64, 85),
	(2258, 65, 89),
	(2259, 65, 88),
	(2260, 65, 86),
	(2262, 67, 48),
	(2263, 68, 88),
	(2264, 68, 87),
	(2265, 69, 89),
	(2266, 69, 88),
	(2267, 69, 86),
	(2268, 69, 87),
	(2269, 69, 85),
	(2270, 69, 84),
	(2271, 70, 85),
	(2272, 70, 89),
	(2273, 70, 88),
	(2274, 70, 87),
	(2275, 70, 86),
	(2276, 70, 84),
	(2277, 71, 87),
	(2278, 72, 59),
	(2279, 73, 48),
	(2280, 74, 88),
	(2281, 74, 87),
	(2282, 75, 88),
	(2283, 75, 87),
	(2284, 76, 85),
	(2285, 76, 89),
	(2286, 76, 88),
	(2287, 76, 87),
	(2288, 76, 86),
	(2289, 76, 84),
	(2292, 78, 88),
	(2293, 78, 87),
	(2294, 78, NULL),
	(2295, 78, NULL),
	(2296, 78, NULL),
	(2308, 80, 87),
	(2309, 80, 86),
	(2310, 80, -1),
	(2311, 80, 84),
	(2312, 80, 85),
	(2328, 79, 72),
	(2329, 79, 48),
	(2330, 79, 77),
	(2331, 79, 84),
	(2332, 79, 89),
	(2333, 79, 88),
	(2334, 79, 87),
	(2335, 79, 86),
	(2336, 79, 85),
	(2337, 79, -1),
	(2338, 77, 89),
	(2339, 77, 88),
	(2340, 77, 87),
	(2341, 77, 86),
	(2342, 77, 85),
	(2343, 77, 84),
	(2344, 77, 72),
	(2345, 77, -1),
	(2346, 77, 77),
	(2974, 57, 93),
	(2975, 57, 99),
	(2976, 57, 95),
	(2977, 57, 101),
	(2978, 57, 96),
	(2979, 57, 94),
	(2980, 57, -1),
	(2981, 58, 93),
	(2982, 58, 99),
	(2983, 58, 95),
	(2984, 58, 101),
	(2985, 58, 96),
	(2986, 58, 94),
	(2987, 58, -1),
	(3232, 59, 98),
	(3233, 59, 101),
	(3234, 59, 99),
	(3235, 59, 95),
	(3236, 59, 90),
	(3237, 59, 89),
	(3238, 59, 88),
	(3239, 59, 87),
	(3240, 59, 86),
	(3241, 59, 68),
	(3242, 59, 60),
	(3243, 59, 59),
	(3244, 59, 58),
	(3245, 59, 51),
	(3246, 59, 76),
	(3247, 59, 75),
	(3248, 59, 74),
	(3249, 59, 62),
	(3250, 59, 56),
	(3251, 59, 55),
	(3252, 59, 15),
	(3253, 59, 26),
	(3254, 59, 25),
	(3255, 59, 24),
	(3256, 59, 14),
	(3257, 59, 13),
	(3258, 59, 12),
	(3259, 59, 61),
	(3260, 59, 22),
	(3261, 59, 21),
	(3262, 59, 20),
	(3263, 59, 83),
	(3264, 59, 81),
	(3265, 59, 80),
	(3266, 59, 79),
	(3267, 59, 71),
	(3268, 59, 97),
	(3269, 59, 96),
	(3270, 59, 94),
	(3271, 59, 93),
	(3272, 59, 85),
	(3273, 59, 84),
	(3274, 59, 50),
	(3275, 59, 49),
	(3276, 59, 73),
	(3277, 59, 7),
	(3278, 59, 6),
	(3279, 59, 2),
	(3280, 59, 3),
	(3281, 59, 78),
	(3282, 59, 1),
	(3283, 59, -1),
	(4611, 61, 208),
	(4612, 61, 207),
	(4613, 61, 206),
	(4614, 61, 205),
	(4615, 61, 204),
	(4616, 61, 92),
	(4617, 61, 57),
	(4618, 61, 30),
	(4619, 61, 29),
	(4620, 61, 28),
	(4621, 61, 104),
	(4622, 61, 48),
	(4623, 61, 214),
	(4624, 61, 213),
	(4625, 61, 212),
	(4626, 61, 211),
	(4627, 61, 210),
	(4628, 61, 76),
	(4629, 61, 75),
	(4630, 61, 74),
	(4631, 61, 62),
	(4632, 61, 56),
	(4633, 61, 55),
	(4634, 61, 15),
	(4635, 61, 26),
	(4636, 61, 25),
	(4637, 61, 24),
	(4638, 61, 14),
	(4639, 61, 13),
	(4640, 61, 12),
	(4641, 61, 61),
	(4642, 61, 22),
	(4643, 61, 21),
	(4644, 61, 20),
	(4645, 61, 83),
	(4646, 61, 81),
	(4647, 61, 80),
	(4648, 61, 79),
	(4649, 61, 71),
	(4650, 61, 203),
	(4651, 61, 202),
	(4652, 61, 27),
	(4653, 61, 91),
	(4654, 61, 77),
	(4655, 61, 209),
	(4656, 61, 73),
	(4657, 61, 7),
	(4658, 61, 6),
	(4659, 61, 2),
	(4660, 61, 3),
	(4661, 61, 78),
	(4662, 61, 1),
	(4663, 61, -1),
	(4664, 60, 92),
	(4665, 60, 57),
	(4666, 60, 30),
	(4667, 60, 29),
	(4668, 60, 28),
	(4669, 60, 104),
	(4670, 60, 48),
	(4671, 60, 76),
	(4672, 60, 75),
	(4673, 60, 74),
	(4674, 60, 62),
	(4675, 60, 56),
	(4676, 60, 55),
	(4677, 60, 15),
	(4678, 60, 26),
	(4679, 60, 25),
	(4680, 60, 24),
	(4681, 60, 14),
	(4682, 60, 13),
	(4683, 60, 12),
	(4684, 60, 61),
	(4685, 60, 22),
	(4686, 60, 21),
	(4687, 60, 20),
	(4688, 60, 83),
	(4689, 60, 81),
	(4690, 60, 80),
	(4691, 60, 79),
	(4692, 60, 71),
	(4693, 60, 27),
	(4694, 60, 91),
	(4695, 60, 77),
	(4696, 60, 73),
	(4697, 60, 7),
	(4698, 60, 6),
	(4699, 60, 2),
	(4700, 60, 78),
	(4701, 60, 1),
	(4702, 60, -1),
	(4703, 60, 3),
	(4764, 1, 227),
	(4765, 1, 226),
	(4766, 1, 225),
	(4767, 1, 224),
	(4768, 1, 223),
	(4769, 1, 208),
	(4770, 1, 207),
	(4771, 1, 206),
	(4772, 1, 205),
	(4773, 1, 204),
	(4774, 1, 92),
	(4775, 1, 57),
	(4776, 1, 30),
	(4777, 1, 29),
	(4778, 1, 28),
	(4779, 1, 104),
	(4780, 1, 48),
	(4781, 1, 214),
	(4782, 1, 213),
	(4783, 1, 212),
	(4784, 1, 211),
	(4785, 1, 210),
	(4786, 1, 76),
	(4787, 1, 75),
	(4788, 1, 74),
	(4789, 1, 62),
	(4790, 1, 56),
	(4791, 1, 55),
	(4792, 1, 15),
	(4793, 1, 26),
	(4794, 1, 25),
	(4795, 1, 24),
	(4796, 1, 14),
	(4797, 1, 13),
	(4798, 1, 12),
	(4799, 1, 61),
	(4800, 1, 22),
	(4801, 1, 21),
	(4802, 1, 20),
	(4803, 1, 83),
	(4804, 1, 81),
	(4805, 1, 80),
	(4806, 1, 79),
	(4807, 1, 71),
	(4808, 1, 222),
	(4809, 1, 203),
	(4810, 1, 202),
	(4811, 1, 27),
	(4812, 1, 91),
	(4813, 1, 77),
	(4814, 1, 209),
	(4815, 1, 73),
	(4816, 1, 7),
	(4817, 1, 6),
	(4818, 1, 2),
	(4819, 1, 3),
	(4820, 1, 78),
	(4821, 1, 1),
	(4822, 1, 228),
	(4823, 1, 233),
	(4824, 1, 232),
	(4825, 1, 231),
	(4826, 1, 230),
	(4827, 1, 229),
	(4828, 1, 221),
	(4829, 1, -1);

-- Dumping structure for table novel_plus.sys_user
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE IF NOT EXISTS `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '用户名',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '密码',
  `dept_id` bigint DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '手机号',
  `status` tinyint DEFAULT NULL COMMENT '状态 0:禁用，1:正常',
  `user_id_create` bigint DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `sex` bigint DEFAULT NULL COMMENT '性别',
  `birth` datetime DEFAULT NULL COMMENT '出身日期',
  `pic_id` bigint DEFAULT NULL,
  `live_address` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '现居住地',
  `hobby` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '爱好',
  `province` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '省份',
  `city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '所在城市',
  `district` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '所在地区',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- Dumping data for table novel_plus.sys_user: ~2 rows (approximately)
DELETE FROM `sys_user`;
INSERT INTO `sys_user` (`user_id`, `username`, `name`, `password`, `dept_id`, `email`, `mobile`, `status`, `user_id_create`, `gmt_create`, `gmt_modified`, `sex`, `birth`, `pic_id`, `live_address`, `hobby`, `province`, `city`, `district`) VALUES
	(1, 'admin', '超级管理员', '27bd386e70f280e24c2f4f2a549b82cf', 14, 'admin@example.com', '17699999999', 1, 1, '2017-08-15 21:40:39', '2017-08-15 21:41:00', 96, '2017-12-14 00:00:00', 148, 'ccc', '122;121;', '北京市', '北京市市辖区', '东城区'),
	(2, 'test', '测试用户', 'd0af8fa1272ef5a152d9e27763eea293', 14, 'test@example.com', '17688888888', 1, 1, '2025-11-20 15:30:00', '2025-11-20 15:31:00', 96, '2025-12-31 00:00:00', 148, 'abc', '122;121;', '上海市', '上海市市辖区', '浦东新区');

-- Dumping structure for table novel_plus.sys_user_role
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE IF NOT EXISTS `sys_user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='用户与角色对应关系';

-- Dumping data for table novel_plus.sys_user_role: ~34 rows (approximately)
DELETE FROM `sys_user_role`;
INSERT INTO `sys_user_role` (`id`, `user_id`, `role_id`) VALUES
	(73, 30, 48),
	(74, 30, 49),
	(75, 30, 50),
	(76, 31, 48),
	(77, 31, 49),
	(78, 31, 52),
	(79, 32, 48),
	(80, 32, 49),
	(81, 32, 50),
	(82, 32, 51),
	(83, 32, 52),
	(84, 33, 38),
	(85, 33, 49),
	(86, 33, 52),
	(87, 34, 50),
	(88, 34, 51),
	(89, 34, 52),
	(106, 124, 1),
	(110, 1, 1),
	(111, 2, 1),
	(113, 131, 48),
	(117, 135, 1),
	(120, 134, 1),
	(121, 134, 48),
	(123, 130, 1),
	(124, NULL, 48),
	(125, 132, 52),
	(126, 132, 49),
	(127, 123, 48),
	(132, 36, 48),
	(133, 137, 61),
	(134, 137, 60),
	(135, 138, 61),
	(136, 138, 60);

-- Dumping structure for table novel_plus.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录密码',
  `nick_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '昵称',
  `user_photo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户头像',
  `user_sex` tinyint(1) DEFAULT NULL COMMENT '用户性别，0：男，1：女',
  `account_balance` bigint NOT NULL DEFAULT '0' COMMENT '账户余额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态，0：正常',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1997843516947996673 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table novel_plus.user: ~8 rows (approximately)
DELETE FROM `user`;
INSERT INTO `user` (`id`, `username`, `password`, `nick_name`, `user_photo`, `user_sex`, `account_balance`, `status`, `create_time`, `update_time`) VALUES
	(1255060328322027520, '13560421324', 'e10adc3949ba59abbe56e057f20f883e', '13560421324', NULL, NULL, 0, 0, '2020-04-28 17:04:35', '2020-04-28 17:04:35'),
	(1255379610071322624, '15924184378', '6a204bd89f3c8348afd5c77c717a097a', '15924184378', NULL, NULL, 0, 0, '2020-04-29 14:13:18', '2020-04-29 14:13:18'),
	(1255396367099031552, '13111111111', 'a4de053ee1e8ba473312b537bc360709', '13111111111', NULL, NULL, 0, 0, '2020-04-29 15:19:53', '2020-04-29 15:19:53'),
	(1255398795835895808, '13333333333', 'a4de053ee1e8ba473312b537bc360709', '13333333333', NULL, NULL, 0, 0, '2020-04-29 15:29:32', '2020-04-29 15:29:32'),
	(1255403074344747008, '13444444444', 'a4de053ee1e8ba473312b537bc360709', '13444444444', NULL, NULL, 0, 0, '2020-04-29 15:46:32', '2020-04-29 15:46:32'),
	(1255426058765852672, '13555555555', 'a4de053ee1e8ba473312b537bc360709', '13555555555', NULL, NULL, 0, 0, '2020-04-29 17:17:52', '2020-04-29 17:17:52'),
	(1255664783722586112, '13560421323', 'e10adc3949ba59abbe56e057f20f883e', '13560421323', NULL, NULL, 0, 0, '2020-04-30 09:06:28', '2020-04-30 09:06:28'),
	(1997843516947996672, '13456789076', '96e79218965eb72c92a549dd5a330112', '13456789076', NULL, NULL, 5100, 0, '2025-12-08 09:39:47', '2025-12-08 09:39:47');

-- Dumping structure for table novel_plus.user_bookshelf
DROP TABLE IF EXISTS `user_bookshelf`;
CREATE TABLE IF NOT EXISTS `user_bookshelf` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `book_id` bigint NOT NULL COMMENT '小说ID',
  `pre_content_id` bigint DEFAULT NULL COMMENT '上一次阅读的章节内容表ID',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_userid_bookid` (`user_id`,`book_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户书架表';

-- Dumping data for table novel_plus.user_bookshelf: ~5 rows (approximately)
DELETE FROM `user_bookshelf`;
INSERT INTO `user_bookshelf` (`id`, `user_id`, `book_id`, `pre_content_id`, `create_time`, `update_time`) VALUES
	(37, 1255060328322027520, 1254957312633352192, 3335449, '2020-04-30 07:27:23', '2020-04-30 19:37:36'),
	(38, 1255664783722586112, 1254674396451897344, 1254674396690972672, '2020-04-30 09:06:53', '2020-04-30 09:06:59'),
	(39, 1255060328322027520, 1254681071191785472, 1254681071552495616, '2020-04-30 09:37:47', NULL),
	(40, 1255060328322027520, 1254676970567565312, 3264258, '2020-04-30 09:57:18', '2020-04-30 19:19:11'),
	(41, 1255060328322027520, 1254675594315759616, 1254675594496114688, '2020-04-30 18:37:18', NULL);

-- Dumping structure for table novel_plus.user_buy_record
DROP TABLE IF EXISTS `user_buy_record`;
CREATE TABLE IF NOT EXISTS `user_buy_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `book_id` bigint DEFAULT NULL COMMENT '购买的小说ID',
  `book_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '购买的小说名',
  `book_index_id` bigint DEFAULT NULL COMMENT '购买的章节ID',
  `book_index_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '购买的章节名',
  `buy_amount` int DEFAULT NULL COMMENT '购买使用的屋币数量',
  `create_time` datetime DEFAULT NULL COMMENT '购买时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_userId_indexId` (`user_id`,`book_index_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户消费记录表';

-- Dumping data for table novel_plus.user_buy_record: ~2 rows (approximately)
DELETE FROM `user_buy_record`;
INSERT INTO `user_buy_record` (`id`, `user_id`, `book_id`, `book_name`, `book_index_id`, `book_index_name`, `buy_amount`, `create_time`) VALUES
	(1, 1255060328322027520, 1260400284744613890, '我是一只消消乐2', 1260522024606953472, '第三章', 10, '2020-05-13 21:29:09'),
	(2, 1255060328322027520, 1260400284744613890, '我是一只消消乐2', 1260564410687107072, '第四章', 10, '2020-05-13 21:40:38');

-- Dumping structure for table novel_plus.user_feedback
DROP TABLE IF EXISTS `user_feedback`;
CREATE TABLE IF NOT EXISTS `user_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '反馈内容',
  `create_time` datetime DEFAULT NULL COMMENT '反馈时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table novel_plus.user_feedback: ~1 rows (approximately)
DELETE FROM `user_feedback`;
INSERT INTO `user_feedback` (`id`, `user_id`, `content`, `create_time`) VALUES
	(8, 1255060328322027520, '好战，多点书', '2020-04-30 08:58:49');

-- Dumping structure for table novel_plus.user_read_history
DROP TABLE IF EXISTS `user_read_history`;
CREATE TABLE IF NOT EXISTS `user_read_history` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `book_id` bigint NOT NULL COMMENT '小说ID',
  `pre_content_id` bigint DEFAULT NULL COMMENT '上一次阅读的章节内容表ID',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uq_userid_bookid` (`user_id`,`book_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户阅读记录表';

-- Dumping data for table novel_plus.user_read_history: ~18 rows (approximately)
DELETE FROM `user_read_history`;
INSERT INTO `user_read_history` (`id`, `user_id`, `book_id`, `pre_content_id`, `create_time`, `update_time`) VALUES
	(49, 1255060328322027520, 1254944717113274368, 1254944717314600960, '2020-04-28 17:05:48', '2020-04-28 17:05:48'),
	(52, 1255060328322027520, 1254944968184311808, 1254944969023172608, '2020-04-28 17:12:31', '2020-04-28 17:12:31'),
	(53, 1255379610071322624, 1254682148440047616, 1254682148729454592, '2020-04-29 14:13:28', '2020-04-29 14:13:28'),
	(54, 1255379610071322624, 1254676970567565312, 1254676970794057728, '2020-04-29 14:17:36', '2020-04-29 14:17:36'),
	(60, 1255060328322027520, 1254677251162308608, 1254677251367829504, '2020-04-30 07:32:03', '2020-04-30 07:32:03'),
	(61, 1255060328322027520, 1254677887534694400, 1254677887790546944, '2020-04-30 07:36:03', '2020-04-30 07:36:03'),
	(64, 1255060328322027520, 1254678892443795456, 1254678893156827136, '2020-04-30 08:34:00', '2020-04-30 08:34:00'),
	(65, 1255664783722586112, 1254674396451897344, 1254674396690972672, '2020-04-30 09:06:59', '2020-04-30 09:06:59'),
	(66, 1255664783722586112, 1254945413401292800, 1254945551112876032, '2020-04-30 09:09:46', '2020-04-30 09:09:46'),
	(68, 1255664783722586112, 1254681071191785472, 1254681071552495616, '2020-04-30 09:14:31', '2020-04-30 09:14:31'),
	(75, 1255060328322027520, 1254677745226153984, 1254677746505416704, '2020-04-30 09:53:17', '2020-04-30 09:53:17'),
	(90, 1255060328322027520, 1254681753466634240, 1254681754687176704, '2020-04-30 10:47:47', '2020-04-30 10:47:47'),
	(91, 1255060328322027520, 1254943211274252288, 1254943211462995968, '2020-04-30 10:53:51', '2020-04-30 10:53:51'),
	(104, 1255060328322027520, 1254675826696978432, 3263201, '2020-04-30 18:53:02', '2020-04-30 18:53:02'),
	(111, 1255060328322027520, 1254957626056912896, 3336649, '2020-04-30 19:11:57', '2020-04-30 19:11:57'),
	(113, 1255060328322027520, 1254676970567565312, 3264258, '2020-04-30 19:19:11', '2020-04-30 19:19:11'),
	(117, 1255060328322027520, 1254946661743603712, 1254946914001629184, '2020-04-30 19:37:09', '2020-04-30 19:37:09'),
	(118, 1255060328322027520, 1254957312633352192, 3335449, '2020-04-30 19:37:36', '2020-04-30 19:37:36');

-- Dumping structure for table novel_plus.website_info
DROP TABLE IF EXISTS `website_info`;
CREATE TABLE IF NOT EXISTS `website_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '网站名',
  `domain` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '网站域名',
  `keyword` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'SEO关键词',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '网站描述',
  `qq` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '站长QQ',
  `logo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '网站logo图片（默认）',
  `logo_dark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '网站logo图片（深色）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user_id` bigint DEFAULT NULL COMMENT '创建人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user_id` bigint DEFAULT NULL COMMENT '更新人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='网站信息表';

-- Dumping data for table novel_plus.website_info: ~1 rows (approximately)
DELETE FROM `website_info`;
INSERT INTO `website_info` (`id`, `name`, `domain`, `keyword`, `description`, `qq`, `logo`, `logo_dark`, `create_time`, `create_user_id`, `update_time`, `update_user_id`) VALUES
	(1, '番笳小说', 'www.xxyopen.com', '番笳小说', '番笳小说', '1179705413', '/images/logo.png', '/images/logo.png', NULL, NULL, NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
