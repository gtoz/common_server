/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : schoolmarket

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2019-04-12 09:52:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bill
-- ----------------------------
DROP TABLE IF EXISTS `bill`;
CREATE TABLE `bill` (
  `id` varchar(255) DEFAULT NULL,
  `member` varchar(255) DEFAULT NULL COMMENT '这笔钱谁赚的，或者给了谁',
  `num` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `typeName` varchar(255) DEFAULT NULL COMMENT '类别',
  `remake` varchar(255) DEFAULT NULL COMMENT '备注',
  `time` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '支出、收入'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bill
-- ----------------------------

-- ----------------------------
-- Table structure for classify
-- ----------------------------
DROP TABLE IF EXISTS `classify`;
CREATE TABLE `classify` (
  `classify_id` varchar(255) DEFAULT NULL,
  `classify_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classify
-- ----------------------------
INSERT INTO `classify` VALUES ('1', '商品一');
INSERT INTO `classify` VALUES ('2', '商品二');

-- ----------------------------
-- Table structure for good
-- ----------------------------
DROP TABLE IF EXISTS `good`;
CREATE TABLE `good` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `classify` varchar(255) DEFAULT NULL,
  `introduction` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `shitang` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `pinlun` varchar(255) DEFAULT NULL COMMENT '评论id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of good
-- ----------------------------
INSERT INTO `good` VALUES ('1', '阶放什置见接', '213.00', '1', '么意就质规民统争空次消劳上斗同作机基日热见目变许委那单按天样图入又路人表价东流革头海员发力非效使白层划期美议算已手形资构放自', 'http://dummyimage.com/100x100/79f29c', '1', '克个达类存在示间此党始你导风片车整', null);
INSERT INTO `good` VALUES ('2', '123', '12.00', '2', '123', 'http://dummyimage.com/100x100/79f29c', '2', '123', null);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goods_id` varchar(255) DEFAULT NULL,
  `goods_name` varchar(255) DEFAULT NULL,
  `goods_originprice` decimal(10,2) DEFAULT NULL,
  `goods_price` decimal(10,2) DEFAULT NULL,
  `classify_id` varchar(255) DEFAULT NULL,
  `goods_recommend` varchar(255) DEFAULT NULL,
  `goods_picture` varchar(255) DEFAULT NULL,
  `goods_sellerid` varchar(255) DEFAULT NULL,
  `goods_addtime` varchar(255) DEFAULT NULL,
  `goods_newold` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('24ded1f1-3920-11e9-bb0d-31fead1a90cf', '测试', '12.00', '11.00', '2', '123', '11fa4030-6340-11e8-9841-b97022c02c8e', '123456', '2019-02-26 01:09:43', '2');
INSERT INTO `goods` VALUES ('a8777e01-3924-11e9-b9ec-d5f433746dd5', '测试', '12.00', '11.00', '1', '123', 'a8733840-3924-11e9-b9ec-d5f433746dd5.jpg#a873fb90-3924-11e9-b9ec-d5f433746dd5.jpg#a87422a0-3924-11e9-b9ec-d5f433746dd5.jpg', '123456', '2019-02-26 01:42:01', '1');

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES ('1', '123');
INSERT INTO `type` VALUES ('2', '1234');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `super` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('admin', 'admin', '0');
INSERT INTO `user` VALUES ('123', '1234', '1');
INSERT INTO `user` VALUES ('123', '123', '1');
INSERT INTO `user` VALUES ('123456', '18157146715', '1');

-- ----------------------------
-- Table structure for v_order
-- ----------------------------
DROP TABLE IF EXISTS `v_order`;
CREATE TABLE `v_order` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `num` decimal(10,2) DEFAULT NULL,
  `gidList` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of v_order
-- ----------------------------
INSERT INTO `v_order` VALUES ('4', '225.00', '[1,2]', '1', '');

-- ----------------------------
-- Table structure for v_trace
-- ----------------------------
DROP TABLE IF EXISTS `v_trace`;
CREATE TABLE `v_trace` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `gid` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `gname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of v_trace
-- ----------------------------

-- ----------------------------
-- Table structure for v_user
-- ----------------------------
DROP TABLE IF EXISTS `v_user`;
CREATE TABLE `v_user` (
  `user_id` varchar(255) DEFAULT NULL,
  `user_nick` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `true_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `institute` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  `wechat` varchar(255) DEFAULT NULL,
  `selfsign` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of v_user
-- ----------------------------
INSERT INTO `v_user` VALUES ('123456', 'chenxuezhou', '0', '123456789', '测试', '18654234679', '12', '某学院', '146783134', 'gh456456', '歇息');
INSERT INTO `v_user` VALUES (null, null, null, null, null, null, null, null, null, null, null);
