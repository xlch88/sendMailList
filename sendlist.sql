-- phpMyAdmin SQL Dump
-- version 5.0.0-alpha1
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2020-02-13 13:22:02
-- 服务器版本： 5.7.24
-- PHP 版本： 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `sendlist`
--

-- --------------------------------------------------------

--
-- 表的结构 `send_auth`
--

CREATE TABLE `send_auth` (
  `id` int(11) NOT NULL COMMENT '秘钥id',
  `secret` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '秘钥,32位长',
  `allowGid` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '允许使用的组id，用英文逗号分割'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `send_auth`
--

INSERT INTO `send_auth` (`id`, `secret`, `allowGid`) VALUES
(1, '12345678901234567890123456789012', '0');

-- --------------------------------------------------------

--
-- 表的结构 `send_mail`
--

CREATE TABLE `send_mail` (
  `id` int(11) NOT NULL,
  `gid` smallint(6) NOT NULL COMMENT '组id',
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '邮箱名',
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '邮箱密码',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '发件人名称',
  `host` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'smtp服务器',
  `port` smallint(11) NOT NULL COMMENT 'smtp端口'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `send_mail`
--

INSERT INTO `send_mail` (`id`, `gid`, `username`, `password`, `name`, `host`, `port`) VALUES
(1, 0, 'sendlist1@clogin.cn', '2333333', 'Clogin 系统邮件 [请勿回复]', 'smtp.exmail.qq.com', 465);

-- --------------------------------------------------------

--
-- 表的结构 `send_task`
--

CREATE TABLE `send_task` (
  `id` int(11) NOT NULL,
  `sender` int(11) NOT NULL COMMENT '发送组id',
  `target` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '目标邮箱',
  `subject` varchar(300) COLLATE utf8_unicode_ci NOT NULL COMMENT '标题',
  `body` text COLLATE utf8_unicode_ci NOT NULL COMMENT '内容',
  `altBody` text COLLATE utf8_unicode_ci NOT NULL COMMENT '简化内容',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=待发送,1=发送中,2=成功,3=失败',
  `addTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `endTime` datetime DEFAULT NULL COMMENT '完成时间',
  `error` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '错误信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `send_task`
--

INSERT INTO `send_task` (`id`, `sender`, `target`, `subject`, `body`, `altBody`, `status`, `addTime`, `endTime`, `error`) VALUES
(1, 0, 'i@xlch.me', '测试', '这是一份测试邮件，啦啦啦啦啦<div style=\"font-size:64px;\">啦啦</div>', '草', 0, '2020-02-13 20:25:11', NULL, NULL);

--
-- 转储表的索引
--

--
-- 表的索引 `send_auth`
--
ALTER TABLE `send_auth`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `send_mail`
--
ALTER TABLE `send_mail`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `send_task`
--
ALTER TABLE `send_task`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `send_auth`
--
ALTER TABLE `send_auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '秘钥id', AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `send_mail`
--
ALTER TABLE `send_mail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `send_task`
--
ALTER TABLE `send_task`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

