/*
 Navicat Premium Data Transfer

 Source Server         : 51boshao.com
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : b1

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 06/12/2024 14:36:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for character
-- ----------------------------
DROP TABLE IF EXISTS `character`;
CREATE TABLE `character`  (
  `guid` int(11) NOT NULL AUTO_INCREMENT COMMENT '全局唯一标识符',
  `account` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '帐户标识',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '名称',
  `hair` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发型',
  `job` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '职业',
  `sex` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别',
  `dir` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '方向',
  `level` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '等级',
  `exp` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '经验值',
  `money` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '金币',
  `map` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '地图名称',
  `position_x` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '坐标X',
  `position_y` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '坐标Y',
  `hp` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '生命值',
  `mp` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '魔法值',
  `selectd` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '当前是否是选择的角色',
  `deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标志(显示到恢复列表)',
  `createdate` timestamp(0) NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '创建日期',
  `Lastupdate` timestamp(0) NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '最后更新日期',
  `home_map` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '回城地图名称',
  `home_x` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回城坐标X',
  `home_y` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回城坐标Y',
  `master` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否有徒弟',
  `DearName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '别名(配偶)',
  `MasterDearName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '师傅名字',
  `CreditPoint` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '声望',
  `Storagekey` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '仓库密码',
  `RebirthLevel` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '转生等级',
  `locklogon` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否锁定登录',
  `gamegold` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '元宝',
  `gamepoint` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点卷',
  `GameDiaMond` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '金刚石',
  `GameGird` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '灵符',
  `GameGlory` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '荣誉',
  `Loyal` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '英雄的忠诚度',
  `Contribution` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '贡献值',
  `PayMentPoint` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '充值点',
  `HungerStatus` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '饥饿状态(主体)',
  `PKPoint` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'PK点数',
  `AllowGroup` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否允许组队',
  `attackmode` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '攻击模式',
  `IncHealth` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '增加健康数',
  `IncSpell` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '增加攻击点',
  `IncHealing` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '增加治愈点',
  `FightZoneDie` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '行会占争地图中死亡次数',
  `AllowGuildRecall` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否允许行会合一',
  `AllowGroupRecall` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否允许天地合一',
  `KillMonExpRate` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '杀怪经验倍率',
  `KillMonExpRateTime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '杀怪经验时间',
  `HeroName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '英雄名称',
  `HeroMasterName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '英雄主人名称',
  `GroupRcallTime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '队传送时间',
  `BodyLuck` double NOT NULL DEFAULT 0 COMMENT '幸运',
  `HideFashion` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否隐藏时装',
  `JLZExp` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚灵珠累计经验',
  `JLZTick` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚灵珠聚集时间',
  `LastOutStatus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '退出状态 1为死亡退出',
  `MarryCount` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '结婚次数',
  `MasterCount` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '出师徒弟数',
  `HasHero` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否有白日门英雄',
  `HasHeroTwo` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否有卧龙英雄',
  `HeroType` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '英雄类型 0-白日门英雄 1-卧龙英雄',
  `HeroStatus` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '英雄的状态',
  `UnKnow` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '杂项',
  `UnKnow2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '杂项',
  `UnKnow3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '杂项',
  `QuestFlag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '任务标志位',
  `StatusTime` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '中毒等状态时间',
  `varUIntVar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'U变量',
  `varJIntVar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'J变量',
  `varTStrVar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'T变量',
  `varJUpdateDate` timestamp(0) NOT NULL DEFAULT '1970-01-02 00:00:00' COMMENT '脚本变量J更新日期',
  `Skill` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '技能',
  `NGSkill` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '内功技能',
  `BoBo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '宠物',
  `Title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '称号',
  `varInts` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'ints变量',
  `varHInts` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '英雄ints变量',
  `MaxBagItemSlot` int(10) UNSIGNED NOT NULL DEFAULT 48 COMMENT '背包最大格子数',
  `accgold` int(11) NOT NULL DEFAULT 0 COMMENT '帐号金币',
  `accgoldadd` int(11) NOT NULL DEFAULT 0 COMMENT '帐号金币充值',
  `Task` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '任务',
  `QuestUnitOpen` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '任务状态',
  `QuestUnit` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '任务状态',
  `serverid` int(11) NULL DEFAULT NULL COMMENT '服务区',
  `BonusAbil` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '永久属性',
  PRIMARY KEY (`guid`, `name`) USING BTREE,
  UNIQUE INDEX `idx_name`(`name`) USING BTREE,
  INDEX `idx_account`(`account`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
