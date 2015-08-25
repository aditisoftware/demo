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
  `hotelcategory` varchar(5) DEFAULT NULL,
  `roomsharing` varchar(3) DEFAULT NULL,
  `vehicletype` varchar(1) DEFAULT NULL,
  `allss` varchar(1) DEFAULT NULL,
  `allentry` varchar(1) DEFAULT NULL,
  `departuredate` date DEFAULT NULL,
  `transporttype` varchar(1) DEFAULT NULL,
  `traintype` varchar(1) DEFAULT NULL,
  `foodtype` varchar(1) DEFAULT NULL,
  `mealplan` varchar(1) DEFAULT NULL,
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
  `sitevisit` varchar(1) DEFAULT NULL,
  `remark` varchar(250) DEFAULT NULL,
  `tourid` int(11) DEFAULT NULL,
  `createddate` datetime DEFAULT NULL,
  `createdby` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `inquery` */

insert  into `inquery`(`Id`,`companyname`,`contactperson`,`address`,`city`,`state`,`country`,`zipcode`,`phone1`,`phone2`,`mobile`,`email`,`tourtype`,`destination`,`totalpassenger`,`adult`,`child`,`child511year`,`child11plus`,`hotelcategory`,`roomsharing`,`vehicletype`,`allss`,`allentry`,`departuredate`,`transporttype`,`traintype`,`foodtype`,`mealplan`,`soundsystem`,`project`,`amt_pmt`,`stagedecoration`,`B2B`,`DJParty`,`cocktailparty`,`artist`,`cultureparty`,`productlaunching`,`sitevisit`,`remark`,`tourid`,`createddate`,`createdby`) values (1,'gfdfgdfgd','xdfdfsdf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'dfgdfg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-08-24',NULL,NULL,NULL,NULL,NULL,'on','pmt','on',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2015-08-23 05:20:36',1);

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
  `password` varchar(15) DEFAULT NULL,
  `usertype` enum('superadmin','admin','staff','agent') DEFAULT NULL,
  `createddate` datetime DEFAULT NULL,
  `createdby` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `usermaster` */

insert  into `usermaster`(`Id`,`firstname`,`lastname`,`address1`,`address2`,`city`,`state`,`country`,`username`,`password`,`usertype`,`createddate`,`createdby`) values (1,'PArixit','Jani',NULL,NULL,NULL,NULL,NULL,'admin','admin','admin',NULL,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
