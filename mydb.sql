-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dept`
--

DROP TABLE IF EXISTS `dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dept` (
  `deptno` int NOT NULL,
  `dname` varchar(100) DEFAULT NULL,
  `loc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept`
--

LOCK TABLES `dept` WRITE;
/*!40000 ALTER TABLE `dept` DISABLE KEYS */;
INSERT INTO `dept` VALUES (10,'총무부','101'),(20,'영업부','202'),(30,'전산실','303'),(40,'관리부','404'),(50,'경리부','505');
/*!40000 ALTER TABLE `dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gogek`
--

DROP TABLE IF EXISTS `gogek`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gogek` (
  `gobun` int NOT NULL,
  `goname` varchar(30) DEFAULT NULL,
  `goaddr` varchar(30) DEFAULT NULL,
  `gojumin` varchar(14) DEFAULT NULL,
  `godam` int DEFAULT NULL,
  PRIMARY KEY (`gobun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gogek`
--

LOCK TABLES `gogek` WRITE;
/*!40000 ALTER TABLE `gogek` DISABLE KEYS */;
INSERT INTO `gogek` VALUES (1,'류민','서울 강남구','660215-1325467',3),(2,'강철','대전 유성구','760815-1325467',4),(3,'영희','부산 강서구','791015-2325467',10),(4,'순이','인천 계양구','911105-2325467',10),(5,'마징가','서울 동작구','860212-1325467',1),(6,'짱가','서울 강북구','801215-1325467',10),(7,'아톰','경기도 안양시','770225-1325467',19),(8,'스머프','서울 강남구','850205-1325467',8),(9,'투덜이','서울 강서구','880215-1325467',7),(10,'슛돌이','서울  강북구','911115-1325467',6),(11,'몰리','대전 유성구','920815-1325467',15),(12,'가민','서울 영등포구','930214-1325467',4),(13,'짜장','서울 강남구','960310-1325467',3),(14,'짬뽕','서울 강북구','950205-1325467',2),(15,'만두','서울 강서구','981215-1325467',1);
/*!40000 ALTER TABLE `gogek` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `mem_idx` int NOT NULL AUTO_INCREMENT,
  `mem_name` varchar(100) NOT NULL,
  `mem_id` varchar(100) NOT NULL,
  `mem_pwd` varchar(100) NOT NULL,
  `mem_zipcode` char(5) NOT NULL,
  `mem_addr` varchar(1000) NOT NULL,
  `mem_ip` varchar(100) NOT NULL,
  `mem_regdate` datetime DEFAULT CURRENT_TIMESTAMP,
  `mem_grade` varchar(100) DEFAULT '일반',
  PRIMARY KEY (`mem_idx`),
  UNIQUE KEY `unique_member_id` (`mem_id`),
  CONSTRAINT `ck_member_grade` CHECK ((`mem_grade` in (_utf8mb4'일반',_utf8mb4'관리자')))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'김관리','admin','admin','00000','서울시 관악구','127.0.0.1','2024-08-19 09:32:53','관리자'),(2,'일길동','one','1234','00000','서울시 관악구','127.0.0.1','2024-08-19 09:32:56','일반');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo` (
  `p_idx` int NOT NULL AUTO_INCREMENT,
  `p_title` varchar(200) NOT NULL,
  `p_content` varchar(2000) NOT NULL,
  `p_filename` varchar(200) NOT NULL,
  `p_ip` varchar(100) NOT NULL,
  `p_regdate` datetime DEFAULT NULL,
  `mem_idx` int DEFAULT NULL,
  `mem_name` varchar(100) NOT NULL,
  PRIMARY KEY (`p_idx`),
  KEY `fk_photo_mem_idx` (`mem_idx`),
  CONSTRAINT `fk_photo_mem_idx` FOREIGN KEY (`mem_idx`) REFERENCES `member` (`mem_idx`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` VALUES (1,'1','1','연예1.jpeg','0:0:0:0:0:0:0:1','2024-08-20 09:45:55',1,'김관리'),(2,'2','2','연예3.jpg','0:0:0:0:0:0:0:1','2024-08-20 09:46:00',1,'김관리'),(3,'3','3','연예4.jpg','0:0:0:0:0:0:0:1','2024-08-20 09:46:06',1,'김관리'),(5,'5151','51515','스포츠2.jpg','0:0:0:0:0:0:0:1','2024-08-20 09:47:20',1,'김관리');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sawon`
--

DROP TABLE IF EXISTS `sawon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sawon` (
  `sabun` int NOT NULL,
  `saname` varchar(30) DEFAULT NULL,
  `sasex` varchar(10) DEFAULT NULL,
  `deptno` int DEFAULT NULL,
  `sajob` varchar(10) DEFAULT NULL,
  `sahire` datetime DEFAULT NULL,
  `samgr` int DEFAULT NULL,
  `sapay` int DEFAULT NULL,
  PRIMARY KEY (`sabun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sawon`
--

LOCK TABLES `sawon` WRITE;
/*!40000 ALTER TABLE `sawon` DISABLE KEYS */;
INSERT INTO `sawon` VALUES (1,'장동건','남자',40,'부장','1993-07-25 00:00:00',NULL,4000),(2,'안재욱','남자',20,'부장','1988-02-25 00:00:00',NULL,4000),(3,'이미자','여자',20,'대리','1998-03-25 00:00:00',2,3500),(4,'황신혜','여자',10,'과장','1993-05-25 00:00:00',7,3800),(5,'영덕스','남자',10,'사원','2000-07-11 00:00:00',14,2200),(6,'김민종','남자',20,'사원','2002-03-15 00:00:00',3,2400),(7,'최불암','남자',10,'부장','1984-07-25 00:00:00',NULL,4000),(8,'맥라이언','여자',30,'과장','2004-05-25 00:00:00',19,3900),(9,'최민수','남자',10,'사원','2005-04-25 00:00:00',4,2000),(10,'배용준','남자',30,'알바','2005-05-25 00:00:00',17,500),(11,'김용만','남자',40,'과장','1993-08-25 00:00:00',1,3000),(12,'안성기','남자',20,'부장','1994-05-25 00:00:00',NULL,4000),(13,'배슬기','여자',20,'대리','1997-11-25 00:00:00',12,3200),(14,'전도현','여자',10,'과장','1997-05-25 00:00:00',7,3800),(15,'데미무어','여자',30,'대리','2000-12-25 00:00:00',8,3000),(16,'감우성','남자',10,'대리','1998-05-25 00:00:00',4,3300),(17,'이미연','여자',30,'사원','2003-06-25 00:00:00',15,2000),(18,'이소라','여자',20,'사원','2003-05-25 00:00:00',13,2400),(19,'최명길','여자',30,'부장','1988-08-25 00:00:00',NULL,4500),(20,'차범근','남자',20,'사원','2005-01-25 00:00:00',13,2200);
/*!40000 ALTER TABLE `sawon` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-20 10:40:39
