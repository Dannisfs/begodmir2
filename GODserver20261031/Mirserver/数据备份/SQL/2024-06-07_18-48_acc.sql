-- MySQL dump 10.13  Distrib 5.5.38, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: acc
-- ------------------------------------------------------
-- Server version	5.7.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '帐号标识符(唯一)',
  `username` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '名称',
  `gmlevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员等级',
  `password` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '密码',
  `channel` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '渠道',
  `accgold` int(11) NOT NULL DEFAULT '0' COMMENT '帐号金币',
  `accgoldadd` int(11) NOT NULL DEFAULT '0' COMMENT '帐号金币充值',
  `email` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '邮箱',
  `last_ip` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '0.0.0.0' COMMENT '登录IP',
  `joindate` timestamp NOT NULL DEFAULT '1970-01-01 16:00:00' COMMENT '创建日期',
  `last_login` timestamp NOT NULL DEFAULT '1970-01-01 16:00:00' COMMENT '离线日期',
  `locked` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `cardname` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `cardid` varchar(18) COLLATE utf8mb4_bin NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_bin DEFAULT NULL,
  `quiz1` varchar(18) COLLATE utf8mb4_bin DEFAULT NULL,
  `answer1` varchar(18) COLLATE utf8mb4_bin NOT NULL,
  `quiz2` varchar(18) COLLATE utf8mb4_bin NOT NULL,
  `answer2` varchar(18) COLLATE utf8mb4_bin NOT NULL,
  `birthday` varchar(18) COLLATE utf8mb4_bin NOT NULL,
  `mobilephone` varchar(18) COLLATE utf8mb4_bin NOT NULL,
  `error_count` int(11) unsigned NOT NULL DEFAULT '0',
  `action_tick` bigint(20) unsigned NOT NULL DEFAULT '0',
  `SecCode` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '安全码',
  PRIMARY KEY (`id`,`username`) USING BTREE,
  KEY `idx_account` (`username`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'qq9851320',0,'123456',1000,0,0,'','','2023-06-16 16:10:13','2023-06-16 18:38:15',0,'qq9851320','','','1','1','1','1','1980/10/10','',0,0,'888888'),(2,'qcymwcom',0,'123456',1000,0,0,'','','2023-06-18 03:27:12','2023-06-18 03:27:16',0,'qcymwcom','','','1','1','1','1','1980/10/10','',0,0,'123456'),(3,'90175com',0,'123456',1000,0,0,'','','2023-06-18 03:35:14','2023-06-18 03:35:15',0,'90175com','','','1','1','1','1','1980/10/10','',0,0,'123456'),(4,'boshao',0,'123456',1000,0,0,'','','2023-06-20 01:54:06','2023-06-27 03:16:49',0,'boshao','','','1','1','1','1','1980/10/10','',0,0,'12345678'),(5,'qq3180155362',0,'3180155362',1000,0,0,'','','2023-06-27 03:19:28','2023-06-27 03:19:56',0,'qq3180155362','','','1','1','1','1','1980/10/10','',0,0,'3180155362'),(6,'111',0,'222',1000,0,0,'','','2024-05-05 04:10:29','2024-05-25 12:27:39',0,'111','','','1','1','1','1','1980/10/10','',0,0,'11'),(7,'11111',0,'111111',1000,0,0,'','','2024-05-09 16:39:24','2024-05-09 16:39:24',0,'11111','','','1','1','1','1','1980/10/10','',0,0,'12323'),(8,'12123',0,'1111',1000,0,0,'','','2024-05-09 16:57:23','2024-05-10 08:52:17',0,'12123','','','1','1','1','1','1980/10/10','',0,0,'123213'),(9,'123123',0,'1111',1000,0,0,'','','2024-05-10 08:53:19','2024-05-10 08:53:21',0,'123123','','','1','1','1','1','1980/10/10','',0,0,'1111'),(10,'111112',0,'1122',1000,0,0,'','','2024-05-10 14:23:26','2024-05-20 16:25:00',0,'111112','','','1','1','1','1','1980/10/10','',0,0,'12121'),(11,'13222',0,'1111',1000,0,0,'','','2024-05-10 15:12:59','2024-05-10 15:12:59',0,'13222','','','1','1','1','1','1980/10/10','',0,0,'123123'),(12,'12121',0,'1111',1000,0,0,'','','2024-05-10 15:40:07','2024-05-10 15:40:10',0,'12121','','','1','1','1','1','1980/10/10','',0,0,'121212'),(13,'222',0,'333',1000,0,0,'','','2024-05-20 16:18:07','2024-06-05 17:56:45',0,'222','','','1','1','1','1','1980/10/10','',0,0,'123缂?\0');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-07 18:48:25
