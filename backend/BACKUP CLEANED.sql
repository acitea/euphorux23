-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: REDACTED    Database: EUPHORUX
-- ------------------------------------------------------
-- Server version	8.0.26-google

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

--
-- Table structure for table `BINGOCARDS`
--

DROP TABLE IF EXISTS `BINGOCARDS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BINGOCARDS` (
  `clanName` varchar(45) NOT NULL,
  `teamName` varchar(12) NOT NULL,
  `combination` char(38) NOT NULL,
  `completed` varchar(38) DEFAULT NULL,
  `swapped` tinyint DEFAULT '1',
  `removed` tinyint DEFAULT '1',
  `points` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`teamName`),
  KEY `bingoCarcclaneamName_idx` (`clanName`,`teamName`),
  CONSTRAINT `bingoCarcclaneamName` FOREIGN KEY (`clanName`, `teamName`) REFERENCES `TEAMS` (`clanName`, `teamName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BINGOCARDS`
--

LOCK TABLES `BINGOCARDS` WRITE;
/*!40000 ALTER TABLE `BINGOCARDS` DISABLE KEYS */;
INSERT INTO `BINGOCARDS` VALUES ('Trailblazers','Blazer 1','12,10,14,11,7,2,0,15,9,3,4,13,8,5,1,6','11,9,12,8,4,10,2,15,14,0,7,3,13',1,1,15),('Trailblazers','Blazer 2','9,7,15,5,12,14,0,11,3,8,4,6,1,10,2,13','11,9,7,13,3,10,4,2,14,8,15,1,5,0,6,12',1,1,40),('Trailblazers','Blazer 3','9,12,13,0,7,11,1,5,15,8,14,3,10,6,4,2','11,9,4,3,0,12,15,8,1,5,13,14,6,7,10,2',1,1,40),('Trailblazers','Blazer 4','7,15,12,5,2,1,10,8,11,0,4,14,13,3,6,9','11,9,14,12,4,15,13,1,5,5,3,6,0',1,1,9),('Daredevils','Darer 10','3,9,0,13,7,1,2,14,4,10,11,15,6,8,5,12','9,11,12,7,13,1,4,3,14,15,0',1,1,9),('Daredevils','Darer 8','14,11,0,8,6,3,1,10,2,13,4,12,5,7,15,9','11,9,0,13,14,15,10,2,4,3,12,5,7,6,8,1',1,1,40),('Daredevils','Darer 9','15,8,14,5,2,11,4,13,12,0,3,6,10,1,9,7','11,9,4,13',1,1,0),('Wanderlusts','Wander 5','3,15,13,1,8,11,10,2,0,12,14,7,6,4,5,9','11,9,12,4,6,1,15,14,10,2',1,1,6),('Wanderlusts','Wander 6','14,11,0,15,10,3,8,13,5,1,6,2,4,9,12,7','11,9,14,2,10,3,4,7,13,12,15,6,5,8,1,0',1,1,40),('Wanderlusts','Wander 7','11,12,0,4,5,9,3,15,7,10,13,1,8,2,6,14','9,11,12,4,2,8,10,15,1',1,0,3);
/*!40000 ALTER TABLE `BINGOCARDS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTotalTeamPointsOnBingoUpdate` AFTER UPDATE ON `BINGOCARDS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.teamName = NEW.teamName);
	UPDATE TEAMS SET teamPoints = currentTeamPoints + NEW.points - OLD.points where TEAMS.teamName = NEW.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CLANS`
--

DROP TABLE IF EXISTS `CLANS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLANS` (
  `clanName` varchar(45) NOT NULL,
  `pointsTotal` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`clanName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLANS`
--

LOCK TABLES `CLANS` WRITE;
/*!40000 ALTER TABLE `CLANS` DISABLE KEYS */;
INSERT INTO `CLANS` VALUES ('Daredevils',173.1),('Trailblazers',298.79),('Wanderlusts',184.57);
/*!40000 ALTER TABLE `CLANS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KAYAKLOGS`
--

DROP TABLE IF EXISTS `KAYAKLOGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KAYAKLOGS` (
  `date` date NOT NULL,
  `time` time DEFAULT NULL,
  `timing` int NOT NULL,
  `clanName` varchar(45) NOT NULL,
  `teamName` varchar(12) NOT NULL,
  `points` tinyint NOT NULL,
  `clair` tinyint NOT NULL,
  `pos` tinyint NOT NULL,
  PRIMARY KEY (`teamName`),
  KEY `clanteamName_idx` (`clanName`,`teamName`),
  CONSTRAINT `kayakclanteamName` FOREIGN KEY (`clanName`, `teamName`) REFERENCES `TEAMS` (`clanName`, `teamName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KAYAKLOGS`
--

LOCK TABLES `KAYAKLOGS` WRITE;
/*!40000 ALTER TABLE `KAYAKLOGS` DISABLE KEYS */;
INSERT INTO `KAYAKLOGS` VALUES ('2023-08-04','24:07:49',164,'Trailblazers','Blazer 1',2,0,10),('2023-08-04','14:00:42',112,'Trailblazers','Blazer 2',18,0,2),('2023-08-03','21:14:05',110,'Trailblazers','Blazer 3',20,0,1),('2023-08-04','10:59:01',154,'Trailblazers','Blazer 4',4,0,9),('2023-08-04','10:58:44',145,'Daredevils','Darer 10',10,0,6),('2023-08-04','16:31:55',114,'Daredevils','Darer 8',16,0,3),('2023-08-04','14:01:45',145,'Daredevils','Darer 9',11,1,7),('2023-08-04','24:07:19',153,'Wanderlusts','Wander 5',6,0,8),('2023-08-04','16:31:32',121,'Wanderlusts','Wander 6',14,0,4),('2023-08-03','21:14:46',123,'Wanderlusts','Wander 7',12,0,5);
/*!40000 ALTER TABLE `KAYAKLOGS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTeamPointsOnKayakInsert` AFTER INSERT ON `KAYAKLOGS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = NEW.clanName AND t.teamName = NEW.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints + NEW.points where t.clanName = NEW.clanName AND t.teamName = NEW.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTotalTeamPointsOnKayakUpdate` AFTER UPDATE ON `KAYAKLOGS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.teamName = NEW.teamName);
	UPDATE TEAMS SET teamPoints = currentTeamPoints + NEW.points - OLD.points where TEAMS.teamName = NEW.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTeamPointsOnKayakDelete` AFTER DELETE ON `KAYAKLOGS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = OLD.clanName AND t.teamName = OLD.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints - OLD.points where t.clanName = OLD.clanName AND t.teamName = OLD.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `MOVEMENTS`
--

DROP TABLE IF EXISTS `MOVEMENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MOVEMENTS` (
  `dateLeft` date DEFAULT NULL,
  `timeLeft` time DEFAULT NULL,
  `dateArr` date DEFAULT NULL,
  `timeArr` time DEFAULT NULL,
  `teamName` varchar(12) NOT NULL,
  `fromloc` varchar(8) NOT NULL,
  `toloc` varchar(8) DEFAULT NULL,
  `remarks` tinytext,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`teamName`,`fromloc`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MOVEMENTS`
--

LOCK TABLES `MOVEMENTS` WRITE;
/*!40000 ALTER TABLE `MOVEMENTS` DISABLE KEYS */;
INSERT INTO `MOVEMENTS` VALUES (NULL,NULL,NULL,NULL,'Blazer 1','kayaking',NULL,NULL,125),('2023-08-03','12:24:36','2023-08-03','12:26:28','Blazer 1','lunchD1','xseed','Stadium - Gate 18',100),('2023-08-03','09:56:09','2023-08-03','10:03:02','Blazer 1','report','trekking','→ SMU',88),('2023-08-03','11:23:06','2023-08-03','11:34:16','Blazer 1','trekking','lunchD1','Stadium',99),('2023-08-03','15:21:27','2023-08-03','15:50:18','Blazer 1','xseed','kayaking','Singapore Canoe Federation',104),('2023-08-03','15:43:11','2023-08-03','16:37:03','Blazer 2','biking','diving','SMU Admin Pool',116),(NULL,NULL,NULL,NULL,'Blazer 2','diving',NULL,NULL,128),('2023-08-03','12:48:02','2023-08-03','13:53:57','Blazer 2','lunchD1','biking','ECP→MBS',103),('2023-08-03','09:29:46','2023-08-03','09:31:58','Blazer 2','report','skating','CIS Plaza',83),('2023-08-03','12:02:05','2023-08-03','12:02:36','Blazer 2','skating','lunchD1','Connexion ',91),('2023-08-03','16:24:48','2023-08-03','17:15:06','Blazer 3','kayaking','trekking','→ Maxwell',114),('2023-08-03','13:27:48','2023-08-03','13:43:19','Blazer 3','lunchD1','kayaking','Singapore Canoe Federation',111),('2023-08-03','09:31:02','2023-08-03','10:38:48','Blazer 3','report','xseed','Stadium - Gate 18',81),(NULL,NULL,NULL,NULL,'Blazer 3','school',NULL,NULL,140),('2023-08-03','18:30:22','2023-08-03','18:30:25','Blazer 3','trekking','school','SMU',138),('2023-08-03','13:11:51','2023-08-03','13:27:33','Blazer 3','xseed','lunchD1','KWM',97),(NULL,NULL,NULL,NULL,'Blazer 4','biking',NULL,NULL,127),('2023-08-03','16:35:31','2023-08-03','13:41:41','Blazer 4','diving','biking','MBS→ECP',92),('2023-08-03','09:19:38','2023-08-03','09:39:50','Blazer 4','report','diving','SMU Admin Pool',85),('2023-08-03','15:49:58','2023-08-03','16:26:38','Blazer 4','skating','biking','MBS→ECP',113),('2023-08-03','13:46:05','2023-08-03','14:03:12','Darer 10','diving','skating','CIS Plaza',93),('2023-08-03','10:15:34','2023-08-03','10:15:38','Darer 10','report','diving','SMU Admin Pool',82),('2023-08-03','15:50:23',NULL,NULL,'Darer 10','skating','biking','MBS→ECP',121),('2023-08-03','13:16:47','2023-08-03','14:16:44','Darer 8','biking','lunchD1','Cityhall',98),('2023-08-03','16:27:01','2023-08-03','17:14:52','Darer 8','diving','skating','→ Maxwell',124),('2023-08-03','15:02:13','2023-08-03','15:02:18','Darer 8','LunchD1','diving','SMU Admin Pool',118),('2023-08-03','09:49:46','2023-08-03','10:59:29','Darer 8','report','biking','MBS→ECP',84),(NULL,NULL,NULL,NULL,'Darer 8','skating',NULL,NULL,135),('2023-08-03','15:46:57','2023-08-03','16:35:56','Darer 9','biking','diving','SMU Admin Pool',117),('2023-08-04','08:42:00',NULL,NULL,'Darer 9','diving','xseed','Stadium - Gate 18',129),('2023-08-03','12:27:32','2023-08-03','14:00:26','Darer 9','lunchD1','biking','ECP→MBS',105),('2023-08-03','09:31:31','2023-08-03','09:31:34','Darer 9','report','skating','CIS Plaza',80),('2023-08-03','12:27:12','2023-08-03','12:27:18','Darer 9','skating','lunchD1','connex',90),('2023-08-03','16:58:54','2023-08-03','17:47:22','Wander 5','kayaking','trekking','→ Maxwell',115),('2023-08-03','13:37:08','2023-08-03','13:49:07','Wander 5','lunchD1','kayaking','Singapore Canoe Federation',109),('2023-08-03','09:33:25','2023-08-03','10:50:23','Wander 5','report','xseed','Stadium - Gate 18',87),(NULL,NULL,NULL,NULL,'Wander 5','trekking',NULL,NULL,139),('2023-08-03','12:28:20','2023-08-03','12:47:01','Wander 5','xseed','lunchD1','Kallang Wave Mall Food Court',101),('2023-08-03','12:39:36','2023-08-03','12:46:36','Wander 6','biking','lunchD1','ECP ',94),('2023-08-03','16:48:47',NULL,NULL,'Wander 6','diving','skating','CIS Plaza',122),('2023-08-03','14:10:14','2023-08-03','14:58:45','Wander 6','lunchD1','diving','SMU Admin Pool',108),('2023-08-03','07:47:03','2023-08-03','12:39:11','Wander 6','report','biking','MBS→ECP',86),(NULL,NULL,NULL,NULL,'Wander 7','kayaking',NULL,NULL,126),('2023-08-03','12:14:38','2023-08-03','13:28:48','Wander 7','lunchD1','xseed','Stadium - Gate 18',102),('2023-08-03','09:55:06','2023-08-03','10:00:10','Wander 7','report','trekking','→ Maxwell',89),('2023-08-03','12:00:21','2023-08-03','12:00:52','Wander 7','trekking','lunchD1','GSR 3-6',96),('2023-08-03','14:59:36','2023-08-03','15:56:46','Wander 7','xseed','kayaking','Singapore Canoe Federation',112);
/*!40000 ALTER TABLE `MOVEMENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PARTICIPANTS`
--

DROP TABLE IF EXISTS `PARTICIPANTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PARTICIPANTS` (
  `matricId` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `role` varchar(4) NOT NULL,
  `contact` varchar(45) DEFAULT NULL,
  `clanName` varchar(12) DEFAULT 'NONE',
  `teamName` varchar(12) DEFAULT 'NONE',
  `attendMRD1` tinyint DEFAULT NULL,
  `attendMRD2` tinyint DEFAULT NULL,
  `attendR1D1` tinyint DEFAULT NULL,
  `attendR1D2` tinyint DEFAULT NULL,
  `attendR2D1` tinyint DEFAULT NULL,
  `attendR2D2` tinyint DEFAULT NULL,
  `attendDEMO` tinyint DEFAULT NULL,
  PRIMARY KEY (`matricId`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PARTICIPANTS`
--

LOCK TABLES `PARTICIPANTS` WRITE;
/*!40000 ALTER TABLE `PARTICIPANTS` DISABLE KEYS */;
INSERT INTO `PARTICIPANTS` VALUES (23, 'Amanda' , 'ppnt' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 4' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(80, 'Yas' , 'faci' , '@USERREDACTED' , 'Wanderlusts' , 'Wander 7' , 1 , 0 , NULL , NULL , 1 , 1 , NULL),(232, 'Joey' , 'faci' , '@USERREDACTED' , 'Wanderlusts' , 'Wander 7' , 1 , 1 , NULL , NULL , NULL , 1 , NULL),(510, 'Danial' , 'faci' , '@USERREDACTED' , 'Daredevils' , 'Darer 9' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(1568, 'Ben' , 'ppnt' , '@USERREDACTED' , 'Daredevils' , 'Darer 10' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(1883, 'Jay' , 'faci' , '@USERREDACTED' , 'Daredevils' , 'Darer 10' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(1934, 'Gloria' , 'faci' , '@USERREDACTED' , 'Daredevils' , 'Darer 8' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(2638, 'Terry' , 'faci' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 2' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(3594, 'Olivia' , 'ppnt' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 4' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(3703, 'Shers' , 'faci' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 2' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(3716, 'Gabrielle' , 'faci' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 3' , 0 , 1 , NULL , NULL , 1 , 1 , 1),(3793, 'Alyss' , 'ppnt' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 1' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(3993, 'Natalie' , 'faci' , '@USERREDACTED' , 'Wanderlusts' , 'Wander 5' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(4269, 'Zen' , 'faci' , '@USERREDACTED' , 'Wanderlusts' , 'Wander 7' , 1 , 0 , NULL , NULL , NULL , NULL , NULL),(5694, 'Stefan' , 'ppnt' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 2' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(5794, 'Aiman' , 'faci' , '@USERREDACTED' , 'Daredevils' , 'Darer 10' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(5834, 'Daniel' , 'ppnt' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 3' , NULL , NULL , NULL , NULL , 0 , 0 , NULL),(6135, 'Cali' , 'faci' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 1' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(6789, 'Ray' , 'ppnt' , '@USERREDACTED' , 'Wanderlusts' , 'Wander 7' , NULL , NULL , NULL , NULL , NULL , NULL , NULL),(7150, 'Stephanie' , 'ppnt' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 1' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(7231, 'Darren' , 'ppnt' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 1' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(7381, 'Alice' , 'ppnt' , '@USERREDACTED' , 'Daredevils' , 'Darer 8' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(7623, 'Joy' , 'ppnt' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 3' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(7697, 'Sherry' , 'ppnt' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 2' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(7777, 'Victoria' , 'ppnt' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 3' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(8181, 'Jacky' , 'ppnt' , '@USERREDACTED' , 'Daredevils' , 'Darer 8' , NULL , NULL , NULL , NULL , 1 , 0 , NULL),(8282, 'Chloe' , 'faci' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 4' , 1 , NULL , NULL , NULL , 1 , 1 , NULL),(8421, 'Vanessa' , 'faci' , '@USERREDACTED' , 'Daredevils' , 'Darer 9' , 1 , 0 , NULL , NULL , 1 , 1 , NULL),(8494, 'Jessa' , 'faci' , '@USERREDACTED' , 'Wanderlusts' , 'Wander 6' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(8555, 'Jenna' , 'ppnt' , '@USERREDACTED' , 'Daredevils' , 'Darer 10' , NULL , NULL , NULL , NULL , 1 , 0 , NULL),(8668, 'Rachel' , 'faci' , '@USERREDACTED' , 'Wanderlusts' , 'Wander 5' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(8761, 'Isaac' , 'faci' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 4' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(8888, 'Hann' , 'faci' , '@USERREDACTED' , 'Daredevils' , 'Darer 9' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(8922, 'Jun Jie' , 'faci' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 2' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(8999, 'A. Darryl' , 'orgc' , '@USERREDACTED' , 'ORGC' , 'ORG COMM' , NULL , NULL , NULL , NULL , NULL , NULL , NULL),(9132, 'Becks' , 'faci' , '@USERREDACTED' , 'Trailblazers' , 'Blazer 1' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(9669, 'Avinesh' , 'faci' , '@USERREDACTED' , 'Daredevils' , 'Darer 8' , 1 , 1 , NULL , NULL , 1 , 1 , NULL),(9759, 'Benedict' , 'ppnt' , '@USERREDACTED' , 'Wanderlusts' , 'Wander 5' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(10000, 'GM' , 'game' , '@USERREDACTED' , 'NONE' , 'NONE' , NULL , NULL , NULL , NULL , NULL , NULL , NULL),(31321, 'Bob' , 'ppnt' , '@USERREDACTED' , 'Wanderlusts' , 'Wander 7' , NULL , NULL , NULL , NULL , NULL , NULL , NULL),(110010, 'Clare' , 'ppnt' , '@USERREDACTED' , 'Daredevils' , 'Darer 10' , NULL , NULL , NULL , NULL , 1 , 1 , NULL),(111111, 'SUPER' , 'orgc' , '@USERREDACTED' , 'ORGC' , 'ORG COMM' , NULL , NULL , NULL , NULL , NULL , NULL , NULL);
/*!40000 ALTER TABLE `PARTICIPANTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SKATINGLOGS`
--

DROP TABLE IF EXISTS `SKATINGLOGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SKATINGLOGS` (
  `date` date NOT NULL,
  `time` time NOT NULL,
  `clanName` varchar(45) NOT NULL,
  `teamName` varchar(12) NOT NULL,
  `players` tinyint NOT NULL,
  `survivors` tinyint NOT NULL,
  `points` float NOT NULL,
  `skill` tinyint NOT NULL,
  PRIMARY KEY (`teamName`),
  KEY `skatingclanteamNamefk_idx` (`clanName`,`teamName`),
  CONSTRAINT `skatingclanteamNamefk` FOREIGN KEY (`clanName`, `teamName`) REFERENCES `TEAMS` (`clanName`, `teamName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SKATINGLOGS`
--

LOCK TABLES `SKATINGLOGS` WRITE;
/*!40000 ALTER TABLE `SKATINGLOGS` DISABLE KEYS */;
INSERT INTO `SKATINGLOGS` VALUES ('2023-08-04','11:04:23','Trailblazers','Blazer 1',9,4,8.89,0),('2023-08-03','11:26:56','Trailblazers','Blazer 2',8,2,5,0),('2023-08-04','18:05:20','Trailblazers','Blazer 3',9,4,8.89,0),('2023-08-03','16:23:12','Trailblazers','Blazer 4',8,4,10,0),('2023-08-03','16:24:05','Daredevils','Darer 10',7,1,2.85,0),('2023-08-03','21:39:25','Daredevils','Darer 8',8,6,15,0),('2023-08-03','11:24:11','Daredevils','Darer 9',8,1,2.5,0),('2023-08-04','18:04:03','Wanderlusts','Wander 5',8,4,10,0),('2023-08-03','20:03:51','Wanderlusts','Wander 6',9,5,14.11,1),('2023-08-04','11:04:39','Wanderlusts','Wander 7',9,4,8.89,0);
/*!40000 ALTER TABLE `SKATINGLOGS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTeamPointsOnSkatingInsert` AFTER INSERT ON `SKATINGLOGS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = NEW.clanName AND t.teamName = NEW.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints + NEW.points where t.clanName = NEW.clanName AND t.teamName = NEW.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTeamPointsOnSkatingDelete` AFTER DELETE ON `SKATINGLOGS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = OLD.clanName AND t.teamName = OLD.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints - OLD.points where t.clanName = OLD.clanName AND t.teamName = OLD.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `TEAMS`
--

DROP TABLE IF EXISTS `TEAMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEAMS` (
  `clanName` varchar(45) NOT NULL,
  `teamName` varchar(45) NOT NULL,
  `teamPoints` float NOT NULL DEFAULT '0',
  `abilities` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`clanName`,`teamName`),
  CONSTRAINT `teamsclanName` FOREIGN KEY (`clanName`) REFERENCES `CLANS` (`clanName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEAMS`
--

LOCK TABLES `TEAMS` WRITE;
/*!40000 ALTER TABLE `TEAMS` DISABLE KEYS */;
INSERT INTO `TEAMS` VALUES ('Daredevils','Darer 10',43.85,NULL),('Daredevils','Darer 8',105.44,NULL),('Daredevils','Darer 9',33.81,NULL),('Trailblazers','Blazer 1',59.39,NULL),('Trailblazers','Blazer 2',103.63,NULL),('Trailblazers','Blazer 3',99.64,NULL),('Trailblazers','Blazer 4',36.13,NULL),('Wanderlusts','Wander 5',38.19,NULL),('Wanderlusts','Wander 6',100.49,NULL),('Wanderlusts','Wander 7',45.89,NULL);
/*!40000 ALTER TABLE `TEAMS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTotalClanPointsOnTeamsUpdate` AFTER UPDATE ON `TEAMS` FOR EACH ROW BEGIN
	declare currentClanPoints float;
	set currentClanPoints = (select c.pointsTotal from CLANS c where c.clanName = NEW.clanName);
	UPDATE CLANS SET pointsTotal = currentClanPoints + NEW.teamPoints - OLD.teamPoints where CLANS.clanName = NEW.clanName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `TREKLOGS`
--

DROP TABLE IF EXISTS `TREKLOGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TREKLOGS` (
  `date` date NOT NULL,
  `time` time NOT NULL,
  `clanName` varchar(45) NOT NULL,
  `teamName` varchar(12) NOT NULL,
  `found` tinyint NOT NULL,
  `buffed` tinyint NOT NULL DEFAULT '0',
  `bruce` tinyint NOT NULL,
  `timing` int NOT NULL,
  `pos` tinyint NOT NULL,
  `points` float NOT NULL,
  PRIMARY KEY (`teamName`),
  KEY `clanteamName_idx` (`clanName`,`teamName`),
  CONSTRAINT `trekclanteamName` FOREIGN KEY (`clanName`, `teamName`) REFERENCES `TEAMS` (`clanName`, `teamName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TREKLOGS`
--

LOCK TABLES `TREKLOGS` WRITE;
/*!40000 ALTER TABLE `TREKLOGS` DISABLE KEYS */;
INSERT INTO `TREKLOGS` VALUES ('2023-08-03','12:07:08','Trailblazers','Blazer 1',6,0,0,60,2,13.5),('2023-08-04','17:02:11','Trailblazers','Blazer 2',8,0,5,54,1,20.63),('2023-08-04','10:55:33','Trailblazers','Blazer 3',8,5,5,72,7,10.75),('2023-08-04','14:54:15','Trailblazers','Blazer 4',6,0,5,77,9,3.13),('2023-08-04','14:58:21','Daredevils','Darer 10',8,0,0,83,10,2),('2023-08-04','10:31:03','Daredevils','Darer 8',8,0,5,68,4,14.44),('2023-08-04','17:31:39','Daredevils','Darer 9',8,0,5,70,6,10.31),('2023-08-04','24:32:29','Wanderlusts','Wander 5',8,0,5,75,8,6.19),('2023-08-04','10:20:51','Wanderlusts','Wander 6',8,0,5,70,5,12.38),('2023-08-03','13:41:39','Wanderlusts','Wander 7',6,0,0,60,3,12);
/*!40000 ALTER TABLE `TREKLOGS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTeamPointsOnTrekInsert` AFTER INSERT ON `TREKLOGS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = NEW.clanName AND t.teamName = NEW.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints + NEW.points where t.clanName = NEW.clanName AND t.teamName = NEW.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTotalTeamPointsOnTrekUpdate` AFTER UPDATE ON `TREKLOGS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.teamName = NEW.teamName);
	UPDATE TEAMS SET teamPoints = currentTeamPoints + NEW.points - OLD.points where TEAMS.teamName = NEW.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTeamPointsOnTrekDelete` AFTER DELETE ON `TREKLOGS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = OLD.clanName AND t.teamName = OLD.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints - OLD.points where t.clanName = OLD.clanName AND t.teamName = OLD.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `XSEEDLOGS`
--

DROP TABLE IF EXISTS `XSEEDLOGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `XSEEDLOGS` (
  `date` date NOT NULL,
  `time` time NOT NULL,
  `clanName` varchar(45) NOT NULL,
  `teamName` varchar(12) NOT NULL,
  `points` int NOT NULL,
  `won` tinyint NOT NULL,
  PRIMARY KEY (`teamName`),
  KEY `xseedclanteamNamefk_idx` (`clanName`,`teamName`),
  CONSTRAINT `xseedclanteamNamefk` FOREIGN KEY (`clanName`, `teamName`) REFERENCES `TEAMS` (`clanName`, `teamName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `XSEEDLOGS`
--

LOCK TABLES `XSEEDLOGS` WRITE;
/*!40000 ALTER TABLE `XSEEDLOGS` DISABLE KEYS */;
INSERT INTO `XSEEDLOGS` VALUES ('2023-08-03','14:43:51','Trailblazers','Blazer 1',20,1),('2023-08-04','14:00:18','Trailblazers','Blazer 2',20,1),('2023-08-03','12:29:19','Trailblazers','Blazer 3',20,1),('2023-08-04','17:03:07','Trailblazers','Blazer 4',10,0),('2023-08-04','17:03:07','Daredevils','Darer 10',20,1),('2023-08-04','13:59:58','Daredevils','Darer 8',10,0),('2023-08-04','14:00:18','Daredevils','Darer 9',10,0),('2023-08-03','12:29:19','Wanderlusts','Wander 5',10,0),('2023-08-04','13:59:58','Wanderlusts','Wander 6',20,1),('2023-08-03','14:43:51','Wanderlusts','Wander 7',10,0);
/*!40000 ALTER TABLE `XSEEDLOGS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTeamPointsOnXseedInsert` AFTER INSERT ON `XSEEDLOGS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = NEW.clanName AND t.teamName = NEW.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints + NEW.points where t.clanName = NEW.clanName AND t.teamName = NEW.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`CURRENT_USER`@`%`*/ /*!50003 TRIGGER `updateTeamPointsOnXseedDelete` AFTER DELETE ON `XSEEDLOGS` FOR EACH ROW BEGIN
	declare currentTeamPoints float;
	set currentTeamPoints = (select t.teamPoints from TEAMS t where t.clanName = OLD.clanName AND t.teamName = OLD.teamName);
	UPDATE TEAMS t SET teamPoints = currentTeamPoints - OLD.points where t.clanName = OLD.clanName AND t.teamName = OLD.teamName;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-09 18:23:15
