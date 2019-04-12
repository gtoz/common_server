/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : smart_campus

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2019-04-12 09:52:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `cls_name` varchar(20) NOT NULL,
  `cls_college` varchar(255) DEFAULT NULL,
  `cls_major` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES ('1', '计算机学院', '123');

-- ----------------------------
-- Table structure for clscore
-- ----------------------------
DROP TABLE IF EXISTS `clscore`;
CREATE TABLE `clscore` (
  `cs_id` varchar(50) NOT NULL,
  `cs_college` varchar(50) DEFAULT NULL,
  `cs_major` varchar(255) DEFAULT NULL,
  `cs_class` varchar(255) DEFAULT NULL,
  `cs_tea_id` varchar(255) DEFAULT NULL,
  `cs_term` varchar(255) DEFAULT NULL,
  `cs_course` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of clscore
-- ----------------------------
INSERT INTO `clscore` VALUES ('1', '计算机学院', '123', '1', '2', '20141', '123');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `cor_id` varchar(20) NOT NULL,
  `cor_name` varchar(20) DEFAULT NULL,
  `cor_hour` varchar(50) DEFAULT NULL,
  `cor_score1` int(11) DEFAULT NULL,
  `cor_grade` int(11) DEFAULT NULL COMMENT '1为2014,2为2015,3为2016年',
  `cor_score` varchar(255) DEFAULT NULL,
  `cor_college` varchar(255) DEFAULT NULL,
  `cor_major` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '123', '64', '86', '1', '4', '自动化学院', '123');

-- ----------------------------
-- Table structure for evaluate
-- ----------------------------
DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE `evaluate` (
  `eva_tea_id` varchar(20) DEFAULT NULL,
  `eva_tea_content` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eva_stu_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluate
-- ----------------------------
INSERT INTO `evaluate` VALUES ('2', '1234', '4', '0');
INSERT INTO `evaluate` VALUES ('1', '123asd', '9', '0');
INSERT INTO `evaluate` VALUES ('1', 'asgdh12', '10', '0');
INSERT INTO `evaluate` VALUES ('1', '123asd', '11', '0');
INSERT INTO `evaluate` VALUES ('1', '1234', '12', '0');
INSERT INTO `evaluate` VALUES ('2', '老师技术精湛，学到很多', '14', '1');

-- ----------------------------
-- Table structure for graduate
-- ----------------------------
DROP TABLE IF EXISTS `graduate`;
CREATE TABLE `graduate` (
  `eva_tea_id` varchar(20) DEFAULT NULL,
  `eva_tea_content` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eva_stu_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of graduate
-- ----------------------------
INSERT INTO `graduate` VALUES ('0', '123', '5', '1');
INSERT INTO `graduate` VALUES ('0', '123', '6', '1');
INSERT INTO `graduate` VALUES ('2', '213阿萨德', '7', '1');
INSERT INTO `graduate` VALUES ('2', '阿里巴巴', '8', '2');

-- ----------------------------
-- Table structure for reward
-- ----------------------------
DROP TABLE IF EXISTS `reward`;
CREATE TABLE `reward` (
  `info_id` varchar(50) NOT NULL,
  `info_stu_id` varchar(50) DEFAULT NULL,
  `info_name` varchar(255) DEFAULT NULL,
  `info_content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reward
-- ----------------------------
INSERT INTO `reward` VALUES ('1', '1', '违纪1', '抄作业');
INSERT INTO `reward` VALUES ('123', '1', '违规惩戒', '12而后卡仕达 ');

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `sco_id` varchar(20) NOT NULL,
  `sco_name` varchar(20) DEFAULT NULL,
  `sco_stu_id` varchar(50) DEFAULT NULL,
  `term` varchar(20) DEFAULT NULL,
  `sco_stu_name` varchar(255) DEFAULT NULL,
  `sco_class` varchar(255) DEFAULT NULL,
  `sco_score` int(11) DEFAULT NULL,
  `sco_tea_id` varchar(255) DEFAULT NULL,
  `sco_college` varchar(255) DEFAULT NULL,
  `sco_major` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sco_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES ('1', '123', '1', '20141', 'admin', '1', '69', '2', '计算机学院', '123');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `stu_id` varchar(20) NOT NULL,
  `stu_name` varchar(20) DEFAULT NULL,
  `stu_gender` varchar(50) DEFAULT NULL,
  `stu_tel` varchar(20) DEFAULT NULL,
  `stu_class` varchar(255) DEFAULT NULL,
  `stu_birth` varchar(255) DEFAULT NULL,
  `stu_grade` int(11) DEFAULT NULL,
  `stu_address` varchar(255) DEFAULT NULL,
  `stu_college` varchar(255) DEFAULT NULL,
  `stu_major` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`stu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '学生姓名', '女', '16538424961', '1', '1992-05-09', '85', '学生地址', '自动化学院', '123');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `tea_id` varchar(20) NOT NULL,
  `tea_name` varchar(20) DEFAULT NULL,
  `tea_gender` varchar(50) DEFAULT NULL,
  `tea_tel` varchar(20) DEFAULT NULL,
  `tea_class` varchar(255) DEFAULT NULL,
  `tea_college` varchar(255) DEFAULT NULL,
  `tea_major` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tea_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('2', '123123as', '男', '13546713465', '1', '计算机学院', '123');

-- ----------------------------
-- Table structure for timetable
-- ----------------------------
DROP TABLE IF EXISTS `timetable`;
CREATE TABLE `timetable` (
  `t_id` varchar(50) NOT NULL,
  `t_user` varchar(50) DEFAULT NULL COMMENT '老师的id',
  `t_zhouyi` varchar(255) DEFAULT NULL,
  `t_zhouer` varchar(255) DEFAULT NULL,
  `t_zhousan` varchar(255) DEFAULT NULL,
  `t_zhousi` varchar(255) DEFAULT NULL,
  `t_zhouwu` varchar(255) DEFAULT NULL,
  `t_zhouliu` varchar(255) DEFAULT NULL,
  `t_zhouri` varchar(255) DEFAULT NULL,
  `t_year` varchar(255) DEFAULT NULL,
  `t_order` varchar(255) DEFAULT NULL COMMENT '多少节课',
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of timetable
-- ----------------------------
INSERT INTO `timetable` VALUES ('1', '2', '1', '2', '3', '4', '5', '6', '7', '20141', '3');
INSERT INTO `timetable` VALUES ('2', '1', '1', '2', '3', '4', '5', '6', '7', '20141', '3');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` varchar(50) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `user_password` varchar(50) DEFAULT NULL,
  `user_role` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('0', '管理员', '0', '0');
INSERT INTO `users` VALUES ('1', '学生', '1', '2');
INSERT INTO `users` VALUES ('2', '老师', '2', '1');

-- ----------------------------
-- Table structure for work
-- ----------------------------
DROP TABLE IF EXISTS `work`;
CREATE TABLE `work` (
  `eva_tea_id` varchar(20) DEFAULT NULL,
  `eva_tea_content` text,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eva_stu_id` varchar(255) DEFAULT NULL,
  `eva_work_content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of work
-- ----------------------------
INSERT INTO `work` VALUES ('1', '[\"static\\\\QQ浏览器截图_20180421012224_E4D1588961FC4fa9863E6D865ADCECE5.jpg\",\"static\\\\QQ浏览器截图_20180421012243_FDDE36E0CD834fe192FC5845C8EE17FF.jpg\"]', '5', '0', '123');
INSERT INTO `work` VALUES ('1', '[\"static\\\\QQ浏览器截图_20180421012224_E4D1588961FC4fa9863E6D865ADCECE5.jpg\"]', '6', '0', null);
INSERT INTO `work` VALUES ('2', '[\"static\\\\QQ浏览器截图_20180421012224_E4D1588961FC4fa9863E6D865ADCECE5.jpg\"]', '7', '1', '1234');
INSERT INTO `work` VALUES ('2', '[\"static\\\\QQ浏览器截图_20180421012224_E4D1588961FC4fa9863E6D865ADCECE5.jpg\"]', '8', '1', '12341');
INSERT INTO `work` VALUES ('2', '[\"static\\\\QQ浏览器截图_20180421012224_E4D1588961FC4fa9863E6D865ADCECE5.jpg\"]', '9', '1', null);
INSERT INTO `work` VALUES ('2', '[\"static\\\\QQ浏览器截图_20180421012243_FDDE36E0CD834fe192FC5845C8EE17FF.jpg\"]', '10', '1', '阿萨德环球网');
INSERT INTO `work` VALUES ('2', '[\"static\\\\QQ浏览器截图_20180430170524_1F090EA5C75943a78D8E5E6E8BE47F65.jpg\"]', '11', '1', '挺好的');
