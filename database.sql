-- MySQL dump 10.13  Distrib 5.7.42, for Linux (x86_64)
--
-- Host: localhost    Database: gamersdecide_new
-- ------------------------------------------------------
-- Server version	5.7.42-0ubuntu0.18.04.1

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
-- Table structure for table `accesslog`
--

DROP TABLE IF EXISTS `accesslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accesslog` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique accesslog ID.',
  `sid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Browser session ID of user that visited page.',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title of page visited.',
  `path` varchar(255) DEFAULT NULL COMMENT 'Internal path to page visited (relative to Drupal root.)',
  `url` text COMMENT 'Referrer URI.',
  `hostname` varchar(128) DEFAULT NULL COMMENT 'Hostname of user that visited the page.',
  `uid` int(10) unsigned DEFAULT '0' COMMENT 'User users.uid that visited the page.',
  `timer` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Time in milliseconds that the page took to load.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Timestamp of when the page was visited.',
  PRIMARY KEY (`aid`),
  KEY `accesslog_timestamp` (`timestamp`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores site access information for statistics.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for any activity',
  `uid` int(10) unsigned NOT NULL COMMENT 'The user id of whomever performed the activity being recorded.',
  `type` varchar(50) NOT NULL COMMENT 'The hook that created this activity.',
  `nid` int(10) unsigned DEFAULT NULL COMMENT 'A foreign key used with node_access table. Can be NULL for all non-node, comment activities',
  `eid` int(10) unsigned DEFAULT NULL COMMENT 'Entity ID used to maintain the relationship between activity and the entity that created the activity',
  `created` int(10) unsigned NOT NULL COMMENT 'When the activity was recorded',
  `actions_id` int(10) unsigned NOT NULL COMMENT 'Id of the action stored in the actions table.',
  `argument1` longtext COMMENT 'Serialized value of first argument passed to the actions callback',
  `argument2` longtext COMMENT 'Serialized value of second argument passed to the actions callback',
  `status` tinyint(4) DEFAULT '1' COMMENT 'Whether or not this Activity is published',
  PRIMARY KEY (`aid`),
  KEY `nid` (`nid`),
  KEY `eid` (`eid`),
  KEY `created` (`created`)
) ENGINE=InnoDB AUTO_INCREMENT=4349 DEFAULT CHARSET=utf8 COMMENT='Provides a place to record activity messages for display.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity_access`
--

DROP TABLE IF EXISTS `activity_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_access` (
  `aid` int(10) unsigned NOT NULL COMMENT 'The primary identifier for an activity',
  `realm` varchar(255) NOT NULL COMMENT 'The module providing the access control',
  `value` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The provided value from the implementing module. E.g a uid, nid or a tid',
  PRIMARY KEY (`aid`,`realm`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Provides access control on a very granular level to...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity_messages`
--

DROP TABLE IF EXISTS `activity_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_messages` (
  `amid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The Unique id of the message',
  `message` longtext NOT NULL,
  PRIMARY KEY (`amid`)
) ENGINE=InnoDB AUTO_INCREMENT=655376 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `activity_targets`
--

DROP TABLE IF EXISTS `activity_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_targets` (
  `aid` int(10) unsigned NOT NULL COMMENT 'Foreign key to the activity table',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The uid for which this message is for',
  `amid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The message id for this uid/aid combination',
  `language` varchar(12) NOT NULL COMMENT 'The  IS0-3166 name of the langauge for the associated message.',
  PRIMARY KEY (`aid`,`uid`,`language`),
  UNIQUE KEY `amid` (`amid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad`
--

DROP TABLE IF EXISTS `ad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an advertisement, used internally only.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The ad_type.type of this advertisement.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this advertisement, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this advertisement.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Workflow status of advertisement.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the advertisement was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the advertisement was most recently saved.',
  PRIMARY KEY (`aid`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for ads.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ad_type`
--

DROP TABLE IF EXISTS `ad_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ad_type` (
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating an ad of this type.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined ad types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ajaxblocks`
--

DROP TABLE IF EXISTS `ajaxblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajaxblocks` (
  `block_id` varchar(255) NOT NULL COMMENT 'The primary identifier for a block.',
  `is_ajax` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the block is to be loaded via AJAX.',
  `loader_picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Loader picture index (0 - none).',
  `is_late` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether to use window.onload event.',
  `delay` int(11) NOT NULL DEFAULT '0' COMMENT 'Time to wait before block loading.',
  `include_noscript` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether to include noscript tag.',
  `cached_roles` varchar(1000) DEFAULT '1' COMMENT 'Roles for which the block is loaded via AJAX for cached pages.',
  `uncached_roles` varchar(1000) DEFAULT '' COMMENT 'Roles for which the block is loaded via AJAX for uncached pages.',
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores AJAX settings for blocks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authmap`
--

DROP TABLE IF EXISTS `authmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backup_migrate_destinations`
--

DROP TABLE IF EXISTS `backup_migrate_destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_migrate_destinations` (
  `destination_id` varchar(255) NOT NULL DEFAULT '0' COMMENT 'The primary identifier for a profile.',
  `name` varchar(255) NOT NULL COMMENT 'The name of the profile.',
  `type` varchar(32) NOT NULL COMMENT 'The type of the destination.',
  `location` text NOT NULL COMMENT 'The the location string of the destination.',
  `settings` text NOT NULL COMMENT 'Other settings for the destination.',
  PRIMARY KEY (`destination_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backup_migrate_profiles`
--

DROP TABLE IF EXISTS `backup_migrate_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_migrate_profiles` (
  `profile_id` varchar(255) NOT NULL DEFAULT '0' COMMENT 'The primary identifier for a profile.',
  `name` varchar(255) NOT NULL COMMENT 'The name of the profile.',
  `filename` varchar(255) NOT NULL COMMENT 'The name of the profile.',
  `append_timestamp` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Append a timestamp to the filename.',
  `timestamp_format` varchar(14) NOT NULL COMMENT 'The format of the timestamp.',
  `filters` text NOT NULL COMMENT 'The filter settings for the profile.',
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backup_migrate_schedules`
--

DROP TABLE IF EXISTS `backup_migrate_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_migrate_schedules` (
  `schedule_id` varchar(255) NOT NULL DEFAULT '0' COMMENT 'The primary identifier for a profile.',
  `name` varchar(255) NOT NULL COMMENT 'The name of the profile.',
  `source_id` varchar(255) NOT NULL DEFAULT 'db' COMMENT 'The backup_migrate_destination.destination_id of the source to backup from.',
  `destination_id` varchar(255) NOT NULL DEFAULT '0' COMMENT 'The backup_migrate_destination.destination_id of the destination to back up to.',
  `profile_id` varchar(255) NOT NULL DEFAULT '0' COMMENT 'The primary identifier for a profile.',
  `keep` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of backups to keep.',
  `period` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of seconds between backups.',
  `enabled` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Whether the schedule is enabled.',
  `cron` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Whether the schedule should be run during cron.',
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ban_user`
--

DROP TABLE IF EXISTS `ban_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ban_user` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique ban ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'user.uid identifier of the user.',
  `deadline` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the ban will be lifted.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the item created or changed.',
  PRIMARY KEY (`bid`),
  KEY `uid` (`uid`),
  KEY `deadline` (`deadline`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store data about temporarily banned users.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the `Pages` block; contains either a list of paths on which to include/exclude the block or PHP code, depending on `visibility` setting.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  `css_class` varchar(255) NOT NULL DEFAULT '' COMMENT 'String containing the classes for the block.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=1623 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block_custom`
--

DROP TABLE IF EXISTS `block_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block_node_type`
--

DROP TABLE IF EXISTS `block_node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block_role`
--

DROP TABLE IF EXISTS `block_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blocked_ips`
--

DROP TABLE IF EXISTS `blocked_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache__truncated_table`
--

DROP TABLE IF EXISTS `cache__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_admin_menu`
--

DROP TABLE IF EXISTS `cache_admin_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_admin_menu` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for Administration menu to store client-side...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_admin_menu__truncated_table`
--

DROP TABLE IF EXISTS `cache_admin_menu__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_admin_menu__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for Administration menu to store client-side...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_advagg_aggregates__truncated_table`
--

DROP TABLE IF EXISTS `cache_advagg_aggregates__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_advagg_aggregates__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for Advanced CSS/JS Aggregation. Used to keep...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_advagg_info__truncated_table`
--

DROP TABLE IF EXISTS `cache_advagg_info__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_advagg_info__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for Advanced CSS/JS Aggregation. Used to keep...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_block`
--

DROP TABLE IF EXISTS `cache_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_block` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_block__truncated_table`
--

DROP TABLE IF EXISTS `cache_block__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_block__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_bootstrap`
--

DROP TABLE IF EXISTS `cache_bootstrap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_bootstrap` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_bootstrap__truncated_table`
--

DROP TABLE IF EXISTS `cache_bootstrap__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_bootstrap__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_entity_message`
--

DROP TABLE IF EXISTS `cache_entity_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_entity_message` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store message entity records.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_entity_message_type`
--

DROP TABLE IF EXISTS `cache_entity_message_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_entity_message_type` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store message_type entity records.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_entity_message_type_category`
--

DROP TABLE IF EXISTS `cache_entity_message_type_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_entity_message_type_category` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store message_type_category entity...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_features`
--

DROP TABLE IF EXISTS `cache_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_features` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_features__truncated_table`
--

DROP TABLE IF EXISTS `cache_features__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_features__truncated_table` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_field`
--

DROP TABLE IF EXISTS `cache_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_field` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_filter`
--

DROP TABLE IF EXISTS `cache_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_filter` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_filter__truncated_table`
--

DROP TABLE IF EXISTS `cache_filter__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_filter__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_form`
--

DROP TABLE IF EXISTS `cache_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_form` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_hacked`
--

DROP TABLE IF EXISTS `cache_hacked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_hacked` (
  `cid` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Cache table for the Hacked! module. Holds hashes for the ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_image`
--

DROP TABLE IF EXISTS `cache_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_image` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_libraries`
--

DROP TABLE IF EXISTS `cache_libraries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_libraries` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table to store library information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_libraries__truncated_table`
--

DROP TABLE IF EXISTS `cache_libraries__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_libraries__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table to store library information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_mailchimp_user`
--

DROP TABLE IF EXISTS `cache_mailchimp_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_mailchimp_user` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the MailChimp module to store a list...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_mailchimp_user__truncated_table`
--

DROP TABLE IF EXISTS `cache_mailchimp_user__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_mailchimp_user__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the MailChimp module to store a list...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_media_xml`
--

DROP TABLE IF EXISTS `cache_media_xml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_media_xml` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the the results of retreived XML...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_menu`
--

DROP TABLE IF EXISTS `cache_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_menu` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_menu__truncated_table`
--

DROP TABLE IF EXISTS `cache_menu__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_menu__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_metatag`
--

DROP TABLE IF EXISTS `cache_metatag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_metatag` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the generated meta tag output.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_metatag__truncated_table`
--

DROP TABLE IF EXISTS `cache_metatag__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_metatag__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the generated meta tag output.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_page`
--

DROP TABLE IF EXISTS `cache_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_page` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_page__truncated_table`
--

DROP TABLE IF EXISTS `cache_page__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_page__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_panels`
--

DROP TABLE IF EXISTS `cache_panels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_panels` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_panels__truncated_table`
--

DROP TABLE IF EXISTS `cache_panels__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_panels__truncated_table` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_path`
--

DROP TABLE IF EXISTS `cache_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_path` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_path__truncated_table`
--

DROP TABLE IF EXISTS `cache_path__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_path__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_rules`
--

DROP TABLE IF EXISTS `cache_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_rules` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the rules engine to store configured items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_rules__truncated_table`
--

DROP TABLE IF EXISTS `cache_rules__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_rules__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the rules engine to store configured items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_token`
--

DROP TABLE IF EXISTS `cache_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_token` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for token information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_token__truncated_table`
--

DROP TABLE IF EXISTS `cache_token__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_token__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for token information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_update`
--

DROP TABLE IF EXISTS `cache_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_update` (
  `cid` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Cache table for the Update module to store information...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_update__truncated_table`
--

DROP TABLE IF EXISTS `cache_update__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_update__truncated_table` (
  `cid` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Cache table for the Update module to store information...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_views`
--

DROP TABLE IF EXISTS `cache_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_views` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_views__truncated_table`
--

DROP TABLE IF EXISTS `cache_views__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_views__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_views_data`
--

DROP TABLE IF EXISTS `cache_views_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_views_data` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '1' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for views to store pre-rendered queries,...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_views_data__truncated_table`
--

DROP TABLE IF EXISTS `cache_views_data__truncated_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_views_data__truncated_table` (
  `cid` varchar(255) NOT NULL,
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '1' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for views to store pre-rendered queries,...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `captcha_points`
--

DROP TABLE IF EXISTS `captcha_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha_points` (
  `form_id` varchar(128) NOT NULL DEFAULT '' COMMENT 'The form_id of the form to add a CAPTCHA to.',
  `module` varchar(64) DEFAULT NULL COMMENT 'The module that provides the challenge.',
  `captcha_type` varchar(64) DEFAULT NULL COMMENT 'The challenge type to use.',
  PRIMARY KEY (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table describes which challenges should be added to...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `captcha_sessions`
--

DROP TABLE IF EXISTS `captcha_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha_sessions` (
  `csid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'CAPTCHA session ID.',
  `token` varchar(64) DEFAULT NULL COMMENT 'One time CAPTCHA token.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `sid` varchar(64) NOT NULL DEFAULT '' COMMENT 'Session ID of the user.',
  `ip_address` varchar(128) DEFAULT NULL COMMENT 'IP address of the visitor.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the challenge was generated.',
  `form_id` varchar(128) NOT NULL COMMENT 'The form_id of the form where the CAPTCHA is added to.',
  `solution` varchar(128) NOT NULL DEFAULT '' COMMENT 'Solution of the challenge.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Status of the CAPTCHA session (unsolved, solved, ...)',
  `attempts` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of attempts.',
  PRIMARY KEY (`csid`),
  KEY `csid_ip` (`csid`,`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the data about CAPTCHA sessions (solution, IP...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ckeditor_input_format`
--

DROP TABLE IF EXISTS `ckeditor_input_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckeditor_input_format` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'Name of the CKEditor role',
  `format` varchar(128) NOT NULL DEFAULT '' COMMENT 'Drupal filter format ID',
  PRIMARY KEY (`name`,`format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores CKEditor input format assignments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ckeditor_settings`
--

DROP TABLE IF EXISTS `ckeditor_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckeditor_settings` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'Name of the CKEditor profile',
  `settings` text COMMENT 'Profile settings',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores CKEditor profile settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this comment.',
  PRIMARY KEY (`cid`),
  KEY `comment_status_pid` (`pid`,`status`),
  KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  KEY `comment_uid` (`uid`),
  KEY `comment_nid_language` (`nid`,`language`),
  KEY `comment_created` (`created`)
) ENGINE=InnoDB AUTO_INCREMENT=23055 DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `context`
--

DROP TABLE IF EXISTS `context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `context` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The primary identifier for a context.',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'Description for this context.',
  `tag` varchar(255) NOT NULL DEFAULT '' COMMENT 'Tag for this context.',
  `conditions` text COMMENT 'Serialized storage of all context condition settings.',
  `reactions` text COMMENT 'Serialized storage of all context reaction settings.',
  `condition_mode` int(11) DEFAULT '0' COMMENT 'Condition mode for this context.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Storage for normal (user-defined) contexts.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries_country`
--

DROP TABLE IF EXISTS `countries_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries_country` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique country ID. Required for the country bundle.',
  `iso2` char(2) NOT NULL COMMENT 'ISO 3166-1 alpha-2 country code.',
  `iso3` char(3) DEFAULT NULL COMMENT 'ISO 3166-1 alpha-3 country code.',
  `name` varchar(95) NOT NULL COMMENT 'ISO 3166-1 official short name.',
  `official_name` varchar(127) NOT NULL COMMENT 'ISO 3166-1 official long name.',
  `numcode` smallint(6) DEFAULT NULL COMMENT 'ISO 3166-1 numeric-3 country code.',
  `continent` char(2) NOT NULL COMMENT 'Continent code.',
  `enabled` int(11) NOT NULL DEFAULT '1' COMMENT 'Whether the country is enabled.',
  `language` varchar(12) NOT NULL DEFAULT 'und' COMMENT 'The languages.language of this node.',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `iso2` (`iso2`),
  UNIQUE KEY `name` (`name`),
  KEY `enabled` (`enabled`),
  KEY `continent` (`continent`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8 COMMENT='Maintains a country database.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctools_css_cache`
--

DROP TABLE IF EXISTS `ctools_css_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctools_css_cache` (
  `cid` varchar(128) NOT NULL COMMENT 'The CSS ID this cache object belongs to.',
  `filename` varchar(255) DEFAULT NULL COMMENT 'The filename this CSS is stored in.',
  `css` longtext COMMENT 'CSS being stored.',
  `filter` tinyint(4) DEFAULT NULL COMMENT 'Whether or not this CSS needs to be filtered.',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store CSS that must be non-volatile.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctools_object_cache`
--

DROP TABLE IF EXISTS `ctools_object_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctools_object_cache` (
  `sid` varchar(64) NOT NULL COMMENT 'The session ID this cache object belongs to.',
  `name` varchar(128) NOT NULL COMMENT 'The name of the object this cache is attached to.',
  `obj` varchar(128) NOT NULL COMMENT 'The type of the object this cache is attached to; this essentially represents the owner so that several sub-systems can use this cache.',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The time this cache was created or updated.',
  `data` longblob COMMENT 'Serialized data being stored.',
  PRIMARY KEY (`sid`,`obj`,`name`),
  KEY `updated` (`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store objects that are being...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `date_format_locale`
--

DROP TABLE IF EXISTS `date_format_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format_locale` (
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `date_format_type`
--

DROP TABLE IF EXISTS `date_format_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `date_formats`
--

DROP TABLE IF EXISTS `date_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_formats` (
  `dfid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dfp_tags`
--

DROP TABLE IF EXISTS `dfp_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dfp_tags` (
  `adid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `machinename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The tag’s unique name.',
  `slot` varchar(255) NOT NULL DEFAULT '' COMMENT 'The ad slot’s name.',
  `adunit` varchar(255) DEFAULT '' COMMENT 'The ad unit name.',
  `size` varchar(255) NOT NULL DEFAULT '' COMMENT 'The tag’s size(s).',
  `block` int(11) DEFAULT '1' COMMENT 'If true, a block will be created in which to display this ad tag.',
  `settings` longblob COMMENT 'Serialized array of settings.',
  PRIMARY KEY (`adid`),
  UNIQUE KEY `machinename` (`machinename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about DFP ad tags.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elysia_cron`
--

DROP TABLE IF EXISTS `elysia_cron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elysia_cron` (
  `name` varchar(120) NOT NULL,
  `disable` tinyint(4) DEFAULT NULL,
  `rule` varchar(256) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `context` varchar(32) DEFAULT NULL,
  `running` int(11) NOT NULL DEFAULT '0',
  `last_run` int(11) NOT NULL DEFAULT '0',
  `last_aborted` tinyint(4) NOT NULL DEFAULT '0',
  `abort_count` int(11) NOT NULL DEFAULT '0',
  `last_abort_function` varchar(128) DEFAULT NULL,
  `last_execution_time` int(11) NOT NULL DEFAULT '0',
  `execution_count` int(11) NOT NULL DEFAULT '0',
  `avg_execution_time` float NOT NULL DEFAULT '0',
  `max_execution_time` int(11) NOT NULL DEFAULT '0',
  `last_shutdown_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entity_modified`
--

DROP TABLE IF EXISTS `entity_modified`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_modified` (
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The entity type this modified tracker refers to.',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The entity ID this modified tracker refers to.',
  `modified` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the entity was most recently saved.',
  PRIMARY KEY (`entity_type`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Entity modification timestamps for entities that do not...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fb_social_preset`
--

DROP TABLE IF EXISTS `fb_social_preset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb_social_preset` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The primary identifier for a plugin preset.',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'Description for this plugin preset.',
  `plugin_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'Type of this preset.',
  `settings` text COMMENT 'Serialized storage of drupal related plugin settings.',
  `fb_attrs` text COMMENT 'Serialized storage of facebook related plugin settings',
  PRIMARY KEY (`name`),
  KEY `type` (`plugin_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Storage for user-defined fb plugins templates.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_config`
--

DROP TABLE IF EXISTS `field_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_config_instance`
--

DROP TABLE IF EXISTS `field_config_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_body`
--

DROP TABLE IF EXISTS `field_data_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_comment_body`
--

DROP TABLE IF EXISTS `field_data_comment_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_5star_rating`
--

DROP TABLE IF EXISTS `field_data_field_5star_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_5star_rating` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_5star_rating_rating` int(10) unsigned DEFAULT NULL,
  `field_5star_rating_target` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 25 (field_5star_rating)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field__trailer_theme`
--

DROP TABLE IF EXISTS `field_data_field__trailer_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field__trailer_theme` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field__trailer_theme_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field__trailer_theme_value` (`field__trailer_theme_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 61 (field__trailer_theme)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_about`
--

DROP TABLE IF EXISTS `field_data_field_about`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_about` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_about_value` longtext,
  `field_about_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_about_format` (`field_about_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 170 (field_about)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ad_category`
--

DROP TABLE IF EXISTS `field_data_field_ad_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ad_category` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_category_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_category_tid` (`field_ad_category_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 96 (field_ad_category)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ad_end_date`
--

DROP TABLE IF EXISTS `field_data_field_ad_end_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ad_end_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_end_date_value` varchar(255) DEFAULT NULL,
  `field_ad_end_date_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_end_date_format` (`field_ad_end_date_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 98 (field_ad_end_date)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ad_flash`
--

DROP TABLE IF EXISTS `field_data_field_ad_flash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ad_flash` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_flash_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_ad_flash_display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
  `field_ad_flash_description` text COMMENT 'A description of the file.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_flash_fid` (`field_ad_flash_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 93 (field_ad_flash)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ad_image`
--

DROP TABLE IF EXISTS `field_data_field_ad_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ad_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_ad_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_ad_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_ad_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_ad_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_image_fid` (`field_ad_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 92 (field_ad_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ad_start_date`
--

DROP TABLE IF EXISTS `field_data_field_ad_start_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ad_start_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_start_date_value` varchar(255) DEFAULT NULL,
  `field_ad_start_date_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_start_date_format` (`field_ad_start_date_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 97 (field_ad_start_date)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ad_status`
--

DROP TABLE IF EXISTS `field_data_field_ad_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ad_status` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_status_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_status_value` (`field_ad_status_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 100 (field_ad_status)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ad_text`
--

DROP TABLE IF EXISTS `field_data_field_ad_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ad_text` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_text_value` varchar(255) DEFAULT NULL,
  `field_ad_text_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_text_format` (`field_ad_text_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 94 (field_ad_text)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ad_type`
--

DROP TABLE IF EXISTS `field_data_field_ad_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ad_type` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_type_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_type_value` (`field_ad_type_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 91 (field_ad_type)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ad_url`
--

DROP TABLE IF EXISTS `field_data_field_ad_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ad_url` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_url_value` varchar(255) DEFAULT NULL,
  `field_ad_url_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_url_format` (`field_ad_url_format`),
  FULLTEXT KEY `similar` (`field_ad_url_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 95 (field_ad_url)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ad_url_taget`
--

DROP TABLE IF EXISTS `field_data_field_ad_url_taget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ad_url_taget` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_url_taget_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_url_taget_value` (`field_ad_url_taget_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 99 (field_ad_url_taget)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_adcamp_click`
--

DROP TABLE IF EXISTS `field_data_field_adcamp_click`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_adcamp_click` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_click_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_click_value` (`field_adcamp_click_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 104 (field_adcamp_click)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_adcamp_clicks`
--

DROP TABLE IF EXISTS `field_data_field_adcamp_clicks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_adcamp_clicks` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_clicks_value` varchar(255) DEFAULT NULL,
  `field_adcamp_clicks_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_clicks_format` (`field_adcamp_clicks_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 105 (field_adcamp_clicks)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_adcamp_day`
--

DROP TABLE IF EXISTS `field_data_field_adcamp_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_adcamp_day` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_day_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_day_value` (`field_adcamp_day_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 106 (field_adcamp_day)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_adcamp_days`
--

DROP TABLE IF EXISTS `field_data_field_adcamp_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_adcamp_days` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_days_value` varchar(255) DEFAULT NULL,
  `field_adcamp_days_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_days_format` (`field_adcamp_days_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 107 (field_adcamp_days)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_adcamp_impression`
--

DROP TABLE IF EXISTS `field_data_field_adcamp_impression`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_adcamp_impression` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_impression_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_impression_value` (`field_adcamp_impression_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 102 (field_adcamp_impression)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_adcamp_impressions`
--

DROP TABLE IF EXISTS `field_data_field_adcamp_impressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_adcamp_impressions` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_impressions_value` varchar(255) DEFAULT NULL,
  `field_adcamp_impressions_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_impressions_format` (`field_adcamp_impressions_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 103 (field_adcamp_impressions)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_adcamp_list`
--

DROP TABLE IF EXISTS `field_data_field_adcamp_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_adcamp_list` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_list_value` varchar(255) DEFAULT NULL,
  `field_adcamp_list_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_list_format` (`field_adcamp_list_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 101 (field_adcamp_list)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_adcamp_start`
--

DROP TABLE IF EXISTS `field_data_field_adcamp_start`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_adcamp_start` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_start_value` varchar(255) DEFAULT NULL,
  `field_adcamp_start_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_start_format` (`field_adcamp_start_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 108 (field_adcamp_start)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_average_vote`
--

DROP TABLE IF EXISTS `field_data_field_average_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_average_vote` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_average_vote_value` float DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 84 (field_average_vote)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_background_colour`
--

DROP TABLE IF EXISTS `field_data_field_background_colour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_background_colour` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_background_colour_value` varchar(255) DEFAULT NULL,
  `field_background_colour_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_background_colour_format` (`field_background_colour_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 150 (field_background_colour)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_background_image`
--

DROP TABLE IF EXISTS `field_data_field_background_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_background_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_background_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_background_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_background_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_background_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_background_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_background_image_fid` (`field_background_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 148 (field_background_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_background_image_opacity`
--

DROP TABLE IF EXISTS `field_data_field_background_image_opacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_background_image_opacity` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_background_image_opacity_value` float DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 151 (field_background_image_opacity)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_best_game_rank`
--

DROP TABLE IF EXISTS `field_data_field_best_game_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_best_game_rank` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_best_game_rank_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 82 (field_best_game_rank)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_birthday`
--

DROP TABLE IF EXISTS `field_data_field_birthday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_birthday` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_birthday_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 54 (field_birthday)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_body`
--

DROP TABLE IF EXISTS `field_data_field_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_body_value` longtext,
  `field_body_summary` longtext,
  `field_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_body_format` (`field_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 80 (field_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_body_html`
--

DROP TABLE IF EXISTS `field_data_field_body_html`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_body_html` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_body_html_value` longtext,
  `field_body_html_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_body_html_format` (`field_body_html_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 149 (field_body_html)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_box_background_color`
--

DROP TABLE IF EXISTS `field_data_field_box_background_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_box_background_color` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_box_background_color_value` varchar(255) DEFAULT NULL,
  `field_box_background_color_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_box_background_color_format` (`field_box_background_color_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 58 (field_box_background_color)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_box_position`
--

DROP TABLE IF EXISTS `field_data_field_box_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_box_position` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_box_position_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_box_position_value` (`field_box_position_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 57 (field_box_position)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_breaking_news`
--

DROP TABLE IF EXISTS `field_data_field_breaking_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_breaking_news` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_breaking_news_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_breaking_news_value` (`field_breaking_news_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 160 (field_breaking_news)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_brief_introduction`
--

DROP TABLE IF EXISTS `field_data_field_brief_introduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_brief_introduction` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_brief_introduction_value` longtext,
  `field_brief_introduction_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_brief_introduction_format` (`field_brief_introduction_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 62 (field_brief_introduction)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_buy_now_button`
--

DROP TABLE IF EXISTS `field_data_field_buy_now_button`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_buy_now_button` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_buy_now_button_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_buy_now_button_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_buy_now_button_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_buy_now_button_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_buy_now_button_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_buy_now_button_fid` (`field_buy_now_button_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 136 (field_buy_now_button)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_buy_now_game`
--

DROP TABLE IF EXISTS `field_data_field_buy_now_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_buy_now_game` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_buy_now_game_url` varchar(2048) DEFAULT NULL,
  `field_buy_now_game_title` varchar(255) DEFAULT NULL,
  `field_buy_now_game_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 22 (field_buy_now_game)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_coming_soon`
--

DROP TABLE IF EXISTS `field_data_field_coming_soon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_coming_soon` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_coming_soon_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_coming_soon_value` (`field_coming_soon_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 20 (field_coming_soon)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_comment`
--

DROP TABLE IF EXISTS `field_data_field_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_comment` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_comment_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_comment_target_id` (`field_comment_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 124 (field_comment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_comment_author`
--

DROP TABLE IF EXISTS `field_data_field_comment_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_comment_author` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_comment_author_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_comment_author_target_id` (`field_comment_author_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 123 (field_comment_author)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_contact_me`
--

DROP TABLE IF EXISTS `field_data_field_contact_me`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_contact_me` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_contact_me_url` varchar(2048) DEFAULT NULL,
  `field_contact_me_title` varchar(255) DEFAULT NULL,
  `field_contact_me_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 145 (field_contact_me)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_country`
--

DROP TABLE IF EXISTS `field_data_field_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_country` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_country_iso2` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_country_iso2` (`field_country_iso2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 55 (field_country)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_creation_ip`
--

DROP TABLE IF EXISTS `field_data_field_creation_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_creation_ip` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_creation_ip_value` varchar(255) DEFAULT NULL,
  `field_creation_ip_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_creation_ip_format` (`field_creation_ip_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 86 (field_creation_ip)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_currently_playing`
--

DROP TABLE IF EXISTS `field_data_field_currently_playing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_currently_playing` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_currently_playing_value` varchar(255) DEFAULT NULL,
  `field_currently_playing_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_currently_playing_format` (`field_currently_playing_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 40 (field_currently_playing)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_date_to_publish`
--

DROP TABLE IF EXISTS `field_data_field_date_to_publish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_date_to_publish` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_date_to_publish_value` datetime DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 141 (field_date_to_publish)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_day_of_birth`
--

DROP TABLE IF EXISTS `field_data_field_day_of_birth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_day_of_birth` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_day_of_birth_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_day_of_birth_value` (`field_day_of_birth_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 74 (field_day_of_birth)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_developer_name`
--

DROP TABLE IF EXISTS `field_data_field_developer_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_developer_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_developer_name_url` varchar(2048) DEFAULT NULL,
  `field_developer_name_title` varchar(255) DEFAULT NULL,
  `field_developer_name_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 34 (field_developer_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_dfp_ad_categories`
--

DROP TABLE IF EXISTS `field_data_field_dfp_ad_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_dfp_ad_categories` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_dfp_ad_categories_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_dfp_ad_categories_tid` (`field_dfp_ad_categories_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 134 (field_dfp_ad_categories)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_discount_percentage`
--

DROP TABLE IF EXISTS `field_data_field_discount_percentage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_discount_percentage` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_discount_percentage_value` float DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 140 (field_discount_percentage)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_discount_price`
--

DROP TABLE IF EXISTS `field_data_field_discount_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_discount_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_discount_price_value` float DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 139 (field_discount_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_email`
--

DROP TABLE IF EXISTS `field_data_field_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_email` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_email_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 162 (field_email)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_enabled`
--

DROP TABLE IF EXISTS `field_data_field_enabled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_enabled` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_enabled_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_enabled_value` (`field_enabled_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 155 (field_enabled)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ext_dame_description`
--

DROP TABLE IF EXISTS `field_data_field_ext_dame_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ext_dame_description` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ext_dame_description_value` longtext,
  `field_ext_dame_description_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ext_dame_description_format` (`field_ext_dame_description_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 174 (field_ext_dame_description)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ext_game_genre`
--

DROP TABLE IF EXISTS `field_data_field_ext_game_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ext_game_genre` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ext_game_genre_value` varchar(255) DEFAULT NULL,
  `field_ext_game_genre_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ext_game_genre_format` (`field_ext_game_genre_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 173 (field_ext_game_genre)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ext_image`
--

DROP TABLE IF EXISTS `field_data_field_ext_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ext_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ext_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_ext_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_ext_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_ext_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_ext_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ext_image_fid` (`field_ext_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 172 (field_ext_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ext_link`
--

DROP TABLE IF EXISTS `field_data_field_ext_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ext_link` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ext_link_url` varchar(2048) DEFAULT NULL,
  `field_ext_link_title` varchar(255) DEFAULT NULL,
  `field_ext_link_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 171 (field_ext_link)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_favorite_game`
--

DROP TABLE IF EXISTS `field_data_field_favorite_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_favorite_game` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_favorite_game_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_favorite_game_target_id` (`field_favorite_game_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 57 (field_favorite_game)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_favorite_genre`
--

DROP TABLE IF EXISTS `field_data_field_favorite_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_favorite_genre` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_favorite_genre_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_favorite_genre_value` (`field_favorite_genre_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 88 (field_favorite_genre)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_feature_this_article`
--

DROP TABLE IF EXISTS `field_data_field_feature_this_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_feature_this_article` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_feature_this_article_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_feature_this_article_value` (`field_feature_this_article_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 175 (field_feature_this_article)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_featured`
--

DROP TABLE IF EXISTS `field_data_field_featured`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_featured` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_featured_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_featured_value` (`field_featured_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 30 (field_featured)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_featured_image`
--

DROP TABLE IF EXISTS `field_data_field_featured_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_featured_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_featured_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_featured_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_featured_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_featured_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_featured_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_featured_image_fid` (`field_featured_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 63 (field_featured_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_featured_trailer`
--

DROP TABLE IF EXISTS `field_data_field_featured_trailer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_featured_trailer` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_featured_trailer_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_featured_trailer_value` (`field_featured_trailer_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 64 (field_featured_trailer)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_first_name`
--

DROP TABLE IF EXISTS `field_data_field_first_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_first_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_first_name_value` varchar(255) DEFAULT NULL,
  `field_first_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_first_name_format` (`field_first_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 71 (field_first_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_firstname`
--

DROP TABLE IF EXISTS `field_data_field_firstname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_firstname` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_firstname_value` varchar(255) DEFAULT NULL,
  `field_firstname_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_firstname_format` (`field_firstname_format`),
  FULLTEXT KEY `similar` (`field_firstname_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 51 (field_firstname)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_full_name`
--

DROP TABLE IF EXISTS `field_data_field_full_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_full_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_full_name_value` varchar(255) DEFAULT NULL,
  `field_full_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_full_name_format` (`field_full_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 38 (field_full_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_game_genre`
--

DROP TABLE IF EXISTS `field_data_field_game_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_game_genre` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_game_genre_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_game_genre_tid` (`field_game_genre_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 9 (field_game_genre)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_game_image`
--

DROP TABLE IF EXISTS `field_data_field_game_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_game_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_game_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_game_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_game_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_game_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_game_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_game_image_fid` (`field_game_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 13 (field_game_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_game_node`
--

DROP TABLE IF EXISTS `field_data_field_game_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_game_node` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_game_node_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_game_node_target_id` (`field_game_node_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 66 (field_game_node)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_game_system_requirements`
--

DROP TABLE IF EXISTS `field_data_field_game_system_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_game_system_requirements` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_game_system_requirements_value` longtext,
  `field_game_system_requirements_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_game_system_requirements_format` (`field_game_system_requirements_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 19 (field_game_system_requirements)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_game_trailer`
--

DROP TABLE IF EXISTS `field_data_field_game_trailer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_game_trailer` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_game_trailer_fid` int(10) unsigned DEFAULT NULL,
  `field_game_trailer_title` varchar(255) DEFAULT NULL,
  `field_game_trailer_data` longtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_game_trailer_fid` (`field_game_trailer_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 14 (field_game_trailer)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_gamer_age`
--

DROP TABLE IF EXISTS `field_data_field_gamer_age`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_gamer_age` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_gamer_age_value` varchar(255) DEFAULT NULL,
  `field_gamer_age_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_gamer_age_format` (`field_gamer_age_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 42 (field_gamer_age)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_gamer_since`
--

DROP TABLE IF EXISTS `field_data_field_gamer_since`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_gamer_since` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_gamer_since_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_gamer_since_value` (`field_gamer_since_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 41 (field_gamer_since)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_gender`
--

DROP TABLE IF EXISTS `field_data_field_gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_gender` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_gender_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_gender_value` (`field_gender_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 53 (field_gender)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_headline`
--

DROP TABLE IF EXISTS `field_data_field_headline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_headline` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_headline_value` longtext,
  `field_headline_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_headline_format` (`field_headline_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 52 (field_headline)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_home_page_hero_image`
--

DROP TABLE IF EXISTS `field_data_field_home_page_hero_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_home_page_hero_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_home_page_hero_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_home_page_hero_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_home_page_hero_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_home_page_hero_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_home_page_hero_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_home_page_hero_image_fid` (`field_home_page_hero_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 168 (field_home_page_hero_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_image`
--

DROP TABLE IF EXISTS `field_data_field_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_image_gallery`
--

DROP TABLE IF EXISTS `field_data_field_image_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_image_gallery` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_gallery_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_gallery_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_gallery_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_gallery_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_gallery_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_gallery_fid` (`field_image_gallery_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 129 (field_image_gallery)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_image_url`
--

DROP TABLE IF EXISTS `field_data_field_image_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_image_url` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_url_value` varchar(255) DEFAULT NULL,
  `field_image_url_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_url_format` (`field_image_url_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 55 (field_image_url)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_img`
--

DROP TABLE IF EXISTS `field_data_field_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_img` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_img_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_img_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_img_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_img_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_img_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_img_fid` (`field_img_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 54 (field_img)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_ip_geo_info`
--

DROP TABLE IF EXISTS `field_data_field_ip_geo_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_ip_geo_info` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ip_geo_info_value` varchar(1000) DEFAULT NULL,
  `field_ip_geo_info_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ip_geo_info_format` (`field_ip_geo_info_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 79 (field_ip_geo_info)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_is_editors_choice`
--

DROP TABLE IF EXISTS `field_data_field_is_editors_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_is_editors_choice` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_is_editors_choice_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_is_editors_choice_value` (`field_is_editors_choice_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 87 (field_is_editors_choice)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_last_name`
--

DROP TABLE IF EXISTS `field_data_field_last_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_last_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_last_name_value` varchar(255) DEFAULT NULL,
  `field_last_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_last_name_format` (`field_last_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 72 (field_last_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_lastname`
--

DROP TABLE IF EXISTS `field_data_field_lastname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_lastname` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_lastname_value` varchar(255) DEFAULT NULL,
  `field_lastname_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_lastname_format` (`field_lastname_format`),
  FULLTEXT KEY `similar` (`field_lastname_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 52 (field_lastname)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_latest_rank`
--

DROP TABLE IF EXISTS `field_data_field_latest_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_latest_rank` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_latest_rank_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 83 (field_latest_rank)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_link`
--

DROP TABLE IF EXISTS `field_data_field_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_link` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_value` varchar(255) DEFAULT NULL,
  `field_link_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_link_format` (`field_link_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 143 (field_link)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_location`
--

DROP TABLE IF EXISTS `field_data_field_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_location` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_location_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_location_value` (`field_location_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 90 (field_location)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_month_of_birth`
--

DROP TABLE IF EXISTS `field_data_field_month_of_birth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_month_of_birth` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_month_of_birth_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_month_of_birth_value` (`field_month_of_birth_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 75 (field_month_of_birth)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_new`
--

DROP TABLE IF EXISTS `field_data_field_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_new` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_new_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_new_value` (`field_new_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 69 (field_new)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_news_image`
--

DROP TABLE IF EXISTS `field_data_field_news_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_news_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_news_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_news_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_news_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_news_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_news_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_news_image_fid` (`field_news_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 11 (field_news_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_news_video`
--

DROP TABLE IF EXISTS `field_data_field_news_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_news_video` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_news_video_fid` int(10) unsigned DEFAULT NULL,
  `field_news_video_title` varchar(255) DEFAULT NULL,
  `field_news_video_data` longtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_news_video_fid` (`field_news_video_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 12 (field_news_video)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_next_popup_timeout`
--

DROP TABLE IF EXISTS `field_data_field_next_popup_timeout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_next_popup_timeout` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_next_popup_timeout_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 157 (field_next_popup_timeout)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_normal_price`
--

DROP TABLE IF EXISTS `field_data_field_normal_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_normal_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_normal_price_value` float DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 138 (field_normal_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_order`
--

DROP TABLE IF EXISTS `field_data_field_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_order` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_order_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 159 (field_order)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_parent_comment`
--

DROP TABLE IF EXISTS `field_data_field_parent_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_parent_comment` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_parent_comment_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_parent_comment_target_id` (`field_parent_comment_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 120 (field_parent_comment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_parent_node`
--

DROP TABLE IF EXISTS `field_data_field_parent_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_parent_node` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_parent_node_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_parent_node_target_id` (`field_parent_node_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 122 (field_parent_node)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_plateform`
--

DROP TABLE IF EXISTS `field_data_field_plateform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_plateform` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_plateform_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_plateform_tid` (`field_plateform_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 10 (field_plateform)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_popular`
--

DROP TABLE IF EXISTS `field_data_field_popular`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_popular` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_popular_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_popular_value` (`field_popular_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 70 (field_popular)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_popularity_rank`
--

DROP TABLE IF EXISTS `field_data_field_popularity_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_popularity_rank` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_popularity_rank_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 81 (field_popularity_rank)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_price`
--

DROP TABLE IF EXISTS `field_data_field_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_price_value` varchar(255) DEFAULT NULL,
  `field_price_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_price_format` (`field_price_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 33 (field_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_product_image`
--

DROP TABLE IF EXISTS `field_data_field_product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_product_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_product_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_product_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_product_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_product_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_product_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_product_image_fid` (`field_product_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 137 (field_product_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_rating`
--

DROP TABLE IF EXISTS `field_data_field_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_rating` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_rating_rating` int(10) unsigned DEFAULT NULL,
  `field_rating_target` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 163 (field_rating)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_read`
--

DROP TABLE IF EXISTS `field_data_field_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_read` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_read_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_read_value` (`field_read_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 128 (field_read)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_read_more_url`
--

DROP TABLE IF EXISTS `field_data_field_read_more_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_read_more_url` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_read_more_url_value` longtext,
  `field_read_more_url_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_read_more_url_format` (`field_read_more_url_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 60 (field_read_more_url)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_registration_popup_thanks`
--

DROP TABLE IF EXISTS `field_data_field_registration_popup_thanks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_registration_popup_thanks` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_registration_popup_thanks_url` varchar(2048) DEFAULT NULL,
  `field_registration_popup_thanks_title` varchar(255) DEFAULT NULL,
  `field_registration_popup_thanks_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 153 (field_registration_popup_thanks)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_related_post`
--

DROP TABLE IF EXISTS `field_data_field_related_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_related_post` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_related_post_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_related_post_target_id` (`field_related_post_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 127 (field_related_post)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_release_date`
--

DROP TABLE IF EXISTS `field_data_field_release_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_release_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_release_date_value` datetime DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 167 (field_release_date)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_repeat_timeout`
--

DROP TABLE IF EXISTS `field_data_field_repeat_timeout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_repeat_timeout` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_repeat_timeout_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 158 (field_repeat_timeout)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_review_image`
--

DROP TABLE IF EXISTS `field_data_field_review_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_review_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_review_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_review_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_review_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_review_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_review_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_review_image_fid` (`field_review_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 165 (field_review_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_review_subtitle`
--

DROP TABLE IF EXISTS `field_data_field_review_subtitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_review_subtitle` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_review_subtitle_value` varchar(255) DEFAULT NULL,
  `field_review_subtitle_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_review_subtitle_format` (`field_review_subtitle_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 166 (field_review_subtitle)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_sale_tags`
--

DROP TABLE IF EXISTS `field_data_field_sale_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_sale_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_sale_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_sale_tags_tid` (`field_sale_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 144 (field_sale_tags)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_select_game_for_review`
--

DROP TABLE IF EXISTS `field_data_field_select_game_for_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_select_game_for_review` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_select_game_for_review_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_select_game_for_review_target_id` (`field_select_game_for_review_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 164 (field_select_game_for_review)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_sex`
--

DROP TABLE IF EXISTS `field_data_field_sex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_sex` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_sex_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_sex_value` (`field_sex_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 78 (field_sex)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_show_count`
--

DROP TABLE IF EXISTS `field_data_field_show_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_show_count` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_show_count_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 156 (field_show_count)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_simplenews_term`
--

DROP TABLE IF EXISTS `field_data_field_simplenews_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_simplenews_term` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_simplenews_term_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_simplenews_term_tid` (`field_simplenews_term_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 117 (field_simplenews_term)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_slide_text`
--

DROP TABLE IF EXISTS `field_data_field_slide_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_slide_text` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_slide_text_value` varchar(255) DEFAULT NULL,
  `field_slide_text_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_slide_text_format` (`field_slide_text_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 56 (field_slide_text)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_subtitle`
--

DROP TABLE IF EXISTS `field_data_field_subtitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_subtitle` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_subtitle_value` varchar(255) DEFAULT NULL,
  `field_subtitle_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_subtitle_format` (`field_subtitle_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 109 (field_subtitle)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_teaser_copy_label`
--

DROP TABLE IF EXISTS `field_data_field_teaser_copy_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_teaser_copy_label` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_teaser_copy_label_value` varchar(255) DEFAULT NULL,
  `field_teaser_copy_label_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_teaser_copy_label_format` (`field_teaser_copy_label_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 53 (field_teaser_copy_label)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_term_image`
--

DROP TABLE IF EXISTS `field_data_field_term_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_term_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_term_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_term_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_term_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_term_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_term_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_term_image_fid` (`field_term_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 26 (field_term_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_testimage`
--

DROP TABLE IF EXISTS `field_data_field_testimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_testimage` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_testimage_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_testimage_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_testimage_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_testimage_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_testimage_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_testimage_fid` (`field_testimage_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 147 (field_testimage)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_thank_you_page`
--

DROP TABLE IF EXISTS `field_data_field_thank_you_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_thank_you_page` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_thank_you_page_url` varchar(2048) DEFAULT NULL,
  `field_thank_you_page_title` varchar(255) DEFAULT NULL,
  `field_thank_you_page_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 152 (field_thank_you_page)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_themes`
--

DROP TABLE IF EXISTS `field_data_field_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_themes` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_themes_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_themes_tid` (`field_themes_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 130 (field_themes)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_time_available`
--

DROP TABLE IF EXISTS `field_data_field_time_available`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_time_available` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_time_available_countdown_timer` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 142 (field_time_available)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_top_3_1`
--

DROP TABLE IF EXISTS `field_data_field_top_3_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_top_3_1` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_top_3_1_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_top_3_1_target_id` (`field_top_3_1_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 111 (field_top_3_1)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_top_3_2`
--

DROP TABLE IF EXISTS `field_data_field_top_3_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_top_3_2` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_top_3_2_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_top_3_2_target_id` (`field_top_3_2_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 112 (field_top_3_2)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_top_3_3`
--

DROP TABLE IF EXISTS `field_data_field_top_3_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_top_3_3` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_top_3_3_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_top_3_3_target_id` (`field_top_3_3_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 113 (field_top_3_3)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_trailer_game_image`
--

DROP TABLE IF EXISTS `field_data_field_trailer_game_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_trailer_game_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_trailer_game_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_trailer_game_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_trailer_game_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_trailer_game_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_trailer_game_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_trailer_game_image_fid` (`field_trailer_game_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 67 (field_trailer_game_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_trailer_link`
--

DROP TABLE IF EXISTS `field_data_field_trailer_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_trailer_link` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_trailer_link_url` varchar(2048) DEFAULT NULL,
  `field_trailer_link_title` varchar(255) DEFAULT NULL,
  `field_trailer_link_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 23 (field_trailer_link)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_trailer_video`
--

DROP TABLE IF EXISTS `field_data_field_trailer_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_trailer_video` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_trailer_video_fid` int(10) unsigned DEFAULT NULL,
  `field_trailer_video_title` varchar(255) DEFAULT NULL,
  `field_trailer_video_data` longtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_trailer_video_fid` (`field_trailer_video_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 68 (field_trailer_video)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_twitter_account`
--

DROP TABLE IF EXISTS `field_data_field_twitter_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_twitter_account` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_twitter_account_value` varchar(50) DEFAULT NULL,
  `field_twitter_account_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_twitter_account_format` (`field_twitter_account_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 132 (field_twitter_account)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_type`
--

DROP TABLE IF EXISTS `field_data_field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_type` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_type_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_type_tid` (`field_type_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 51 (field_type)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_user`
--

DROP TABLE IF EXISTS `field_data_field_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_user` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_user_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_user_target_id` (`field_user_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 169 (field_user)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_user_description`
--

DROP TABLE IF EXISTS `field_data_field_user_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_user_description` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_user_description_value` varchar(200) DEFAULT NULL,
  `field_user_description_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_user_description_format` (`field_user_description_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 135 (field_user_description)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_video_url`
--

DROP TABLE IF EXISTS `field_data_field_video_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_video_url` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_video_url_value` longtext,
  `field_video_url_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_video_url_format` (`field_video_url_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 59 (field_video_url)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_vote_description`
--

DROP TABLE IF EXISTS `field_data_field_vote_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_vote_description` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_vote_description_value` varchar(25) DEFAULT NULL,
  `field_vote_description_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_vote_description_format` (`field_vote_description_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 126 (field_vote_description)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_voter`
--

DROP TABLE IF EXISTS `field_data_field_voter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_voter` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_voter_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_voter_target_id` (`field_voter_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 125 (field_voter)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_votes_number`
--

DROP TABLE IF EXISTS `field_data_field_votes_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_votes_number` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_votes_number_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 85 (field_votes_number)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_year_of_birth`
--

DROP TABLE IF EXISTS `field_data_field_year_of_birth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_year_of_birth` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_year_of_birth_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_year_of_birth_value` (`field_year_of_birth_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 76 (field_year_of_birth)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_year_released`
--

DROP TABLE IF EXISTS `field_data_field_year_released`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_year_released` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_year_released_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 7 (field_year_released)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_message_text`
--

DROP TABLE IF EXISTS `field_data_message_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_message_text` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `message_text_value` longtext,
  `message_text_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `message_text_format` (`message_text_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 118 (message_text)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_taxonomy_forums`
--

DROP TABLE IF EXISTS `field_data_taxonomy_forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_taxonomy_forums` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `taxonomy_forums_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `taxonomy_forums_tid` (`taxonomy_forums_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 46 (taxonomy_forums)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_body`
--

DROP TABLE IF EXISTS `field_revision_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_comment_body`
--

DROP TABLE IF EXISTS `field_revision_comment_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_5star_rating`
--

DROP TABLE IF EXISTS `field_revision_field_5star_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_5star_rating` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_5star_rating_rating` int(10) unsigned DEFAULT NULL,
  `field_5star_rating_target` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 25 (field_5star_rating)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field__trailer_theme`
--

DROP TABLE IF EXISTS `field_revision_field__trailer_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field__trailer_theme` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field__trailer_theme_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field__trailer_theme_value` (`field__trailer_theme_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 61 (field__trailer_theme)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_about`
--

DROP TABLE IF EXISTS `field_revision_field_about`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_about` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_about_value` longtext,
  `field_about_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_about_format` (`field_about_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 170 (field_about)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ad_category`
--

DROP TABLE IF EXISTS `field_revision_field_ad_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ad_category` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_category_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_category_tid` (`field_ad_category_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 96 (field_ad_category)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ad_end_date`
--

DROP TABLE IF EXISTS `field_revision_field_ad_end_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ad_end_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_end_date_value` varchar(255) DEFAULT NULL,
  `field_ad_end_date_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_end_date_format` (`field_ad_end_date_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 98 (field_ad_end_date)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ad_flash`
--

DROP TABLE IF EXISTS `field_revision_field_ad_flash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ad_flash` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_flash_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_ad_flash_display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
  `field_ad_flash_description` text COMMENT 'A description of the file.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_flash_fid` (`field_ad_flash_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 93 (field_ad_flash)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ad_image`
--

DROP TABLE IF EXISTS `field_revision_field_ad_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ad_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_ad_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_ad_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_ad_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_ad_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_image_fid` (`field_ad_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 92 (field_ad_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ad_start_date`
--

DROP TABLE IF EXISTS `field_revision_field_ad_start_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ad_start_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_start_date_value` varchar(255) DEFAULT NULL,
  `field_ad_start_date_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_start_date_format` (`field_ad_start_date_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 97 (field_ad_start_date)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ad_status`
--

DROP TABLE IF EXISTS `field_revision_field_ad_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ad_status` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_status_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_status_value` (`field_ad_status_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 100 (field_ad_status)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ad_text`
--

DROP TABLE IF EXISTS `field_revision_field_ad_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ad_text` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_text_value` varchar(255) DEFAULT NULL,
  `field_ad_text_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_text_format` (`field_ad_text_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 94 (field_ad_text)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ad_type`
--

DROP TABLE IF EXISTS `field_revision_field_ad_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ad_type` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_type_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_type_value` (`field_ad_type_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 91 (field_ad_type)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ad_url`
--

DROP TABLE IF EXISTS `field_revision_field_ad_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ad_url` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_url_value` varchar(255) DEFAULT NULL,
  `field_ad_url_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_url_format` (`field_ad_url_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 95 (field_ad_url)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ad_url_taget`
--

DROP TABLE IF EXISTS `field_revision_field_ad_url_taget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ad_url_taget` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ad_url_taget_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ad_url_taget_value` (`field_ad_url_taget_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 99 (field_ad_url_taget)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_adcamp_click`
--

DROP TABLE IF EXISTS `field_revision_field_adcamp_click`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_adcamp_click` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_click_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_click_value` (`field_adcamp_click_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 104 (field_adcamp_click)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_adcamp_clicks`
--

DROP TABLE IF EXISTS `field_revision_field_adcamp_clicks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_adcamp_clicks` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_clicks_value` varchar(255) DEFAULT NULL,
  `field_adcamp_clicks_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_clicks_format` (`field_adcamp_clicks_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 105 (field_adcamp_clicks)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_adcamp_day`
--

DROP TABLE IF EXISTS `field_revision_field_adcamp_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_adcamp_day` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_day_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_day_value` (`field_adcamp_day_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 106 (field_adcamp_day)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_adcamp_days`
--

DROP TABLE IF EXISTS `field_revision_field_adcamp_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_adcamp_days` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_days_value` varchar(255) DEFAULT NULL,
  `field_adcamp_days_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_days_format` (`field_adcamp_days_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 107 (field_adcamp_days)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_adcamp_impression`
--

DROP TABLE IF EXISTS `field_revision_field_adcamp_impression`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_adcamp_impression` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_impression_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_impression_value` (`field_adcamp_impression_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 102 (field_adcamp_impr...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_adcamp_impressions`
--

DROP TABLE IF EXISTS `field_revision_field_adcamp_impressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_adcamp_impressions` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_impressions_value` varchar(255) DEFAULT NULL,
  `field_adcamp_impressions_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_impressions_format` (`field_adcamp_impressions_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 103 (field_adcamp_impr...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_adcamp_list`
--

DROP TABLE IF EXISTS `field_revision_field_adcamp_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_adcamp_list` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_list_value` varchar(255) DEFAULT NULL,
  `field_adcamp_list_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_list_format` (`field_adcamp_list_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 101 (field_adcamp_list)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_adcamp_start`
--

DROP TABLE IF EXISTS `field_revision_field_adcamp_start`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_adcamp_start` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_adcamp_start_value` varchar(255) DEFAULT NULL,
  `field_adcamp_start_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_adcamp_start_format` (`field_adcamp_start_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 108 (field_adcamp_start)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_average_vote`
--

DROP TABLE IF EXISTS `field_revision_field_average_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_average_vote` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_average_vote_value` float DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 84 (field_average_vote)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_background_colour`
--

DROP TABLE IF EXISTS `field_revision_field_background_colour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_background_colour` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_background_colour_value` varchar(255) DEFAULT NULL,
  `field_background_colour_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_background_colour_format` (`field_background_colour_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 150 (field_background...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_background_image`
--

DROP TABLE IF EXISTS `field_revision_field_background_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_background_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_background_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_background_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_background_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_background_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_background_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_background_image_fid` (`field_background_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 148 (field_background...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_background_image_opacity`
--

DROP TABLE IF EXISTS `field_revision_field_background_image_opacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_background_image_opacity` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_background_image_opacity_value` float DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 151 (field_background...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_best_game_rank`
--

DROP TABLE IF EXISTS `field_revision_field_best_game_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_best_game_rank` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_best_game_rank_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 82 (field_best_game_rank)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_birthday`
--

DROP TABLE IF EXISTS `field_revision_field_birthday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_birthday` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_birthday_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 54 (field_birthday)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_body`
--

DROP TABLE IF EXISTS `field_revision_field_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_body_value` longtext,
  `field_body_summary` longtext,
  `field_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_body_format` (`field_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 80 (field_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_body_html`
--

DROP TABLE IF EXISTS `field_revision_field_body_html`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_body_html` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_body_html_value` longtext,
  `field_body_html_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_body_html_format` (`field_body_html_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 149 (field_body_html)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_box_background_color`
--

DROP TABLE IF EXISTS `field_revision_field_box_background_color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_box_background_color` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_box_background_color_value` varchar(255) DEFAULT NULL,
  `field_box_background_color_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_box_background_color_format` (`field_box_background_color_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 58 (field_box...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_box_position`
--

DROP TABLE IF EXISTS `field_revision_field_box_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_box_position` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_box_position_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_box_position_value` (`field_box_position_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 57 (field_box_position)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_breaking_news`
--

DROP TABLE IF EXISTS `field_revision_field_breaking_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_breaking_news` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_breaking_news_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_breaking_news_value` (`field_breaking_news_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 160 (field_breaking_news)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_brief_introduction`
--

DROP TABLE IF EXISTS `field_revision_field_brief_introduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_brief_introduction` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_brief_introduction_value` longtext,
  `field_brief_introduction_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_brief_introduction_format` (`field_brief_introduction_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 62 (field_brief...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_buy_now_button`
--

DROP TABLE IF EXISTS `field_revision_field_buy_now_button`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_buy_now_button` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_buy_now_button_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_buy_now_button_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_buy_now_button_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_buy_now_button_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_buy_now_button_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_buy_now_button_fid` (`field_buy_now_button_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 136 (field_buy_now...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_buy_now_game`
--

DROP TABLE IF EXISTS `field_revision_field_buy_now_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_buy_now_game` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_buy_now_game_url` varchar(2048) DEFAULT NULL,
  `field_buy_now_game_title` varchar(255) DEFAULT NULL,
  `field_buy_now_game_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 22 (field_buy_now_game)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_coming_soon`
--

DROP TABLE IF EXISTS `field_revision_field_coming_soon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_coming_soon` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_coming_soon_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_coming_soon_value` (`field_coming_soon_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 20 (field_coming_soon)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_comment`
--

DROP TABLE IF EXISTS `field_revision_field_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_comment` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_comment_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_comment_target_id` (`field_comment_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 124 (field_comment)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_comment_author`
--

DROP TABLE IF EXISTS `field_revision_field_comment_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_comment_author` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_comment_author_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_comment_author_target_id` (`field_comment_author_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 123 (field_comment...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_contact_me`
--

DROP TABLE IF EXISTS `field_revision_field_contact_me`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_contact_me` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_contact_me_url` varchar(2048) DEFAULT NULL,
  `field_contact_me_title` varchar(255) DEFAULT NULL,
  `field_contact_me_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 145 (field_contact_me)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_country`
--

DROP TABLE IF EXISTS `field_revision_field_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_country` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_country_iso2` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_country_iso2` (`field_country_iso2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 55 (field_country)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_creation_ip`
--

DROP TABLE IF EXISTS `field_revision_field_creation_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_creation_ip` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_creation_ip_value` varchar(255) DEFAULT NULL,
  `field_creation_ip_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_creation_ip_format` (`field_creation_ip_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 86 (field_creation_ip)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_currently_playing`
--

DROP TABLE IF EXISTS `field_revision_field_currently_playing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_currently_playing` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_currently_playing_value` varchar(255) DEFAULT NULL,
  `field_currently_playing_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_currently_playing_format` (`field_currently_playing_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 40 (field_currently...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_date_to_publish`
--

DROP TABLE IF EXISTS `field_revision_field_date_to_publish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_date_to_publish` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_date_to_publish_value` datetime DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 141 (field_date_to...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_day_of_birth`
--

DROP TABLE IF EXISTS `field_revision_field_day_of_birth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_day_of_birth` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_day_of_birth_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_day_of_birth_value` (`field_day_of_birth_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 74 (field_day_of_birth)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_developer_name`
--

DROP TABLE IF EXISTS `field_revision_field_developer_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_developer_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_developer_name_url` varchar(2048) DEFAULT NULL,
  `field_developer_name_title` varchar(255) DEFAULT NULL,
  `field_developer_name_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 34 (field_developer_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_dfp_ad_categories`
--

DROP TABLE IF EXISTS `field_revision_field_dfp_ad_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_dfp_ad_categories` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_dfp_ad_categories_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_dfp_ad_categories_tid` (`field_dfp_ad_categories_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 134 (field_dfp_ad...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_discount_percentage`
--

DROP TABLE IF EXISTS `field_revision_field_discount_percentage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_discount_percentage` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_discount_percentage_value` float DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 140 (field_discount...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_discount_price`
--

DROP TABLE IF EXISTS `field_revision_field_discount_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_discount_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_discount_price_value` float DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 139 (field_discount...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_email`
--

DROP TABLE IF EXISTS `field_revision_field_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_email` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_email_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 162 (field_email)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_enabled`
--

DROP TABLE IF EXISTS `field_revision_field_enabled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_enabled` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_enabled_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_enabled_value` (`field_enabled_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 155 (field_enabled)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ext_dame_description`
--

DROP TABLE IF EXISTS `field_revision_field_ext_dame_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ext_dame_description` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ext_dame_description_value` longtext,
  `field_ext_dame_description_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ext_dame_description_format` (`field_ext_dame_description_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 174 (field_ext_dame...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ext_game_genre`
--

DROP TABLE IF EXISTS `field_revision_field_ext_game_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ext_game_genre` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ext_game_genre_value` varchar(255) DEFAULT NULL,
  `field_ext_game_genre_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ext_game_genre_format` (`field_ext_game_genre_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 173 (field_ext_game...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ext_image`
--

DROP TABLE IF EXISTS `field_revision_field_ext_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ext_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ext_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_ext_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_ext_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_ext_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_ext_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ext_image_fid` (`field_ext_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 172 (field_ext_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ext_link`
--

DROP TABLE IF EXISTS `field_revision_field_ext_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ext_link` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ext_link_url` varchar(2048) DEFAULT NULL,
  `field_ext_link_title` varchar(255) DEFAULT NULL,
  `field_ext_link_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 171 (field_ext_link)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_favorite_game`
--

DROP TABLE IF EXISTS `field_revision_field_favorite_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_favorite_game` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_favorite_game_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_favorite_game_target_id` (`field_favorite_game_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 57 (field_favorite_game)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_favorite_genre`
--

DROP TABLE IF EXISTS `field_revision_field_favorite_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_favorite_genre` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_favorite_genre_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_favorite_genre_value` (`field_favorite_genre_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 88 (field_favorite_genre)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_feature_this_article`
--

DROP TABLE IF EXISTS `field_revision_field_feature_this_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_feature_this_article` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_feature_this_article_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_feature_this_article_value` (`field_feature_this_article_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 175 (field_feature...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_featured`
--

DROP TABLE IF EXISTS `field_revision_field_featured`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_featured` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_featured_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_featured_value` (`field_featured_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 30 (field_featured)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_featured_image`
--

DROP TABLE IF EXISTS `field_revision_field_featured_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_featured_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_featured_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_featured_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_featured_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_featured_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_featured_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_featured_image_fid` (`field_featured_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 63 (field_featured_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_featured_trailer`
--

DROP TABLE IF EXISTS `field_revision_field_featured_trailer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_featured_trailer` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_featured_trailer_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_featured_trailer_value` (`field_featured_trailer_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 64 (field_featured...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_first_name`
--

DROP TABLE IF EXISTS `field_revision_field_first_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_first_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_first_name_value` varchar(255) DEFAULT NULL,
  `field_first_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_first_name_format` (`field_first_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 71 (field_first_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_firstname`
--

DROP TABLE IF EXISTS `field_revision_field_firstname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_firstname` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_firstname_value` varchar(255) DEFAULT NULL,
  `field_firstname_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_firstname_format` (`field_firstname_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 51 (field_firstname)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_full_name`
--

DROP TABLE IF EXISTS `field_revision_field_full_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_full_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_full_name_value` varchar(255) DEFAULT NULL,
  `field_full_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_full_name_format` (`field_full_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 38 (field_full_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_game_genre`
--

DROP TABLE IF EXISTS `field_revision_field_game_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_game_genre` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_game_genre_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_game_genre_tid` (`field_game_genre_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 9 (field_game_genre)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_game_image`
--

DROP TABLE IF EXISTS `field_revision_field_game_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_game_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_game_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_game_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_game_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_game_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_game_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_game_image_fid` (`field_game_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 13 (field_game_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_game_node`
--

DROP TABLE IF EXISTS `field_revision_field_game_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_game_node` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_game_node_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_game_node_target_id` (`field_game_node_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 66 (field_game_node)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_game_system_requirements`
--

DROP TABLE IF EXISTS `field_revision_field_game_system_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_game_system_requirements` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_game_system_requirements_value` longtext,
  `field_game_system_requirements_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_game_system_requirements_format` (`field_game_system_requirements_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 19 (field_game_system...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_game_trailer`
--

DROP TABLE IF EXISTS `field_revision_field_game_trailer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_game_trailer` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_game_trailer_fid` int(10) unsigned DEFAULT NULL,
  `field_game_trailer_title` varchar(255) DEFAULT NULL,
  `field_game_trailer_data` longtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_game_trailer_fid` (`field_game_trailer_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 14 (field_game_trailer)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_gamer_age`
--

DROP TABLE IF EXISTS `field_revision_field_gamer_age`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_gamer_age` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_gamer_age_value` varchar(255) DEFAULT NULL,
  `field_gamer_age_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_gamer_age_format` (`field_gamer_age_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 42 (field_gamer_age)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_gamer_since`
--

DROP TABLE IF EXISTS `field_revision_field_gamer_since`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_gamer_since` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_gamer_since_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_gamer_since_value` (`field_gamer_since_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 41 (field_gamer_since)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_gender`
--

DROP TABLE IF EXISTS `field_revision_field_gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_gender` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_gender_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_gender_value` (`field_gender_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 53 (field_gender)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_headline`
--

DROP TABLE IF EXISTS `field_revision_field_headline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_headline` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_headline_value` longtext,
  `field_headline_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_headline_format` (`field_headline_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 52 (field_headline)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_home_page_hero_image`
--

DROP TABLE IF EXISTS `field_revision_field_home_page_hero_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_home_page_hero_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_home_page_hero_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_home_page_hero_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_home_page_hero_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_home_page_hero_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_home_page_hero_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_home_page_hero_image_fid` (`field_home_page_hero_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 168 (field_home_page...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_image`
--

DROP TABLE IF EXISTS `field_revision_field_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_image_gallery`
--

DROP TABLE IF EXISTS `field_revision_field_image_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_image_gallery` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_gallery_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_gallery_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_gallery_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_gallery_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_gallery_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_gallery_fid` (`field_image_gallery_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 129 (field_image_gallery)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_image_url`
--

DROP TABLE IF EXISTS `field_revision_field_image_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_image_url` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_url_value` varchar(255) DEFAULT NULL,
  `field_image_url_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_url_format` (`field_image_url_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 55 (field_image_url)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_img`
--

DROP TABLE IF EXISTS `field_revision_field_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_img` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_img_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_img_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_img_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_img_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_img_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_img_fid` (`field_img_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 54 (field_img)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_ip_geo_info`
--

DROP TABLE IF EXISTS `field_revision_field_ip_geo_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_ip_geo_info` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_ip_geo_info_value` varchar(1000) DEFAULT NULL,
  `field_ip_geo_info_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_ip_geo_info_format` (`field_ip_geo_info_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 79 (field_ip_geo_info)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_is_editors_choice`
--

DROP TABLE IF EXISTS `field_revision_field_is_editors_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_is_editors_choice` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_is_editors_choice_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_is_editors_choice_value` (`field_is_editors_choice_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 87 (field_is_editors_c...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_last_name`
--

DROP TABLE IF EXISTS `field_revision_field_last_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_last_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_last_name_value` varchar(255) DEFAULT NULL,
  `field_last_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_last_name_format` (`field_last_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 72 (field_last_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_lastname`
--

DROP TABLE IF EXISTS `field_revision_field_lastname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_lastname` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_lastname_value` varchar(255) DEFAULT NULL,
  `field_lastname_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_lastname_format` (`field_lastname_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 52 (field_lastname)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_latest_rank`
--

DROP TABLE IF EXISTS `field_revision_field_latest_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_latest_rank` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_latest_rank_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 83 (field_latest_rank)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_link`
--

DROP TABLE IF EXISTS `field_revision_field_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_link` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_value` varchar(255) DEFAULT NULL,
  `field_link_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_link_format` (`field_link_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 143 (field_link)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_location`
--

DROP TABLE IF EXISTS `field_revision_field_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_location` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_location_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_location_value` (`field_location_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 90 (field_location)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_month_of_birth`
--

DROP TABLE IF EXISTS `field_revision_field_month_of_birth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_month_of_birth` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_month_of_birth_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_month_of_birth_value` (`field_month_of_birth_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 75 (field_month_of_birth)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_new`
--

DROP TABLE IF EXISTS `field_revision_field_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_new` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_new_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_new_value` (`field_new_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 69 (field_new)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_news_image`
--

DROP TABLE IF EXISTS `field_revision_field_news_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_news_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_news_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_news_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_news_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_news_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_news_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_news_image_fid` (`field_news_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 11 (field_news_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_news_video`
--

DROP TABLE IF EXISTS `field_revision_field_news_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_news_video` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_news_video_fid` int(10) unsigned DEFAULT NULL,
  `field_news_video_title` varchar(255) DEFAULT NULL,
  `field_news_video_data` longtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_news_video_fid` (`field_news_video_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 12 (field_news_video)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_next_popup_timeout`
--

DROP TABLE IF EXISTS `field_revision_field_next_popup_timeout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_next_popup_timeout` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_next_popup_timeout_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 157 (field_next_popup...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_normal_price`
--

DROP TABLE IF EXISTS `field_revision_field_normal_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_normal_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_normal_price_value` float DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 138 (field_normal_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_order`
--

DROP TABLE IF EXISTS `field_revision_field_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_order` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_order_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 159 (field_order)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_parent_comment`
--

DROP TABLE IF EXISTS `field_revision_field_parent_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_parent_comment` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_parent_comment_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_parent_comment_target_id` (`field_parent_comment_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 120 (field_parent...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_parent_node`
--

DROP TABLE IF EXISTS `field_revision_field_parent_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_parent_node` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_parent_node_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_parent_node_target_id` (`field_parent_node_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 122 (field_parent_node)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_plateform`
--

DROP TABLE IF EXISTS `field_revision_field_plateform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_plateform` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_plateform_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_plateform_tid` (`field_plateform_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 10 (field_plateform)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_popular`
--

DROP TABLE IF EXISTS `field_revision_field_popular`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_popular` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_popular_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_popular_value` (`field_popular_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 70 (field_popular)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_popularity_rank`
--

DROP TABLE IF EXISTS `field_revision_field_popularity_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_popularity_rank` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_popularity_rank_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 81 (field_popularity...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_price`
--

DROP TABLE IF EXISTS `field_revision_field_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_price_value` varchar(255) DEFAULT NULL,
  `field_price_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_price_format` (`field_price_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 33 (field_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_product_image`
--

DROP TABLE IF EXISTS `field_revision_field_product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_product_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_product_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_product_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_product_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_product_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_product_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_product_image_fid` (`field_product_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 137 (field_product_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_rating`
--

DROP TABLE IF EXISTS `field_revision_field_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_rating` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_rating_rating` int(10) unsigned DEFAULT NULL,
  `field_rating_target` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 163 (field_rating)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_read`
--

DROP TABLE IF EXISTS `field_revision_field_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_read` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_read_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_read_value` (`field_read_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 128 (field_read)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_read_more_url`
--

DROP TABLE IF EXISTS `field_revision_field_read_more_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_read_more_url` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_read_more_url_value` longtext,
  `field_read_more_url_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_read_more_url_format` (`field_read_more_url_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 60 (field_read_more_url)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_registration_popup_thanks`
--

DROP TABLE IF EXISTS `field_revision_field_registration_popup_thanks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_registration_popup_thanks` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_registration_popup_thanks_url` varchar(2048) DEFAULT NULL,
  `field_registration_popup_thanks_title` varchar(255) DEFAULT NULL,
  `field_registration_popup_thanks_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 153 (field...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_related_post`
--

DROP TABLE IF EXISTS `field_revision_field_related_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_related_post` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_related_post_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_related_post_target_id` (`field_related_post_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 127 (field_related_post)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_release_date`
--

DROP TABLE IF EXISTS `field_revision_field_release_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_release_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_release_date_value` datetime DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 167 (field_release_date)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_repeat_timeout`
--

DROP TABLE IF EXISTS `field_revision_field_repeat_timeout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_repeat_timeout` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_repeat_timeout_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 158 (field_repeat...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_review_image`
--

DROP TABLE IF EXISTS `field_revision_field_review_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_review_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_review_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_review_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_review_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_review_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_review_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_review_image_fid` (`field_review_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 165 (field_review_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_review_subtitle`
--

DROP TABLE IF EXISTS `field_revision_field_review_subtitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_review_subtitle` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_review_subtitle_value` varchar(255) DEFAULT NULL,
  `field_review_subtitle_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_review_subtitle_format` (`field_review_subtitle_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 166 (field_review...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_sale_tags`
--

DROP TABLE IF EXISTS `field_revision_field_sale_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_sale_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_sale_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_sale_tags_tid` (`field_sale_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 144 (field_sale_tags)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_select_game_for_review`
--

DROP TABLE IF EXISTS `field_revision_field_select_game_for_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_select_game_for_review` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_select_game_for_review_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_select_game_for_review_target_id` (`field_select_game_for_review_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 164 (field_select_game...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_sex`
--

DROP TABLE IF EXISTS `field_revision_field_sex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_sex` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_sex_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_sex_value` (`field_sex_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 78 (field_sex)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_show_count`
--

DROP TABLE IF EXISTS `field_revision_field_show_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_show_count` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_show_count_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 156 (field_show_count)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_simplenews_term`
--

DROP TABLE IF EXISTS `field_revision_field_simplenews_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_simplenews_term` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_simplenews_term_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_simplenews_term_tid` (`field_simplenews_term_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 117 (field_simplenews...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_slide_text`
--

DROP TABLE IF EXISTS `field_revision_field_slide_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_slide_text` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_slide_text_value` varchar(255) DEFAULT NULL,
  `field_slide_text_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_slide_text_format` (`field_slide_text_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 56 (field_slide_text)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_subtitle`
--

DROP TABLE IF EXISTS `field_revision_field_subtitle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_subtitle` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_subtitle_value` varchar(255) DEFAULT NULL,
  `field_subtitle_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_subtitle_format` (`field_subtitle_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 109 (field_subtitle)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_teaser_copy_label`
--

DROP TABLE IF EXISTS `field_revision_field_teaser_copy_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_teaser_copy_label` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_teaser_copy_label_value` varchar(255) DEFAULT NULL,
  `field_teaser_copy_label_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_teaser_copy_label_format` (`field_teaser_copy_label_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 53 (field_teaser_copy...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_term_image`
--

DROP TABLE IF EXISTS `field_revision_field_term_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_term_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_term_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_term_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_term_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_term_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_term_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_term_image_fid` (`field_term_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 26 (field_term_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_testimage`
--

DROP TABLE IF EXISTS `field_revision_field_testimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_testimage` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_testimage_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_testimage_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_testimage_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_testimage_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_testimage_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_testimage_fid` (`field_testimage_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 147 (field_testimage)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_thank_you_page`
--

DROP TABLE IF EXISTS `field_revision_field_thank_you_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_thank_you_page` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_thank_you_page_url` varchar(2048) DEFAULT NULL,
  `field_thank_you_page_title` varchar(255) DEFAULT NULL,
  `field_thank_you_page_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 152 (field_thank_you...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_themes`
--

DROP TABLE IF EXISTS `field_revision_field_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_themes` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_themes_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_themes_tid` (`field_themes_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 130 (field_themes)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_time_available`
--

DROP TABLE IF EXISTS `field_revision_field_time_available`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_time_available` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_time_available_countdown_timer` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 142 (field_time...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_top_3_1`
--

DROP TABLE IF EXISTS `field_revision_field_top_3_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_top_3_1` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_top_3_1_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_top_3_1_target_id` (`field_top_3_1_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 111 (field_top_3_1)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_top_3_2`
--

DROP TABLE IF EXISTS `field_revision_field_top_3_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_top_3_2` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_top_3_2_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_top_3_2_target_id` (`field_top_3_2_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 112 (field_top_3_2)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_top_3_3`
--

DROP TABLE IF EXISTS `field_revision_field_top_3_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_top_3_3` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_top_3_3_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_top_3_3_target_id` (`field_top_3_3_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 113 (field_top_3_3)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_trailer_game_image`
--

DROP TABLE IF EXISTS `field_revision_field_trailer_game_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_trailer_game_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_trailer_game_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_trailer_game_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_trailer_game_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_trailer_game_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_trailer_game_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_trailer_game_image_fid` (`field_trailer_game_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 67 (field_trailer_game...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_trailer_link`
--

DROP TABLE IF EXISTS `field_revision_field_trailer_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_trailer_link` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_trailer_link_url` varchar(2048) DEFAULT NULL,
  `field_trailer_link_title` varchar(255) DEFAULT NULL,
  `field_trailer_link_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 23 (field_trailer_link)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_trailer_video`
--

DROP TABLE IF EXISTS `field_revision_field_trailer_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_trailer_video` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_trailer_video_fid` int(10) unsigned DEFAULT NULL,
  `field_trailer_video_title` varchar(255) DEFAULT NULL,
  `field_trailer_video_data` longtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_trailer_video_fid` (`field_trailer_video_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 68 (field_trailer_video)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_twitter_account`
--

DROP TABLE IF EXISTS `field_revision_field_twitter_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_twitter_account` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_twitter_account_value` varchar(50) DEFAULT NULL,
  `field_twitter_account_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_twitter_account_format` (`field_twitter_account_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 132 (field_twitter...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_type`
--

DROP TABLE IF EXISTS `field_revision_field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_type` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_type_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_type_tid` (`field_type_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 51 (field_type)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_user`
--

DROP TABLE IF EXISTS `field_revision_field_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_user` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_user_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_user_target_id` (`field_user_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 169 (field_user)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_user_description`
--

DROP TABLE IF EXISTS `field_revision_field_user_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_user_description` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_user_description_value` varchar(200) DEFAULT NULL,
  `field_user_description_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_user_description_format` (`field_user_description_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 135 (field_user...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_video_url`
--

DROP TABLE IF EXISTS `field_revision_field_video_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_video_url` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_video_url_value` longtext,
  `field_video_url_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_video_url_format` (`field_video_url_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 59 (field_video_url)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_vote_description`
--

DROP TABLE IF EXISTS `field_revision_field_vote_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_vote_description` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_vote_description_value` varchar(25) DEFAULT NULL,
  `field_vote_description_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_vote_description_format` (`field_vote_description_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 126 (field_vote...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_voter`
--

DROP TABLE IF EXISTS `field_revision_field_voter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_voter` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_voter_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_voter_target_id` (`field_voter_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 125 (field_voter)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_votes_number`
--

DROP TABLE IF EXISTS `field_revision_field_votes_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_votes_number` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_votes_number_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 85 (field_votes_number)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_year_of_birth`
--

DROP TABLE IF EXISTS `field_revision_field_year_of_birth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_year_of_birth` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_year_of_birth_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_year_of_birth_value` (`field_year_of_birth_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 76 (field_year_of_birth)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_year_released`
--

DROP TABLE IF EXISTS `field_revision_field_year_released`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_year_released` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_year_released_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 7 (field_year_released)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_message_text`
--

DROP TABLE IF EXISTS `field_revision_message_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_message_text` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `message_text_value` longtext,
  `message_text_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `message_text_format` (`message_text_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 118 (message_text)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_taxonomy_forums`
--

DROP TABLE IF EXISTS `field_revision_taxonomy_forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_taxonomy_forums` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `taxonomy_forums_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `taxonomy_forums_tid` (`taxonomy_forums_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 46 (taxonomy_forums)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file_display`
--

DROP TABLE IF EXISTS `file_display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_display` (
  `name` varchar(255) NOT NULL COMMENT 'A combined string (FILE_TYPE__VIEW_MODE__FILE_FORMATTER) identifying a file display configuration. For integration with CTools Exportables, stored as a single string rather than as a compound primary key.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of formatter within the display chain for the associated file type and view mode. A file is rendered using the lowest weighted enabled display configuration that matches the file type and view mode and that is capable of displaying the file.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The status of the display. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the formatter settings for the display.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for file displays.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file_managed`
--

DROP TABLE IF EXISTS `file_managed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  `type` varchar(50) NOT NULL DEFAULT 'undefined' COMMENT 'The type of this file.',
  `origname` varchar(255) NOT NULL DEFAULT '' COMMENT 'Original name of the file with no path components. Used by the filefield_paths module.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`),
  KEY `file_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=281164 DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file_usage`
--

DROP TABLE IF EXISTS `file_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filter`
--

DROP TABLE IF EXISTS `filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filter_format`
--

DROP TABLE IF EXISTS `filter_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flood`
--

DROP TABLE IF EXISTS `flood`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flood` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB AUTO_INCREMENT=359573 DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum`
--

DROP TABLE IF EXISTS `forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid of the node.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The node.vid of the node.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_term_data.tid of the forum term assigned to the node.',
  PRIMARY KEY (`vid`),
  KEY `forum_topic` (`nid`,`tid`),
  KEY `tid` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the relationship of nodes to forum terms.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_index`
--

DROP TABLE IF EXISTS `forum_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.timestamp.',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.',
  KEY `forum_topics` (`nid`,`tid`,`sticky`,`last_comment_timestamp`),
  KEY `created` (`created`),
  KEY `last_comment_timestamp` (`last_comment_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `game_functions_sn_subscriber_ext`
--

DROP TABLE IF EXISTS `game_functions_sn_subscriber_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_functions_sn_subscriber_ext` (
  `email` varchar(128) NOT NULL COMMENT 'Simplenews Subscriber email',
  `name` varchar(128) NOT NULL COMMENT 'The name of the subscriber',
  `country` varchar(10) NOT NULL COMMENT 'The country of the subscriber',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Holds extended fields for the susbscribers in the simplenews_subscriber table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gd_infinite_scroll`
--

DROP TABLE IF EXISTS `gd_infinite_scroll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gd_infinite_scroll` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for the infinite scroll settings',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the settings.',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'The url of the settings.',
  `value` longblob NOT NULL COMMENT 'The values of the settings.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by GD infinite scroll.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `google_analytics_counter`
--

DROP TABLE IF EXISTS `google_analytics_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `google_analytics_counter` (
  `pagepath_hash` varchar(32) NOT NULL COMMENT 'md5 hash of the relative page path.',
  `pagepath` varchar(2048) NOT NULL COMMENT 'Relative page path, for example "node/1" or "contact", as stored by GA.',
  `pageviews` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Pageview count.',
  PRIMARY KEY (`pagepath_hash`),
  KEY `pagepath` (`pagepath`(20)),
  KEY `pageviews` (`pageviews`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Analytics data storage.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `google_analytics_counter_storage`
--

DROP TABLE IF EXISTS `google_analytics_counter_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `google_analytics_counter_storage` (
  `nid` int(10) unsigned NOT NULL COMMENT 'Node IDs',
  `pageview_total` int(10) unsigned NOT NULL COMMENT 'Total pageview counts',
  PRIMARY KEY (`nid`),
  KEY `pageview_total` (`pageview_total`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Analytics Counter module table holding pageview...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image_dimensions`
--

DROP TABLE IF EXISTS `image_dimensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_dimensions` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `height` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The height of the image in pixels.',
  `width` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The width of the image in pixels..',
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=281164 DEFAULT CHARSET=utf8 COMMENT='Cache images dimensions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image_effects`
--

DROP TABLE IF EXISTS `image_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image_styles`
--

DROP TABLE IF EXISTS `image_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imce_dir_man`
--

DROP TABLE IF EXISTS `imce_dir_man`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imce_dir_man` (
  `uid` int(11) NOT NULL COMMENT 'User’s users.uid.',
  `dir` varchar(255) NOT NULL COMMENT 'Directory path restriction relative to site root',
  PRIMARY KEY (`uid`,`dir`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip2country`
--

DROP TABLE IF EXISTS `ip2country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip2country` (
  `ip2country_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country` char(3) NOT NULL,
  `registry` char(10) NOT NULL,
  `ip_range_first` bigint(20) NOT NULL,
  `ip_range_last` bigint(20) NOT NULL,
  `ip_range_length` int(11) NOT NULL,
  PRIMARY KEY (`ip2country_id`),
  KEY `country_registry` (`country`,`registry`)
) ENGINE=InnoDB AUTO_INCREMENT=157468 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mailchimp_lists`
--

DROP TABLE IF EXISTS `mailchimp_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailchimp_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique mailchimp_list entity ID.',
  `name` varchar(32) NOT NULL COMMENT 'The machine-readable name of this mailchimp_list type.',
  `mc_list_id` varchar(32) NOT NULL COMMENT 'The MailChimp list id associated with this list.',
  `label` varchar(32) NOT NULL DEFAULT '' COMMENT 'The mailchimp_lists.label of this mailchimp_list.',
  `description` varchar(255) DEFAULT '' COMMENT 'The mailchimp_lists.description of this mailchimp_list.',
  `list_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The mailchimp_lists.type of this mailchimp_list.',
  `settings` longblob COMMENT 'A serialized object that stores the settings for the specific list.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The exportable status of the entity.',
  `module` varchar(255) DEFAULT NULL COMMENT 'The name of the providing module if the entity has been defined in code.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the mailchimp_list was created.',
  `updated` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the mailchimp_list was most recently saved.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `maillog`
--

DROP TABLE IF EXISTS `maillog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maillog` (
  `idmaillog` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The mail_log node.nid',
  `header_message_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'The ’message-id’ field of the e-mail.',
  `header_from` text NOT NULL COMMENT 'The ’From’ field of the e-mail.',
  `header_to` text NOT NULL COMMENT 'The ’To’ field of the e-mail.',
  `header_reply_to` text NOT NULL COMMENT 'The ’Reply-To’ field of the e-mail.',
  `header_all` text NOT NULL COMMENT 'The ’Header’ field of the e-mail.',
  `subject` varchar(255) NOT NULL DEFAULT '' COMMENT 'The ’Subject’ fieldof the e-mail.',
  `body` longtext NOT NULL COMMENT 'The body of this version.',
  `sent_date` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the mail was sent.',
  PRIMARY KEY (`idmaillog`)
) ENGINE=InnoDB AUTO_INCREMENT=52153 DEFAULT CHARSET=utf8 COMMENT='Stores outgoing e-mail details for nodes of type ’maillog’.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_filter_usage`
--

DROP TABLE IF EXISTS `media_filter_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_filter_usage` (
  `fid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The media file_managed.fid.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The timestamp the fid was last recorded by media_filter()',
  PRIMARY KEY (`fid`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores fids that have been included in the media tag in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_list_type`
--

DROP TABLE IF EXISTS `media_list_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_list_type` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The user.uid of the user.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The type of display (table or images).',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the user preference for whether to list as table...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_type`
--

DROP TABLE IF EXISTS `media_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_type` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The machine name of the media type.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label of the media type.',
  `base` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'If this is a base type (i.e. cannot be deleted)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of media type. Determines which one wins when claiming a piece of media (first wins)',
  `type_callback` varchar(255) DEFAULT '' COMMENT 'Callback to determine if provided media is of this type.',
  `type_callback_args` longtext COMMENT 'A serialized array of name value pairs that will be passed to the callback function',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the settings for media types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_custom`
--

DROP TABLE IF EXISTS `menu_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_links`
--

DROP TABLE IF EXISTS `menu_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB AUTO_INCREMENT=3791 DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_router`
--

DROP TABLE IF EXISTS `menu_router`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.',
  PRIMARY KEY (`path`),
  KEY `fit` (`fit`),
  KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `mid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The Unique ID of the message.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'Reference to a message a type.',
  `arguments` text COMMENT 'Serialized array with the arguments',
  `uid` int(10) unsigned DEFAULT NULL COMMENT 'The user ID of the acting user.',
  `timestamp` int(10) unsigned NOT NULL COMMENT 'When the message instance was recorded.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this message.',
  PRIMARY KEY (`mid`),
  KEY `type_index` (`type`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=7287 DEFAULT CHARSET=utf8 COMMENT='An instance of a message type (e.g. like a node is an...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_type`
--

DROP TABLE IF EXISTS `message_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Numeric message type ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The unified identifier for a message type.',
  `category` varchar(255) NOT NULL DEFAULT 'message_type' COMMENT 'Reference to a message type category.',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'Description for this message type.',
  `argument_keys` text COMMENT 'Serialized array with the argument keys',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this message type.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The exportable status of the entity.',
  `module` varchar(255) DEFAULT NULL COMMENT 'The name of the providing module if the entity has been defined in code.',
  `arguments` text COMMENT 'Serialized array with the arguments.',
  `data` longtext COMMENT 'Serialized array with general data.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Storage for user-defined message templates.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_type_category`
--

DROP TABLE IF EXISTS `message_type_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_type_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Numeric message type category ID.',
  `category` varchar(255) NOT NULL DEFAULT '' COMMENT 'The unified identifier for a message type category.',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'Description for this message type category.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this message type category.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The exportable status of the entity.',
  `module` varchar(255) DEFAULT NULL COMMENT 'The name of the providing module if the entity has been defined in code.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Storage for user-defined message category.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metatag`
--

DROP TABLE IF EXISTS `metatag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metatag` (
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The entity id this data is attached to',
  `data` longblob NOT NULL,
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language of the tag.',
  `revision_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The revision_id for the entity object this data is attached to.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`language`),
  KEY `type_revision` (`entity_type`,`revision_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metatag_config`
--

DROP TABLE IF EXISTS `metatag_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metatag_config` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a metatag configuration set.',
  `instance` varchar(255) NOT NULL DEFAULT '' COMMENT 'The machine-name of the configuration, typically entity-type:bundle.',
  `config` longblob NOT NULL COMMENT 'Serialized data containing the meta tag configuration.',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `instance` (`instance`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Storage of meta tag configuration and defaults.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node`
--

DROP TABLE IF EXISTS `node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned DEFAULT NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`),
  KEY `language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=50714 DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_access`
--

DROP TABLE IF EXISTS `node_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_comment_statistics`
--

DROP TABLE IF EXISTS `node_comment_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.',
  PRIMARY KEY (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`),
  KEY `comment_count` (`comment_count`),
  KEY `last_comment_uid` (`last_comment_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_counter`
--

DROP TABLE IF EXISTS `node_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_counter` (
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid for these statistics.',
  `totalcount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of times the node has been viewed.',
  `daycount` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of times the node has been viewed today.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The most recent time the node has been viewed.',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Access statistics for nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_revision`
--

DROP TABLE IF EXISTS `node_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=50716 DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_type`
--

DROP TABLE IF EXISTS `node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nodejs_presence`
--

DROP TABLE IF EXISTS `nodejs_presence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodejs_presence` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The uid of the user.',
  `login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The timestamp of when the user came online.',
  UNIQUE KEY `uid` (`uid`),
  KEY `login_time` (`login_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of currently online users on a node.js server.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nodequeue_nodes`
--

DROP TABLE IF EXISTS `nodequeue_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodequeue_nodes` (
  `qid` int(10) unsigned NOT NULL COMMENT 'Queue id',
  `sqid` int(10) unsigned NOT NULL COMMENT 'Subqueue this node is in',
  `nid` int(10) unsigned DEFAULT NULL COMMENT 'Node id in this subqueue',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'The position of the node in this subqueue.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The time that the item’s position in the subqueue was updated.',
  KEY `sqid` (`sqid`,`position`),
  KEY `nid` (`nid`),
  KEY `qid_nid` (`qid`,`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indicates which nodes are in which queues/subqueues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nodequeue_queue`
--

DROP TABLE IF EXISTS `nodequeue_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodequeue_queue` (
  `qid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a queue.',
  `name` varchar(128) DEFAULT NULL COMMENT 'The machine name for the queue.',
  `title` varchar(255) NOT NULL COMMENT 'Title of a queue.',
  `subqueue_title` varchar(255) NOT NULL COMMENT 'Title of a subqueue.',
  `size` int(11) DEFAULT '0' COMMENT 'How many nodes this queue will hold',
  `link` varchar(40) DEFAULT NULL COMMENT 'The link text to show under a node to add it to the queue.',
  `link_remove` varchar(40) DEFAULT NULL COMMENT 'The link text to show under a node to remove it from the queue.',
  `owner` varchar(255) DEFAULT NULL,
  `show_in_ui` tinyint(4) DEFAULT '1',
  `show_in_tab` tinyint(4) DEFAULT '1',
  `show_in_links` tinyint(4) DEFAULT '1',
  `reference` varchar(255) DEFAULT '0',
  `reverse` tinyint(4) DEFAULT '0',
  `insert_at_front` tinyint(4) DEFAULT '0',
  `i18n` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`qid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Base table for queues, storing global information for...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nodequeue_roles`
--

DROP TABLE IF EXISTS `nodequeue_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodequeue_roles` (
  `qid` bigint(20) unsigned NOT NULL COMMENT 'Primary key for nodequeue_queue',
  `rid` bigint(20) unsigned NOT NULL COMMENT 'Primary key for roles',
  KEY `qid` (`qid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines the roles which are allowed to use a particular...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nodequeue_subqueue`
--

DROP TABLE IF EXISTS `nodequeue_subqueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodequeue_subqueue` (
  `sqid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Subqueue identifier',
  `qid` int(10) unsigned NOT NULL COMMENT 'Queue identifier.',
  `reference` varchar(255) DEFAULT '0',
  `title` varchar(255) DEFAULT '',
  PRIMARY KEY (`sqid`),
  KEY `qid` (`qid`),
  KEY `reference` (`reference`),
  KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Subqueues are minor queues that inherit all of the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nodequeue_types`
--

DROP TABLE IF EXISTS `nodequeue_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodequeue_types` (
  `qid` bigint(20) unsigned NOT NULL COMMENT 'Primary key for nodequeue_queue',
  `type` varchar(255) DEFAULT NULL COMMENT 'Node Type',
  KEY `qid` (`qid`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines the node types which are allowed in each queue';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `noty_notifications`
--

DROP TABLE IF EXISTS `noty_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `noty_notifications` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Notification ID.',
  `uid` int(10) unsigned NOT NULL COMMENT 'User ID for which is a notification addressed.',
  `noty_type` varchar(32) NOT NULL DEFAULT 'none' COMMENT 'Notification type.',
  `noty_message` text NOT NULL COMMENT 'Message.',
  `variables` text NOT NULL COMMENT 'Message variables.',
  `entity_type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Related entity type.',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Related entity ID.',
  `status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicate status of notification (0 = unseen, 1 = seen).',
  `removable` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Boolean indicate if notification is removable after reading (0 = not removable, 1 = removable).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the notification was created.',
  PRIMARY KEY (`nid`),
  KEY `nid_uid_created` (`nid`,`uid`,`created`),
  KEY `uid_created` (`uid`,`created`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores notifications for users.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_manager_handlers`
--

DROP TABLE IF EXISTS `page_manager_handlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_manager_handlers` (
  `did` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `name` varchar(255) DEFAULT NULL COMMENT 'Unique ID for this task handler. Used to identify it programmatically.',
  `task` varchar(64) DEFAULT NULL COMMENT 'ID of the task this handler is for.',
  `subtask` varchar(64) NOT NULL DEFAULT '' COMMENT 'ID of the subtask this handler is for.',
  `handler` varchar(64) DEFAULT NULL COMMENT 'ID of the task handler being used.',
  `weight` int(11) DEFAULT NULL COMMENT 'The order in which this handler appears. Lower numbers go first.',
  `conf` longtext NOT NULL COMMENT 'Serialized configuration of the handler, if needed.',
  PRIMARY KEY (`did`),
  UNIQUE KEY `name` (`name`),
  KEY `fulltask` (`task`,`subtask`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_manager_pages`
--

DROP TABLE IF EXISTS `page_manager_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_manager_pages` (
  `pid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `name` varchar(255) DEFAULT NULL COMMENT 'Unique ID for this subtask. Used to identify it programmatically.',
  `task` varchar(64) DEFAULT 'page' COMMENT 'What type of page this is, so that we can use the same mechanism for creating tighter UIs for targeted pages.',
  `admin_title` varchar(255) DEFAULT NULL COMMENT 'Human readable title for this page subtask.',
  `admin_description` longtext COMMENT 'Administrative description of this item.',
  `path` varchar(255) DEFAULT NULL COMMENT 'The menu path that will invoke this task.',
  `access` longtext NOT NULL COMMENT 'Access configuration for this path.',
  `menu` longtext NOT NULL COMMENT 'Serialized configuration of Drupal menu visibility settings for this item.',
  `arguments` longtext NOT NULL COMMENT 'Configuration of arguments for this menu item.',
  `conf` longtext NOT NULL COMMENT 'Serialized configuration of the page, if needed.',
  PRIMARY KEY (`pid`),
  UNIQUE KEY `name` (`name`),
  KEY `task` (`task`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains page subtasks for implementing pages with...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `page_manager_weights`
--

DROP TABLE IF EXISTS `page_manager_weights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_manager_weights` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Unique ID for this task handler. Used to identify it programmatically.',
  `weight` int(11) DEFAULT NULL COMMENT 'The order in which this handler appears. Lower numbers go first.',
  PRIMARY KEY (`name`),
  KEY `weights` (`name`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains override weights for page_manager handlers that...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `panels_display`
--

DROP TABLE IF EXISTS `panels_display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `panels_display` (
  `did` int(11) NOT NULL AUTO_INCREMENT,
  `layout` varchar(255) DEFAULT '',
  `layout_settings` longtext,
  `panel_settings` longtext,
  `cache` text,
  `title` varchar(255) DEFAULT '',
  `hide_title` tinyint(4) DEFAULT '0',
  `title_pane` int(11) DEFAULT '0',
  `uuid` char(36) DEFAULT NULL,
  `storage_type` varchar(255) DEFAULT '',
  `storage_id` varchar(255) DEFAULT '',
  PRIMARY KEY (`did`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `panels_layout`
--

DROP TABLE IF EXISTS `panels_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `panels_layout` (
  `lid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'A database primary key to ensure uniqueness.',
  `name` varchar(255) DEFAULT NULL COMMENT 'Unique ID for this content. Used to identify it programmatically.',
  `admin_title` varchar(255) DEFAULT NULL COMMENT 'Administrative title for this layout.',
  `admin_description` longtext COMMENT 'Administrative description for this layout.',
  `category` varchar(255) DEFAULT NULL COMMENT 'Administrative category for this layout.',
  `plugin` varchar(255) DEFAULT NULL COMMENT 'The layout plugin that owns this layout.',
  `settings` longtext COMMENT 'Serialized settings for the actual layout. The contents of this field are up to the plugin that uses it.',
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains exportable customized layouts for this site.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `panels_mini`
--

DROP TABLE IF EXISTS `panels_mini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `panels_mini` (
  `pid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary key for uniqueness.',
  `name` varchar(255) DEFAULT NULL COMMENT 'The unique name of the mini panel.',
  `category` varchar(64) DEFAULT NULL COMMENT 'The category this mini panel appears in on the add content pane.',
  `did` int(11) DEFAULT NULL COMMENT 'The display ID of the panel.',
  `admin_title` varchar(128) DEFAULT NULL COMMENT 'The administrative title of the mini panel.',
  `admin_description` longtext COMMENT 'Administrative title of this mini panel.',
  `requiredcontexts` longtext COMMENT 'An array of required contexts.',
  `contexts` longtext COMMENT 'An array of contexts embedded into the panel.',
  `relationships` longtext COMMENT 'An array of relationships embedded into the panel.',
  PRIMARY KEY (`pid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `panels_node`
--

DROP TABLE IF EXISTS `panels_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `panels_node` (
  `nid` int(11) NOT NULL DEFAULT '0',
  `css_id` varchar(255) DEFAULT NULL,
  `did` int(11) NOT NULL,
  `pipeline` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `panels_pane`
--

DROP TABLE IF EXISTS `panels_pane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `panels_pane` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) NOT NULL DEFAULT '0',
  `panel` varchar(255) DEFAULT '',
  `type` varchar(255) DEFAULT '',
  `subtype` varchar(255) DEFAULT '',
  `shown` tinyint(4) DEFAULT '1',
  `access` longtext,
  `configuration` longtext,
  `cache` longtext,
  `style` longtext,
  `css` longtext,
  `extras` longtext,
  `position` smallint(6) DEFAULT '0',
  `locks` longtext,
  `uuid` char(36) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `did_idx` (`did`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `panels_renderer_pipeline`
--

DROP TABLE IF EXISTS `panels_renderer_pipeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `panels_renderer_pipeline` (
  `rpid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'A database primary key to ensure uniqueness.',
  `name` varchar(255) DEFAULT NULL COMMENT 'Unique ID for this content. Used to identify it programmatically.',
  `admin_title` varchar(255) DEFAULT NULL COMMENT 'Administrative title for this pipeline.',
  `admin_description` longtext COMMENT 'Administrative description for this pipeline.',
  `weight` smallint(6) DEFAULT '0',
  `settings` longtext COMMENT 'Serialized settings for the actual pipeline. The contents of this field are up to the plugin that uses it.',
  PRIMARY KEY (`rpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains renderer pipelines for Panels. Each pipeline...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pathauto_state`
--

DROP TABLE IF EXISTS `pathauto_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathauto_state` (
  `entity_type` varchar(32) NOT NULL COMMENT 'The entity type.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity ID.',
  `pathauto` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The automatic alias status of the entity.',
  PRIMARY KEY (`entity_type`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The status of each entity alias (whether it was...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poll`
--

DROP TABLE IF EXISTS `poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The poll’s node.nid.',
  `runtime` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of seconds past node.created during which the poll is open.',
  `active` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not the poll is open.',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores poll-specific information for poll nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poll_choice`
--

DROP TABLE IF EXISTS `poll_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_choice` (
  `chid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for a poll choice.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this choice belongs to.',
  `chtext` varchar(128) NOT NULL DEFAULT '' COMMENT 'The text for this choice.',
  `chvotes` int(11) NOT NULL DEFAULT '0' COMMENT 'The total number of votes this choice has received by all users.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The sort order of this choice among all choices for the same node.',
  PRIMARY KEY (`chid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='Stores information about all choices for all polls.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poll_vote`
--

DROP TABLE IF EXISTS `poll_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_vote` (
  `chid` int(10) unsigned NOT NULL COMMENT 'The users’s vote for this poll.',
  `nid` int(10) unsigned NOT NULL COMMENT 'The poll node this vote is for.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid this vote is from unless the voter was anonymous.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address this vote is from unless the voter was logged in.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The timestamp of the vote creation.',
  PRIMARY KEY (`nid`,`uid`,`hostname`),
  KEY `chid` (`chid`),
  KEY `hostname` (`hostname`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores per-users votes for each poll.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pollfield`
--

DROP TABLE IF EXISTS `pollfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pollfield` (
  `nid` int(10) unsigned DEFAULT '0' COMMENT 'Node ID',
  `field_table` varchar(255) DEFAULT '' COMMENT 'The table where the pollfield is stored',
  `field_name` varchar(32) DEFAULT '' COMMENT 'Pollfield name',
  `field_name_delta` int(11) DEFAULT '0' COMMENT 'Delta for multiple fields',
  `runtime` int(11) DEFAULT '0' COMMENT 'Time in seconds a pollfield is scheduled to be active',
  `active` int(10) unsigned DEFAULT '0' COMMENT 'Whether the poll is active or not',
  KEY `nid` (`nid`),
  KEY `field_table` (`field_table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Inventory of all pollfields their basic settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pollfield_votes`
--

DROP TABLE IF EXISTS `pollfield_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pollfield_votes` (
  `nid` int(10) unsigned NOT NULL COMMENT 'Pollfield node ID',
  `field_table` varchar(255) NOT NULL DEFAULT '' COMMENT 'The table where the pollfield is stored',
  `field_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The table where the pollfield is stored',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Voter user ID',
  `delta` int(11) NOT NULL DEFAULT '-1' COMMENT 'Choice',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Voter hostname',
  `field_name_delta` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Pollfield delta',
  `weight` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Weight for mulitchoice',
  `cookie` varchar(128) NOT NULL DEFAULT '' COMMENT 'Cookie for anonymous voters',
  KEY `nid` (`nid`),
  KEY `uid` (`uid`),
  KEY `field_table` (`field_table`),
  KEY `hostname` (`hostname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pollfield results table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB AUTO_INCREMENT=44342 DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quicktabs`
--

DROP TABLE IF EXISTS `quicktabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quicktabs` (
  `machine_name` varchar(255) NOT NULL COMMENT 'The primary identifier for a qt block.',
  `ajax` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Whether this is an ajax views block.',
  `hide_empty_tabs` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Whether this tabset hides empty tabs.',
  `default_tab` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Default tab.',
  `title` varchar(255) NOT NULL COMMENT 'The title of this quicktabs block.',
  `tabs` mediumtext NOT NULL COMMENT 'A serialized array of the contents of this qt block.',
  `renderer` varchar(255) NOT NULL COMMENT 'The rendering mechanism.',
  `style` varchar(255) NOT NULL COMMENT 'The tab style.',
  `options` mediumtext COMMENT 'A serialized array of the options for this qt instance.',
  PRIMARY KEY (`machine_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The quicktabs table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rate_bot_agent`
--

DROP TABLE IF EXISTS `rate_bot_agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rate_bot_agent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pattern` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rate_bot_ip`
--

DROP TABLE IF EXISTS `rate_bot_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rate_bot_ip` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rdf_mapping`
--

DROP TABLE IF EXISTS `rdf_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registry`
--

DROP TABLE IF EXISTS `registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registry_file`
--

DROP TABLE IF EXISTS `registry_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rules_config`
--

DROP TABLE IF EXISTS `rules_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal identifier for any configuration.',
  `name` varchar(64) NOT NULL COMMENT 'The name of the configuration.',
  `label` varchar(255) NOT NULL DEFAULT 'unlabeled' COMMENT 'The label of the configuration.',
  `plugin` varchar(127) NOT NULL COMMENT 'The name of the plugin of this configuration.',
  `active` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the configuration is active. Usage depends on how the using module makes use of it.',
  `weight` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Weight of the configuration. Usage depends on how the using module makes use of it.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The exportable status of the entity.',
  `dirty` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Dirty configurations fail the integrity check, e.g. due to missing dependencies.',
  `module` varchar(255) DEFAULT NULL COMMENT 'The name of the providing module if the entity has been defined in code.',
  `access_exposed` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether to use a permission to control access for using components.',
  `data` longblob COMMENT 'Everything else, serialized.',
  `owner` varchar(255) NOT NULL DEFAULT 'rules' COMMENT 'The name of the module via which the rule has been configured.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `plugin` (`plugin`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rules_dependencies`
--

DROP TABLE IF EXISTS `rules_dependencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_dependencies` (
  `id` int(10) unsigned NOT NULL COMMENT 'The primary identifier of the configuration.',
  `module` varchar(255) NOT NULL COMMENT 'The name of the module that is required for the configuration.',
  PRIMARY KEY (`id`,`module`),
  KEY `module` (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rules_tags`
--

DROP TABLE IF EXISTS `rules_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_tags` (
  `id` int(10) unsigned NOT NULL COMMENT 'The primary identifier of the configuration.',
  `tag` varchar(255) NOT NULL COMMENT 'The tag string associated with this configuration',
  PRIMARY KEY (`id`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rules_trigger`
--

DROP TABLE IF EXISTS `rules_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_trigger` (
  `id` int(10) unsigned NOT NULL COMMENT 'The primary identifier of the configuration.',
  `event` varchar(127) NOT NULL DEFAULT '' COMMENT 'The name of the event on which the configuration should be triggered.',
  PRIMARY KEY (`id`,`event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduler`
--

DROP TABLE IF EXISTS `scheduler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler` (
  `nid` int(10) unsigned NOT NULL COMMENT 'The foreign key to node.nid',
  `publish_on` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The UNIX UTC timestamp when to publish',
  `unpublish_on` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The UNIX UTC timestamp when to unpublish',
  PRIMARY KEY (`nid`),
  KEY `scheduler_publish_on` (`publish_on`),
  KEY `scheduler_unpublish_on` (`unpublish_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The main table to hold the scheduler data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_dataset`
--

DROP TABLE IF EXISTS `search_dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_dataset` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.',
  PRIMARY KEY (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_index`
--

DROP TABLE IF EXISTS `search_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.',
  PRIMARY KEY (`word`,`sid`,`type`),
  KEY `sid_type` (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_node_links`
--

DROP TABLE IF EXISTS `search_node_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_node_links` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.',
  PRIMARY KEY (`sid`,`type`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_total`
--

DROP TABLE IF EXISTS `search_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `semaphore`
--

DROP TABLE IF EXISTS `semaphore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=173586 DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `uid` int(10) unsigned NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.',
  PRIMARY KEY (`sid`,`ssid`),
  KEY `timestamp` (`timestamp`),
  KEY `uid` (`uid`),
  KEY `ssid` (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `share_count`
--

DROP TABLE IF EXISTS `share_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_count` (
  `sid` varchar(128) NOT NULL COMMENT 'The primary identifier for a social service.',
  `updated` int(11) DEFAULT '0',
  `count` int(11) DEFAULT '0',
  `entity_type` varchar(32) NOT NULL COMMENT 'The type of the item being counted.',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`sid`,`entity_type`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores share counts per node for certain items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `share_counter`
--

DROP TABLE IF EXISTS `share_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_counter` (
  `scid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Share Count ID.',
  `uri` varchar(255) NOT NULL COMMENT 'The URI of the shared page.',
  `button_type` varchar(128) NOT NULL COMMENT 'The type of button of the sharing.',
  `count` int(11) NOT NULL COMMENT 'The amount of shares for this URI with this button.',
  PRIMARY KEY (`scid`),
  KEY `share_counter_uri` (`uri`)
) ENGINE=InnoDB AUTO_INCREMENT=1080 DEFAULT CHARSET=utf8 COMMENT='Counter for the sharing buttons.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `share_services`
--

DROP TABLE IF EXISTS `share_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_services` (
  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a social service.',
  `title` varchar(255) DEFAULT NULL COMMENT 'The name of the social service that is being counted.',
  `admin_title` varchar(255) DEFAULT NULL COMMENT 'The name of the social service that is being counted.',
  `enabled` tinyint(3) unsigned DEFAULT '1' COMMENT 'Whether this service is being counted or not.',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores service names and status';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `share_transaction`
--

DROP TABLE IF EXISTS `share_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `share_transaction` (
  `stid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Share Transaction ID.',
  `sender_id` int(11) DEFAULT NULL COMMENT 'The uid of the sender.',
  `sender_description` varchar(250) DEFAULT NULL COMMENT 'The sender description. eg. email.',
  `sender_ip` varchar(100) DEFAULT NULL COMMENT 'The sender IP address.',
  `recipient_id` int(11) DEFAULT NULL COMMENT 'The uid of the recipient.',
  `recipient_description` varchar(250) DEFAULT NULL COMMENT 'The recipient description. eg. email.',
  `share_type` varchar(50) DEFAULT NULL COMMENT 'The kind of sharing.',
  `uri` varchar(250) DEFAULT NULL COMMENT 'The URI of the shared page.',
  `entity_type` varchar(100) DEFAULT NULL COMMENT 'The type of the shared entity.',
  `entity_id` int(11) DEFAULT NULL COMMENT 'The ID of the shared entity.',
  `text` text COMMENT 'The text associated to the sharing.',
  `status` int(11) DEFAULT '0' COMMENT '1=sent, -1=error, 0=pending.',
  `timestamp` int(11) DEFAULT '0' COMMENT 'The creation date timestamp.',
  PRIMARY KEY (`stid`)
) ENGINE=InnoDB AUTO_INCREMENT=7191 DEFAULT CHARSET=latin1 COMMENT='Keeps a log of the sharing transactions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shortcut_set`
--

DROP TABLE IF EXISTS `shortcut_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shortcut_set_users`
--

DROP TABLE IF EXISTS `shortcut_set_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set_users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.',
  PRIMARY KEY (`uid`),
  KEY `set_name` (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simpleads_blocks`
--

DROP TABLE IF EXISTS `simpleads_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simpleads_blocks` (
  `abid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Ad Block ID',
  `tid` int(11) NOT NULL COMMENT 'Taxonomy Term ID',
  `settings` text NOT NULL COMMENT 'Serialized data (settings)',
  PRIMARY KEY (`abid`),
  KEY `tid` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='Stores Ad Blocks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simpleads_clicks`
--

DROP TABLE IF EXISTS `simpleads_clicks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simpleads_clicks` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Ad ID',
  `nid` int(11) NOT NULL COMMENT 'Node ID',
  `timestamp` varchar(30) NOT NULL DEFAULT '' COMMENT 'Timestamp',
  `ip_address` varchar(255) NOT NULL DEFAULT '' COMMENT 'IP Address',
  PRIMARY KEY (`aid`),
  KEY `nid` (`nid`),
  KEY `aid` (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='Stores Ad Clicks';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simpleads_impressions`
--

DROP TABLE IF EXISTS `simpleads_impressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simpleads_impressions` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Ad ID',
  `nid` int(11) NOT NULL COMMENT 'Node ID',
  `timestamp` varchar(30) NOT NULL DEFAULT '' COMMENT 'Timestamp',
  `ip_address` varchar(255) NOT NULL DEFAULT '' COMMENT 'IP Address',
  PRIMARY KEY (`aid`),
  KEY `nid` (`nid`),
  KEY `aid` (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=31081 DEFAULT CHARSET=utf8 COMMENT='Stores Ad Impressions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simplenews_category`
--

DROP TABLE IF EXISTS `simplenews_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simplenews_category` (
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT 'taxonomy_term_data.tid used as newsletter category.',
  `format` varchar(8) NOT NULL DEFAULT '' COMMENT 'Format of the newsletter email (plain, html).',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Email priority according to RFC 2156 and RFC 5231 (0 = none; 1 = highest; 2 = high; 3 = normal; 4 = low; 5 = lowest).',
  `receipt` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating request for email receipt confirmation according to RFC 2822.',
  `from_name` varchar(128) NOT NULL DEFAULT '' COMMENT 'Sender name for newsletter emails.',
  `email_subject` varchar(255) NOT NULL DEFAULT '' COMMENT 'Subject of newsletter email. May contain tokens.',
  `from_address` varchar(64) NOT NULL DEFAULT '' COMMENT 'Sender address for newsletter emails',
  `hyperlinks` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag indicating type of hyperlink conversion (1 = hyperlinks are in-line; 0 = hyperlinks are placed at email bottom).',
  `new_account` varchar(12) NOT NULL DEFAULT '' COMMENT 'How to treat subscription at account creation (none = None; on = Default on; off = Default off; silent = Invisible subscription).',
  `opt_inout` varchar(12) NOT NULL DEFAULT '' COMMENT 'How to treat subscription confirmation (hidden = Newsletter is hidden from the user; single = Single opt-in; double = Double opt-in).',
  `block` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'For this category a subscription block is available.',
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Simplenews newsletter categories.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simplenews_mail_spool`
--

DROP TABLE IF EXISTS `simplenews_mail_spool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simplenews_mail_spool` (
  `msid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a mail spool record.',
  `mail` varchar(255) NOT NULL DEFAULT '' COMMENT 'The formatted email address of mail message recipient.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid of this newsletter.',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT 'The simplenews_category.tid this newsletter belongs to.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The sent status of the email (0 = hold, 1 = pending, 2 = done).',
  `error` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether an error occured while sending the email.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The time status was set or changed.',
  `data` longtext COMMENT 'A serialized array of name value pairs that are related to the email address.',
  `snid` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key for subscriber table (simplenews_subscriptions.snid)',
  PRIMARY KEY (`msid`),
  KEY `tid` (`tid`),
  KEY `status` (`status`),
  KEY `snid_tid` (`snid`,`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Spool for temporary storage of newsletter emails.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simplenews_newsletter`
--

DROP TABLE IF EXISTS `simplenews_newsletter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simplenews_newsletter` (
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'node that is used as newsletter.',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT 'The newsletter category simplenews_category.tid this newsletter belongs to.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'sent status of the newsletter issue (0 = not sent; 1 = pending; 2 = sent, 3 = send on publish).',
  `sent_subscriber_count` int(11) NOT NULL DEFAULT '0' COMMENT 'The count of subscribers to the newsletter when it was sent.',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Simplenews newsletter data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simplenews_subscriber`
--

DROP TABLE IF EXISTS `simplenews_subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simplenews_subscriber` (
  `snid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key: Unique subscriber ID.',
  `activated` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating the status of the subscription.',
  `mail` varchar(64) NOT NULL DEFAULT '' COMMENT 'The subscriber’s email address.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that has the same email address.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'Subscriber preferred language.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp of when the user is (un)subscribed.',
  `changes` text COMMENT 'Contains the requested subscription changes',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp of when the subscription record was added.',
  PRIMARY KEY (`snid`),
  KEY `mail` (`mail`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=44528 DEFAULT CHARSET=utf8 COMMENT='Subscribers to simplenews_category. Many-to-many relation...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simplenews_subscription`
--

DROP TABLE IF EXISTS `simplenews_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simplenews_subscription` (
  `snid` int(11) NOT NULL DEFAULT '0' COMMENT 'The simplenews_subscriber.snid who is subscribed.',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT 'The category (simplenews_category.tid) the subscriber is subscribed to.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'A flag indicating whether the user is subscribed (1) or unsubscribed (0).',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp of when the user is (un)subscribed.',
  `source` varchar(24) NOT NULL DEFAULT '' COMMENT 'The source via which the user is (un)subscription.',
  PRIMARY KEY (`snid`,`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter subscription data. Which subscriber is...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `smart_paging`
--

DROP TABLE IF EXISTS `smart_paging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smart_paging` (
  `entity_id` int(11) NOT NULL COMMENT 'The entity type ID this configuration is attached to.',
  `entity_type` varchar(128) NOT NULL COMMENT 'An entity type refer to table field_config_entity_type.type.',
  `configuration` blob COMMENT 'Customized settings of Smart Paging (serialized).',
  PRIMARY KEY (`entity_id`,`entity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Entity content level customized settings of Smart Paging.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.',
  `md5check` varchar(32) DEFAULT NULL COMMENT 'The md5check hash of this file',
  PRIMARY KEY (`filename`),
  KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  KEY `type_name` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxonomy_index`
--

DROP TABLE IF EXISTS `taxonomy_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxonomy_menu`
--

DROP TABLE IF EXISTS `taxonomy_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_menu` (
  `mlid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy terms menu_link.mlid.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tid that is linked to the mlid.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vid for the tid.',
  PRIMARY KEY (`mlid`,`tid`),
  KEY `vid` (`vid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Links a taxonomy term to a menu item.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxonomy_term_data`
--

DROP TABLE IF EXISTS `taxonomy_term_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12817 DEFAULT CHARSET=utf8 COMMENT='Stores term information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxonomy_term_hierarchy`
--

DROP TABLE IF EXISTS `taxonomy_term_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxonomy_vocabulary`
--

DROP TABLE IF EXISTS `taxonomy_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trigger_assignments`
--

DROP TABLE IF EXISTS `trigger_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_assignments` (
  `hook` varchar(78) NOT NULL DEFAULT '' COMMENT 'Primary Key: The name of the internal Drupal hook; for example, node_insert.',
  `aid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Action’s actions.aid.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the trigger assignment in relation to other triggers.',
  PRIMARY KEY (`hook`,`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps trigger to hook and operation assignments from...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `url_alias`
--

DROP TABLE IF EXISTS `url_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=226551 DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_stats_ips`
--

DROP TABLE IF EXISTS `user_stats_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_stats_ips` (
  `iid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key: IP address unique ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user.',
  `ip_address` varchar(40) NOT NULL DEFAULT '' COMMENT 'The user’s IP address.',
  `first_seen_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the IP address was first used by this user.',
  PRIMARY KEY (`iid`),
  KEY `uid` (`uid`),
  KEY `first_seen_timestamp` (`first_seen_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=96444 DEFAULT CHARSET=utf8 COMMENT='IP address storage, links timestamps and uids to IP';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_stats_values`
--

DROP TABLE IF EXISTS `user_stats_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_stats_values` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the statistic.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the statistic user.',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'The value of the statistic.',
  PRIMARY KEY (`name`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User Stats data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpoints`
--

DROP TABLE IF EXISTS `userpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpoints` (
  `pid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Points ID',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User ID',
  `points` int(11) NOT NULL DEFAULT '0' COMMENT 'Current Points',
  `max_points` int(11) NOT NULL DEFAULT '0' COMMENT 'Out of a maximum points',
  `last_update` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT 'Category ID',
  PRIMARY KEY (`pid`),
  UNIQUE KEY `uid_tid` (`uid`,`tid`),
  KEY `last_update` (`last_update`),
  KEY `points` (`points`)
) ENGINE=InnoDB AUTO_INCREMENT=21130 DEFAULT CHARSET=utf8 COMMENT='Holds the user points';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpoints_ranks_level`
--

DROP TABLE IF EXISTS `userpoints_ranks_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpoints_ranks_level` (
  `lid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Level ID.',
  `level_name` varchar(128) NOT NULL COMMENT 'The name of the level.',
  `min_xp` int(11) NOT NULL COMMENT 'The minimum XP necessary to reach this level.',
  `rid` int(11) NOT NULL COMMENT 'The rank ID of this level.',
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='The different levels in the ranks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpoints_ranks_rank`
--

DROP TABLE IF EXISTS `userpoints_ranks_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpoints_ranks_rank` (
  `rid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Rank ID',
  `rank_name` varchar(128) NOT NULL COMMENT 'The name of the rank',
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Holds the possible ranks in the system.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpoints_redeem_award`
--

DROP TABLE IF EXISTS `userpoints_redeem_award`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpoints_redeem_award` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Award ID.',
  `name` varchar(128) NOT NULL COMMENT 'The name of the award.',
  `description` varchar(500) NOT NULL COMMENT 'The description of the award.',
  `picture` int(11) NOT NULL COMMENT 'The file id of the award''s picture.',
  `userpoints_type` int(11) NOT NULL COMMENT 'The type of userpoints needed to redeem this award.',
  `userpoints_amount` int(11) NOT NULL COMMENT 'The amount of userpoints needed to redeem this award.',
  `status` varchar(50) NOT NULL COMMENT 'The status of this award.',
  `amount` int(11) NOT NULL COMMENT 'The amount of this award in inventory.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='The awards the user can redeem with their userpoints.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpoints_total`
--

DROP TABLE IF EXISTS `userpoints_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpoints_total` (
  `uid` int(11) NOT NULL COMMENT 'User ID',
  `points` int(11) NOT NULL DEFAULT '0' COMMENT 'Current Points',
  `max_points` int(11) NOT NULL DEFAULT '0' COMMENT 'Out of a maximum points',
  `last_update` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp',
  PRIMARY KEY (`uid`),
  KEY `last_update` (`last_update`),
  KEY `points` (`points`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds the total user points';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpoints_txn`
--

DROP TABLE IF EXISTS `userpoints_txn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpoints_txn` (
  `txn_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Transaction ID',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User ID',
  `approver_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'Moderator User ID',
  `points` int(11) NOT NULL DEFAULT '0' COMMENT 'Points',
  `time_stamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'Effective timestamp of last action on this transaction, for tracking purposes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Status',
  `description` text COMMENT 'Description',
  `reference` varchar(128) DEFAULT NULL COMMENT 'Reserved for module specific use',
  `expirydate` int(11) NOT NULL DEFAULT '0' COMMENT 'Expirydate',
  `expired` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Expiration status',
  `parent_txn_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Parent Transaction ID',
  `tid` int(11) NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `entity_id` int(11) NOT NULL DEFAULT '0' COMMENT 'ID of an entity in the Database',
  `entity_type` varchar(128) DEFAULT NULL COMMENT 'Type of entity',
  `operation` varchar(48) DEFAULT NULL COMMENT 'Operation being carried out',
  PRIMARY KEY (`txn_id`),
  KEY `operation` (`operation`),
  KEY `reference` (`reference`),
  KEY `status_expired_expiry` (`status`,`expired`,`expirydate`),
  KEY `changed` (`changed`),
  KEY `uid` (`uid`),
  KEY `approver_uid` (`approver_uid`),
  KEY `points` (`points`)
) ENGINE=InnoDB AUTO_INCREMENT=195103 DEFAULT CHARSET=utf8 COMMENT='Userpoints Transactions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  KEY `access` (`access`),
  KEY `created` (`created`),
  KEY `mail` (`mail`),
  KEY `picture` (`picture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variable`
--

DROP TABLE IF EXISTS `variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `views_content_cache`
--

DROP TABLE IF EXISTS `views_content_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views_content_cache` (
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Updated timestamp for a given cache segment.',
  `c1` varchar(255) DEFAULT NULL COMMENT 'Cache segment 1.',
  `c2` varchar(255) DEFAULT NULL COMMENT 'Cache segment 2.',
  `c3` varchar(255) DEFAULT NULL COMMENT 'Cache segment 3.',
  `c4` varchar(255) DEFAULT NULL COMMENT 'Cache segment 4.',
  `c5` varchar(255) DEFAULT NULL COMMENT 'Cache segment 5.',
  `c6` varchar(255) DEFAULT NULL COMMENT 'Cache segment 6.',
  `c7` varchar(255) DEFAULT NULL COMMENT 'Cache segment 7.',
  `c8` varchar(255) DEFAULT NULL COMMENT 'Cache segment 8.',
  KEY `timestamp` (`timestamp`),
  KEY `c1` (`c1`),
  KEY `c2` (`c2`),
  KEY `c3` (`c3`),
  KEY `c4` (`c4`),
  KEY `c5` (`c5`),
  KEY `c6` (`c6`),
  KEY `c7` (`c7`),
  KEY `c8` (`c8`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores timestamps for various cache segments showing the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `views_data_export`
--

DROP TABLE IF EXISTS `views_data_export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views_data_export` (
  `eid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique id for each on-going export.',
  `view_name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The unique name of the view. This is the primary field views are loaded from, and is used so that views may be internal and not necessarily in the database. May only be alphanumeric characters plus underscores.',
  `view_display_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'The unique name of the view. This is the primary field views are loaded from, and is used so that views may be internal and not necessarily in the database. May only be alphanumeric characters plus underscores.',
  `time_stamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The time this export started',
  `fid` int(10) unsigned NOT NULL COMMENT 'Files ID.',
  `batch_state` varchar(32) NOT NULL DEFAULT 'init' COMMENT 'The current state of the batch.',
  `sandbox` longblob,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keep track of currently executing exports.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `views_data_export_object_cache`
--

DROP TABLE IF EXISTS `views_data_export_object_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views_data_export_object_cache` (
  `eid` varchar(64) DEFAULT NULL COMMENT 'The export ID this view equates too.',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The time this cache was created or updated.',
  `data` longtext COMMENT 'Serialized data being stored.',
  KEY `eid` (`eid`),
  KEY `updated` (`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A modified version of the views_object_cache that ignores...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `views_display`
--

DROP TABLE IF EXISTS `views_display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views_display` (
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The view this display is attached to.',
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT 'An identifier for this display; usually generated from the display_plugin, so should be something like page or page_1 or block_2, etc.',
  `display_title` varchar(64) NOT NULL DEFAULT '' COMMENT 'The title of the display, viewable by the administrator.',
  `display_plugin` varchar(64) NOT NULL DEFAULT '' COMMENT 'The type of the display. Usually page, block or embed, but is pluggable so may be other things.',
  `position` int(11) DEFAULT '0' COMMENT 'The order in which this display is loaded.',
  `display_options` longtext COMMENT 'A serialized array of options for this display; it contains options that are generally only pertinent to that display plugin type.',
  PRIMARY KEY (`vid`,`id`),
  KEY `vid` (`vid`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each display attached to a view.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `views_view`
--

DROP TABLE IF EXISTS `views_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views_view` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The view ID of the field, defined by the database.',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The unique name of the view. This is the primary field views are loaded from, and is used so that views may be internal and not necessarily in the database. May only be alphanumeric characters plus underscores.',
  `description` varchar(255) DEFAULT '' COMMENT 'A description of the view for the admin interface.',
  `tag` varchar(255) DEFAULT '' COMMENT 'A tag used to group/sort views in the admin interface',
  `base_table` varchar(64) NOT NULL DEFAULT '' COMMENT 'What table this view is based on, such as node, user, comment, or term.',
  `human_name` varchar(255) DEFAULT '' COMMENT 'A human readable name used to be displayed in the admin interface',
  `core` int(11) DEFAULT '0' COMMENT 'Stores the drupal core version of the view.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 COMMENT='Stores the general data for a view.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `votingapi_cache`
--

DROP TABLE IF EXISTS `votingapi_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votingapi_cache` (
  `vote_cache_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(64) NOT NULL DEFAULT 'node',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` float NOT NULL DEFAULT '0',
  `value_type` varchar(64) NOT NULL DEFAULT 'percent',
  `tag` varchar(64) NOT NULL DEFAULT 'vote',
  `function` varchar(64) NOT NULL DEFAULT '',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`vote_cache_id`),
  KEY `content` (`entity_type`,`entity_id`),
  KEY `content_function` (`entity_type`,`entity_id`,`function`),
  KEY `content_tag_func` (`entity_type`,`entity_id`,`tag`,`function`),
  KEY `content_vtype_tag` (`entity_type`,`entity_id`,`value_type`,`tag`),
  KEY `content_vtype_tag_func` (`entity_type`,`entity_id`,`value_type`,`tag`,`function`)
) ENGINE=InnoDB AUTO_INCREMENT=98616 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `votingapi_vote`
--

DROP TABLE IF EXISTS `votingapi_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votingapi_vote` (
  `vote_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(64) NOT NULL DEFAULT 'node',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0',
  `value` float NOT NULL DEFAULT '0',
  `value_type` varchar(64) NOT NULL DEFAULT 'percent',
  `tag` varchar(64) NOT NULL DEFAULT 'vote',
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `vote_source` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vote_id`),
  KEY `content_uid` (`entity_type`,`entity_id`,`uid`),
  KEY `content_uid_2` (`entity_type`,`uid`),
  KEY `content_source` (`entity_type`,`entity_id`,`vote_source`),
  KEY `content_value_tag` (`entity_type`,`entity_id`,`value_type`,`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=45268 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `watchdog`
--

DROP TABLE IF EXISTS `watchdog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchdog` (
  `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example `user` or `page not found.`',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.',
  PRIMARY KEY (`wid`),
  KEY `type` (`type`),
  KEY `uid` (`uid`),
  KEY `severity` (`severity`)
) ENGINE=InnoDB AUTO_INCREMENT=629843289 DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webform`
--

DROP TABLE IF EXISTS `webform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform` (
  `nid` int(10) unsigned NOT NULL COMMENT 'The node identifier of a webform.',
  `confirmation` text NOT NULL COMMENT 'The confirmation message or URL displayed to the user after submitting a form.',
  `confirmation_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the confirmation message.',
  `redirect_url` varchar(255) DEFAULT '<confirmation>' COMMENT 'The URL a user is redirected to after submitting a form.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value of a webform for open (1) or closed (0).',
  `block` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether this form be available as a block.',
  `teaser` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether the entire form should be displayed on the teaser.',
  `allow_draft` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether submissions to this form be saved as a draft.',
  `auto_save` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether submissions to this form should be auto-saved between pages.',
  `submit_notice` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value for whether to show or hide the previous submissions notification.',
  `submit_text` varchar(255) DEFAULT NULL COMMENT 'The title of the submit button on the form.',
  `submit_limit` tinyint(4) NOT NULL DEFAULT '-1' COMMENT 'The number of submissions a single user is allowed to submit within an interval. -1 is unlimited.',
  `submit_interval` int(11) NOT NULL DEFAULT '-1' COMMENT 'The amount of time in seconds that must pass before a user can submit another submission within the set limit.',
  `total_submit_limit` int(11) NOT NULL DEFAULT '-1' COMMENT 'The total number of submissions allowed within an interval. -1 is unlimited.',
  `total_submit_interval` int(11) NOT NULL DEFAULT '-1' COMMENT 'The amount of time in seconds that must pass before another submission can be submitted within the set limit.',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for storing additional properties for webform nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webform_component`
--

DROP TABLE IF EXISTS `webform_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_component` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `cid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'If this component has a parent fieldset, the cid of that component.',
  `form_key` varchar(128) DEFAULT NULL COMMENT 'When the form is displayed and processed, this key can be used to reference the results.',
  `name` varchar(255) DEFAULT NULL COMMENT 'The label for this component.',
  `type` varchar(16) DEFAULT NULL COMMENT 'The field type of this component (textfield, select, hidden, etc.).',
  `value` text NOT NULL COMMENT 'The default value of the component when displayed to the end-user.',
  `extra` text NOT NULL COMMENT 'Additional information unique to the display or processing of this component.',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean flag for if this component is required.',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Determines the position of this component in the form.',
  PRIMARY KEY (`nid`,`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about components for webform nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webform_emails`
--

DROP TABLE IF EXISTS `webform_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_emails` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `eid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The e-mail identifier for this row’s settings.',
  `email` text COMMENT 'The e-mail address that will be sent to upon submission. This may be an e-mail address, the special key `default` or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `subject` varchar(255) DEFAULT NULL COMMENT 'The e-mail subject that will be used. This may be a string, the special key `default` or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_name` varchar(255) DEFAULT NULL COMMENT 'The e-mail `from` name that will be used. This may be a string, the special key `default` or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_address` varchar(255) DEFAULT NULL COMMENT 'The e-mail `from` e-mail address that will be used. This may be a string, the special key `default` or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `template` text COMMENT 'A template that will be used for the sent e-mail. This may be a string or the special key `default`, which will use the template provided by the theming layer.',
  `excluded_components` text NOT NULL COMMENT 'A list of components that will not be included in the %email_values token. A list of CIDs separated by commas.',
  `html` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will be sent in an HTML format. Requires Mime Mail module.',
  `attachments` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will include file attachments. Requires Mime Mail module.',
  PRIMARY KEY (`nid`,`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information regarding e-mails that should be sent...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webform_last_download`
--

DROP TABLE IF EXISTS `webform_last_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_last_download` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The user identifier.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The last downloaded submission number.',
  `requested` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Timestamp of last download request.',
  PRIMARY KEY (`nid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores last submission number per user download.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webform_roles`
--

DROP TABLE IF EXISTS `webform_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_roles` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The role identifier.',
  PRIMARY KEY (`nid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds access information regarding which roles are...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webform_submissions`
--

DROP TABLE IF EXISTS `webform_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_submissions` (
  `sid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for this submission.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The id of the user that completed this submission.',
  `is_draft` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this a draft of the submission?',
  `submitted` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of when the form was submitted.',
  `remote_addr` varchar(128) DEFAULT NULL COMMENT 'The IP address of the user that submitted the form.',
  PRIMARY KEY (`sid`),
  UNIQUE KEY `sid_nid` (`sid`,`nid`),
  KEY `nid_uid_sid` (`nid`,`uid`,`sid`),
  KEY `nid_sid` (`nid`,`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=10339 DEFAULT CHARSET=utf8 COMMENT='Holds general information about submissions outside of...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webform_submitted_data`
--

DROP TABLE IF EXISTS `webform_submitted_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_submitted_data` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier for this submission.',
  `cid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `no` varchar(128) NOT NULL DEFAULT '0' COMMENT 'Usually this value is 0, but if a field has multiple values (such as a time or date), it may require multiple rows in the database.',
  `data` mediumtext NOT NULL COMMENT 'The submitted value of this field, may be serialized for some components.',
  PRIMARY KEY (`nid`,`sid`,`cid`,`no`),
  KEY `nid` (`nid`),
  KEY `sid_nid` (`sid`,`nid`),
  KEY `data` (`data`(64))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all submitted field data for webform submissions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `xmlsitemap`
--

DROP TABLE IF EXISTS `xmlsitemap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xmlsitemap` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary key with type; a unique id for the item.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary key with id; the type of item (e.g. node, user, etc.).',
  `subtype` varchar(128) NOT NULL DEFAULT '' COMMENT 'A sub-type identifier for the link (node type, menu name, term VID, etc.).',
  `loc` varchar(255) NOT NULL DEFAULT '' COMMENT 'The URL to the item relative to the Drupal path.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this link or an empty string if it is language-neutral.',
  `access` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'A boolean that represents if the item is viewable by the anonymous user. This field is useful to store the result of node_access() so we can retain changefreq and priority_override information.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'An integer that represents if the item is included in the sitemap.',
  `status_override` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean that if TRUE means that the status field has been overridden from its default value.',
  `lastmod` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The UNIX timestamp of last modification of the item.',
  `priority` float DEFAULT NULL COMMENT 'The priority of this URL relative to other URLs on your site. Valid values range from 0.0 to 1.0.',
  `priority_override` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean that if TRUE means that the priority field has been overridden from its default value.',
  `changefreq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The average time in seconds between changes of this item.',
  `changecount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this item has been changed. Used to help calculate the next changefreq value.',
  PRIMARY KEY (`id`,`type`),
  KEY `loc` (`loc`),
  KEY `access_status_loc` (`access`,`status`,`loc`),
  KEY `type_subtype` (`type`,`subtype`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for xmlsitemap links.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `xmlsitemap_sitemap`
--

DROP TABLE IF EXISTS `xmlsitemap_sitemap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xmlsitemap_sitemap` (
  `smid` varchar(64) NOT NULL COMMENT 'The sitemap ID (the hashed value of xmlsitemap.context.',
  `context` text NOT NULL COMMENT 'Serialized array with the sitemaps context',
  `updated` int(10) unsigned NOT NULL DEFAULT '0',
  `links` int(10) unsigned NOT NULL DEFAULT '0',
  `chunks` int(10) unsigned NOT NULL DEFAULT '0',
  `max_filesize` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`smid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-02 11:16:32
