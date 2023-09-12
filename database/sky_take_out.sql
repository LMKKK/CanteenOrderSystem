/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80027 (8.0.27)
 Source Host           : localhost:3306
 Source Schema         : sky_take_out

 Target Server Type    : MySQL
 Target Server Version : 80027 (8.0.27)
 File Encoding         : 65001

 Date: 08/09/2023 14:29:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '收货人',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认 0 否 1是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1700009823038525443 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '地址簿' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address_book
-- ----------------------------
INSERT INTO `address_book` VALUES (2, 1, '盖伦', '0', '15666668888', '11', '北京市', '1101', '市辖区', '110113', '顺义区', '京顺路 99号 黑马程序员 顺义校区', '3', 1);
INSERT INTO `address_book` VALUES (3, 1, '波仔', '0', '13666666666', '13', '河北省', '1302', '唐山市', '130202', '路南区', '马坡 恒顺大街 香悦四季西区2号楼', '2', 0);
INSERT INTO `address_book` VALUES (4, 1, '安琪拉', '0', '13666666666', '11', '北京市', '1101', '市辖区', '110102', '西城区', '望京东路 99号', '1', 0);
INSERT INTO `address_book` VALUES (5, 1, '提莫', '0', '13265691111', '11', '北京市', '1101', '市辖区', '110108', '海淀区', '朝阳路 56号', '1', 0);
INSERT INTO `address_book` VALUES (6, 10, '德玛', '0', '13696969696', '11', '北京市', '1101', '市辖区', '110102', '西城区', '土城路 78号', '1', 1);
INSERT INTO `address_book` VALUES (1698669380339052545, 1698668374821777409, '刘明凯', '0', '18254321828', '37', '山东省', '3710', '威海市', '371082', '荣成市', '宇宙中心哈理工荣成', '3', 0);
INSERT INTO `address_book` VALUES (1699227302873804801, 1698668374821777409, '凯凯', '0', '18254321828', '11', '北京市', '1101', '市辖区', '110101', '东城区', '天安门', '2', 1);
INSERT INTO `address_book` VALUES (1699604748482256898, 1699601882287841282, '于子墨', '0', '18746746968', '11', '北京市', '1101', '市辖区', '110102', '西城区', '宇宙中心哈理工', '1', 0);
INSERT INTO `address_book` VALUES (1699692176952082433, 1699691610033176578, '张守民', '0', '18445420078', '23', '黑龙江省', '2308', '佳木斯市', '230881', '同江市', '前进农垦社区修配厂家属区', '2', 1);
INSERT INTO `address_book` VALUES (1699977840840617986, 1699931303569731585, '53', '0', '18345813314', '15', '内蒙古自治区', '1501', '呼和浩特市', '150102', '新城区', '432.', '1', 0);
INSERT INTO `address_book` VALUES (1700009823038525442, 1699601882287841282, 'yu', '0', '18746746068', '15', '内蒙古自治区', '1503', '乌海市', '150304', '乌达区', '123', '2', 1);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int NULL DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT 0 COMMENT '顺序',
  `status` int NULL DEFAULT NULL COMMENT '分类状态 0:禁用，1:启用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1699261329529921538 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品及套餐分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (11, 1, '酒水饮料', 10, 1, '2022-06-09 22:09:18', '2023-04-12 15:59:54', 1, 1);
INSERT INTO `category` VALUES (12, 1, '主食', 10, 1, '2022-06-09 22:09:32', '2023-04-16 22:02:46', 1, 1);
INSERT INTO `category` VALUES (13, 2, '干锅套餐', 1, 0, '2022-06-09 22:11:38', '2023-09-04 18:11:26', 1, 1);
INSERT INTO `category` VALUES (15, 2, '双人套餐', 2, 1, '2022-06-09 22:14:10', '2023-04-14 09:33:34', 1, 1);
INSERT INTO `category` VALUES (16, 1, '特色菜', 4, 1, '2022-06-09 22:15:37', '2023-04-13 21:55:12', 1, 1);
INSERT INTO `category` VALUES (17, 1, '蜀味牛蛙', 2, 1, '2022-06-09 22:16:14', '2023-02-10 10:19:20', 1, 1);
INSERT INTO `category` VALUES (18, 1, '特色蒸菜', 6, 1, '2022-06-09 22:17:42', '2022-06-09 22:17:42', 1, 1);
INSERT INTO `category` VALUES (19, 1, '新鲜时蔬', 7, 1, '2022-06-09 22:18:12', '2022-06-09 22:18:28', 1, 1);
INSERT INTO `category` VALUES (20, 1, '秘制干锅', 8, 1, '2022-06-09 22:22:29', '2023-04-16 22:03:15', 1, 1);
INSERT INTO `category` VALUES (21, 1, '汤类', 9, 1, '2022-06-10 10:51:47', '2023-04-16 22:03:00', 1, 1);
INSERT INTO `category` VALUES (27, 1, '海鲜系列', 2, 1, '2023-02-16 09:46:12', '2023-04-12 15:51:25', 1, 1);
INSERT INTO `category` VALUES (29, 1, '碳烤全鱼', 1, 1, '2023-04-12 19:46:20', '2023-04-13 21:53:46', 1, 1);
INSERT INTO `category` VALUES (30, 1, '烤鱼伴侣', 2, 1, '2023-04-12 20:19:13', '2023-04-13 21:54:16', 1, 1);
INSERT INTO `category` VALUES (31, 1, '精美凉菜', 6, 1, '2023-04-13 21:48:19', '2023-04-13 21:55:26', 1, 1);
INSERT INTO `category` VALUES (33, 2, '海鲜套餐', 4, 1, '2023-04-13 22:31:16', '2023-04-13 22:31:16', 1, 1);
INSERT INTO `category` VALUES (34, 2, '烤鱼套餐', 5, 1, '2023-04-13 22:31:47', '2023-04-14 09:33:44', 1, 1);
INSERT INTO `category` VALUES (1693982380189061122, 1, '卤菜', 3, 1, '2023-08-22 21:44:07', '2023-08-22 21:44:07', 1, 1);
INSERT INTO `category` VALUES (1693982680870326273, 2, '单人餐', 1, 1, '2023-08-22 21:45:18', '2023-08-22 21:45:18', 1, 1);
INSERT INTO `category` VALUES (1699261329529921537, 1, '东北菜', 1, 1, '2023-09-06 11:20:46', '2023-09-06 11:20:46', 1, 1);

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品价格',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述信息',
  `status` int NULL DEFAULT 1 COMMENT '0 停售 1 起售',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1699714598777757698 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES (30, '干锅牛蛙', 20, 38.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398849610-干锅牛蛙.jpg', '干锅牛蛙', 1, '2023-04-13 23:14:12', '2023-04-16 22:04:25', 1, 1);
INSERT INTO `dish` VALUES (46, '王老吉', 11, 5.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/41bfcacf-7ad4-4927-8b26-df366553a94c.png', '', 1, '2022-06-09 22:40:47', '2023-04-16 22:04:11', 1, 1);
INSERT INTO `dish` VALUES (47, '北冰洋', 11, 4.00, 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/2d2a8524-2bd5-4415-aa92-efa804d29ae3-2.png', '还是小时候的味道', 1, '2022-06-10 09:18:49', '2023-02-16 09:24:50', 1, 1);
INSERT INTO `dish` VALUES (48, '雪花啤酒', 11, 4.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/bf8cbfc1-04d2-40e8-9826-061ee41ab87c.png', '', 1, '2022-06-10 09:22:54', '2022-06-10 09:22:54', 1, 1);
INSERT INTO `dish` VALUES (49, '米饭', 12, 2.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', '精选五常大米', 1, '2022-06-10 09:30:17', '2022-06-10 09:30:17', 1, 1);
INSERT INTO `dish` VALUES (50, '馒头', 12, 1.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681436083461-馒头.jpg', '优质面粉', 1, '2022-06-10 09:34:28', '2023-04-14 09:34:45', 1, 1);
INSERT INTO `dish` VALUES (51, '老坛酸菜鱼', 16, 56.00, 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/eee4461f-42b9-483f-9d10-c7a4e67faf49-27.png', '原料：汤，草鱼，酸菜', 1, '2022-06-10 09:40:51', '2023-04-13 23:06:51', 1, 1);
INSERT INTO `dish` VALUES (54, '清炒小油菜', 19, 18.00, 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/fa5d67cf-2a86-4d6e-b0c5-b9ad5bf4dc1a-9.png', '原料：小油菜', 1, '2022-06-10 09:51:46', '2023-02-16 09:24:37', 1, 1);
INSERT INTO `dish` VALUES (55, '蒜蓉娃娃菜', 19, 18.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/4879ed66-3860-4b28-ba14-306ac025fdec.png', '原料：蒜，娃娃菜', 1, '2022-06-10 09:53:37', '2022-06-10 09:53:37', 1, 1);
INSERT INTO `dish` VALUES (56, '清炒西兰花', 19, 18.00, 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/24f97f89-5e56-4dae-804f-f0508c578331-11.png', '原料：西兰花', 0, '2022-06-10 09:55:44', '2023-02-16 09:24:13', 1, 1);
INSERT INTO `dish` VALUES (57, '炝炒圆白菜', 19, 18.00, 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/c47acef5-dad1-42a7-b5b2-60490363b8e6-12.png', '原料：圆白菜', 1, '2022-06-10 09:58:35', '2023-02-16 09:23:58', 1, 1);
INSERT INTO `dish` VALUES (58, '清蒸鲈鱼', 18, 98.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/c18b5c67-3b71-466c-a75a-e63c6449f21c.png', '原料：鲈鱼', 1, '2022-06-10 10:12:28', '2022-06-10 10:12:28', 1, 1);
INSERT INTO `dish` VALUES (59, '东坡肘子', 18, 138.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/a80a4b8c-c93e-4f43-ac8a-856b0d5cc451.png', '原料：猪肘棒', 1, '2022-06-10 10:24:03', '2022-06-10 10:24:03', 1, 1);
INSERT INTO `dish` VALUES (60, '梅菜扣肉', 18, 58.00, 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/76bbfd95-2e70-4eb7-b80c-5219ffde57a1-毛氏红烧肉.jpg', '原料：猪肉，梅菜', 1, '2022-06-10 10:26:03', '2023-04-14 12:28:53', 1, 1);
INSERT INTO `dish` VALUES (61, '剁椒鱼头', 18, 66.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/13da832f-ef2c-484d-8370-5934a1045a06.png', '原料：鲢鱼，剁椒', 1, '2022-06-10 10:28:54', '2022-06-10 10:28:54', 1, 1);
INSERT INTO `dish` VALUES (63, '香锅牛蛙', 17, 66.00, 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/4fa13758-5f70-41c1-bb38-a8fb5db19af7-18.png', '配料：鲜活牛蛙，莲藕，青笋', 1, '2022-06-10 10:35:40', '2023-02-15 18:56:36', 1, 1);
INSERT INTO `dish` VALUES (64, '馋嘴牛蛙', 17, 88.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/7a55b845-1f2b-41fa-9486-76d187ee9ee1.png', '配料：鲜活牛蛙，丝瓜，黄豆芽', 1, '2022-06-10 10:37:52', '2023-08-23 10:58:04', 1, 1);
INSERT INTO `dish` VALUES (65, '蒜香烤鱼草鱼2斤', 29, 66.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/b544d3ba-a1ae-4d20-a860-81cb5dec9e03.png', '原料：草鱼，黄豆芽，莲藕', 1, '2022-06-10 10:41:08', '2023-04-16 01:25:22', 1, 1);
INSERT INTO `dish` VALUES (66, '碳烤江团鱼2斤', 29, 119.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/a101a1e9-8f8b-47b2-afa4-1abd47ea0a87.png', '配料：江团鱼，黄豆芽，莲藕', 1, '2022-06-10 10:42:42', '2023-04-13 23:21:36', 1, 1);
INSERT INTO `dish` VALUES (67, '碳烤鮰鱼2斤', 29, 72.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/8cfcc576-4b66-4a09-ac68-ad5b273c2590.png', '原料：鮰鱼，黄豆芽，莲藕', 1, '2022-06-10 10:43:56', '2023-04-13 23:21:03', 1, 1);
INSERT INTO `dish` VALUES (68, '鸡蛋汤', 21, 4.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/c09a0ee8-9d19-428d-81b9-746221824113.png', '配料：鸡蛋，紫菜', 1, '2022-06-10 10:54:25', '2022-06-10 10:54:25', 1, 1);
INSERT INTO `dish` VALUES (69, '平菇豆腐汤', 21, 6.00, 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/16d0a3d6-2253-4cfc-9b49-bf7bd9eb2ad2.png', '配料：豆腐，平菇', 1, '2022-06-10 10:55:02', '2022-06-10 10:55:02', 1, 1);
INSERT INTO `dish` VALUES (72, '红烧肉', 16, 32.00, 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/747433e9-27fd-4bd0-98bf-d05fe4c479a1-毛氏红烧肉.jpg', '菜品描述', 0, '2023-02-09 10:34:36', '2023-04-13 23:08:11', 1, 1);
INSERT INTO `dish` VALUES (73, '香辣花蛤', 27, 38.00, 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/67315a7e-1f4f-4b6a-9b3a-ac7b371ddbc3-香辣花蛤.jpg', '香辣 花蛤 香葱', 1, '2023-02-16 09:47:15', '2023-02-16 09:47:15', 1, 1);
INSERT INTO `dish` VALUES (74, '黑金鲍鱼', 27, 68.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397045666-黑金鲍海鲜.jpg', '新西兰黑金鲍鱼', 1, '2023-02-16 09:48:28', '2023-04-13 22:44:08', 1, 1);
INSERT INTO `dish` VALUES (75, '波士顿龙虾', 27, 128.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681396948811-5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', '2斤重 波斯顿龙虾', 1, '2023-02-16 09:50:06', '2023-04-13 22:42:31', 1, 1);
INSERT INTO `dish` VALUES (76, '香辣烤乌江鱼3斤', 29, 108.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681396881076-烤鱼2.jpg', '香辣烤乌江鱼3斤', 1, '2023-02-16 09:52:30', '2023-04-13 22:41:29', 1, 1);
INSERT INTO `dish` VALUES (77, '香辣烤鱼3斤', 29, 78.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681396752225-烤鱼1.jpg', '香辣烤鱼3斤 草鱼', 1, '2023-02-17 15:27:02', '2023-04-13 22:39:20', 1, 1);
INSERT INTO `dish` VALUES (80, '宽粉', 30, 8.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397331911-宽粉.jpg', '宽粉', 0, '2023-04-13 22:48:57', '2023-04-15 13:45:03', 1, 1);
INSERT INTO `dish` VALUES (81, '青笋', 30, 10.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397358593-青笋.jpg', '青笋', 1, '2023-04-13 22:49:21', '2023-04-13 22:49:21', 1, 1);
INSERT INTO `dish` VALUES (82, '鲜豆皮', 30, 8.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397389673-鲜豆皮.jpg', '鲜豆皮', 1, '2023-04-13 22:49:52', '2023-04-13 22:49:52', 1, 1);
INSERT INTO `dish` VALUES (83, '娃娃菜', 30, 6.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397423765-娃娃菜.jpg', '娃娃菜', 1, '2023-04-13 22:50:26', '2023-04-13 22:50:26', 1, 1);
INSERT INTO `dish` VALUES (84, '土豆片', 30, 6.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397450872-土豆片.jpg', '土豆片', 1, '2023-04-13 22:50:59', '2023-04-13 22:50:59', 1, 1);
INSERT INTO `dish` VALUES (85, '鱼豆腐', 30, 6.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397585037-鱼豆腐.jpg', '鱼豆腐', 1, '2023-04-13 22:53:07', '2023-04-16 14:45:30', 1, 1);
INSERT INTO `dish` VALUES (86, '重庆毛血旺', 16, 58.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397774614-重庆毛血旺.jpg', '重庆毛血旺', 1, '2023-04-13 22:56:18', '2023-04-13 22:56:18', 1, 1);
INSERT INTO `dish` VALUES (87, '重庆辣子鸡', 16, 48.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397813331-重庆辣子鸡.jpg', '重庆辣子鸡', 1, '2023-04-13 22:56:57', '2023-04-13 22:56:57', 1, 1);
INSERT INTO `dish` VALUES (88, '渝乡沸腾鱼片', 16, 79.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397886462-沸腾鱼片.jpg', '渝乡沸腾鱼片 草鱼', 1, '2023-04-13 22:58:29', '2023-04-13 22:58:29', 1, 1);
INSERT INTO `dish` VALUES (89, '皮蛋豆腐', 31, 28.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397971808-皮蛋豆腐.jpeg', '皮蛋豆腐 鸭蛋 松花江皮蛋', 1, '2023-04-13 22:59:45', '2023-04-13 22:59:45', 1, 1);
INSERT INTO `dish` VALUES (90, '果仁菠菜', 31, 18.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398074872-果仁菠菜.jpg', '果仁菠菜 花生 菠菜', 1, '2023-04-13 23:01:32', '2023-04-13 23:01:32', 1, 1);
INSERT INTO `dish` VALUES (91, '蒜泥黄瓜', 31, 12.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398142706-蒜泥黄瓜.jpg', '蒜泥黄瓜 大蒜 剁椒', 1, '2023-04-13 23:02:32', '2023-04-13 23:02:32', 1, 1);
INSERT INTO `dish` VALUES (92, '老醋花生', 31, 12.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398185891-老醋花生.jpeg', '老醋花生 老陈醋', 1, '2023-04-13 23:03:15', '2023-04-13 23:03:15', 1, 1);
INSERT INTO `dish` VALUES (93, '干锅花菜', 20, 28.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398621640-干锅花菜.jpg', '干锅花菜', 1, '2023-04-13 23:10:32', '2023-04-13 23:10:32', 1, 1);
INSERT INTO `dish` VALUES (94, '干锅千页豆腐', 20, 30.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398665753-干锅千页豆腐.jpg', '干锅千页豆腐', 1, '2023-04-13 23:11:08', '2023-04-13 23:11:08', 1, 1);
INSERT INTO `dish` VALUES (95, '干锅鸡胗', 20, 38.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398701510-干锅鸡胗.jpg', '干锅鸡胗', 1, '2023-04-13 23:11:46', '2023-04-13 23:11:46', 1, 1);
INSERT INTO `dish` VALUES (96, '干锅藕片', 20, 28.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398783756-干锅藕片.jpg', '干锅藕片', 1, '2023-04-13 23:13:18', '2023-04-13 23:13:18', 1, 1);
INSERT INTO `dish` VALUES (98, '扬州炒饭', 12, 12.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681399057973-炒饭.jpg', '扬州炒饭', 1, '2023-04-13 23:17:52', '2023-04-16 22:04:29', 1, 1);
INSERT INTO `dish` VALUES (99, '腐竹', 30, 8.00, 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681399144535-腐竹.jpg', '腐竹', 0, '2023-04-13 23:19:18', '2023-04-14 10:27:59', 1, 1);
INSERT INTO `dish` VALUES (1698682525262639105, '天天盖饭', 12, 8.50, 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/04/1693832425797-gaifan.webp', '天天盖饭，好吃不贵！两会一素只需要八块五', 1, '2023-09-04 21:00:49', '2023-09-06 09:47:44', 1, 1);
INSERT INTO `dish` VALUES (1699238658113036289, '农夫山贼矿泉水', 11, 2.00, 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693965025388-农夫shanzei.png', '我们不生产水，我们只是臭水沟的搬运工', 1, '2023-09-06 09:50:41', '2023-09-06 23:08:39', 1, 1);
INSERT INTO `dish` VALUES (1699261805889609729, '锅包肉', 1699261329529921537, 15.60, 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693970553255-src=http___safe-img.xhscdn.com_bw1_8fccc715-4fb3-4423-a26f-988ff23a5871_imageView2_2_w_1080_format_jpg&refer=http___safe-img.xhscdn.webp', '好吃', 1, '2023-09-06 11:22:40', '2023-09-06 11:23:13', 1, 1);
INSERT INTO `dish` VALUES (1699309202929938434, '馅饼', 12, 2.00, 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693981768384-馅饼.png', '兄弟要带饭吗？', 0, '2023-09-06 14:31:00', '2023-09-06 14:31:00', 1, 1);
INSERT INTO `dish` VALUES (1699605296459685890, '九转大肠', 1693982380189061122, 19.90, 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/07/1694052449240-v2-68b0f6e29f80191a459ec31c8fde98d6_720w.webp', '啦啦啦', 1, '2023-09-07 10:07:34', '2023-09-07 15:51:13', 1, 1);
INSERT INTO `dish` VALUES (1699714598777757697, '凌波鱼烤鱼', 29, 129.00, 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/07/1694078494683-fish.webp', '烤鱼不用挑，就吃半天妖', 1, '2023-09-07 17:21:54', '2023-09-08 11:08:54', 1, 1);

-- ----------------------------
-- Table structure for dish_flavor
-- ----------------------------
DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dish_id` bigint NOT NULL COMMENT '菜品',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味名称',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味数据list',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1699714599339794434 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品口味关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dish_flavor
-- ----------------------------
INSERT INTO `dish_flavor` VALUES (110, 63, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (111, 63, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (112, 60, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (113, 60, '甜味', '[\"无糖\",\"少糖\",\"半糖\"]');
INSERT INTO `dish_flavor` VALUES (114, 57, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (115, 57, '辣度', '[\"不辣\",\"微辣\",\"中辣\"]');
INSERT INTO `dish_flavor` VALUES (116, 56, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (117, 54, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\"]');
INSERT INTO `dish_flavor` VALUES (118, 52, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (119, 52, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (122, 73, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (136, 77, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (137, 77, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (138, 76, '辣度', '[\"微辣\",\"中辣\"]');
INSERT INTO `dish_flavor` VALUES (139, 76, '忌口', '[\"不要葱\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (140, 75, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (141, 75, '辣度', '[\"不辣\",\"微辣\",\"中辣\"]');
INSERT INTO `dish_flavor` VALUES (142, 74, '忌口', '[\"不要葱\",\"不要蒜\"]');
INSERT INTO `dish_flavor` VALUES (143, 74, '甜味', '[\"无糖\",\"少糖\",\"半糖\"]');
INSERT INTO `dish_flavor` VALUES (144, 86, '辣度', '[\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (145, 87, '辣度', '[\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (146, 88, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\"]');
INSERT INTO `dish_flavor` VALUES (147, 88, '辣度', '[\"微辣\",\"中辣\"]');
INSERT INTO `dish_flavor` VALUES (148, 89, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\"]');
INSERT INTO `dish_flavor` VALUES (149, 89, '甜味', '[\"无糖\",\"少糖\"]');
INSERT INTO `dish_flavor` VALUES (150, 90, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\"]');
INSERT INTO `dish_flavor` VALUES (151, 90, '辣度', '[\"不辣\",\"微辣\"]');
INSERT INTO `dish_flavor` VALUES (152, 91, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (153, 91, '辣度', '[\"不辣\",\"微辣\"]');
INSERT INTO `dish_flavor` VALUES (154, 92, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\"]');
INSERT INTO `dish_flavor` VALUES (155, 51, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (156, 51, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (157, 72, '辣度', '[\"微辣\",\"中辣\"]');
INSERT INTO `dish_flavor` VALUES (158, 72, '甜味', '[\"少糖\"]');
INSERT INTO `dish_flavor` VALUES (161, 93, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');
INSERT INTO `dish_flavor` VALUES (162, 93, '辣度', '[\"微辣\",\"中辣\"]');
INSERT INTO `dish_flavor` VALUES (163, 94, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\"]');
INSERT INTO `dish_flavor` VALUES (164, 94, '辣度', '[\"不辣\",\"微辣\"]');
INSERT INTO `dish_flavor` VALUES (165, 95, '辣度', '[\"微辣\",\"中辣\"]');
INSERT INTO `dish_flavor` VALUES (166, 96, '辣度', '[\"微辣\",\"中辣\"]');
INSERT INTO `dish_flavor` VALUES (167, 97, '忌口', '[\"不要蒜\",\"不要香菜\"]');
INSERT INTO `dish_flavor` VALUES (168, 97, '辣度', '[\"微辣\",\"中辣\"]');
INSERT INTO `dish_flavor` VALUES (169, 67, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (170, 66, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (172, 65, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (173, 46, '温度', '[\"热饮\",\"常温\",\"少冰\"]');
INSERT INTO `dish_flavor` VALUES (1698682525262639106, 1698682525262639105, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (1699228110558343170, 1698682525262639105, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (1699238658113036290, 1699238658113036289, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]');
INSERT INTO `dish_flavor` VALUES (1699261805889609730, 1699261805889609729, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]');
INSERT INTO `dish_flavor` VALUES (1699261805889609731, 1699261805889609729, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (1699309202997047298, 1699309202929938434, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (1699605297051082754, 1699605296459685890, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]');
INSERT INTO `dish_flavor` VALUES (1699605297516650498, 1699605296459685890, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (1699714599012638721, 1699714598777757697, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]');
INSERT INTO `dish_flavor` VALUES (1699714599339794433, 1699714598777757697, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '性别 0:女 1:男 ',
  `id_number` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT 1 COMMENT '状态 0:禁用，1:启用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
  UNIQUE INDEX `id_number`(`id_number` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1699305549288501251 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '员工信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13812312312', '1', '110101199001010047', 1, '2022-02-15 15:51:20', '2022-02-20 09:16:20', 10, 1);
INSERT INTO `employee` VALUES (2, '赵云', 'zy123', 'e10adc3949ba59abbe56e057f20f883e', '13888888888', '1', '429001199110061236', 1, '2023-02-07 17:32:21', '2023-04-12 11:18:18', 10, 1);
INSERT INTO `employee` VALUES (3, '波仔', 'bozai', 'e10adc3949ba59abbe56e057f20f883e', '13698695698', '1', '429001199110061631', 1, '2023-02-07 17:55:58', '2023-04-15 13:43:06', 10, 1);
INSERT INTO `employee` VALUES (4, '大乔', 'xiaoqiao', 'e10adc3949ba59abbe56e057f20f883e', '13666656666', '0', '110101199001010036', 0, '2023-02-08 18:22:18', '2023-09-04 19:32:41', 1, 1);
INSERT INTO `employee` VALUES (5, '赵信', 'zhaoxin', 'e10adc3949ba59abbe56e057f20f883e', '13888886688', '1', '110101199001010205', 1, '2023-02-08 19:09:39', '2023-09-04 17:31:56', 1, 1);
INSERT INTO `employee` VALUES (6, '卡特琳娜', 'kate', 'e10adc3949ba59abbe56e057f20f883e', '13888887788', '0', '11010119900101697', 1, '2023-04-11 11:42:28', '2023-04-16 22:00:16', 1, 1);
INSERT INTO `employee` VALUES (7, '提莫', 'timo', 'e10adc3949ba59abbe56e057f20f883e', '13677778888', '1', '421302199906181668', 1, '2023-04-11 12:01:23', '2023-09-04 17:02:26', 1, 1);
INSERT INTO `employee` VALUES (8, '小乔', 'xiaoqiao123', 'e10adc3949ba59abbe56e057f20f883e', '13666569896', '1', '421302199906191326', 0, '2023-04-16 22:01:16', '2023-04-16 22:01:25', 1, 1);
INSERT INTO `employee` VALUES (1693892574780100610, '刘明凯', 'lmk', '202cb962ac59075b964b07152d234b70', '18254321828', '1', '37232120010912805X', 0, '2023-08-22 15:47:15', '2023-09-04 14:53:28', 1, 1);
INSERT INTO `employee` VALUES (1693898302949462017, '丁丁', 'dingding', '202cb962ac59075b964b07152d234b70', '18254321888', '1', '372321200109128888', 1, '2023-08-22 16:10:01', '2023-08-22 16:10:01', 1, 1);
INSERT INTO `employee` VALUES (1693898433966936065, '王王', 'wang', '202cb962ac59075b964b07152d234b70', '18255555808', '1', '372321200109999', 1, '2023-08-22 16:10:32', '2023-08-22 20:44:01', 1, 1);
INSERT INTO `employee` VALUES (1698661500898557954, '刘其田', 'liuqitian', 'e10adc3949ba59abbe56e057f20f883e', '15006987447', '1', '372321197011298056', 0, '2023-09-04 19:37:16', '2023-09-06 14:14:39', 1, 1);
INSERT INTO `employee` VALUES (1699305549288501250, '牛牛牛', 'niu', 'e10adc3949ba59abbe56e057f20f883e', '17304561379', '1', '231181200111290017', 1, '2023-09-06 14:16:29', '2023-09-08 11:08:46', 1, 1);

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名字',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `dish_id` bigint NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1700021997707264003 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES (36, '蒜香烤鱼草鱼2斤', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/b544d3ba-a1ae-4d20-a860-81cb5dec9e03.png', 23, 65, NULL, '微辣', 1, 66.00);
INSERT INTO `order_detail` VALUES (37, '重庆辣子鸡', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397813331-重庆辣子鸡.jpg', 23, 87, NULL, '中辣', 1, 48.00);
INSERT INTO `order_detail` VALUES (38, '平菇豆腐汤', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/16d0a3d6-2253-4cfc-9b49-bf7bd9eb2ad2.png', 23, 69, NULL, NULL, 1, 6.00);
INSERT INTO `order_detail` VALUES (39, '米饭', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', 23, 49, NULL, NULL, 2, 2.00);
INSERT INTO `order_detail` VALUES (40, '蒜香烤鱼草鱼2斤', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/b544d3ba-a1ae-4d20-a860-81cb5dec9e03.png', 24, 65, NULL, '中辣', 1, 66.00);
INSERT INTO `order_detail` VALUES (41, '米饭', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', 24, 49, NULL, NULL, 1, 2.00);
INSERT INTO `order_detail` VALUES (42, '北冰洋', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/2d2a8524-2bd5-4415-aa92-efa804d29ae3-2.png', 24, 47, NULL, NULL, 2, 4.00);
INSERT INTO `order_detail` VALUES (43, '蒜香烤鱼草鱼2斤', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/b544d3ba-a1ae-4d20-a860-81cb5dec9e03.png', 25, 65, NULL, '中辣', 1, 66.00);
INSERT INTO `order_detail` VALUES (44, '米饭', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', 25, 49, NULL, NULL, 1, 2.00);
INSERT INTO `order_detail` VALUES (45, '北冰洋', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/2d2a8524-2bd5-4415-aa92-efa804d29ae3-2.png', 25, 47, NULL, NULL, 2, 4.00);
INSERT INTO `order_detail` VALUES (46, '28元干锅藕片套餐', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681445023205-干锅藕片.jpg', 26, NULL, 32, NULL, 2, 28.00);
INSERT INTO `order_detail` VALUES (47, '28元干锅藕片套餐', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681445023205-干锅藕片.jpg', 27, NULL, 32, NULL, 1, 28.00);
INSERT INTO `order_detail` VALUES (48, '时蔬38元套餐', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/d560528f-61ad-4154-bde5-26e17725a272-9.png', 28, NULL, 35, NULL, 1, 66.00);
INSERT INTO `order_detail` VALUES (49, '68干锅牛蛙套餐', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681442145727-干锅牛蛙.jpg', 28, NULL, 39, NULL, 1, 68.00);
INSERT INTO `order_detail` VALUES (50, '米饭', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', 28, 49, NULL, NULL, 2, 2.00);
INSERT INTO `order_detail` VALUES (51, '蒜香烤鱼草鱼2斤', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/b544d3ba-a1ae-4d20-a860-81cb5dec9e03.png', 29, 65, NULL, '中辣', 1, 66.00);
INSERT INTO `order_detail` VALUES (52, '波士顿龙虾', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681396948811-5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 29, 75, NULL, '中辣,不要蒜', 1, 128.00);
INSERT INTO `order_detail` VALUES (53, '28元干锅藕片套餐', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681445023205-干锅藕片.jpg', 30, NULL, 32, NULL, 1, 28.00);
INSERT INTO `order_detail` VALUES (54, '米饭', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', 30, 49, NULL, NULL, 2, 2.00);
INSERT INTO `order_detail` VALUES (55, '雪花啤酒', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/bf8cbfc1-04d2-40e8-9826-061ee41ab87c.png', 31, 48, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (56, '皮蛋豆腐', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397971808-皮蛋豆腐.jpeg', 31, 89, NULL, '不要葱,无糖', 1, 28.00);
INSERT INTO `order_detail` VALUES (57, '蒜泥黄瓜', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398142706-蒜泥黄瓜.jpg', 31, 91, NULL, '不要葱,不辣', 1, 12.00);
INSERT INTO `order_detail` VALUES (58, '北冰洋', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/2d2a8524-2bd5-4415-aa92-efa804d29ae3-2.png', 32, 47, NULL, NULL, 2, 4.00);
INSERT INTO `order_detail` VALUES (59, '米饭', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', 32, 49, NULL, NULL, 2, 2.00);
INSERT INTO `order_detail` VALUES (60, '香辣烤乌江鱼3斤', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681396881076-烤鱼2.jpg', 32, 76, NULL, '中辣,不要香菜', 1, 108.00);
INSERT INTO `order_detail` VALUES (1698669411720835074, '王老吉', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/41bfcacf-7ad4-4927-8b26-df366553a94c.png', 1698669411662114817, 46, NULL, '少冰', 1, 5.00);
INSERT INTO `order_detail` VALUES (1698669411720835075, '雪花啤酒', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/bf8cbfc1-04d2-40e8-9826-061ee41ab87c.png', 1698669411662114817, 48, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (1698669411720835076, '时蔬38元套餐', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/d560528f-61ad-4154-bde5-26e17725a272-9.png', 1698669411662114817, NULL, 35, NULL, 1, 66.00);
INSERT INTO `order_detail` VALUES (1698670157921071106, '平菇豆腐汤', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/16d0a3d6-2253-4cfc-9b49-bf7bd9eb2ad2.png', 1698670157921071105, 69, NULL, NULL, 1, 6.00);
INSERT INTO `order_detail` VALUES (1698670685656788994, '平菇豆腐汤', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/16d0a3d6-2253-4cfc-9b49-bf7bd9eb2ad2.png', 1698670685656788993, 69, NULL, NULL, 1, 6.00);
INSERT INTO `order_detail` VALUES (1698670685656788995, '干锅鸡胗', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398701510-干锅鸡胗.jpg', 1698670685656788993, 95, NULL, '中辣', 1, 38.00);
INSERT INTO `order_detail` VALUES (1698670685656788996, '干锅藕片', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681398783756-干锅藕片.jpg', 1698670685656788993, 96, NULL, '中辣', 1, 28.00);
INSERT INTO `order_detail` VALUES (1698670959783915523, '东坡肘子', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/a80a4b8c-c93e-4f43-ac8a-856b0d5cc451.png', 1698670959783915522, 59, NULL, NULL, 1, 138.00);
INSERT INTO `order_detail` VALUES (1698674978862477314, '馒头', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681436083461-馒头.jpg', 1698674978862477313, 50, NULL, NULL, 6, 1.00);
INSERT INTO `order_detail` VALUES (1698674978862477315, '米饭', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', 1698674978862477313, 49, NULL, NULL, 4, 2.00);
INSERT INTO `order_detail` VALUES (1698674978862477316, '扬州炒饭', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681399057973-炒饭.jpg', 1698674978862477313, 98, NULL, NULL, 3, 12.00);
INSERT INTO `order_detail` VALUES (1698675243124523010, '雪花啤酒', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/bf8cbfc1-04d2-40e8-9826-061ee41ab87c.png', 1698675243124523009, 48, NULL, NULL, 2, 4.00);
INSERT INTO `order_detail` VALUES (1698675995691778049, '老坛酸菜鱼', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/eee4461f-42b9-483f-9d10-c7a4e67faf49-27.png', 1698675995670806529, 51, NULL, '不要葱,不辣', 1, 56.00);
INSERT INTO `order_detail` VALUES (1698676309043998723, '蒜蓉娃娃菜', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/4879ed66-3860-4b28-ba14-306ac025fdec.png', 1698676309043998722, 55, NULL, NULL, 2, 18.00);
INSERT INTO `order_detail` VALUES (1698676832220504066, '香辣花蛤', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/67315a7e-1f4f-4b6a-9b3a-ac7b371ddbc3-香辣花蛤.jpg', 1698676832220504065, 73, NULL, '微辣', 1, 38.00);
INSERT INTO `order_detail` VALUES (1698677368374190083, '王老吉', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/41bfcacf-7ad4-4927-8b26-df366553a94c.png', 1698677368374190082, 46, NULL, '热饮', 1, 5.00);
INSERT INTO `order_detail` VALUES (1698680343968686083, '碳烤鮰鱼2斤', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/8cfcc576-4b66-4a09-ac68-ad5b273c2590.png', 1698680343968686082, 67, NULL, '微辣', 1, 72.00);
INSERT INTO `order_detail` VALUES (1699244547079430146, '波士顿龙虾', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681396948811-5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 1699244547012321282, 75, NULL, '微辣,不要葱', 1, 128.00);
INSERT INTO `order_detail` VALUES (1699260900163215363, '天天盖饭', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/04/1693832425797-gaifan.webp', 1699260900163215362, 1698682525262639105, NULL, '无糖,不辣', 3, 8.50);
INSERT INTO `order_detail` VALUES (1699307644435623939, '华莱士窜稀套餐', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/e71e138a-e874-4cca-8a60-c13440d87b14.png', 1699307644435623938, NULL, 1694186537185484803, NULL, 1, 9.90);
INSERT INTO `order_detail` VALUES (1699439984914796546, '香锅牛蛙', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/4fa13758-5f70-41c1-bb38-a8fb5db19af7-18.png', 1699439984847687682, 63, NULL, '不辣,不要香菜', 1, 66.00);
INSERT INTO `order_detail` VALUES (1699592351656218626, '王老吉', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/41bfcacf-7ad4-4927-8b26-df366553a94c.png', 1699592351194845185, 46, NULL, '少冰', 1, 5.00);
INSERT INTO `order_detail` VALUES (1699592351979180034, '鱼豆腐', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397585037-鱼豆腐.jpg', 1699592351194845185, 85, NULL, NULL, 1, 6.00);
INSERT INTO `order_detail` VALUES (1699592352444747778, '老坛酸菜鱼', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/eee4461f-42b9-483f-9d10-c7a4e67faf49-27.png', 1699592351194845185, 51, NULL, '不要葱,不辣', 1, 56.00);
INSERT INTO `order_detail` VALUES (1699604770036785154, '雪花啤酒', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/bf8cbfc1-04d2-40e8-9826-061ee41ab87c.png', 1699604769516691457, 48, NULL, NULL, 4, 4.00);
INSERT INTO `order_detail` VALUES (1699605464043102210, '九转大肠', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/07/1694052449240-v2-68b0f6e29f80191a459ec31c8fde98d6_720w.webp', 1699605463518814210, 1699605296459685890, NULL, '少糖,微辣', 1, 19.90);
INSERT INTO `order_detail` VALUES (1699609217724354561, '九转大肠', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/07/1694052449240-v2-68b0f6e29f80191a459ec31c8fde98d6_720w.webp', 1699609217254592513, 1699605296459685890, NULL, '无糖,不辣', 1, 19.90);
INSERT INTO `order_detail` VALUES (1699611851625631745, '北冰洋', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/2d2a8524-2bd5-4415-aa92-efa804d29ae3-2.png', 1699611851222978561, 47, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (1699611852019896322, '雪花啤酒', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/bf8cbfc1-04d2-40e8-9826-061ee41ab87c.png', 1699611851222978561, 48, NULL, NULL, 2, 4.00);
INSERT INTO `order_detail` VALUES (1699679751127130114, '北冰洋', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/2d2a8524-2bd5-4415-aa92-efa804d29ae3-2.png', 1699679750938386434, 47, NULL, NULL, 6, 4.00);
INSERT INTO `order_detail` VALUES (1699684372312027137, '王老吉', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/41bfcacf-7ad4-4927-8b26-df366553a94c.png', 1699684371796127746, 46, NULL, '热饮', 1, 5.00);
INSERT INTO `order_detail` VALUES (1699685514894962689, '农夫山贼矿泉水', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693965025388-农夫shanzei.png', 1699685514311954434, 1699238658113036289, NULL, '热饮', 1, 2.00);
INSERT INTO `order_detail` VALUES (1699692202369564674, '九转大肠', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/07/1694052449240-v2-68b0f6e29f80191a459ec31c8fde98d6_720w.webp', 1699692202105323521, 1699605296459685890, NULL, '无糖,不辣', 1, 19.90);
INSERT INTO `order_detail` VALUES (1699692455625834498, '九转大肠', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/07/1694052449240-v2-68b0f6e29f80191a459ec31c8fde98d6_720w.webp', 1699692455428702209, 1699605296459685890, NULL, '无糖,不辣', 1, 19.90);
INSERT INTO `order_detail` VALUES (1699692455822966785, '北冰洋', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/2d2a8524-2bd5-4415-aa92-efa804d29ae3-2.png', 1699692455428702209, 47, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (1699692455969767426, '农夫山贼矿泉水', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693965025388-农夫shanzei.png', 1699692455428702209, 1699238658113036289, NULL, '热饮', 1, 2.00);
INSERT INTO `order_detail` VALUES (1699715271766417409, '2人超值凌波鱼套餐', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/07/1694078644077-半天妖.webp', 1699715271439261698, NULL, 1699715202963054594, NULL, 1, 139.00);
INSERT INTO `order_detail` VALUES (1699716141312745473, '2人超值凌波鱼套餐', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/07/1694078644077-半天妖.webp', 1699716140981395457, NULL, 1699715202963054594, NULL, 1, 139.00);
INSERT INTO `order_detail` VALUES (1699716141648289794, '农夫山贼矿泉水', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693965025388-农夫shanzei.png', 1699716140981395457, 1699238658113036289, NULL, '少冰', 1, 2.00);
INSERT INTO `order_detail` VALUES (1699739678421393410, '锅包肉', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693970553255-src=http___safe-img.xhscdn.com_bw1_8fccc715-4fb3-4423-a26f-988ff23a5871_imageView2_2_w_1080_format_jpg&refer=http___safe-img.xhscdn.webp', 1699739678085849089, 1699261805889609729, NULL, '热饮,无糖', 2, 15.60);
INSERT INTO `order_detail` VALUES (1699752126327136257, '雪花啤酒', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/bf8cbfc1-04d2-40e8-9826-061ee41ab87c.png', 1699752126058700801, 48, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (1699946345536704513, '雪花啤酒', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/bf8cbfc1-04d2-40e8-9826-061ee41ab87c.png', 1699946345285046273, 48, NULL, NULL, 3, 4.00);
INSERT INTO `order_detail` VALUES (1699947470528729089, '扬州炒饭', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681399057973-炒饭.jpg', 1699947470268682241, 98, NULL, NULL, 1, 12.00);
INSERT INTO `order_detail` VALUES (1699947470860079106, '馒头', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681436083461-馒头.jpg', 1699947470268682241, 50, NULL, NULL, 1, 1.00);
INSERT INTO `order_detail` VALUES (1699947471124320258, '渝乡沸腾鱼片', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681397886462-沸腾鱼片.jpg', 1699947470268682241, 88, NULL, '中辣,不要蒜', 1, 79.00);
INSERT INTO `order_detail` VALUES (1699947990135885826, '清蒸鲈鱼', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/c18b5c67-3b71-466c-a75a-e63c6449f21c.png', 1699947989884227585, 58, NULL, NULL, 1, 98.00);
INSERT INTO `order_detail` VALUES (1699947990475624450, '炝炒圆白菜', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/c47acef5-dad1-42a7-b5b2-60490363b8e6-12.png', 1699947989884227585, 57, NULL, '不要葱,不辣', 1, 18.00);
INSERT INTO `order_detail` VALUES (1699947990735671297, '波士顿龙虾', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681396948811-5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 1699947989884227585, 75, NULL, '不要葱,不辣', 1, 128.00);
INSERT INTO `order_detail` VALUES (1699964882236674050, '农夫山贼矿泉水', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693965025388-农夫shanzei.png', 1699964881980821505, 1699238658113036289, NULL, '少冰', 3, 2.00);
INSERT INTO `order_detail` VALUES (1699972335716196353, '农夫山贼矿泉水', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693965025388-农夫shanzei.png', 1699972335456149506, 1699238658113036289, NULL, '热饮', 1, 2.00);
INSERT INTO `order_detail` VALUES (1699972773496676354, '农夫山贼矿泉水', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693965025388-农夫shanzei.png', 1699972773039497217, 1699238658113036289, NULL, '热饮', 1, 2.00);
INSERT INTO `order_detail` VALUES (1699972842857881602, '农夫山贼矿泉水', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/06/1693965025388-农夫shanzei.png', 1699972842329399297, 1699238658113036289, NULL, '热饮', 1, 2.00);
INSERT INTO `order_detail` VALUES (1699977864991420418, '北冰洋', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/2d2a8524-2bd5-4415-aa92-efa804d29ae3-2.png', 1699977864538435586, 47, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (1699981930615832577, '王老吉', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/41bfcacf-7ad4-4927-8b26-df366553a94c.png', 1699981929823109121, 46, NULL, '热饮', 1, 5.00);
INSERT INTO `order_detail` VALUES (1699981931739906049, '天天盖饭', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/04/1693832425797-gaifan.webp', 1699981929823109121, 1698682525262639105, NULL, '无糖,不辣', 1, 8.50);
INSERT INTO `order_detail` VALUES (1700008465111633921, '王老吉', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/41bfcacf-7ad4-4927-8b26-df366553a94c.png', 1700008464729952257, 46, NULL, '热饮', 2, 5.00);
INSERT INTO `order_detail` VALUES (1700019743981944833, '王老吉', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/41bfcacf-7ad4-4927-8b26-df366553a94c.png', 1700019743512182786, 46, NULL, '热饮', 2, 5.00);
INSERT INTO `order_detail` VALUES (1700019744304906242, '雪花啤酒', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/bf8cbfc1-04d2-40e8-9826-061ee41ab87c.png', 1700019743512182786, 48, NULL, NULL, 1, 4.00);
INSERT INTO `order_detail` VALUES (1700021997707264002, '雪花啤酒', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/bf8cbfc1-04d2-40e8-9826-061ee41ab87c.png', 1700021997250084865, 48, NULL, NULL, 3, 4.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单号',
  `status` int NOT NULL DEFAULT 1 COMMENT '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
  `user_id` bigint NOT NULL COMMENT '下单用户',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime NULL DEFAULT NULL COMMENT '结账时间',
  `pay_method` int NOT NULL DEFAULT 1 COMMENT '支付方式 1微信,2支付宝',
  `pay_status` tinyint NOT NULL DEFAULT 0 COMMENT '支付状态 0未支付 1已支付 2退款',
  `amount` decimal(10, 2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '地址',
  `consignee` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '收货人',
  `cancel_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单取消原因',
  `rejection_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单拒绝原因',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '订单取消时间',
  `estimated_delivery_time` datetime NULL DEFAULT NULL COMMENT '预计送达时间',
  `delivery_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '配送状态  1立即送出  0选择具体时间',
  `delivery_time` datetime NULL DEFAULT NULL COMMENT '送达时间',
  `pack_amount` int NULL DEFAULT NULL COMMENT '打包费',
  `tableware_number` int NULL DEFAULT NULL COMMENT '餐具数量',
  `tableware_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '餐具数量状态  1按餐量提供  0选择具体数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1700021997250084866 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (23, '48127788', 6, 1, 2, '2023-04-16 23:14:31', NULL, 1, 0, 135.00, '带一碟醋', '15666668888', '京顺路 99号 黑马程序员 顺义校区', '盖伦', '订单超时，自动取消', NULL, '2023-08-23 15:25:00', '2023-04-16 00:14:00', 0, NULL, 5, 2, 0);
INSERT INTO `orders` VALUES (24, '62795114', 6, 5, 3, '2023-04-16 23:27:34', NULL, 1, 0, 86.00, '带一碟醋', '15666668888', '京顺路 99号 黑马程序员 顺义校区', '波仔', '订单超时，自动取消', NULL, '2023-08-23 15:25:00', '2023-04-16 00:19:00', 0, NULL, 4, 2, 0);
INSERT INTO `orders` VALUES (25, '30949166', 6, 5, 2, '2023-04-16 23:40:35', NULL, 1, 2, 86.00, '带一碟醋', '15666668888', '京顺路 99号 黑马程序员 顺义校区', '盖伦', '订单量较多，暂时无法接单', NULL, '2023-09-08 10:29:38', '2023-04-16 00:40:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (26, '68856141', 5, 1, 4, '2023-04-18 11:11:13', NULL, 1, 2, 64.00, '', '15666668888', '京顺路 99号 黑马程序员 顺义校区', '安琪拉', NULL, NULL, '2023-09-04 20:09:27', '2023-04-18 12:11:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (27, '23822219', 6, 10, 2, '2023-04-18 11:14:02', NULL, 1, 0, 35.00, '', '13696969696', '土城路 78号', '盖伦', '用户取消订单', NULL, '2023-04-18 19:11:24', '2023-04-18 12:13:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (28, '83563829', 6, 6, 5, '2023-04-18 11:57:57', '2023-04-18 11:59:14', 1, 2, 148.00, '', '13696969696', '土城路 78号', '提莫', '用户取消订单', NULL, '2023-04-18 19:11:33', '2023-04-18 12:57:00', 0, NULL, 4, 4, 0);
INSERT INTO `orders` VALUES (29, '94091957', 6, 10, 6, '2023-04-18 19:48:05', NULL, 1, 0, 202.00, '', '13696969696', '土城路 78号', '德玛', '订单超时，自动取消', NULL, '2023-08-23 15:25:00', '2023-04-18 20:48:00', 0, NULL, 2, 0, 0);
INSERT INTO `orders` VALUES (30, '91450771', 5, 6, 5, '2023-04-18 19:48:25', NULL, 1, 2, 41.00, '', '13696969696', '土城路 78号', '提莫', '用户取消订单', NULL, '2023-09-04 20:09:27', '2023-04-18 20:48:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (31, '83162957', 6, 10, 3, '2023-04-18 19:48:46', NULL, 1, 0, 53.00, '', '13696969696', '土城路 78号', '波仔', '用户取消订单', NULL, '2023-04-18 21:35:38', '2023-04-18 20:48:00', 0, NULL, 3, 0, 0);
INSERT INTO `orders` VALUES (32, '68926061', 5, 10, 6, '2023-04-18 21:38:34', NULL, 1, 2, 131.00, '带点辣椒', '13696969696', '土城路 78号', '德玛', '用户取消订单', NULL, '2023-09-04 20:09:27', '2023-04-18 22:38:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1698669411662114817, '13d807c4c11f4f4e875c294437fe9c95', 6, 1698668374821777409, 1698669380339052545, '2023-09-04 20:08:42', '2023-09-04 20:08:48', 1, 2, 84.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单量较多，暂时无法接单', NULL, '2023-09-08 12:01:11', '2023-09-04 21:08:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1698670157921071105, '34e310f85b6947d7bffe245db012b056', 6, 1698668374821777409, 1698669380339052545, '2023-09-04 20:11:40', '2023-09-04 20:11:47', 1, 2, 13.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '商家拒单', '就你？饿着吧！！', '2023-09-04 20:23:52', '2023-09-04 21:11:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1698670685656788993, '0129fefe64af49a0bf9c8dbca715c8d9', 6, 1698668374821777409, 1698669380339052545, '2023-09-04 20:13:46', '2023-09-04 20:13:47', 1, 2, 81.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单量较多，暂时无法接单', NULL, '2023-09-08 12:01:16', '2023-09-04 21:13:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1698670959783915522, '68347ed5f8de4f16b34c9f880384ca3f', 3, 1698668374821777409, 1698669380339052545, '2023-09-04 20:14:51', '2023-09-04 20:14:52', 1, 1, 145.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', NULL, NULL, NULL, '2023-09-04 21:14:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1698674978862477313, '793e8a08b0aa43cb8e9de9a59ab4a9be', 2, 1698668374821777409, 1698669380339052545, '2023-09-04 20:30:49', '2023-09-04 20:30:51', 1, 1, 69.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', NULL, NULL, NULL, '2023-09-04 21:30:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1698675243124523009, '82bd3643616c4b16ad78e52e49c5adcc', 2, 1698668374821777409, 1698669380339052545, '2023-09-04 20:31:52', '2023-09-04 20:33:26', 1, 1, 16.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', NULL, NULL, NULL, '2023-09-04 21:31:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1698675995670806529, '3dbe394b979b4785a09007b6c6e3a201', 6, 1698668374821777409, 1698669380339052545, '2023-09-04 20:34:52', NULL, 1, 0, 63.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单超时未支付', NULL, '2023-09-04 20:50:00', '2023-09-04 21:34:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (1698676309043998722, '6a3b0434b23546718937ec8a8a1d17ed', 2, 1698668374821777409, 1698669380339052545, '2023-09-04 20:36:07', '2023-09-04 20:36:08', 1, 1, 44.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', NULL, NULL, NULL, '2023-09-04 21:36:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1698676832220504065, '95641f51772d4c3da13ca23baea51947', 6, 1698668374821777409, 1698669380339052545, '2023-09-04 20:38:11', '2023-09-04 20:38:21', 1, 2, 45.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '商家拒单', '订单量较多，暂时无法接单', '2023-09-06 13:35:37', '2023-09-04 21:38:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1698677368374190082, 'ef9bf8af13324762ae9029420a54caf9', 6, 1698668374821777409, 1698669380339052545, '2023-09-04 20:40:19', NULL, 1, 0, 12.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单超时未支付', NULL, '2023-09-04 20:56:00', '2023-09-04 21:40:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (1698680343968686082, '7ccea45693654d8da758e0c0e9a7aa92', 6, 1698668374821777409, 1698669380339052545, '2023-09-04 20:52:09', NULL, 1, 0, 79.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单超时未支付', NULL, '2023-09-06 08:38:00', '2023-09-04 21:52:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (1699244547012321282, '7a97702df5a24be395f6bd2091a1d47f', 6, 1698668374821777409, 1698669380339052545, '2023-09-06 10:14:05', '2023-09-06 10:14:07', 1, 2, 135.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单量较多，暂时无法接单', NULL, '2023-09-08 12:01:20', '2023-09-06 11:14:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699260900163215362, 'dcdc51044e1f45f0a55a0f5df8adc2ec', 6, 1698668374821777409, 1698669380339052545, '2023-09-06 11:19:04', '2023-09-06 11:19:05', 1, 2, 34.50, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单量较多，暂时无法接单', NULL, '2023-09-08 12:01:25', '2023-09-06 12:18:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699307644435623938, '2aabe03f9c044a13a35d1dd0e2f39948', 6, 1698668374821777409, 1698669380339052545, '2023-09-06 14:24:49', NULL, 1, 0, 16.90, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单超时未支付', NULL, '2023-09-06 23:08:01', '2023-09-06 15:24:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (1699439984847687682, 'a59b236cb0e14a8092a6b2e08f9a839e', 6, 1698668374821777409, 1698669380339052545, '2023-09-06 23:10:41', '2023-09-06 23:10:43', 1, 2, 73.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单量较多，暂时无法接单', NULL, '2023-09-08 12:01:29', '2023-09-06 00:10:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699592351194845185, '734609f9b08142f4b6e43946f0f2551a', 6, 1698668374821777409, 1698669380339052545, '2023-09-07 09:16:08', NULL, 1, 0, 76.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单超时未支付', NULL, '2023-09-07 09:32:00', '2023-09-07 10:16:00', 0, NULL, 3, 0, 0);
INSERT INTO `orders` VALUES (1699604769516691457, '6cf7198e3dcb44f981a44c45fb3c6028', 5, 1699601882287841282, 1699604748482256898, '2023-09-07 10:05:29', '2023-09-07 10:05:30', 1, 1, 26.00, '', '18746746968', '北京市市辖区西城区宇宙中心哈理工', '于子墨', NULL, NULL, '2023-09-07 10:05:59', '2023-09-07 11:05:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699605463518814210, 'cc44c9a40ef3498f8eed9145259300e0', 5, 1699601882287841282, 1699604748482256898, '2023-09-07 10:08:14', '2023-09-07 10:08:17', 1, 1, 26.90, '', '18746746968', '北京市市辖区西城区宇宙中心哈理工', '于子墨', NULL, NULL, '2023-09-07 10:08:44', '2023-09-07 11:08:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699609217254592513, '7169b85e0d0547d4a9b7205714c91808', 2, 1698668374821777409, 1698669380339052545, '2023-09-07 10:23:09', '2023-09-07 10:30:52', 1, 1, 26.90, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', NULL, NULL, NULL, '2023-09-07 11:22:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699611851222978561, '45f53b7e0bf744918294cb3275524787', 6, 1698668374821777409, 1698669380339052545, '2023-09-07 10:33:37', NULL, 1, 0, 21.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单超时未支付', NULL, '2023-09-07 10:49:00', '2023-09-07 11:33:00', 0, NULL, 3, 0, 0);
INSERT INTO `orders` VALUES (1699679750938386434, '0cf7693f0ae348c19c23d95edde7b3df', 5, 1699601882287841282, 1699604748482256898, '2023-09-07 15:03:26', '2023-09-07 15:03:27', 1, 1, 36.00, '', '18746746968', '北京市市辖区西城区宇宙中心哈理工', '于子墨', NULL, NULL, '2023-09-07 15:04:34', '2023-09-07 16:03:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699684371796127746, '50e54c9e7fc44ecda44a8ec793ec1e93', 6, 1698668374821777409, 1698669380339052545, '2023-09-07 15:21:48', NULL, 1, 0, 12.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单超时未支付', NULL, '2023-09-07 15:37:00', '2023-09-07 16:21:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (1699685514311954434, 'c894f20665334ff6a6aea68971936c35', 6, 1698668374821777409, 1698669380339052545, '2023-09-07 15:26:20', NULL, 1, 0, 9.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单超时未支付', NULL, '2023-09-07 15:42:00', '2023-09-07 16:26:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (1699692202105323521, '14dff8ce77e74474b1c97c03450c81d8', 5, 1699691610033176578, 1699692176952082433, '2023-09-07 15:52:54', '2023-09-07 15:53:08', 1, 1, 26.90, '', '18445420078', '黑龙江省佳木斯市同江市前进农垦社区修配厂家属区', '张守民', NULL, NULL, '2023-09-07 17:27:20', '2023-09-07 16:52:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699692455428702209, 'fd6aab76885f46beb2ce910b4986e988', 5, 1699691610033176578, 1699692176952082433, '2023-09-07 15:53:55', '2023-09-07 15:53:56', 1, 1, 34.90, '', '18445420078', '黑龙江省佳木斯市同江市前进农垦社区修配厂家属区', '张守民', NULL, NULL, '2023-09-07 17:27:18', '2023-09-07 16:53:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699715271439261698, '603ca3f0842a405f9e93cd2fa56617e3', 5, 1698668374821777409, 1698669380339052545, '2023-09-07 17:24:35', '2023-09-07 17:24:45', 1, 1, 146.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', NULL, NULL, '2023-09-07 17:27:17', '2023-09-07 18:24:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699716140981395457, '9f0e601c383a40a0bc86182cee3db980', 2, 1698668374821777409, 1698669380339052545, '2023-09-07 17:28:02', '2023-09-07 17:28:03', 1, 1, 149.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', NULL, NULL, NULL, '2023-09-07 18:28:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699739678085849089, '596f34ecea58436aa9b07f1d4679e78d', 5, 1698668374821777409, 1698669380339052545, '2023-09-07 19:01:34', '2023-09-07 19:01:36', 1, 1, 39.20, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', NULL, NULL, '2023-09-08 09:58:10', '2023-09-07 20:01:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699752126058700801, 'db9b98a2b62c48f89cb8322d665cd04d', 6, 1698668374821777409, 1698669380339052545, '2023-09-07 19:51:01', NULL, 1, 0, 11.00, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', '订单超时未支付', NULL, '2023-09-07 20:07:00', '2023-09-07 20:50:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (1699946345285046273, '6c05c6f4d5534fac9b8a54908e0c67c8', 5, 1698668374821777409, 1699227302873804801, '2023-09-08 08:42:47', '2023-09-08 08:42:49', 1, 1, 16.00, '', '18254321828', '北京市市辖区东城区天安门', '凯凯', NULL, NULL, '2023-09-08 08:43:01', '2023-09-08 09:42:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699947470268682241, 'cc6f676446bd4a149fb01ab58d505c4a', 2, 1698668374821777409, 1699227302873804801, '2023-09-08 08:47:15', '2023-09-08 08:47:17', 1, 1, 101.00, '', '18254321828', '北京市市辖区东城区天安门', '凯凯', NULL, NULL, NULL, '2023-09-08 09:47:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699947989884227585, 'fe953bee686e4c1db9153f4a8d56a827', 6, 1698668374821777409, 1699227302873804801, '2023-09-08 08:49:19', NULL, 1, 0, 253.00, '', '18254321828', '北京市市辖区东城区天安门', '凯凯', '用户取消订单', NULL, '2023-09-08 09:04:21', '2023-09-08 09:48:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699964881980821505, '23a4c9dd6174461486f46d22be8318e1', 5, 1699601882287841282, 1699604748482256898, '2023-09-08 09:56:26', '2023-09-08 09:56:28', 1, 1, 15.00, '', '18746746968', '北京市市辖区西城区宇宙中心哈理工', '于子墨', NULL, NULL, '2023-09-08 09:58:41', '2023-09-08 10:56:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699972335456149506, 'c25c89c43fd14f1fa62ed942a5a6d488', 5, 1699601882287841282, 1699604748482256898, '2023-09-08 10:26:03', '2023-09-08 10:26:04', 1, 1, 9.00, '', '18746746968', '北京市市辖区西城区宇宙中心哈理工', '于子墨', NULL, NULL, '2023-09-08 10:28:36', '2023-09-08 11:25:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699972773039497217, 'c40e75046ca14ebeb4d82d0aa58b9688', 6, 1699601882287841282, 1699604748482256898, '2023-09-08 10:27:48', NULL, 1, 0, 9.00, '', '18746746968', '北京市市辖区西城区宇宙中心哈理工', '于子墨', '订单超时未支付', NULL, '2023-09-08 10:43:00', '2023-09-08 11:27:00', 0, NULL, 1, 0, 0);
INSERT INTO `orders` VALUES (1699972842329399297, 'b982f70f75bd49428b150fee61a97165', 2, 1699601882287841282, 1699604748482256898, '2023-09-08 10:28:04', '2023-09-08 10:28:06', 1, 1, 9.00, '', '18746746968', '北京市市辖区西城区宇宙中心哈理工', '于子墨', NULL, NULL, NULL, '2023-09-08 11:27:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699977864538435586, '22f967b608ec48bcb9feb6b29402ffbe', 2, 1699931303569731585, 1699977840840617986, '2023-09-08 10:48:02', '2023-09-08 11:56:35', 1, 1, 11.00, '', '18345813314', '内蒙古自治区呼和浩特市新城区432.', '53', NULL, NULL, '2023-09-08 10:48:55', '2023-09-08 11:47:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1699981929823109121, '83e22538c57848718770a437daac5ebb', 5, 1698668374821777409, 1698669380339052545, '2023-09-08 11:04:11', '2023-09-08 11:04:30', 1, 1, 21.50, '', '18254321828', '山东省威海市荣成市宇宙中心哈理工荣成', '刘明凯', NULL, NULL, '2023-09-08 11:04:46', '2023-09-08 12:04:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1700008464729952257, 'c95deb9471db42d28ac2e5f44ccb77d9', 2, 1699601882287841282, 1699604748482256898, '2023-09-08 12:49:37', '2023-09-08 12:49:39', 1, 1, 18.00, '', '18746746968', '北京市市辖区西城区宇宙中心哈理工', '于子墨', NULL, NULL, NULL, '2023-09-08 13:49:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1700019743512182786, '79470b908e324a6fb0e1bf73a6db5857', 2, 1698668374821777409, 1699227302873804801, '2023-09-08 13:34:26', '2023-09-08 13:34:28', 1, 1, 23.00, '', '18254321828', '北京市市辖区东城区天安门', '凯凯', NULL, NULL, NULL, '2023-09-08 14:34:00', 0, NULL, 0, 0, 0);
INSERT INTO `orders` VALUES (1700021997250084865, 'd6c5c837dfd34eca8eceabb86db9016b', 2, 1698668374821777409, 1699227302873804801, '2023-09-08 13:43:24', '2023-09-08 13:43:26', 1, 1, 21.00, '', '18254321828', '北京市市辖区东城区天安门', '凯凯', NULL, NULL, NULL, '2023-09-08 14:43:00', 0, NULL, 0, 0, 0);

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '套餐名称',
  `price` decimal(10, 2) NOT NULL COMMENT '套餐价格',
  `status` int NULL DEFAULT 1 COMMENT '售卖状态 0:停售 1:起售',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1699715202963054595 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '套餐' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of setmeal
-- ----------------------------
INSERT INTO `setmeal` VALUES (31, 15, '88双人份烤鱼套餐', 88.00, 0, '88双人份烤鱼套餐', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681446700976-蒜香烤鱼.jpg', NULL, '2023-04-14 12:31:42', NULL, 1);
INSERT INTO `setmeal` VALUES (32, 13, '28元干锅藕片套餐', 28.00, 1, '28元干锅藕片套餐', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681445023205-干锅藕片.jpg', '2023-02-10 13:03:59', '2023-04-14 12:03:52', 5, 1);
INSERT INTO `setmeal` VALUES (33, 13, '38干锅牛蛙套餐', 38.00, 0, '干锅牛蛙套餐', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681445121519-干锅牛蛙.jpg', '2023-02-10 13:03:59', '2023-04-14 12:05:59', 1, 1);
INSERT INTO `setmeal` VALUES (35, 15, '时蔬38元套餐', 66.00, 1, '娃娃菜 梅菜扣肉', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/d560528f-61ad-4154-bde5-26e17725a272-9.png', '2023-02-16 09:38:18', '2023-04-16 14:44:32', 1, 1);
INSERT INTO `setmeal` VALUES (39, 13, '68干锅牛蛙套餐', 68.00, 1, '干锅牛蛙套餐 68元套餐', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/14/1681442145727-干锅牛蛙.jpg', '2023-04-14 11:16:05', '2023-04-16 22:05:53', 1, 1);
INSERT INTO `setmeal` VALUES (1694186537185484803, 15, '华莱士窜稀套餐', 9.90, 1, '好吃不贵', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/e71e138a-e874-4cca-8a60-c13440d87b14.png', '2023-09-04 14:04:02', '2023-09-06 13:32:38', 1, 1);
INSERT INTO `setmeal` VALUES (1699715202963054594, 34, '2人超值凌波鱼套餐', 139.00, 0, '烤鱼不用挑，就选半天妖怪', 'https://kkbank.oss-cn-qingdao.aliyuncs.com/images/2023/09/07/1694078644077-半天妖.webp', '2023-09-07 17:24:18', '2023-09-08 10:29:48', 1, 1);

-- ----------------------------
-- Table structure for setmeal_dish
-- ----------------------------
DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `setmeal_id` bigint NULL DEFAULT NULL COMMENT '套餐id',
  `dish_id` bigint NULL DEFAULT NULL COMMENT '菜品id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品单价（冗余字段）',
  `copies` int NULL DEFAULT NULL COMMENT '菜品份数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1699715203739000834 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '套餐菜品关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of setmeal_dish
-- ----------------------------
INSERT INTO `setmeal_dish` VALUES (95, 32, 49, '米饭', 2.00, 1);
INSERT INTO `setmeal_dish` VALUES (96, 32, 47, '北冰洋', 4.00, 1);
INSERT INTO `setmeal_dish` VALUES (97, 32, 96, '干锅藕片', 28.00, 1);
INSERT INTO `setmeal_dish` VALUES (98, 33, 49, '米饭', 2.00, 1);
INSERT INTO `setmeal_dish` VALUES (99, 33, 48, '雪花啤酒', 4.00, 1);
INSERT INTO `setmeal_dish` VALUES (100, 33, 97, '干锅牛蛙', 38.00, 1);
INSERT INTO `setmeal_dish` VALUES (101, 39, 97, '干锅牛蛙', 38.00, 1);
INSERT INTO `setmeal_dish` VALUES (102, 39, 49, '米饭', 2.00, 2);
INSERT INTO `setmeal_dish` VALUES (103, 39, 91, '蒜泥黄瓜', 12.00, 1);
INSERT INTO `setmeal_dish` VALUES (104, 39, 89, '皮蛋豆腐', 28.00, 1);
INSERT INTO `setmeal_dish` VALUES (108, 31, 54, '清炒小油菜', 18.00, 1);
INSERT INTO `setmeal_dish` VALUES (109, 31, 77, '香辣烤鱼3斤', 78.00, 1);
INSERT INTO `setmeal_dish` VALUES (110, 31, 49, '米饭', 2.00, 1);
INSERT INTO `setmeal_dish` VALUES (111, 35, 55, '蒜蓉娃娃菜', 18.00, 1);
INSERT INTO `setmeal_dish` VALUES (112, 35, 60, '梅菜扣肉', 58.00, 1);
INSERT INTO `setmeal_dish` VALUES (113, 35, 49, '米饭', 2.00, 1);
INSERT INTO `setmeal_dish` VALUES (1694187153131610121, 1694186537185484803, 77, '香辣烤鱼3斤', 78.00, 1);
INSERT INTO `setmeal_dish` VALUES (1694187153131610122, 1694186537185484803, 76, '香辣烤乌江鱼3斤', 108.00, 1);
INSERT INTO `setmeal_dish` VALUES (1694187153131610123, 1694186537185484803, 67, '碳烤鮰鱼2斤', 72.00, 1);
INSERT INTO `setmeal_dish` VALUES (1694187153131610124, 1694186537185484803, 66, '碳烤江团鱼2斤', 119.00, 1);
INSERT INTO `setmeal_dish` VALUES (1694187153131610125, 1694186537185484803, 65, '蒜香烤鱼草鱼2斤', 66.00, 1);
INSERT INTO `setmeal_dish` VALUES (1694187153131610126, 1694186537185484804, 77, '香辣烤鱼3斤', 78.00, 1);
INSERT INTO `setmeal_dish` VALUES (1699715203227295745, 1699715202963054594, 69, '平菇豆腐汤', 6.00, 1);
INSERT INTO `setmeal_dish` VALUES (1699715203483148289, 1699715202963054594, 73, '香辣花蛤', 38.00, 1);
INSERT INTO `setmeal_dish` VALUES (1699715203739000833, 1699715202963054594, 1699714598777757697, '凌波鱼烤鱼', 129.00, 1);

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop`  (
  `status` int NOT NULL COMMENT '店铺状态'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '店铺' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO `shop` VALUES (1);

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '商品名称',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `user_id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1700022028392792067 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '购物车' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
INSERT INTO `shopping_cart` VALUES (86, '北冰洋', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/2d2a8524-2bd5-4415-aa92-efa804d29ae3-2.png', 10, 47, NULL, NULL, 2, 4.00, NULL);
INSERT INTO `shopping_cart` VALUES (87, '米饭', 'https://sky-itcast.oss-cn-beijing.aliyuncs.com/76752350-2121-44d2-b477-10791c23a8ec.png', 10, 49, NULL, NULL, 2, 2.00, NULL);
INSERT INTO `shopping_cart` VALUES (88, '香辣烤乌江鱼3斤', 'https://sky-heima.oss-cn-beijing.aliyuncs.com/images/2023/04/13/1681396881076-烤鱼2.jpg', 10, 76, NULL, '中辣,不要香菜', 1, 108.00, NULL);
INSERT INTO `shopping_cart` VALUES (1700022028392792066, '北冰洋', 'https://sky-take-out.oss-cn-hangzhou.aliyuncs.com/2d2a8524-2bd5-4415-aa92-efa804d29ae3-2.png', 1698668374821777409, 47, NULL, NULL, 4, 4.00, '2023-09-08 13:43:31');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '微信用户唯一标识',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '头像',
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1699931303569731586 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'oJ2D44hfggfI6pBQ7j27M9YFLwNM', '波仔', '15623659866', '男', NULL, NULL, '2023-02-20 17:18:31');
INSERT INTO `user` VALUES (5, 'osvjO5Y5iQjEO0DlG1sIZpo454GY', '亚瑟', '13688896621', '男', NULL, NULL, '2023-02-26 17:06:00');
INSERT INTO `user` VALUES (6, 'osvjO5Y5iQjEO0DlG1sIZpoZAtq', '盖伦', NULL, '男', NULL, NULL, '2023-04-18 11:13:01');
INSERT INTO `user` VALUES (10, 'osvjO5Y5iQjEO0DlG1sIZpoZklVQ', '提莫', NULL, '男', NULL, NULL, '2023-04-18 11:13:01');
INSERT INTO `user` VALUES (1698668374821777409, 'oCvl261HMF1tezY9GSz5VXh4nbvo', NULL, NULL, NULL, NULL, NULL, '2023-09-04 20:04:35');
INSERT INTO `user` VALUES (1699601882287841282, 'ogS5367bDK8irXwulJlkSjwo4dNA', NULL, NULL, NULL, NULL, NULL, '2023-09-07 09:54:00');
INSERT INTO `user` VALUES (1699691610033176578, 'o42KG6wsFEI0Wo4DFHvkoQVBTSUc', NULL, NULL, NULL, NULL, NULL, '2023-09-07 15:50:33');
INSERT INTO `user` VALUES (1699931303569731585, 'om0KL6wC6EHxp6rSEnJA5ybDFRY4', NULL, NULL, NULL, NULL, NULL, '2023-09-08 07:43:01');

SET FOREIGN_KEY_CHECKS = 1;
