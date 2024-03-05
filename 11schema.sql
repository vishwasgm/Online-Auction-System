CREATE DATABASE  IF NOT EXISTS `buyme` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `buyme`;
-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: localhost    Database: buyme
-- ------------------------------------------------------
-- Server version	8.0.32

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

--
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admin` (
  `userId` int NOT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES (4);
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AutoBid`
--

DROP TABLE IF EXISTS `AutoBid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AutoBid` (
  `auto_bid_id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `itemId` varchar(255) NOT NULL,
  `auto_bid_increment` double NOT NULL,
  `upper_limit` double NOT NULL,
  PRIMARY KEY (`auto_bid_id`),
  KEY `userId` (`userId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `autobid_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `autobid_ibfk_4` FOREIGN KEY (`itemId`) REFERENCES `Item` (`itemId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AutoBid`
--

LOCK TABLES `AutoBid` WRITE;
/*!40000 ALTER TABLE `AutoBid` DISABLE KEYS */;
INSERT INTO `AutoBid` VALUES (7,1,'LPT007',50,1200),(9,8,'LPT007',50,2000),(10,11,'LPT007',50,3000),(18,1,'SAMS-TABLET168296675822611',50,800),(19,7,'SAMS-TABLET168296675822611',50,900),(20,7,'DELL-LAPTOP16829865592277',50,3500),(21,1,'DELL-LAPTOP16829865592277',50,4000),(22,1,'TBL007',30,850);
/*!40000 ALTER TABLE `AutoBid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bid`
--

DROP TABLE IF EXISTS `Bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bid` (
  `bid_id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `itemId` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `time` timestamp NOT NULL,
  `status` enum('active','closed') NOT NULL,
  `winning_bid` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`bid_id`),
  KEY `userId` (`userId`),
  KEY `itemId` (`itemId`),
  CONSTRAINT `bid_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `EndUser` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `bid_ibfk_4` FOREIGN KEY (`itemId`) REFERENCES `Item` (`itemId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=335 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bid`
--

LOCK TABLES `Bid` WRITE;
/*!40000 ALTER TABLE `Bid` DISABLE KEYS */;
INSERT INTO `Bid` VALUES (220,1,'1682725827laptop8557',1599,'2023-04-28 23:52:47','closed',_binary '\0'),(221,1,'1682725827laptop8557',1699,'2023-04-28 23:53:08','closed',_binary ''),(224,1,'LPT007',1050,'2023-04-28 23:59:17','closed',_binary '\0'),(228,8,'1682778945smartphone11092',1039,'2023-04-29 14:36:15','closed',_binary '\0'),(229,1,'1682778945smartphone11092',999,'2023-04-29 14:36:35','closed',_binary '\0'),(230,8,'LPT007',1100,'2023-04-29 15:24:55','closed',_binary '\0'),(231,1,'LPT007',1150,'2023-04-29 15:24:55','closed',_binary '\0'),(233,8,'LPT007',1250,'2023-04-29 15:25:06','closed',_binary '\0'),(234,8,'LPT007',1300,'2023-04-29 15:25:19','active',_binary '\0'),(244,11,'LPT007',2000,'2023-05-01 06:18:20','closed',_binary '\0'),(245,11,'LPT007',2100,'2023-05-01 06:18:23','closed',_binary '\0'),(262,1,'SAMS-TABLET168296675822611',500,'2023-05-01 18:47:26','closed',_binary '\0'),(263,7,'SAMS-TABLET168296675822611',550,'2023-05-01 18:48:16','closed',_binary '\0'),(284,1,'SAMS-TABLET168296675822611',600,'2023-05-01 18:48:16','closed',_binary '\0'),(285,2,'SPH008',800,'2023-05-01 19:14:53','closed',_binary '\0'),(286,2,'SPH008',830,'2023-05-01 19:15:03','closed',_binary '\0'),(287,2,'SPH008',860,'2023-05-01 19:15:03','active',_binary '\0'),(288,11,'LPT007',2200,'2023-05-01 21:08:04','closed',_binary '\0'),(289,11,'LPT007',2250,'2023-05-01 21:08:04','closed',_binary '\0'),(290,11,'LPT007',2300,'2023-05-01 21:08:07','closed',_binary '\0'),(291,11,'LPT007',2350,'2023-05-01 21:08:07','closed',_binary '\0'),(292,11,'LPT007',2400,'2023-05-01 21:08:13','closed',_binary '\0'),(293,11,'LPT007',2450,'2023-05-01 21:08:13','active',_binary '\0'),(294,8,'SAMS-SMARTPHONE168297541111195',1099,'2023-05-01 21:10:31','closed',_binary '\0'),(295,8,'SAMS-SMARTPHONE168297541111195',1124,'2023-05-01 21:10:33','closed',_binary ''),(296,8,' APP-TABLET168297538011674',569,'2023-05-01 21:10:46','closed',_binary '\0'),(297,8,' APP-TABLET168297538011674',599,'2023-05-01 21:10:53','closed',_binary ''),(298,1,'LENO-LAPTOP16829754958957',840,'2023-05-01 21:12:06','closed',_binary ''),(299,1,'ONEP-TABLET16829769438953',720,'2023-05-01 21:36:07','closed',_binary ''),(300,1,'DELL-LAPTOP16829865592277',2100,'2023-05-02 00:16:20','closed',_binary '\0'),(301,3,'DELL-LAPTOP16829865592277',2150,'2023-05-02 00:17:07','closed',_binary '\0'),(302,3,'DELL-LAPTOP16829865592277',2200,'2023-05-02 00:17:23','closed',_binary '\0'),(303,3,'DELL-LAPTOP16829865592277',2250,'2023-05-02 00:18:41','closed',_binary '\0'),(304,2,'MSI -LAPTOP16829868963117',2600,'2023-05-02 00:21:56','closed',_binary '\0'),(305,1,'MSI -LAPTOP16829868963117',2700,'2023-05-02 00:22:09','closed',_binary '\0'),(306,3,'DELL-LAPTOP16829865592277',3000,'2023-05-02 00:23:20','closed',_binary '\0'),(307,7,'DELL-LAPTOP16829865592277',3050,'2023-05-02 00:24:22','closed',_binary '\0'),(308,7,'MSI -LAPTOP16829868963117',2900,'2023-05-02 00:24:49','closed',_binary ''),(309,2,'XIAO-TABLET16829870781495',500,'2023-05-02 00:24:56','closed',_binary '\0'),(310,3,'XIAO-TABLET16829870781495',510,'2023-05-02 00:25:13','closed',_binary '\0'),(311,2,'XIAO-TABLET16829870781495',520,'2023-05-02 00:25:16','closed',_binary '\0'),(312,3,'XIAO-TABLET16829870781495',530,'2023-05-02 00:25:20','closed',_binary '\0'),(313,2,'XIAO-TABLET16829870781495',540,'2023-05-02 00:25:24','closed',_binary '\0'),(314,3,'XIAO-TABLET16829870781495',550,'2023-05-02 00:25:27','closed',_binary '\0'),(315,7,'SPH007',1200,'2023-05-02 00:25:36','active',_binary '\0'),(316,2,'XIAO-TABLET16829870781495',660,'2023-05-02 00:25:39','closed',_binary '\0'),(317,7,'SPH009',1550,'2023-05-02 00:25:48','active',_binary '\0'),(318,2,'XIAO-TABLET16829870781495',670,'2023-05-02 00:26:12','closed',_binary '\0'),(319,1,'GOOG-SMARTPHONE16829873092159',700,'2023-05-02 00:28:57','closed',_binary '\0'),(320,3,'GOOG-SMARTPHONE16829873092159',800,'2023-05-02 00:29:12','closed',_binary '\0'),(321,1,'GOOG-SMARTPHONE16829873092159',900,'2023-05-02 00:29:17','closed',_binary '\0'),(322,3,'GOOG-SMARTPHONE16829873092159',1200,'2023-05-02 00:29:30','closed',_binary '\0'),(323,1,'GOOG-SMARTPHONE16829873092159',1300,'2023-05-02 00:29:34','closed',_binary ''),(324,1,'DELL-LAPTOP16829865592277',3200,'2023-05-02 00:30:22','closed',_binary '\0'),(325,7,'DELL-LAPTOP16829865592277',3250,'2023-05-02 00:30:22','closed',_binary '\0'),(326,1,'DELL-LAPTOP16829865592277',3300,'2023-05-02 00:30:22','closed',_binary '\0'),(327,3,'XIAO-TABLET16829870781495',680,'2023-05-02 00:31:30','closed',_binary ''),(328,1,'SPH007',1250,'2023-05-02 00:34:28','active',_binary '\0'),(329,1,'SPH009',1600,'2023-05-02 00:34:51','active',_binary '\0'),(330,1,'TBL007',760,'2023-05-02 00:37:06','active',_binary '\0'),(331,11,'DELL-LAPTOP16829865592277',3350,'2023-05-02 00:48:27','closed',_binary '\0'),(332,7,'DELL-LAPTOP16829865592277',3400,'2023-05-02 00:48:27','closed',_binary '\0'),(333,1,'DELL-LAPTOP16829865592277',3450,'2023-05-02 00:48:27','closed',_binary ''),(334,11,'ACER-LAPTOP16829888311052',1199,'2023-05-02 00:54:12','active',_binary '\0');
/*!40000 ALTER TABLE `Bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerRep`
--

DROP TABLE IF EXISTS `CustomerRep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CustomerRep` (
  `userId` int NOT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `customerrep_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerRep`
--

LOCK TABLES `CustomerRep` WRITE;
/*!40000 ALTER TABLE `CustomerRep` DISABLE KEYS */;
INSERT INTO `CustomerRep` VALUES (5),(6),(27);
/*!40000 ALTER TABLE `CustomerRep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EndUser`
--

DROP TABLE IF EXISTS `EndUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EndUser` (
  `userId` int NOT NULL,
  `rating` float DEFAULT '0',
  `num_ratings` int DEFAULT '0',
  PRIMARY KEY (`userId`),
  CONSTRAINT `enduser_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `User` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EndUser`
--

LOCK TABLES `EndUser` WRITE;
/*!40000 ALTER TABLE `EndUser` DISABLE KEYS */;
INSERT INTO `EndUser` VALUES (1,2.75,4),(2,3.75,12),(3,3.66667,3),(7,0,0),(8,4,2),(11,5,1),(22,0,0);
/*!40000 ALTER TABLE `EndUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq`
--

DROP TABLE IF EXISTS `faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq` (
  `faq_id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `display_order` int NOT NULL,
  PRIMARY KEY (`faq_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faq`
--

LOCK TABLES `faq` WRITE;
/*!40000 ALTER TABLE `faq` DISABLE KEYS */;
INSERT INTO `faq` VALUES (10,'How do I create an account on BuyMe?','To create an account, click on the \"Create an Account\" button on the homepage and fill in the required information to complete your registration.',1),(11,'How do I post an item for auction?','After logging in, click on the \"Account\" on the navbar. You will see \"Create a listing\" form. Fill in the required item details, including title, description, initial price, bid increment, and closing time. Once submitted, your item will be listed for auction.',3),(12,'How do I place a bid on an item?','To place a bid, go to the item page and enter your bid amount in the provided field. You can also set a secret maximum bid to enable automatic bidding.',4),(13,'What is automatic bidding?','Automatic bidding allows you to set a secret maximum bid. When another user places a higher bid, the system will automatically increase your bid up to your maximum limit.',5),(14,'How do I delete my account?','To delete your account, please contact our customer support team, who will assist you with the account deletion process.',9),(15,'How do I search for items on BuyMe?','Use the search bar at the top of the homepage to enter your desired items keywords or category. You can also apply filters to refine your search results.',10),(16,'What happens if I win an auction?','If you win an auction, you are obligated to purchase the item at the winning bid price. You will receive instructions on how to complete the payment and receive your item.',13),(17,'How can I contact the seller of an item?','Once you have won an auction or made a purchase, you will receive the seller contact information in the confirmation email. You can also contact the seller through the item listing page by clicking the Contact Seller button.',2),(18,'Can I cancel a bid once it has been placed?','No, once a bid has been placed, it cannot be canceled. Please ensure you review and confirm your bid before submitting.',6),(19,'What payment methods are supported on BuyMe?','BuyMe supports various payment methods, including credit/debit cards, PayPal, and bank transfers. The available payment options for a specific item are provided by the seller on the item listing page.',7),(20,'How can I track my purchased items?','Once your payment has been confirmed, the seller will provide you with a tracking number for your item. You can use this tracking number on the shipping company website to track the delivery status of your item.',8),(21,'What should I do if I received a damaged item?','If you receive a damaged item, please contact the seller immediately to report the issue. If you are unable to resolve the issue with the seller, please contact our customer support team for assistance.',11);
/*!40000 ALTER TABLE `faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Item` (
  `userId` int NOT NULL,
  `itemId` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `subcategory` enum('laptop','smartphone','tablet') NOT NULL,
  `initialprice` double NOT NULL,
  `closingtime` timestamp NOT NULL,
  `bidincrement` double NOT NULL,
  `minprice` double NOT NULL,
  PRIMARY KEY (`itemId`),
  KEY `userId` (`userId`),
  CONSTRAINT `item_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `EndUser` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Item`
--

LOCK TABLES `Item` WRITE;
/*!40000 ALTER TABLE `Item` DISABLE KEYS */;
INSERT INTO `Item` VALUES (11,' APP-TABLET168297538011674',' Apple iPad Air M1 ','The Apple iPad Air is a versatile tablet that is perfect for both work and play. With a 10.9-inch Liquid Retina display and an A14 Bionic chip','tablet',549,'2023-05-01 21:12:00',10,549),(8,'1682725827laptop8557','Dell Latitude 5410','Super fast and elegant display with 512 GB SSD and 16 GB DDR5 RAM\r\nIntel i7 11th Generation\r\n4GB Nvidia REX Graphics','laptop',1499,'2023-04-28 23:57:00',50,1499),(11,'1682778945smartphone11092','Apple iPhone 14 Pro | 256 GB','Pro Motion Display, 2000 nits of screen brightness','smartphone',999,'2023-04-29 14:38:00',10,1099),(1,'ACER-LAPTOP16829888311052','Acer Predator Helios 300','The Acer Predator Helios 300 is a gaming laptop that delivers top-tier performance and graphics. With its 15.6-inch Full HD display and 10th Gen Intel Core i7 processor, this laptop is perfect for gamers who need speed and power. I','laptop',1199,'2023-05-09 00:53:00',30,1199),(1,'ASUS-LAPTOP16829881511836','ASUS ZenBook UX425','The ASUS ZenBook UX425 is a lightweight and powerful laptop that is perfect for both work and play. With its 14-inch Full HD display and 11th Gen Intel Core i7 processor, this laptop delivers impressive performance and battery life','laptop',799,'2023-05-16 00:42:00',30,849),(2,'DELL-LAPTOP16829865592277','Dell XPS 17 9720 Laptop','17 inch UHD+ Touchscreen Display, Intel Core i7-12700H, 16GB DDR5, 512GB SSD, NVIDIA GeForce RTX 3050, Killer Wi-Fi 6, Window 11 Pro, 1-Year Premium Support - Silver','laptop',2100,'2023-05-02 01:00:00',50,2500),(2,'GOOG-SMARTPHONE16829873092159','Google Pixel 7-5G','8 GB RAM  256 / 128 GB storage, 50 MP wide - 12 MP ultrawide[13] - 10.8 MP front camera, 6.3\" FHD+ Smooth Display[4] - up to 90Hz','smartphone',700,'2023-05-02 00:33:00',100,750),(1,'item1','Dell XPS 13','13-inch Dell XPS 13 with 16GB RAM and 512GB SSD storage','laptop',1200,'2023-04-20 16:00:00',10,1100),(2,'item2','Google Pixel 6','Google Pixel 6 128GB with 8GB RAM, unlocked','smartphone',800,'2023-04-22 19:00:00',5,750),(3,'item3','Samsung Galaxy Tab S8','12.4-inch Samsung Galaxy Tab S8 with 256GB storage and Wi-Fi','tablet',1100,'2023-04-25 22:00:00',15,1000),(8,'LENO-LAPTOP16829754958957','Lenovo ThinkPad X1 Carbon','14-inch display and 10th Gen Intel Core i7 processor, this laptop is perfect for professionals who need to stay productive on-the-go.','laptop',800,'2023-05-01 21:14:00',20,800),(8,'LPT003','Dell XPS 13','13.3-inch, Intel Core i7, 256GB SSD','laptop',1300,'2023-04-14 20:00:00',50,1300),(2,'LPT004','Lenovo ThinkPad X1 Carbon','14-inch, Intel Core i7, 512GB SSD, 16GB RAM','laptop',1400,'2023-04-10 19:00:00',50,1400),(7,'LPT005','Asus ZenBook 14','14-inch, AMD Ryzen 7, 512GB SSD, 16GB RAM','laptop',1100,'2023-04-09 22:00:00',50,1100),(2,'LPT007','HP Pavilion x360','14-inch, Intel Core i5, 256GB SSD, 8GB RAM','laptop',900,'2023-05-03 14:00:00',50,900),(2,'LPT009','Dell Inspiron 15 5000','15.6-inch, Intel Core i5, 512GB SSD, 8GB RAM','laptop',1000,'2023-05-09 14:00:00',50,1000),(3,'LPT011','Lenovo IdeaPad 5 Pro','16-inch, AMD Ryzen 7, 512GB SSD, 16GB RAM','laptop',1100,'2023-04-27 14:45:29',50,1100),(7,'LPT012','Acer Nitro 5','15.6-inch, Intel Core i5, 512GB SSD, 8GB RAM','laptop',800,'2023-04-28 14:45:29',50,800),(3,'MSI -LAPTOP16829868963117','MSI Creator Z16 Professional Laptop','16\" QHD+ 16:10 120Hz Touch Display, Intel Core i9-11900H, NVIDIA GeForce RTX 3060, 32GB RAM, 2TB NVME SSD, Thunderbolt 4, Win10 PRO, Lunar Gray (A11UET-043)','laptop',2600,'2023-05-02 00:25:00',100,2700),(8,'ONEP-TABLET16829769438953','Oneplus Pad','\r\n7:5 144 Hz Display\r\n\r\nData Sharing to 5G\r\n\r\n1-Month Standby Life\r\n\r\n67W SUPERVOOC','tablet',700,'2023-05-01 21:37:00',10,700),(11,'SAMS-SMARTPHONE168297541111195','Samsung Galaxy S21 Special Edition',' The Samsung Galaxy S21 is a flagship smartphone that offers a stunning 6.2-inch Dynamic AMOLED display and a triple-camera system that can capture incredible photos and videos','smartphone',1099,'2023-05-01 21:14:00',25,1099),(22,'SAMS-TABLET168296675822611','Samsung Galaxy Tab S6 Lite v3','10.4 inch TFT display\r\nExynos 9610 Octa-Core Processor\r\n4GB of RAM 128GB of internal storage','tablet',500,'2023-05-01 18:52:00',50,700),(2,'SPH001','Samsung Galaxy S22','128GB, 5G, 6.2-inch screen','smartphone',800,'2023-04-07 22:00:00',20,800),(7,'SPH004','Apple iPhone 14','128GB, 6.1-inch screen, 5G, A16 chip','smartphone',1200,'2023-04-15 16:00:00',50,1200),(3,'SPH006','Sony Xperia 5 III','128GB, 6.1-inch screen, 5G, Snapdragon 888','smartphone',950,'2023-04-08 18:00:00',50,950),(3,'SPH007','Xiaomi Mi 12','128GB, 6.8-inch screen, 5G, Snapdragon 898','smartphone',1200,'2023-05-02 22:00:00',50,1200),(1,'SPH008','Samsung Galaxy A73','128GB, 6.7-inch screen, 5G, Snapdragon 778G','smartphone',800,'2023-05-05 22:00:00',30,800),(11,'SPH009','Apple iPhone 15','256GB, 6.1-inch screen, 5G, A17 chip','smartphone',1500,'2023-05-08 22:00:00',50,1500),(2,'SPH011','Xiaomi Redmi Note 11 Pro','128GB, 6.67-inch screen, 5G, Snapdragon 870','smartphone',500,'2023-04-28 14:45:29',20,500),(11,'SPH013','Samsung Galaxy Z Fold 4','256GB, 7.1-inch foldable screen, 5G, Snapdragon 898','smartphone',2000,'2023-04-28 14:45:29',100,2000),(3,'TBL001','Apple iPad Pro','11-inch, M1 chip, 128GB storage','tablet',900,'2023-04-07 14:00:00',30,900),(3,'TBL002','Samsung Galaxy Tab S8+','12.4-inch, 256GB storage, Wi-Fi + 5G','tablet',1100,'2023-04-15 00:00:00',30,1100),(7,'TBL007','Lenovo Tab P12 Pro','12.6-inch, 128GB storage, Wi-Fi','tablet',700,'2023-05-07 18:00:00',30,700),(1,'XIAO-TABLET16829870781495','Xiaomi Mi Pad 5','128GB 6GB RAM Tablet - Pearl White','tablet',500,'2023-05-02 00:34:00',10,550);
/*!40000 ALTER TABLE `Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sale`
--

DROP TABLE IF EXISTS `Sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sale` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `seller_id` int NOT NULL,
  `buyer_id` int NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `list_price` double NOT NULL,
  `sale_price` double NOT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `seller_id` (`seller_id`),
  KEY `buyer_id` (`buyer_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `sale_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `User` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `sale_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `User` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `sale_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `Item` (`itemId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sale`
--

LOCK TABLES `Sale` WRITE;
/*!40000 ALTER TABLE `Sale` DISABLE KEYS */;
INSERT INTO `Sale` VALUES (1,8,1,'1682725827laptop8557',1499,1699),(14,11,8,' APP-TABLET168297538011674',549,599),(15,11,8,'SAMS-SMARTPHONE168297541111195',1099,1124),(16,8,1,'LENO-LAPTOP16829754958957',800,840),(18,8,1,'ONEP-TABLET16829769438953',700,720),(19,3,7,'MSI -LAPTOP16829868963117',2600,2900),(20,2,1,'GOOG-SMARTPHONE16829873092159',700,1300),(21,1,3,'XIAO-TABLET16829870781495',500,680),(22,2,1,'DELL-LAPTOP16829865592277',2100,3450);
/*!40000 ALTER TABLE `Sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'John Doe','johndoe','482c811da5d5b4bc6d497ffa98491e38','johndoe@example.com','New York'),(2,'Jane Doe','janedoe','96b33694c4bb7dbd07391e0be54745fb','janedoe@example.com','Los Angeles'),(3,'Bob Smith','bobsmith','7d347cf0ee68174a3588f6cba31b8a67','bobsmith@example.com','Chicago'),(4,'Mike Jones','mikejones','73a054cc528f91ca1bbdda3589b6a22d','mikejones@example.com','Paris'),(5,'Emma Johnson','emmajohnson','ba1b5d9d26dd50164b5fb53a948e5cdf','emmajohnson@example.com','New York'),(6,'David Brown','davidbrown','b4af804009cb036a4ccdc33431ef9ac9','davidbrown@example.com','Los Angeles'),(7,'Sarah Johnson','sjohnson','82080600934821faf0bc59cba79964bc','sarahj@example.com','New York City'),(8,'Michael Lee','mlee23','d34eb083b98f9c2f535fed62c288f583','mlee23@gmail.com','Toronto'),(11,'Harmanpreet','harmanpunn','827ccb0eea8a706c4c34a16891f84e7b','harmanpunn@gmail.com','New Brunswick, NJ'),(22,'SanchayKanade','sanchayk','d186a5b5fc8df8dbd7ae218ad1aecfd1','sk@rutgers.edu','new brunswick'),(27,'Harley Hill','hillharley','827ccb0eea8a706c4c34a16891f84e7b','hillharley@gmail.com','New Brunswick, NJ');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserInterests`
--

DROP TABLE IF EXISTS `UserInterests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserInterests` (
  `interestId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `interest` varchar(255) NOT NULL,
  PRIMARY KEY (`interestId`),
  KEY `userId` (`userId`),
  CONSTRAINT `userinterests_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `EndUser` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserInterests`
--

LOCK TABLES `UserInterests` WRITE;
/*!40000 ALTER TABLE `UserInterests` DISABLE KEYS */;
INSERT INTO `UserInterests` VALUES (26,8,'Laptop'),(27,8,'Smartphone'),(61,11,'Laptop'),(90,1,'Laptop'),(91,1,'Smartphone'),(92,1,'Tablet'),(93,7,'Smartphone'),(94,7,'Tablet');
/*!40000 ALTER TABLE `UserInterests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserQuestion`
--

DROP TABLE IF EXISTS `UserQuestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserQuestion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `question` text NOT NULL,
  `answer` text,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `userquestion_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `EndUser` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserQuestion`
--

LOCK TABLES `UserQuestion` WRITE;
/*!40000 ALTER TABLE `UserQuestion` DISABLE KEYS */;
INSERT INTO `UserQuestion` VALUES (1,1,'This is a test question.','This is a test answer'),(2,1,'How do we remove a bid?','Get in touch with a customer representative to remove a bid'),(5,1,'Another test question',NULL),(7,1,'How is Samsung galaxy tab 6 for gaming?',NULL),(11,3,'What is the return policy for items purchased on BuyMe?','BuyMe return policy varies depending on the seller and item purchased. As a buyer, you should always check the seller\'s return policy before making a purchase. If an item is not as described or arrives damaged, you may be eligible for a refund or exchange. BuyMe also offers a Money Back Guarantee program, which can provide additional protection for eligible purchases.'),(12,7,'How can I track my BuyMe order?',NULL);
/*!40000 ALTER TABLE `UserQuestion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-01 21:02:21
