CREATE DATABASE  IF NOT EXISTS `CarthagoDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `CarthagoDB`;
-- MySQL dump 10.13  Distrib 5.6.11, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: CarthagoDB
-- ------------------------------------------------------
-- Server version	5.5.62

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
-- Table structure for table `Components`
--

DROP TABLE IF EXISTS `Components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Components` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext,
  `Html` longtext,
  `Url` longtext,
  `NumberOfPosts` int(11) NOT NULL DEFAULT '0',
  `ComponentType` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Components`
--

LOCK TABLES `Components` WRITE;
/*!40000 ALTER TABLE `Components` DISABLE KEYS */;
/*!40000 ALTER TABLE `Components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Events`
--

DROP TABLE IF EXISTS `Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Events` (
  `Id` varchar(95) NOT NULL,
  `Name` longtext,
  `IsBorrel` tinyint(1) NOT NULL,
  `Start` datetime NOT NULL,
  `End` datetime NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

LOCK TABLES `Events` WRITE;
/*!40000 ALTER TABLE `Events` DISABLE KEYS */;
/*!40000 ALTER TABLE `Events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EventsSettings`
--

DROP TABLE IF EXISTS `EventsSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventsSettings` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `calanderOwnerEmail` longtext,
  `calanderName` longtext,
  `BorrelEventName` longtext,
  `calanderID` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventsSettings`
--

LOCK TABLES `EventsSettings` WRITE;
/*!40000 ALTER TABLE `EventsSettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `EventsSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NewEmployees`
--

DROP TABLE IF EXISTS `NewEmployees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NewEmployees` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` longtext,
  `Name` longtext,
  `Role` longtext,
  `Description` longtext,
  `Picture` longtext,
  `InDienstPer` datetime NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NewEmployees`
--

LOCK TABLES `NewEmployees` WRITE;
/*!40000 ALTER TABLE `NewEmployees` DISABLE KEYS */;
/*!40000 ALTER TABLE `NewEmployees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OutLookApiSettings`
--

DROP TABLE IF EXISTS `OutLookApiSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OutLookApiSettings` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Tenant` longtext,
  `ClientId` longtext,
  `ClientSecret` longtext,
  `RedirectURL` longtext,
  `Authorized` tinyint(1) NOT NULL,
  `AdminEmail` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OutLookApiSettings`
--

LOCK TABLES `OutLookApiSettings` WRITE;
/*!40000 ALTER TABLE `OutLookApiSettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `OutLookApiSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PageComponents`
--

DROP TABLE IF EXISTS `PageComponents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PageComponents` (
  `PageId` int(11) NOT NULL,
  `ComponentId` int(11) NOT NULL,
  `GridPosition` int(11) NOT NULL,
  PRIMARY KEY (`PageId`,`ComponentId`,`GridPosition`),
  KEY `IX_PageComponents_ComponentId` (`ComponentId`),
  CONSTRAINT `FK_PageComponents_Components_ComponentId` FOREIGN KEY (`ComponentId`) REFERENCES `Components` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_PageComponents_Pages_PageId` FOREIGN KEY (`PageId`) REFERENCES `Pages` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PageComponents`
--

LOCK TABLES `PageComponents` WRITE;
/*!40000 ALTER TABLE `PageComponents` DISABLE KEYS */;
/*!40000 ALTER TABLE `PageComponents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pages`
--

DROP TABLE IF EXISTS `Pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pages` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Index` int(11) NOT NULL,
  `Title` longtext,
  `PrimaryColor` longtext,
  `SecondaryColor` longtext,
  `Background` longtext,
  `Grid` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pages`
--

LOCK TABLES `Pages` WRITE;
/*!40000 ALTER TABLE `Pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RoleClaims`
--

DROP TABLE IF EXISTS `RoleClaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RoleClaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RoleId` longtext,
  `ClaimType` longtext,
  `ClaimValue` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RoleClaims`
--

LOCK TABLES `RoleClaims` WRITE;
/*!40000 ALTER TABLE `RoleClaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `RoleClaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Roles` (
  `Id` varchar(95) NOT NULL,
  `Name` longtext,
  `NormalizedName` longtext,
  `ConcurrencyStamp` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rooms`
--

DROP TABLE IF EXISTS `Rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rooms` (
  `Address` varchar(95) NOT NULL,
  `Name` longtext,
  `AvailabilityView` longtext,
  PRIMARY KEY (`Address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rooms`
--

LOCK TABLES `Rooms` WRITE;
/*!40000 ALTER TABLE `Rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `Rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SpotifyApiSettings`
--

DROP TABLE IF EXISTS `SpotifyApiSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SpotifyApiSettings` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RedirectUrl` longtext,
  `PlaylistName` longtext,
  `ClientID` longtext,
  `ClientSecret` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SpotifyApiSettings`
--

LOCK TABLES `SpotifyApiSettings` WRITE;
/*!40000 ALTER TABLE `SpotifyApiSettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `SpotifyApiSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SpotifyApiToken`
--

DROP TABLE IF EXISTS `SpotifyApiToken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SpotifyApiToken` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Access_token` longtext,
  `Refresh_token` longtext,
  `Expires_in` double NOT NULL,
  `ExpiresOn` datetime NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SpotifyApiToken`
--

LOCK TABLES `SpotifyApiToken` WRITE;
/*!40000 ALTER TABLE `SpotifyApiToken` DISABLE KEYS */;
/*!40000 ALTER TABLE `SpotifyApiToken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserClaims`
--

DROP TABLE IF EXISTS `UserClaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserClaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` longtext,
  `ClaimType` longtext,
  `ClaimValue` longtext,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserClaims`
--

LOCK TABLES `UserClaims` WRITE;
/*!40000 ALTER TABLE `UserClaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserClaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserLogins`
--

DROP TABLE IF EXISTS `UserLogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserLogins` (
  `ProviderKey` varchar(95) NOT NULL,
  `UserId` varchar(95) NOT NULL,
  `LoginProvider` longtext,
  `ProviderDisplayName` longtext,
  PRIMARY KEY (`UserId`,`ProviderKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserLogins`
--

LOCK TABLES `UserLogins` WRITE;
/*!40000 ALTER TABLE `UserLogins` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserLogins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserRoles`
--

DROP TABLE IF EXISTS `UserRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserRoles` (
  `UserId` varchar(95) NOT NULL,
  `RoleId` varchar(95) NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRoles`
--

LOCK TABLES `UserRoles` WRITE;
/*!40000 ALTER TABLE `UserRoles` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserTokens`
--

DROP TABLE IF EXISTS `UserTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserTokens` (
  `UserId` varchar(95) NOT NULL,
  `LoginProvider` varchar(95) NOT NULL,
  `Name` varchar(95) NOT NULL,
  `Value` longtext,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserTokens`
--

LOCK TABLES `UserTokens` WRITE;
/*!40000 ALTER TABLE `UserTokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserTokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `Id` varchar(95) NOT NULL,
  `UserName` longtext,
  `NormalizedUserName` longtext,
  `Email` longtext,
  `NormalizedEmail` longtext,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext,
  `SecurityStamp` longtext,
  `ConcurrencyStamp` longtext,
  `PhoneNumber` longtext,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEnd` datetime DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__EFMigrationsHistory`
--

DROP TABLE IF EXISTS `__EFMigrationsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__EFMigrationsHistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__EFMigrationsHistory`
--

LOCK TABLES `__EFMigrationsHistory` WRITE;
/*!40000 ALTER TABLE `__EFMigrationsHistory` DISABLE KEYS */;
INSERT INTO `__EFMigrationsHistory` VALUES ('20211012202140_init','5.0.11');
/*!40000 ALTER TABLE `__EFMigrationsHistory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-12 22:24:26
