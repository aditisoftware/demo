/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.6.19 : Database - demo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`demo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `demo`;

/*Table structure for table `inquery` */

DROP TABLE IF EXISTS `inquery`;

CREATE TABLE `inquery` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `companyname` varchar(50) DEFAULT NULL,
  `contactperson` varchar(50) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `phone1` varchar(15) DEFAULT NULL,
  `phone2` varchar(15) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `tourtype` varchar(50) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `totalpassenger` varchar(3) DEFAULT NULL,
  `adult` varchar(3) DEFAULT NULL,
  `child` varchar(3) DEFAULT NULL,
  `child511year` varchar(3) DEFAULT NULL,
  `child11plus` varchar(3) DEFAULT NULL,
  `hotelcategory` varchar(50) DEFAULT NULL,
  `roomsharing` varchar(50) DEFAULT NULL,
  `vehicletype` varchar(1) DEFAULT NULL,
  `departuredate` date DEFAULT NULL,
  `transporttype` varchar(50) DEFAULT NULL,
  `traintype` varchar(50) DEFAULT NULL,
  `foodtype` varchar(100) DEFAULT NULL,
  `soundsystem` varchar(3) DEFAULT NULL,
  `project` varchar(3) DEFAULT NULL,
  `amt_pmt` varchar(5) DEFAULT NULL,
  `stagedecoration` varchar(3) DEFAULT NULL,
  `B2B` varchar(15) DEFAULT NULL,
  `DJParty` varchar(15) DEFAULT NULL,
  `cocktailparty` varchar(1) DEFAULT NULL,
  `artist` varchar(50) DEFAULT NULL,
  `cultureparty` varchar(50) DEFAULT NULL,
  `productlaunching` varchar(50) DEFAULT NULL,
  `sitevisit` varchar(50) DEFAULT NULL,
  `remark` varchar(250) DEFAULT NULL,
  `tourid` int(11) DEFAULT NULL,
  `createddate` datetime DEFAULT NULL,
  `createdby` int(11) DEFAULT NULL,
  `infant` int(2) DEFAULT NULL,
  `tourname` varchar(50) DEFAULT NULL,
  `tourcode` varchar(50) DEFAULT NULL,
  `schoolname` varchar(100) DEFAULT NULL,
  `totaldays` int(3) DEFAULT NULL,
  `entryfees` varchar(3) DEFAULT NULL,
  `hotelrooms` int(3) DEFAULT NULL,
  `extramatress` int(3) DEFAULT NULL,
  `mealplan` varchar(100) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `inquery` */

insert  into `inquery`(`Id`,`companyname`,`contactperson`,`address`,`city`,`state`,`country`,`zipcode`,`phone1`,`phone2`,`mobile`,`email`,`tourtype`,`destination`,`totalpassenger`,`adult`,`child`,`child511year`,`child11plus`,`hotelcategory`,`roomsharing`,`vehicletype`,`departuredate`,`transporttype`,`traintype`,`foodtype`,`soundsystem`,`project`,`amt_pmt`,`stagedecoration`,`B2B`,`DJParty`,`cocktailparty`,`artist`,`cultureparty`,`productlaunching`,`sitevisit`,`remark`,`tourid`,`createddate`,`createdby`,`infant`,`tourname`,`tourcode`,`schoolname`,`totaldays`,`entryfees`,`hotelrooms`,`extramatress`,`mealplan`,`vehicle`) values (3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'LUXURY','FIVE SHARING',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'rtyrtyrtyrty',2,'2015-08-31 14:25:14',1,NULL,'BHAKTI YATRA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,'2015-08-31 14:25:28',1,NULL,NULL,NULL,'EDUCATION TOUR',NULL,NULL,NULL,NULL,NULL,NULL),(5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RESORT & AMUZEMENT PARK',NULL,NULL,NULL,NULL,NULL,NULL,'SUPER DELUXE','DOUBLE SHARING',NULL,NULL,'Slepper Bus',NULL,'nonac,SWAMINARAYAN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4,'2015-08-31 14:29:21',1,NULL,NULL,NULL,'ADVENTURE TOUR',NULL,NULL,NULL,NULL,'KITCHEN GROUP',NULL),(6,'Corporate Tour',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SUPER DELUXE','DOUBLE SHARING',NULL,NULL,'Slepper Bus',NULL,'nonac,SWAMINARAYAN','on','on','pmt','on','on','1','1','on','on','on','on','fgsdfsdf',5,'2015-08-31 14:40:25',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'KITCHEN GROUP',NULL),(7,'glfgk','sdff','sdfm','.dfm','.mds.m','.fdm','sdfasdf','alskm','`msadflm','dfm','lsdakf',NULL,'asdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-09-30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,'2015-08-31 14:43:24',1,NULL,'lskdf','lasfdm',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `tourtype` */

DROP TABLE IF EXISTS `tourtype`;

CREATE TABLE `tourtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tourtitle` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `tourtype` */

insert  into `tourtype`(`id`,`tourtitle`) values (1,'ESCORTED TOUR'),(2,'BHAKTI YATRA'),(3,'EDUCATIONAL TOUR'),(4,'ADVENTURE TOUR'),(5,'CORPORATE TOUR'),(6,'INDIVIDUAL TOUR'),(7,'HOTEL BOOKING'),(8,'SHORT BREAK');

/*Table structure for table `usermaster` */

DROP TABLE IF EXISTS `usermaster`;

CREATE TABLE `usermaster` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `address1` varchar(50) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `username` varchar(15) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `usertype` enum('superadmin','admin','staff','agent') DEFAULT NULL,
  `createddate` datetime DEFAULT NULL,
  `createdby` int(11) DEFAULT NULL,
  `passwordsalt` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `usermaster` */

insert  into `usermaster`(`Id`,`firstname`,`lastname`,`address1`,`address2`,`city`,`state`,`country`,`username`,`password`,`usertype`,`createddate`,`createdby`,`passwordsalt`) values (1,'PArixit','Jani',NULL,NULL,NULL,NULL,NULL,'admin','admin','admin',NULL,1,'007AA9A6-8D6B-478F-A4F6ACF7225F4739');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
