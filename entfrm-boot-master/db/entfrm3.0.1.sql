/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : entfrm3.1

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 24/07/2022 16:10:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dev_apiinfo
-- ----------------------------
DROP TABLE IF EXISTS `dev_apiinfo`;
CREATE TABLE `dev_apiinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `application_id` int(11) NULL DEFAULT NULL COMMENT '应用编号',
  `table_id` int(11) NULL DEFAULT NULL COMMENT '表编号',
  `table_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表名',
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义编号',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父编号',
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接口类型',
  `request_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方式',
  `request_method` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `fdata` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '字段数据',
  `pdata` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '参数数据',
  `scripts` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '脚本',
  `dept_id` int(11) NULL DEFAULT NULL COMMENT '机构编号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0-正常，1-停用）',
  `create_by` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标识（0-正常，1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '接口信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dev_column
-- ----------------------------
DROP TABLE IF EXISTS `dev_column`;
CREATE TABLE `dev_column`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `def_value` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '默认值',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否必填（1是）',
  `is_add` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否为新增字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否查询字段（1是）',
  `query_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'eq' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  `is_import` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否导入（1是）',
  `is_export` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否导出（1是）',
  `edit_readonly` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改只读（1是）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dev_dataset
-- ----------------------------
DROP TABLE IF EXISTS `dev_dataset`;
CREATE TABLE `dev_dataset`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `alias` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据源别名',
  `ftype` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'json' COMMENT '格式类型',
  `cdata` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '配置数据',
  `is_page` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否分页',
  `scripts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'sql脚本',
  `create_by` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标识（0-正常，1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据源' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dev_form
-- ----------------------------
DROP TABLE IF EXISTS `dev_form`;
CREATE TABLE `dev_form`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单名称',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单标识',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '表单类型',
  `ds_alias` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据库别名',
  `table_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表名',
  `btn_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '按钮数据',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '表单数据',
  `menu_id` int(11) NULL DEFAULT NULL COMMENT '父级菜单',
  `auto_create` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '自动创建',
  `version` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '版本号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dev_table
-- ----------------------------
DROP TABLE IF EXISTS `dev_table`;
CREATE TABLE `dev_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `cols` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '24' COMMENT '分栏',
  `gen_api` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成API',
  `gen_way` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '生成方式',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `menu_id` int(11) NULL DEFAULT NULL COMMENT '父级菜单',
  `gen_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成路径',
  `sub_table_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_field` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联子表的外键名',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fired_time` bigint(20) NOT NULL,
  `sched_time` bigint(20) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_checkin_time` bigint(20) NOT NULL,
  `checkin_interval` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repeat_count` bigint(20) NOT NULL,
  `repeat_interval` bigint(20) NOT NULL,
  `times_triggered` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_IBFK_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `int_prop_1` int(11) NULL DEFAULT NULL,
  `int_prop_2` int(11) NULL DEFAULT NULL,
  `long_prop_1` bigint(20) NULL DEFAULT NULL,
  `long_prop_2` bigint(20) NULL DEFAULT NULL,
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL,
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL,
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_IBFK_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `next_fire_time` bigint(20) NULL DEFAULT NULL,
  `prev_fire_time` bigint(20) NULL DEFAULT NULL,
  `priority` int(11) NULL DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` bigint(20) NOT NULL,
  `end_time` bigint(20) NULL DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `misfire_instr` smallint(6) NULL DEFAULT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_application
-- ----------------------------
DROP TABLE IF EXISTS `sys_application`;
CREATE TABLE `sys_application`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用名称',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '应用类型',
  `is_sys` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '系统',
  `industry` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行业',
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面',
  `version` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '版本',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `sort` int(11) NULL DEFAULT 1 COMMENT '排序',
  `dept_id` int(11) NULL DEFAULT NULL COMMENT '机构编号',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态',
  `create_by` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标识（0-正常，1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_application
-- ----------------------------
INSERT INTO `sys_application` VALUES (1, '通用管理', '1', '0', '通用', NULL, '1.0.1', '通用管理', 1, 1, '1', 'entfrm', '2020-04-23 19:20:29', 'entfrm', '2020-04-23 20:06:36', NULL, '0');
INSERT INTO `sys_application` VALUES (2, '开发工具', '1', '1', '其他', NULL, '1.0.0', '开发工具', 1, 1, '1', 'entfrm', '2020-05-15 22:55:31', 'entfrm', '2020-05-15 23:09:16', NULL, '0');

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NULL DEFAULT NULL,
  `ancestors` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所有父级编号',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域名称',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域编码',
  `sort` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_backup
-- ----------------------------
DROP TABLE IF EXISTS `sys_backup`;
CREATE TABLE `sys_backup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路径',
  `create_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `is_sys` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '系统内置 0-是|1-否',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '初始密码', 'user.initPassword', '123456', '0', 'entfrm', '2020-03-15 21:51:13', '', NULL, NULL, '0');

-- ----------------------------
-- Table structure for sys_datasource
-- ----------------------------
DROP TABLE IF EXISTS `sys_datasource`;
CREATE TABLE `sys_datasource`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `driver_class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据驱动',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'url地址',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `alias` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '别名',
  `create_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `del_flag` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构编码',
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构名称',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '父级编号',
  `ancestors` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '祖级列表',
  `sort` int(11) NULL DEFAULT 1 COMMENT '排序',
  `contacts` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `email` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `create_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, '100001', '重庆总公司', 0, '0', 1, 'entfrm', '15688888888', NULL, NULL, '0', 'entfrm', '2020-02-13 20:55:57', NULL, '2020-03-19 20:49:29', NULL, '0');
INSERT INTO `sys_dept` VALUES (2, '10000101', '北京分公司', 1, '0,1', 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '2020-03-15 20:22:11', NULL, '0');
INSERT INTO `sys_dept` VALUES (3, '10000102', '昆明分公司', 1, '0,1', 2, '123', '', NULL, NULL, '0', NULL, NULL, 'entfrm', '2020-03-15 20:37:02', NULL, '0');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `is_sys` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '0-是|1-否',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (1, '用户性别', 'user_sex', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2020-03-17 14:19:40', '用户性别列表', '0');
INSERT INTO `sys_dict` VALUES (2, '菜单状态', 'menu_status', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2020-03-17 14:19:41', '菜单状态列表', '0');
INSERT INTO `sys_dict` VALUES (3, '是否', 'yes_no', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2020-03-17 14:19:42', '是否列表', '0');
INSERT INTO `sys_dict` VALUES (4, '状态', 'status', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2020-03-17 14:19:42', '状态列表', '0');
INSERT INTO `sys_dict` VALUES (5, '成功失败', 'success_fail', '0', '0', 'admin', '2019-08-24 10:02:57', 'admin', '2020-03-17 14:19:43', '成功失败列表', '0');
INSERT INTO `sys_dict` VALUES (6, '文件类别', 'file_type', '0', '0', 'entfrm', '2020-03-17 13:57:44', 'entfrm', '2020-03-20 22:48:19', '文件类别列表', '0');
INSERT INTO `sys_dict` VALUES (7, '数据库类型', 'datasource_type', '0', '0', 'entfrm', '2020-03-21 11:33:14', 'entfrm', '2020-03-22 09:56:10', '数据库类型列表', '0');
INSERT INTO `sys_dict` VALUES (8, '任务类型', 'job_type', '0', '0', 'entfrm', '2020-03-21 21:21:46', NULL, NULL, '任务类型列表', '0');
INSERT INTO `sys_dict` VALUES (9, '登录类型', 'login_type', '0', '0', 'entfrm', '2020-03-22 09:55:59', NULL, NULL, '登录类型列表', '0');
INSERT INTO `sys_dict` VALUES (10, '快捷方式类型', 'shortcut_type', '0', '0', 'entfrm', '2020-03-27 09:48:05', 'entfrm', '2020-03-27 10:14:27', '快捷方式类型列表', '0');
INSERT INTO `sys_dict` VALUES (11, '模型分类', 'model_category', '0', '0', 'entfrm', '2020-04-04 22:09:36', NULL, NULL, '', '0');
INSERT INTO `sys_dict` VALUES (12, '请假类型', 'leave_type', '0', '0', 'entfrm', '2020-04-05 10:08:18', NULL, NULL, '', '0');
INSERT INTO `sys_dict` VALUES (13, '任务状态', 'job_status', '0', '0', 'entfrm', '2020-04-11 18:54:20', NULL, NULL, '', '0');
INSERT INTO `sys_dict` VALUES (14, 'Activiti流程状态', 'process_status', '0', '0', 'entfrm', '2020-04-12 14:30:52', 'entfrm', '2021-05-12 01:37:16', 'Activiti流程状态', '1');
INSERT INTO `sys_dict` VALUES (15, '应用类型', 'application_type', '0', '0', 'entfrm', '2020-04-23 18:54:07', NULL, NULL, '', '0');
INSERT INTO `sys_dict` VALUES (16, '消息类型', 'msg_type', '0', '0', 'entfrm', '2020-05-10 16:02:20', NULL, NULL, '', '0');
INSERT INTO `sys_dict` VALUES (17, '应用状态', 'application_status', '0', '0', 'entfrm', '2020-05-15 22:56:49', NULL, NULL, '应用状态列表', '0');
INSERT INTO `sys_dict` VALUES (18, '消息通知类型', 'content_type', '0', '0', 'entfrm', '2020-05-25 15:45:41', NULL, NULL, '', '0');
INSERT INTO `sys_dict` VALUES (19, '数据格式类型', 'data_type', '0', '0', 'entfrm', '2020-06-13 08:51:07', NULL, NULL, '', '0');
INSERT INTO `sys_dict` VALUES (20, '表单类型', 'form_type', '0', '0', 'entfrm', '2021-03-26 23:30:49', NULL, NULL, '', '0');
INSERT INTO `sys_dict` VALUES (21, '流程状态', 'process_status', '1', '0', 'entfrm', '2021-05-12 01:37:30', NULL, '2022-01-27 15:39:41', 'Activiti流程状态', '0');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `dict_id` int(11) NULL DEFAULT NULL COMMENT '字典编号',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名',
  `value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据值',
  `sort` int(10) NOT NULL COMMENT '排序（升序）',
  `create_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, 'user_sex', '男', '0', 1, NULL, '2019-08-13 18:33:37', NULL, '2019-08-13 18:33:40', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (2, 1, 'user_sex', '女', '1', 2, NULL, '2019-08-13 18:34:03', NULL, '2019-08-13 18:34:07', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (3, 2, 'menu_status', '隐藏', '1', 2, NULL, '2019-08-13 18:33:37', NULL, '2019-08-19 15:42:29', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (4, 2, 'menu_status', '显示', '0', 1, NULL, '2019-08-13 18:33:37', NULL, '2019-08-19 15:42:28', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (5, 3, 'yes_no', '是', '0', 1, NULL, '2019-08-13 18:33:37', 'admin', '2020-03-17 12:05:05', '', '0');
INSERT INTO `sys_dict_data` VALUES (6, 3, 'yes_no', '否', '1', 2, NULL, '2019-08-13 18:33:37', 'admin', '2020-03-17 12:05:06', '', '0');
INSERT INTO `sys_dict_data` VALUES (7, 4, 'status', '停用', '1', 2, NULL, '2019-08-13 18:34:03', 'admin', '2019-08-19 15:43:00', '', '0');
INSERT INTO `sys_dict_data` VALUES (8, 4, 'status', '正常', '0', 1, NULL, '2019-08-13 18:33:37', NULL, '2019-08-19 15:42:59', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (9, NULL, 'success_fail', '成功', '0', 10, 'admin', '2019-08-24 11:48:18', 'entfrm', '2019-08-24 11:48:17', '', '0');
INSERT INTO `sys_dict_data` VALUES (10, NULL, 'success_fail', '失败', '1', 20, 'admin', '2019-08-24 11:48:27', NULL, '2019-08-24 11:48:26', '', '0');
INSERT INTO `sys_dict_data` VALUES (11, NULL, 'file_type', '图片', 'image', 1, 'entfrm', '2020-03-20 22:48:39', NULL, '2020-03-28 16:27:48', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (12, NULL, 'file_type', '媒体', 'media', 2, 'entfrm', '2020-03-20 22:48:48', 'entfrm', '2020-03-28 16:28:32', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (13, NULL, 'file_type', '文档', 'file', 3, 'entfrm', '2020-03-20 22:49:03', NULL, '2020-03-28 16:28:21', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (14, NULL, 'datasource_type', 'Mysql', 'com.mysql.cj.jdbc.Driver', 1, 'entfrm', '2020-03-21 11:33:59', 'entfrm', '2020-03-21 11:33:59', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (15, NULL, 'datasource_type', 'Sqlserver', 'com.microsoft.sqlserver.jdbc.SQLServerDriver', 2, 'entfrm', '2020-03-21 11:34:59', 'entfrm', '2020-03-21 11:34:58', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (16, NULL, 'datasource_type', 'Postgresql', 'org.postgresql.Driver', 3, 'entfrm', '2020-03-21 11:36:16', NULL, '2020-03-21 11:36:15', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (17, NULL, 'job_type', 'Java类', '1', 1, 'entfrm', '2020-03-21 21:22:35', NULL, '2020-03-21 21:22:35', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (18, NULL, 'job_type', 'Spring bean名称', '2', 2, 'entfrm', '2020-03-21 21:22:50', NULL, '2020-03-21 21:22:50', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (19, NULL, 'job_type', 'Rest调用', '3', 3, 'entfrm', '2020-03-21 21:23:06', NULL, '2020-03-21 21:23:05', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (20, NULL, 'job_type', 'Jar调用', '4', 4, 'entfrm', '2020-03-21 21:23:19', NULL, '2020-03-21 21:23:18', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (21, NULL, 'job_type', '其他', '5', 0, 'entfrm', '2020-03-21 21:23:24', NULL, '2020-03-21 21:23:24', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (22, NULL, 'login_type', '登录', '0', 1, 'entfrm', '2020-03-22 09:56:41', NULL, '2020-03-22 09:56:40', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (23, NULL, 'login_type', '退出', '1', 2, 'entfrm', '2020-03-22 09:56:51', NULL, '2020-03-22 09:56:51', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (24, NULL, 'shortcut_type', '顶部', '1', 1, 'entfrm', '2020-03-27 09:48:24', NULL, '2020-03-27 09:48:23', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (25, NULL, 'shortcut_type', '首页', '2', 2, 'entfrm', '2020-03-27 09:48:38', NULL, '2020-03-27 09:48:38', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (26, NULL, 'model_category', '办公流程', 'office', 1, 'entfrm', '2020-04-04 22:10:14', NULL, '2020-04-04 22:10:13', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (27, NULL, 'model_category', '项目流程', 'project', 2, 'entfrm', '2020-04-04 22:10:27', NULL, '2020-04-04 22:10:26', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (28, NULL, 'leave_type', '事假', '1', 1, 'entfrm', '2020-04-05 10:08:52', NULL, '2020-04-05 10:08:52', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (29, NULL, 'leave_type', '病假', '2', 2, 'entfrm', '2020-04-05 10:09:05', NULL, '2020-04-05 10:09:05', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (30, NULL, 'leave_type', '产假', '3', 3, 'entfrm', '2020-04-05 10:09:37', 'entfrm', '2020-04-05 10:09:37', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (31, NULL, 'job_status', '未发布', '1', 1, 'entfrm', '2020-04-11 18:54:37', NULL, '2020-04-11 18:54:37', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (32, NULL, 'job_status', '运行中', '2', 2, 'entfrm', '2020-04-11 18:54:48', NULL, '2020-04-11 18:54:47', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (33, NULL, 'job_status', '暂停', '3', 3, 'entfrm', '2020-04-11 18:54:57', NULL, '2020-04-11 18:54:57', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (34, NULL, 'leave_status', '未提交', '0', 0, 'entfrm', '2020-04-12 14:31:12', NULL, '2020-04-12 14:31:11', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (35, NULL, 'leave_status', '未审批', '1', 1, 'entfrm', '2020-04-12 14:31:29', NULL, '2020-04-12 14:31:28', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (36, NULL, 'leave_status', '批准', '2', 2, 'entfrm', '2020-04-12 14:31:38', NULL, '2020-04-12 14:31:38', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (37, NULL, 'leave_status', '驳回', '9', 3, 'entfrm', '2020-04-12 14:31:51', '小狗', '2020-04-12 14:31:51', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (38, NULL, 'application_type', 'PC', '1', 1, 'entfrm', '2020-04-23 18:54:36', NULL, '2020-04-23 18:54:36', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (39, NULL, 'application_type', 'APP', '2', 2, 'entfrm', '2020-04-23 18:54:44', NULL, '2020-04-23 18:54:44', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (40, NULL, 'application_type', '小程序', '3', 3, 'entfrm', '2020-04-23 18:54:58', NULL, '2020-04-23 18:54:57', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (41, NULL, 'msg_type', '短信', '0', 0, 'entfrm', '2020-05-10 16:02:40', NULL, '2020-05-10 16:02:40', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (42, NULL, 'msg_type', '邮件', '1', 1, 'entfrm', '2020-05-10 16:02:50', NULL, '2020-05-10 16:02:50', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (43, NULL, 'application_status', '未发布', '0', 0, 'entfrm', '2020-05-15 22:57:27', NULL, '2020-05-15 22:57:27', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (44, NULL, 'application_status', '已发布', '1', 1, 'entfrm', '2020-05-15 22:57:36', NULL, '2020-05-15 22:57:35', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (45, NULL, 'msg_type', 'PC', '2', 2, 'entfrm', '2020-05-25 15:44:18', NULL, '2020-05-25 15:44:17', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (46, NULL, 'msg_type', 'APP', '3', 3, 'entfrm', '2020-05-25 15:44:44', NULL, '2020-05-25 15:44:43', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (47, NULL, 'msg_type', '微信', '4', 4, 'entfrm', '2020-05-25 15:44:56', NULL, '2020-05-25 15:44:56', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (48, NULL, 'content_type', '通知', '0', 0, 'entfrm', '2020-05-25 15:46:28', NULL, '2020-05-25 15:46:28', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (49, NULL, 'content_type', '公告', '1', 1, 'entfrm', '2020-05-25 15:46:38', NULL, '2020-05-25 15:46:38', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (50, NULL, 'content_type', '其他', '2', 2, 'entfrm', '2020-05-25 15:46:46', NULL, '2020-05-25 15:46:45', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (51, NULL, 'data_type', 'json', 'json', 1, 'entfrm', '2020-06-13 08:51:24', NULL, '2020-06-13 08:51:24', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (52, NULL, 'form_type', '普通表单', '0', 0, 'entfrm', '2021-03-26 23:31:12', NULL, '2021-03-26 23:31:12', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (53, NULL, 'form_type', '工作流表单', '1', 1, 'entfrm', '2021-03-26 23:31:20', NULL, '2021-03-26 23:31:19', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (54, NULL, 'leave_status', '作废', '8', 4, '小狗', '2021-04-15 01:03:15', NULL, '2021-04-15 01:03:14', '作废流程', '0');
INSERT INTO `sys_dict_data` VALUES (55, NULL, 'application_type', '已挂起', '0', 0, 'entfrm', '2021-05-12 01:37:45', NULL, '2021-05-12 01:37:45', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (56, NULL, 'process_status', '已挂起', '0', 0, 'entfrm', '2021-05-12 01:38:51', NULL, '2021-05-12 01:38:50', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (57, NULL, 'process_status', '等待审核', '1', 1, 'entfrm', '2021-05-12 01:38:59', 'entfrm', '2021-05-12 01:38:59', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (58, NULL, 'process_status', '审核通过', '2', 2, 'entfrm', '2021-05-12 01:39:08', 'entfrm', '2021-05-12 01:39:07', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (59, NULL, 'process_status', '流程撤回', '3', 3, 'entfrm', '2021-05-12 01:39:14', 'entfrm', '2021-05-12 01:39:14', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (60, NULL, 'process_status', '审核驳回', '4', 4, 'entfrm', '2021-05-12 01:39:22', 'entfrm', '2021-05-12 01:39:21', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (61, NULL, 'process_status', '审核终止', '5', 5, 'entfrm', '2021-05-12 01:39:32', 'entfrm', '2021-05-12 01:39:31', NULL, '0');
INSERT INTO `sys_dict_data` VALUES (62, NULL, 'process_status', '流程作废', '6', 6, 'entfrm', '2021-05-12 01:39:52', 'entfrm', '2021-05-12 01:39:51', NULL, '0');

-- ----------------------------
-- Table structure for sys_file_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_file_info`;
CREATE TABLE `sys_file_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `format` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件格式',
  `size` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件大小',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件保存路径',
  `thumbnail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩略图',
  `dept_id` int(11) NULL DEFAULT NULL COMMENT '机构编号',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'entfrmTask.entfrmNoParams', '0/10 * * * * ?', '3', '1', '1', 'entfrm', '2022-06-13 13:55:37', '', '2022-06-13 15:32:39', '', '0');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'entfrmTask.entfrmParams(\'entfrm\')', '0/15 * * * * ?', '3', '1', '1', 'entfrm', '2022-06-13 13:55:37', '', '2022-06-13 23:28:47', '', '0');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'entfrmTask.entfrmMultipleParams(\'entfrm\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'entfrm', '2022-06-13 13:55:37', '', '2022-06-13 23:29:09', '', '0');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 202 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDS',
  `application_id` int(11) NULL DEFAULT 1 COMMENT '应用编号',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单类型 ',
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端URL',
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT 'VUE页面',
  `perms` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限标识',
  `icon` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `no_cache` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '路由缓存',
  `sort` int(11) NULL DEFAULT 1 COMMENT '排序值',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `create_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 236 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, NULL, 1, 'M', 'system', '#', '', 'system', '0', 10, '0', 'admin', '2019-03-16 11:33:00', 'admin', '2020-03-16 20:45:21', '系统管理模块', '0');
INSERT INTO `sys_menu` VALUES (2, '运维监控', 0, NULL, 1, 'M', 'monitor', '#', '', 'monitor', '0', 20, '0', 'admin', '2019-03-16 11:33:00', 'admin', '2020-03-17 19:14:27', '运维监控模块', '0');
INSERT INTO `sys_menu` VALUES (3, '开发工具', 0, NULL, 2, 'M', 'toolkit', '#', '', 'tool', '0', 30, '0', 'admin', '2019-03-16 11:33:00', 'admin', '2021-03-26 22:01:59', '开发工具模块', '0');
INSERT INTO `sys_menu` VALUES (4, '机构管理', 1, NULL, 1, 'C', 'dept', 'system/dept/index', '', 'tree', '0', 1, '0', NULL, '2020-03-13 19:31:20', NULL, '2020-03-14 20:55:41', NULL, '0');
INSERT INTO `sys_menu` VALUES (5, '角色管理', 1, NULL, 1, 'C', 'role', 'system/role/index', '', 'peoples', '0', 2, '0', NULL, '2020-03-13 19:32:09', NULL, '2020-03-16 22:11:57', NULL, '0');
INSERT INTO `sys_menu` VALUES (6, '用户管理', 1, NULL, 1, 'C', 'user', 'system/user/index', '', 'user', '0', 3, '0', NULL, '2020-03-13 19:32:30', NULL, '2020-03-16 22:11:59', NULL, '0');
INSERT INTO `sys_menu` VALUES (7, '菜单管理', 1, NULL, 1, 'C', 'menu', 'system/menu/index', '', 'tree-table', '0', 4, '0', NULL, '2020-03-13 19:33:24', NULL, '2020-03-16 22:12:01', NULL, '0');
INSERT INTO `sys_menu` VALUES (8, '机构新增', 4, NULL, 1, 'F', NULL, '#', 'dept_add', NULL, '0', 1, '0', NULL, '2020-03-12 20:42:47', NULL, '2020-03-16 20:42:51', NULL, '0');
INSERT INTO `sys_menu` VALUES (9, '机构修改', 4, NULL, 1, 'F', NULL, '#', 'dept_edit', NULL, '0', 2, '0', NULL, '2020-03-12 20:42:52', NULL, '2020-03-16 20:42:56', NULL, '0');
INSERT INTO `sys_menu` VALUES (10, '机构删除', 4, NULL, 1, 'F', NULL, '#', 'dept_del', NULL, '0', 3, '0', NULL, '2020-03-12 20:42:57', NULL, '2020-03-16 20:43:02', NULL, '0');
INSERT INTO `sys_menu` VALUES (11, '机构查看', 4, NULL, 1, 'F', NULL, '#', 'dept_view', NULL, '0', 4, '0', NULL, '2020-03-12 20:43:03', NULL, '2020-03-16 20:43:06', NULL, '0');
INSERT INTO `sys_menu` VALUES (12, '机构导入', 4, NULL, 1, 'F', NULL, '#', 'dept_import', NULL, '0', 5, '0', 'entfrm', '2020-03-16 20:40:08', 'entfrm', '2020-03-16 20:42:10', NULL, '0');
INSERT INTO `sys_menu` VALUES (13, '角色新增', 5, NULL, 1, 'F', NULL, '#', 'role_add', NULL, '0', 1, '0', 'entfrm', '2020-03-16 11:50:24', NULL, '2020-03-16 20:41:51', NULL, '0');
INSERT INTO `sys_menu` VALUES (14, '角色修改', 5, NULL, 1, 'F', NULL, '#', 'role_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-16 11:51:05', NULL, '2020-03-16 20:41:44', NULL, '0');
INSERT INTO `sys_menu` VALUES (15, '角色删除', 5, NULL, 1, 'F', NULL, '#', 'role_del', NULL, '0', 3, '0', 'entfrm', '2020-03-16 11:51:21', NULL, '2020-03-16 20:41:41', NULL, '0');
INSERT INTO `sys_menu` VALUES (16, '角色查看', 5, NULL, 1, 'F', NULL, '#', 'role_view', NULL, '0', 4, '0', 'entfrm', '2020-03-16 11:51:40', NULL, '2020-03-16 20:41:37', NULL, '0');
INSERT INTO `sys_menu` VALUES (17, '数据权限', 5, NULL, 1, 'F', NULL, '#', 'role_data', NULL, '0', 5, '0', 'entfrm', '2020-03-16 12:15:50', NULL, '2020-03-16 20:41:34', NULL, '0');
INSERT INTO `sys_menu` VALUES (18, '用户添加', 6, NULL, 1, 'F', NULL, '#', 'user_add', NULL, '0', 1, '0', 'entfrm', '2020-03-16 20:31:15', NULL, '2020-03-16 20:41:31', NULL, '0');
INSERT INTO `sys_menu` VALUES (19, '用户修改', 6, NULL, 1, 'F', NULL, '#', 'user_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-16 20:32:19', 'entfrm', '2020-03-16 20:41:28', NULL, '0');
INSERT INTO `sys_menu` VALUES (20, '用户删除', 6, NULL, 1, 'F', NULL, '#', 'user_del', NULL, '0', 3, '0', 'entfrm', '2020-03-16 20:32:41', NULL, '2020-03-16 20:41:25', NULL, '0');
INSERT INTO `sys_menu` VALUES (21, '用户查看', 6, NULL, 1, 'F', NULL, '#', 'user_view', NULL, '0', 4, '0', 'entfrm', '2020-03-16 20:33:11', NULL, '2020-03-16 20:41:20', NULL, '0');
INSERT INTO `sys_menu` VALUES (22, '重置密码', 6, NULL, 1, 'F', NULL, '#', 'user_reset', NULL, '0', 5, '0', 'entfrm', '2020-03-16 20:34:22', 'entfrm', '2020-03-16 20:41:17', NULL, '0');
INSERT INTO `sys_menu` VALUES (23, '用户导入', 6, NULL, 1, 'F', NULL, '#', 'user_import', NULL, '0', 6, '0', 'entfrm', '2020-03-16 20:34:49', NULL, '2020-03-16 20:41:14', NULL, '0');
INSERT INTO `sys_menu` VALUES (24, '用户导出', 6, NULL, 1, 'F', NULL, '#', 'user_export', NULL, '0', 7, '0', 'entfrm', '2020-03-16 20:35:12', NULL, '2020-03-16 20:41:12', NULL, '0');
INSERT INTO `sys_menu` VALUES (25, '菜单新增', 7, NULL, 1, 'F', NULL, '#', 'menu_add', NULL, '0', 1, '0', 'entfrm', '2020-03-16 20:38:18', NULL, '2020-03-16 20:41:10', NULL, '0');
INSERT INTO `sys_menu` VALUES (26, '菜单修改', 7, NULL, 1, 'F', NULL, '#', 'menu_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-16 20:38:41', 'entfrm', '2020-03-16 20:41:07', NULL, '0');
INSERT INTO `sys_menu` VALUES (27, '菜单删除', 7, NULL, 1, 'F', NULL, '#', 'menu_del', NULL, '0', 3, '0', 'entfrm', '2020-03-16 20:39:04', NULL, '2020-03-16 20:41:04', NULL, '0');
INSERT INTO `sys_menu` VALUES (28, '菜单查看', 7, NULL, 1, 'F', NULL, '#', 'menu_view', NULL, '0', 4, '0', 'entfrm', '2020-03-16 20:39:39', NULL, '2020-03-16 20:41:01', NULL, '0');
INSERT INTO `sys_menu` VALUES (29, '字典管理', 1, '6', 1, 'C', 'dict', 'system/dict/index', '', 'dict', '0', 5, '0', 'entfrm', '2020-03-16 11:33:00', '', '2020-03-16 11:33:00', '字典管理菜单', '0');
INSERT INTO `sys_menu` VALUES (30, '字典新增', 29, NULL, 1, 'F', NULL, '#', 'dict_add', NULL, '0', 1, '0', 'entfrm', '2020-03-16 20:50:45', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (31, '字典修改', 29, NULL, 1, 'F', NULL, '#', 'dict_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-16 20:51:01', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (32, '字典删除', 29, NULL, 1, 'F', NULL, '#', 'dict_del', NULL, '0', 3, '0', 'entfrm', '2020-03-16 20:52:18', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (33, '字典查看', 29, NULL, 1, 'F', NULL, '#', 'dict_view', NULL, '0', 4, '0', 'entfrm', '2020-03-16 20:52:38', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (34, '数据增加', 29, NULL, 1, 'F', NULL, '#', 'dictData_add', NULL, '0', 5, '0', 'entfrm', '2020-03-16 21:49:18', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (35, '数据修改', 29, NULL, 1, 'F', NULL, '#', 'dictData_edit', NULL, '0', 6, '0', 'entfrm', '2020-03-16 21:49:36', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (36, '数据删除', 29, NULL, 1, 'F', NULL, '#', 'dictData_del', NULL, '0', 7, '0', 'entfrm', '2020-03-16 21:50:00', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (37, '数据查看', 29, NULL, 1, 'F', NULL, '#', 'dictData_view', NULL, '0', 8, '0', 'entfrm', '2020-03-16 21:50:19', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (38, '参数管理', 1, NULL, 1, 'C', 'config', 'system/config/index', NULL, 'list', '0', 6, '0', 'entfrm', '2020-03-16 22:06:52', NULL, '2020-03-16 22:11:13', NULL, '0');
INSERT INTO `sys_menu` VALUES (39, '参数新增', 38, NULL, 1, 'F', NULL, '#', 'config_add', NULL, '0', 1, '0', 'entfrm', '2020-03-16 22:07:16', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (40, '参数修改', 38, NULL, 1, 'F', NULL, '#', 'config_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-16 22:07:30', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (41, '参数删除', 38, NULL, 1, 'F', NULL, '#', 'config_del', NULL, '0', 3, '0', 'entfrm', '2020-03-16 22:07:43', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (42, '参数查看', 38, NULL, 1, 'F', NULL, '#', 'config_view', NULL, '0', 4, '0', 'entfrm', '2020-03-16 22:08:06', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (43, '快捷方式', 1, NULL, 1, 'C', 'shortcut', 'system/shortcut/index', NULL, 'link', '0', 7, '0', 'entfrm', '2020-03-17 17:53:08', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (44, '文件管理', 1, NULL, 1, 'C', 'fileInfo', 'system/fileInfo/index', NULL, 'zip', '0', 8, '0', 'entfrm', '2020-03-17 17:56:28', 'entfrm', '2020-03-20 22:33:35', NULL, '0');
INSERT INTO `sys_menu` VALUES (46, '数据备份', 1, NULL, 1, 'C', 'backup', 'system/backup/index', NULL, 'date-range', '0', 11, '0', 'entfrm', '2020-03-17 18:02:21', NULL, '2020-03-18 22:20:28', NULL, '0');
INSERT INTO `sys_menu` VALUES (48, '定时任务', 2, NULL, 1, 'C', 'job', 'monitor/job/index', NULL, 'time-range', '0', 2, '0', 'entfrm', '2020-03-17 18:08:23', NULL, '2022-01-23 10:44:05', NULL, '0');
INSERT INTO `sys_menu` VALUES (49, '数据监控', 2, NULL, 1, 'C', 'druid', 'monitor/druid/index', NULL, 'druid', '0', 3, '0', 'entfrm', '2020-03-17 18:08:56', NULL, '2022-01-23 10:44:10', NULL, '0');
INSERT INTO `sys_menu` VALUES (50, '服务监控', 2, NULL, 1, 'C', 'server', 'monitor/server/index', NULL, 'server', '0', 4, '0', 'entfrm', '2020-03-17 18:09:39', 'entfrm', '2020-03-20 19:23:24', NULL, '0');
INSERT INTO `sys_menu` VALUES (51, 'API监控', 2, NULL, 1, 'C', 'apiStat', 'monitor/apiStat/index', 'apiStat_view', 'chart', '0', 6, '0', 'entfrm', '2020-03-17 18:15:13', 'entfrm', '2020-05-17 16:48:20', NULL, '0');
INSERT INTO `sys_menu` VALUES (52, '日志监控', 2, NULL, 1, 'M', 'log', '#', NULL, 'monitor', '0', 7, '0', 'entfrm', '2020-03-17 18:12:01', NULL, '2020-05-17 16:48:23', NULL, '0');
INSERT INTO `sys_menu` VALUES (54, '操作日志', 52, NULL, 1, 'C', 'operLog', 'monitor/operLog/index', NULL, 'log', '0', 2, '0', 'entfrm', '2020-03-17 18:13:52', 'entfrm', '2020-03-18 22:31:36', NULL, '0');
INSERT INTO `sys_menu` VALUES (55, '接口文档', 3, NULL, 2, 'C', 'swagger', 'toolkit/swagger/index', NULL, 'swagger', '0', 4, '0', 'entfrm', '2020-03-17 18:18:38', 'entfrm', '2021-03-26 21:59:08', NULL, '0');
INSERT INTO `sys_menu` VALUES (56, '模板管理', 3, NULL, 2, 'M', 'template', '#', NULL, 'drag', '0', 5, '0', 'entfrm', '2020-03-17 18:19:52', 'entfrm', '2021-03-26 21:59:08', NULL, '1');
INSERT INTO `sys_menu` VALUES (57, '表单构建', 3, NULL, 2, 'C', 'build', 'toolkit/build/index', NULL, 'form', '0', 6, '0', 'entfrm', '2020-03-17 18:21:32', 'entfrm', '2021-03-27 09:12:17', NULL, '1');
INSERT INTO `sys_menu` VALUES (58, '工作流', 0, NULL, 1, 'M', 'workflow', '#', NULL, 'workflow', '1', 1, '0', 'entfrm', '2020-03-17 18:22:36', 'entfrm', '2022-01-21 18:46:21', NULL, '1');
INSERT INTO `sys_menu` VALUES (66, '操作日志删除', 54, NULL, 1, 'F', NULL, '#', 'operLog_del', NULL, '0', 1, '0', 'entfrm', '2020-03-19 11:52:25', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (67, '操作日志查看', 54, NULL, 1, 'F', NULL, '#', 'operLog_view', NULL, '0', 2, '0', 'entfrm', '2020-03-19 11:52:45', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (68, '操作日志导出', 54, NULL, 1, 'F', NULL, '#', 'operLog_export', NULL, '0', 3, '0', 'entfrm', '2020-03-19 11:53:09', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (69, '备份新增', 46, NULL, 1, 'F', NULL, '#', 'backup_add', NULL, '0', 1, '0', 'entfrm', '2020-03-20 21:59:58', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (70, '备份还原', 46, NULL, 1, 'F', NULL, '#', 'backup_restore', NULL, '0', 2, '0', 'entfrm', '2020-03-20 22:00:23', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (71, '备份删除', 46, NULL, 1, 'F', NULL, '#', 'backup_del', NULL, '0', 3, '0', 'entfrm', '2020-03-20 22:00:41', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (72, '备份查看', 46, NULL, 1, 'F', NULL, '#', 'backup_view', NULL, '0', 4, '0', 'entfrm', '2020-03-20 22:44:05', NULL, '2020-03-20 22:44:39', NULL, '0');
INSERT INTO `sys_menu` VALUES (73, '文件上传', 44, NULL, 1, 'F', NULL, '#', 'fileInfo_add', NULL, '0', 1, '0', 'entfrm', '2020-03-20 22:41:42', NULL, '2020-03-20 22:44:35', NULL, '0');
INSERT INTO `sys_menu` VALUES (74, '文件启用', 44, NULL, 1, 'F', NULL, '#', 'fileInfo_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-20 22:42:07', 'entfrm', '2020-03-20 22:44:32', NULL, '0');
INSERT INTO `sys_menu` VALUES (75, '文件删除', 44, NULL, 1, 'F', NULL, '#', 'fileInfo_del', NULL, '0', 3, '0', 'entfrm', '2020-03-20 22:42:30', NULL, '2020-03-20 22:44:29', NULL, '0');
INSERT INTO `sys_menu` VALUES (76, '文件查看', 44, NULL, 1, 'F', NULL, '#', 'fileInfo_view', NULL, '0', 4, '0', 'entfrm', '2020-03-20 22:43:06', NULL, '2020-03-20 22:44:26', NULL, '0');
INSERT INTO `sys_menu` VALUES (77, '文件分享', 44, NULL, 1, 'F', NULL, '#', 'fileInfo_share', NULL, '0', 5, '0', 'entfrm', '2020-03-20 22:43:37', 'entfrm', '2020-03-20 22:44:23', NULL, '0');
INSERT INTO `sys_menu` VALUES (78, '数据库管理', 3, NULL, 2, 'C', 'datasource', 'toolkit/datasource/index', NULL, 'druid', '0', 1, '0', 'entfrm', '2020-03-21 11:05:47', 'entfrm', '2021-03-26 21:59:08', NULL, '0');
INSERT INTO `sys_menu` VALUES (79, '数据表管理', 3, NULL, 2, 'C', 'datatable', 'toolkit/datatable/index', NULL, 'table', '0', 2, '0', 'entfrm', '2020-03-21 11:07:23', 'entfrm', '2021-03-26 21:59:08', NULL, '0');
INSERT INTO `sys_menu` VALUES (81, '数据库新增', 78, NULL, 1, 'F', NULL, '#', 'datasource_add', NULL, '0', 1, '0', 'entfrm', '2020-03-21 11:27:26', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (82, '数据库修改', 78, NULL, 1, 'F', NULL, '#', 'datasource_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-21 11:27:46', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (83, '数据库删除', 78, NULL, 1, 'F', NULL, '#', 'datasource_del', NULL, '0', 3, '0', 'entfrm', '2020-03-21 11:27:59', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (84, '数据库查看', 78, NULL, 1, 'F', NULL, '#', 'datasource_view', NULL, '0', 4, '0', 'entfrm', '2020-03-21 11:28:11', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (90, '表新增', 79, NULL, 1, 'F', NULL, '#', 'datatable_add', NULL, '0', 1, '0', 'entfrm', '2020-03-25 14:59:45', 'entfrm', '2020-03-25 15:00:14', NULL, '0');
INSERT INTO `sys_menu` VALUES (91, '表修改', 79, NULL, 1, 'F', NULL, '#', 'datatable_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-25 15:00:31', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (92, '表删除', 79, NULL, 1, 'F', NULL, '#', 'datatable_del', NULL, '0', 3, '0', 'entfrm', '2020-03-25 15:00:49', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (93, '表查看', 79, NULL, 1, 'F', NULL, '#', 'datatable_view', NULL, '0', 4, '0', 'entfrm', '2020-03-25 15:01:06', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (94, '表配置', 79, NULL, 1, 'F', NULL, '#', 'datatable_config', NULL, '0', 5, '0', 'entfrm', '2020-03-25 15:02:39', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (95, '代码生成', 79, NULL, 1, 'F', NULL, '#', 'datatable_gen', NULL, '0', 6, '0', 'entfrm', '2020-03-25 15:03:06', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (96, '任务新增', 48, NULL, 1, 'F', NULL, '#', 'job_add', NULL, '0', 1, '0', 'entfrm', '2020-03-26 15:34:44', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (97, '任务编辑', 48, NULL, 1, 'F', NULL, '#', 'job_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-26 15:34:59', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (98, '任务删除', 48, NULL, 1, 'F', NULL, '#', 'job_del', NULL, '0', 3, '0', 'entfrm', '2020-03-26 15:35:17', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (99, '任务查看', 48, NULL, 1, 'F', NULL, '#', 'job_view', NULL, '0', 4, '0', 'entfrm', '2020-03-26 15:35:32', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (100, '任务暂停/启动', 48, NULL, 1, 'F', NULL, '#', 'job_changeStatus', NULL, '0', 5, '0', 'entfrm', '2020-03-26 15:37:16', 'entfrm', '2022-07-24 15:50:32', NULL, '0');
INSERT INTO `sys_menu` VALUES (101, '任务导出', 48, NULL, 1, 'F', NULL, '#', 'job_export', NULL, '0', 6, '0', 'entfrm', '2020-03-26 15:37:35', 'entfrm', '2022-07-24 15:50:49', NULL, '0');
INSERT INTO `sys_menu` VALUES (102, '任务日志导出', 48, NULL, 1, 'F', NULL, '#', 'jobLog_export', NULL, '0', 7, '0', 'entfrm', '2020-03-26 15:37:56', 'entfrm', '2022-07-24 15:51:11', NULL, '0');
INSERT INTO `sys_menu` VALUES (103, '任务日志查看', 48, NULL, 1, 'F', NULL, '#', 'jobLog_view', NULL, '0', 8, '0', 'entfrm', '2020-03-26 15:38:19', 'entfrm', '2020-03-26 15:38:35', NULL, '0');
INSERT INTO `sys_menu` VALUES (104, '任务日志删除', 48, NULL, 1, 'F', NULL, '#', 'jobLog_del', NULL, '0', 9, '0', 'entfrm', '2020-03-26 15:38:51', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (105, '快捷方式新增', 43, NULL, 1, 'F', NULL, '#', 'shortcut_add', NULL, '0', 1, '0', 'entfrm', '2020-03-27 09:44:13', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (106, '快捷方式修改', 43, NULL, 1, 'F', NULL, '#', 'shortcut_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-27 09:44:36', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (107, '快捷方式删除', 43, NULL, 1, 'F', NULL, '#', 'shortcut_del', NULL, '0', 3, '0', 'entfrm', '2020-03-27 09:44:57', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (108, '快捷方式查看', 43, NULL, 1, 'F', NULL, '#', 'shortcut_view', NULL, '0', 4, '0', 'entfrm', '2020-03-27 09:45:16', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (109, '数据源管理', 3, NULL, 2, 'C', 'dataset', 'toolkit/dataset/index', NULL, 'star', '1', 2, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2021-03-26 22:17:28', '数据源菜单', '0');
INSERT INTO `sys_menu` VALUES (110, '数据源新增', 109, NULL, 1, 'F', NULL, '#', 'dataset_add', '#', '1', 1, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (111, '数据源修改', 109, NULL, 1, 'F', NULL, '#', 'dataset_edit', '#', '1', 2, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (112, '数据源删除', 109, NULL, 1, 'F', NULL, '#', 'dataset_del', '#', '1', 3, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (113, '数据源查询', 109, NULL, 1, 'F', NULL, '#', 'dataset_view', '#', '1', 4, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (114, '数据源导出', 109, NULL, 1, 'F', NULL, '#', 'dataset_export', '#', '1', 5, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (138, '模板新增', 56, NULL, 1, 'F', NULL, '#', 'template_add', NULL, '1', 1, '0', 'entfrm', '2020-04-12 16:28:51', NULL, '2020-12-11 23:10:15', NULL, '1');
INSERT INTO `sys_menu` VALUES (139, '应用管理', 1, NULL, 1, 'C', 'application', 'system/application/index', NULL, 'tool', '1', 0, '0', 'entfrm', '2020-04-23 18:35:21', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` VALUES (140, '应用新增', 139, NULL, 1, 'F', NULL, '#', 'application_add', '#', '1', 1, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (141, '应用修改', 139, NULL, 1, 'F', NULL, '#', 'application_edit', '#', '1', 2, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (142, '应用删除', 139, NULL, 1, 'F', NULL, '#', 'application_del', '#', '1', 3, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (143, '应用查询', 139, NULL, 1, 'F', NULL, '#', 'application_view', '#', '1', 4, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (144, '应用导出', 139, NULL, 1, 'F', NULL, '#', 'application_export', '#', '1', 5, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (145, 'redis监控', 2, NULL, 1, 'C', 'redis', 'monitor/redis/index', NULL, 'component', '1', 5, '0', 'entfrm', '2020-04-24 22:26:31', 'entfrm', '2020-05-17 16:49:59', NULL, '0');
INSERT INTO `sys_menu` VALUES (146, '接口引擎', 3, NULL, 2, 'C', 'apiinfo', 'toolkit/apiinfo/index', NULL, 'star', '1', 5, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2021-03-26 21:59:08', '接口菜单', '0');
INSERT INTO `sys_menu` VALUES (147, '接口新增', 146, NULL, 1, 'F', NULL, '#', 'apiinfo_add', '#', '1', 1, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (148, '接口修改', 146, NULL, 1, 'F', NULL, '#', 'apiinfo_edit', '#', '1', 2, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (149, '接口删除', 146, NULL, 1, 'F', NULL, '#', 'apiinfo_del', '#', '1', 3, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (150, '接口查询', 146, NULL, 1, 'F', NULL, '#', 'apiinfo_view', '#', '1', 4, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (151, '接口导出', 146, NULL, 1, 'F', NULL, '#', 'apiinfo_export', '#', '1', 5, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` VALUES (229, '表单管理', 3, NULL, 1, 'C', 'form', 'toolkit/form/index', '', 'build', '1', 3, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2021-03-27 09:12:41', '表单管理菜单', '0');
INSERT INTO `sys_menu` VALUES (230, '表单管理新增', 229, NULL, 1, 'F', '', '#', 'form_add', '#', '1', 1, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', '', '0');
INSERT INTO `sys_menu` VALUES (231, '表单管理修改', 229, NULL, 1, 'F', '', '#', 'form_edit', '#', '1', 2, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', '', '0');
INSERT INTO `sys_menu` VALUES (232, '表单管理删除', 229, NULL, 1, 'F', '', '#', 'form_del', '#', '1', 3, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', '', '0');
INSERT INTO `sys_menu` VALUES (233, '表单管理查询', 229, NULL, 1, 'F', '', '#', 'form_view', '#', '1', 4, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', '', '0');
INSERT INTO `sys_menu` VALUES (234, '表单管理导出', 229, NULL, 1, 'F', '', '#', 'form_export', '#', '1', 5, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', '', '0');
INSERT INTO `sys_menu` VALUES (235, '表单设计', 229, NULL, 2, 'F', NULL, '#', 'form_design', NULL, '1', 6, '0', 'entfrm', '2021-03-26 23:33:55', NULL, NULL, NULL, '0');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志编号',
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `user_agent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '用户代理',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `client_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '终端',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '错误消息',
  `execute_time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '执行时间',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, '0', '用户登录', 'POST', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'entfrm', 'pc', '/system/login', '127.0.0.1', '0|0|0|内网IP|内网IP', '', 0, '', '0', '2022-07-24 15:19:44');
INSERT INTO `sys_oper_log` VALUES (2, '1', '新建/配置表', 'POST', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'entfrm', 'pc', '/toolkit/datatable/getGenTable', '127.0.0.1', '0|0|0|内网IP|内网IP', '', 0, '', '0', '2022-07-24 15:27:55');
INSERT INTO `sys_oper_log` VALUES (3, '0', '用户登录', 'POST', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'entfrm', 'pc', '/system/login', '127.0.0.1', '0|0|0|内网IP|内网IP', '', 0, '', '0', '2022-07-24 15:34:01');
INSERT INTO `sys_oper_log` VALUES (4, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'entfrm', 'pc', '/system/menu/update', '127.0.0.1', '0|0|0|内网IP|内网IP', '', 0, '', '0', '2022-07-24 15:50:31');
INSERT INTO `sys_oper_log` VALUES (5, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'entfrm', 'pc', '/system/menu/update', '127.0.0.1', '0|0|0|内网IP|内网IP', '', 0, '', '30', '2022-07-24 15:50:49');
INSERT INTO `sys_oper_log` VALUES (6, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'entfrm', 'pc', '/system/menu/update', '127.0.0.1', '0|0|0|内网IP|内网IP', '', 0, '', '14', '2022-07-24 15:51:11');
INSERT INTO `sys_oper_log` VALUES (7, '0', '用户登录', 'POST', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'entfrm', 'pc', '/system/login', '127.0.0.1', '0|0|0|内网IP|内网IP', '', 0, '', '16', '2022-07-24 15:51:21');
INSERT INTO `sys_oper_log` VALUES (8, '1', '删除定时任务', 'DELETE', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36', 'entfrm', 'pc', '/quartz/job/4', '127.0.0.1', '0|0|0|内网IP|内网IP', '', 0, '', '69', '2022-07-24 15:54:57');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
  `code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色代码',
  `applications` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属应用',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '2' COMMENT '数据权限范围',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态',
  `create_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', 'admin', 'app1,app2', '1', 1, '0', 'entfrm', '2020-03-13 20:54:34', 'entfrm', '2020-08-02 21:44:58', NULL, '0');
INSERT INTO `sys_role` VALUES (2, '测试角色', 'test', 'app1', '2', 1, '0', 'entfrm', '2020-03-14 18:15:51', 'entfrm', '2020-08-02 21:44:57', NULL, '0');
INSERT INTO `sys_role` VALUES (3, '测试', 'cs', 'app1', '2', 0, '0', 'entfrm', '2021-07-27 00:16:34', NULL, '2021-07-27 00:16:58', NULL, '1');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `dept_id` int(11) NOT NULL COMMENT '部门ID'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` int(11) NULL DEFAULT NULL,
  `menu_id` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 11);
INSERT INTO `sys_role_menu` VALUES (2, 16);
INSERT INTO `sys_role_menu` VALUES (2, 7);
INSERT INTO `sys_role_menu` VALUES (2, 25);
INSERT INTO `sys_role_menu` VALUES (2, 26);
INSERT INTO `sys_role_menu` VALUES (2, 27);
INSERT INTO `sys_role_menu` VALUES (2, 28);
INSERT INTO `sys_role_menu` VALUES (2, 33);
INSERT INTO `sys_role_menu` VALUES (2, 78);
INSERT INTO `sys_role_menu` VALUES (2, 81);
INSERT INTO `sys_role_menu` VALUES (2, 82);
INSERT INTO `sys_role_menu` VALUES (2, 83);
INSERT INTO `sys_role_menu` VALUES (2, 84);
INSERT INTO `sys_role_menu` VALUES (2, 79);
INSERT INTO `sys_role_menu` VALUES (2, 90);
INSERT INTO `sys_role_menu` VALUES (2, 91);
INSERT INTO `sys_role_menu` VALUES (2, 92);
INSERT INTO `sys_role_menu` VALUES (2, 93);
INSERT INTO `sys_role_menu` VALUES (2, 94);
INSERT INTO `sys_role_menu` VALUES (2, 95);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 55);
INSERT INTO `sys_role_menu` VALUES (2, 57);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 5);
INSERT INTO `sys_role_menu` VALUES (2, 29);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (3, 109);
INSERT INTO `sys_role_menu` VALUES (3, 110);
INSERT INTO `sys_role_menu` VALUES (3, 111);
INSERT INTO `sys_role_menu` VALUES (3, 112);
INSERT INTO `sys_role_menu` VALUES (3, 113);
INSERT INTO `sys_role_menu` VALUES (3, 114);
INSERT INTO `sys_role_menu` VALUES (3, 3);
INSERT INTO `sys_role_menu` VALUES (1, 139);
INSERT INTO `sys_role_menu` VALUES (1, 140);
INSERT INTO `sys_role_menu` VALUES (1, 141);
INSERT INTO `sys_role_menu` VALUES (1, 142);
INSERT INTO `sys_role_menu` VALUES (1, 143);
INSERT INTO `sys_role_menu` VALUES (1, 144);
INSERT INTO `sys_role_menu` VALUES (1, 4);
INSERT INTO `sys_role_menu` VALUES (1, 8);
INSERT INTO `sys_role_menu` VALUES (1, 9);
INSERT INTO `sys_role_menu` VALUES (1, 10);
INSERT INTO `sys_role_menu` VALUES (1, 11);
INSERT INTO `sys_role_menu` VALUES (1, 12);
INSERT INTO `sys_role_menu` VALUES (1, 5);
INSERT INTO `sys_role_menu` VALUES (1, 13);
INSERT INTO `sys_role_menu` VALUES (1, 14);
INSERT INTO `sys_role_menu` VALUES (1, 15);
INSERT INTO `sys_role_menu` VALUES (1, 16);
INSERT INTO `sys_role_menu` VALUES (1, 17);
INSERT INTO `sys_role_menu` VALUES (1, 6);
INSERT INTO `sys_role_menu` VALUES (1, 18);
INSERT INTO `sys_role_menu` VALUES (1, 19);
INSERT INTO `sys_role_menu` VALUES (1, 20);
INSERT INTO `sys_role_menu` VALUES (1, 21);
INSERT INTO `sys_role_menu` VALUES (1, 22);
INSERT INTO `sys_role_menu` VALUES (1, 23);
INSERT INTO `sys_role_menu` VALUES (1, 24);
INSERT INTO `sys_role_menu` VALUES (1, 7);
INSERT INTO `sys_role_menu` VALUES (1, 25);
INSERT INTO `sys_role_menu` VALUES (1, 26);
INSERT INTO `sys_role_menu` VALUES (1, 27);
INSERT INTO `sys_role_menu` VALUES (1, 28);
INSERT INTO `sys_role_menu` VALUES (1, 29);
INSERT INTO `sys_role_menu` VALUES (1, 30);
INSERT INTO `sys_role_menu` VALUES (1, 31);
INSERT INTO `sys_role_menu` VALUES (1, 32);
INSERT INTO `sys_role_menu` VALUES (1, 33);
INSERT INTO `sys_role_menu` VALUES (1, 34);
INSERT INTO `sys_role_menu` VALUES (1, 35);
INSERT INTO `sys_role_menu` VALUES (1, 36);
INSERT INTO `sys_role_menu` VALUES (1, 37);
INSERT INTO `sys_role_menu` VALUES (1, 38);
INSERT INTO `sys_role_menu` VALUES (1, 39);
INSERT INTO `sys_role_menu` VALUES (1, 40);
INSERT INTO `sys_role_menu` VALUES (1, 41);
INSERT INTO `sys_role_menu` VALUES (1, 42);
INSERT INTO `sys_role_menu` VALUES (1, 43);
INSERT INTO `sys_role_menu` VALUES (1, 105);
INSERT INTO `sys_role_menu` VALUES (1, 106);
INSERT INTO `sys_role_menu` VALUES (1, 107);
INSERT INTO `sys_role_menu` VALUES (1, 108);
INSERT INTO `sys_role_menu` VALUES (1, 44);
INSERT INTO `sys_role_menu` VALUES (1, 73);
INSERT INTO `sys_role_menu` VALUES (1, 74);
INSERT INTO `sys_role_menu` VALUES (1, 75);
INSERT INTO `sys_role_menu` VALUES (1, 76);
INSERT INTO `sys_role_menu` VALUES (1, 77);
INSERT INTO `sys_role_menu` VALUES (1, 48);
INSERT INTO `sys_role_menu` VALUES (1, 96);
INSERT INTO `sys_role_menu` VALUES (1, 97);
INSERT INTO `sys_role_menu` VALUES (1, 98);
INSERT INTO `sys_role_menu` VALUES (1, 99);
INSERT INTO `sys_role_menu` VALUES (1, 100);
INSERT INTO `sys_role_menu` VALUES (1, 101);
INSERT INTO `sys_role_menu` VALUES (1, 102);
INSERT INTO `sys_role_menu` VALUES (1, 103);
INSERT INTO `sys_role_menu` VALUES (1, 104);
INSERT INTO `sys_role_menu` VALUES (1, 50);
INSERT INTO `sys_role_menu` VALUES (1, 145);
INSERT INTO `sys_role_menu` VALUES (1, 51);
INSERT INTO `sys_role_menu` VALUES (1, 52);
INSERT INTO `sys_role_menu` VALUES (1, 54);
INSERT INTO `sys_role_menu` VALUES (1, 66);
INSERT INTO `sys_role_menu` VALUES (1, 67);
INSERT INTO `sys_role_menu` VALUES (1, 68);
INSERT INTO `sys_role_menu` VALUES (1, 3);
INSERT INTO `sys_role_menu` VALUES (1, 78);
INSERT INTO `sys_role_menu` VALUES (1, 81);
INSERT INTO `sys_role_menu` VALUES (1, 82);
INSERT INTO `sys_role_menu` VALUES (1, 83);
INSERT INTO `sys_role_menu` VALUES (1, 84);
INSERT INTO `sys_role_menu` VALUES (1, 79);
INSERT INTO `sys_role_menu` VALUES (1, 90);
INSERT INTO `sys_role_menu` VALUES (1, 91);
INSERT INTO `sys_role_menu` VALUES (1, 92);
INSERT INTO `sys_role_menu` VALUES (1, 93);
INSERT INTO `sys_role_menu` VALUES (1, 94);
INSERT INTO `sys_role_menu` VALUES (1, 95);
INSERT INTO `sys_role_menu` VALUES (1, 109);
INSERT INTO `sys_role_menu` VALUES (1, 110);
INSERT INTO `sys_role_menu` VALUES (1, 111);
INSERT INTO `sys_role_menu` VALUES (1, 112);
INSERT INTO `sys_role_menu` VALUES (1, 113);
INSERT INTO `sys_role_menu` VALUES (1, 114);
INSERT INTO `sys_role_menu` VALUES (1, 229);
INSERT INTO `sys_role_menu` VALUES (1, 230);
INSERT INTO `sys_role_menu` VALUES (1, 231);
INSERT INTO `sys_role_menu` VALUES (1, 232);
INSERT INTO `sys_role_menu` VALUES (1, 233);
INSERT INTO `sys_role_menu` VALUES (1, 234);
INSERT INTO `sys_role_menu` VALUES (1, 235);
INSERT INTO `sys_role_menu` VALUES (1, 55);
INSERT INTO `sys_role_menu` VALUES (1, 146);
INSERT INTO `sys_role_menu` VALUES (1, 147);
INSERT INTO `sys_role_menu` VALUES (1, 148);
INSERT INTO `sys_role_menu` VALUES (1, 149);
INSERT INTO `sys_role_menu` VALUES (1, 150);
INSERT INTO `sys_role_menu` VALUES (1, 151);
INSERT INTO `sys_role_menu` VALUES (1, 1);
INSERT INTO `sys_role_menu` VALUES (1, 2);

-- ----------------------------
-- Table structure for sys_shortcut
-- ----------------------------
DROP TABLE IF EXISTS `sys_shortcut`;
CREATE TABLE `sys_shortcut`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `region` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `bg_color` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#409EFF' COMMENT '背景颜色',
  `path` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路径',
  `sort` int(11) NULL DEFAULT NULL COMMENT '顺序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_shortcut
-- ----------------------------
INSERT INTO `sys_shortcut` VALUES (1, '登录日志', '2', 'form', '#2883CD', 'monitor/log/loginLog', 1, 'entfrm', '2020-03-27 10:09:11', '', '2020-03-27 10:12:39', '1', '0');
INSERT INTO `sys_shortcut` VALUES (2, '内容管理', '2', 'edit', '#EB7024', '/cms/article', 2, 'entfrm', '2020-04-15 22:44:58', '', '2020-06-02 08:59:06', NULL, '0');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `dept_id` int(11) NULL DEFAULT NULL COMMENT '机构ID',
  `dept_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '机构名称',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `qq` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'QQ',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登陆IP',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'entfrm', '管理员', '00', 'e10adc3949ba59abbe56e057f20f883e', 1, '重庆总公司', '111@qq.com', NULL, '15611111111', '0', '/profile/avatar/avatar1642606161598.png', '0', '', NULL, 'entfrm', '2020-03-13 20:56:44', '', NULL, '全栈工程师', '0');
INSERT INTO `sys_user` VALUES (2, 'test', '测试01', '00', 'e10adc3949ba59abbe56e057f20f883e', 1, '重庆总公司', '182@11.com', NULL, '15780454444', '0', '', '0', '', NULL, 'entfrm', '2020-03-14 18:14:11', '', '2022-01-15 13:53:59', NULL, '0');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` int(11) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (4, 2);
INSERT INTO `sys_user_role` VALUES (3, 2);
INSERT INTO `sys_user_role` VALUES (5, 2);
INSERT INTO `sys_user_role` VALUES (8, 2);
INSERT INTO `sys_user_role` VALUES (9, 2);
INSERT INTO `sys_user_role` VALUES (3, 1);
INSERT INTO `sys_user_role` VALUES (4, 1);
INSERT INTO `sys_user_role` VALUES (5, 1);
INSERT INTO `sys_user_role` VALUES (6, 1);
INSERT INTO `sys_user_role` VALUES (7, 1);
INSERT INTO `sys_user_role` VALUES (8, 1);
INSERT INTO `sys_user_role` VALUES (9, 1);
INSERT INTO `sys_user_role` VALUES (10, 1);
INSERT INTO `sys_user_role` VALUES (2, 1);

SET FOREIGN_KEY_CHECKS = 1;
