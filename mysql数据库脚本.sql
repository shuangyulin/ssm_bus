-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(20)  NOT NULL COMMENT 'user_name',
  `password` varchar(20)  NULL COMMENT '密码',
  `realName` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `birthday` varchar(20)  NULL COMMENT '出生日期',
  `cardNumber` varchar(20)  NOT NULL COMMENT '身份证',
  `city` varchar(20)  NULL COMMENT '籍贯',
  `photo` varchar(60)  NOT NULL COMMENT '照片',
  `address` varchar(50)  NULL COMMENT '家庭地址',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_busStation` (
  `stationId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `stationName` varchar(20)  NOT NULL COMMENT '站点名称',
  `longitude` float NOT NULL COMMENT '经度',
  `latitude` float NOT NULL COMMENT '纬度',
  PRIMARY KEY (`stationId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_busLine` (
  `lineId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `name` varchar(40)  NOT NULL COMMENT '线路名称',
  `startStation` int(11) NOT NULL COMMENT '起点站',
  `endStation` int(11) NOT NULL COMMENT '终到站',
  `startTime` varchar(20)  NOT NULL COMMENT '首班车时间',
  `endTime` varchar(20)  NOT NULL COMMENT '末班车时间',
  `company` varchar(60)  NOT NULL COMMENT '所属公司',
  `tjzd` varchar(500)  NOT NULL COMMENT '途径站点',
  `polylinePoints` varchar(200)  NOT NULL COMMENT '地图线路坐标',
  PRIMARY KEY (`lineId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_stationToStation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `startStation` int(11) NOT NULL COMMENT '起始站',
  `endStation` int(11) NOT NULL COMMENT '终到站',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_guestBook` (
  `guestBookId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `title` varchar(40)  NOT NULL COMMENT '留言标题',
  `content` varchar(200)  NOT NULL COMMENT '留言内容',
  `userObj` varchar(20)  NOT NULL COMMENT '留言人',
  `addTime` varchar(20)  NOT NULL COMMENT '留言时间',
  PRIMARY KEY (`guestBookId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_newsInfo` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `newsTitle` varchar(20)  NOT NULL COMMENT '标题',
  `newsContent` varchar(200)  NOT NULL COMMENT '新闻内容',
  `newsDate` varchar(20)  NULL COMMENT '发布日期',
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_busLine ADD CONSTRAINT FOREIGN KEY (startStation) REFERENCES t_busStation(stationId);
ALTER TABLE t_busLine ADD CONSTRAINT FOREIGN KEY (endStation) REFERENCES t_busStation(stationId);
ALTER TABLE t_stationToStation ADD CONSTRAINT FOREIGN KEY (startStation) REFERENCES t_busStation(stationId);
ALTER TABLE t_stationToStation ADD CONSTRAINT FOREIGN KEY (endStation) REFERENCES t_busStation(stationId);
ALTER TABLE t_guestBook ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


