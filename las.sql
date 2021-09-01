-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 12, 2021 at 07:42 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `helpdesk-live-database`
--

-- --------------------------------------------------------

--
-- Table structure for table `migration_versions`
--

CREATE TABLE `migration_versions` (
  `version` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `executed_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migration_versions`
--

INSERT INTO `migration_versions` (`version`, `executed_at`) VALUES
('20210514073631', '2021-05-14 07:36:40'),
('20210517131032', '2021-05-17 13:12:04'),
('20210531074715', '2021-05-31 07:48:25'),
('20210623084956', '2021-06-28 05:10:03'),
('20210625060351', '2021-06-28 05:10:04'),
('20210705121222', '2021-07-05 12:12:32');

-- --------------------------------------------------------

--
-- Table structure for table `recaptcha`
--

CREATE TABLE `recaptcha` (
  `id` int(11) NOT NULL,
  `site_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `recaptcha`
--

INSERT INTO `recaptcha` (`id`, `site_key`, `secret_key`, `is_active`) VALUES
(1, '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `uv_admin_support_groups`
--

CREATE TABLE `uv_admin_support_groups` (
  `adminUserInstanceId` int(11) NOT NULL,
  `supportGroupId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_article`
--

CREATE TABLE `uv_article` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `viewed` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `date_added` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `stared` int(11) DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_article_category`
--

CREATE TABLE `uv_article_category` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_article_feedback`
--

CREATE TABLE `uv_article_feedback` (
  `id` int(11) NOT NULL,
  `article_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_helpful` tinyint(1) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_article_history`
--

CREATE TABLE `uv_article_history` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_article_tags`
--

CREATE TABLE `uv_article_tags` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_article_view_log`
--

CREATE TABLE `uv_article_view_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `article_id` int(11) DEFAULT NULL,
  `viewed_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_email_templates`
--

CREATE TABLE `uv_email_templates` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `template_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_predefined` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_email_templates`
--

INSERT INTO `uv_email_templates` (`id`, `user_id`, `name`, `subject`, `message`, `template_type`, `is_predefined`) VALUES
(1, NULL, 'User Forgot Password', 'Update your {%global.companyName%} helpdesk password', '    <p></p>\n    <p></p>\n    <p></p>\n    <p></p>\n    <p style=\"text-align: center; \">{%global.companyLogo%}</p>\n    <p style=\"text-align: center; \">\n        <br />\n    </p>\n    <p>Hi&nbsp;{%user.userName%},\n        <br />\n    </p>\n    <p>\n        <br />\n    </p>\n    <p>You recently requested to reset your password for your {%global.companyName%} account. Click the link to reset it&nbsp;{%user.forgotPasswordLink%}</p>\n    <p>\n        <br />\n    </p>\n    <p>If you did not request a password reset, please ignore this mail or revert back to let us know.</p>\n    <div>\n        <br />\n    </div>\n    <p>Thanks and Regards</p>\n    <p>{%global.companyName%}</p>\n    <p></p>\n    <p></p>', 'user', 1),
(2, NULL, 'Agent Reply To The Customer\'s ticket', 'New Reply Added on ticket #{% ticket.id %}', '    <p></p>\n    <p></p>\n    <p></p>\n    <p></p>\n    <p style=\"text-align: center\">{%global.companyLogo%}</p>\n    <p style=\"text-align: center\">\n        <br>\n    </p>\n    <p style=\"text-align: center\">\n        <span style=\"font-size: 18px\">\n            <b style=\"font-weight:bold\">New Response!!</b>\n        </span>\n    </p>\n    <span style=\"font-size: 18px\">\n        <b style=\"font-weight:bold\"> </b>\n    </span>\n    <p>\n        <br>\n    </p>\n    <p></p>\n    <p></p> Hello {%ticket.customerName%},\n    <p></p>\n    <p></p>\n    <p>\n        <span style=\"line-height: 1.42857\">\n            <br>\n        </span>\n    </p>\n    <p>\n        <span style=\"line-height: 1.42857\">A reply has been added by the </span>{%ticket.agentName%} on your ticket {%ticket.id%}. Kindly follow this link {%ticket.customerLink%}\n        to get the insight of the message.\n        <span style=\"line-height: 1.42857\"> </span>\n    </p>\n    <p>\n        <span style=\"line-height: 1.42857\">\n            <br>\n        </span>\n    </p>\n    <p>\n        <span style=\"line-height: 1.42857\">Here go the ticket message:</span>\n    </p>\n    <p>{%ticket.threadMessage%}{%ticket.attachments%}\n        <br>\n    </p>\n    <p></p>\n    <p></p>\n    <p>\n        <br>\n    </p>\n    <p></p>\n    <p>Thanks and Regards</p>\n    <p>{%global.companyName%}\n        <br>\n    </p>\n    <br>\n    <p></p>\n    <p></p>\n    <p></p>\n    <p></p>\n    <p></p>', 'ticket', 1),
(3, NULL, 'Ticket generated by customer', 'A new ticket #{%ticket.id%} has been generated by {%ticket.customerName%}', '<p></p>\n<p></p>\n<p style=\"text-align: center; \">{%global.companyLogo%}</p>\n<p style=\"text-align: center; \">\n    <br />\n</p>\n<p style=\"text-align: center; \">\n    <b>\n        <span style=\"font-size: 18px;\">Ticket generated!!</span>\n    </b>\n</p>\n<br />Hello {%ticket.agentName%},\n<p></p>\n<p>\n    <br />\n</p>\n<p>A new ticket {%ticket.id%} has been generated by {%ticket.customerName%} from the id {%ticket.customerEmail%}. Hit on the link provided so that you can have the access to the ticket {%ticket.agentLink%}.</p>\n<p>\n    <br />\n</p>\n<p>Here goes the ticket message:</p>\n<p>{%ticket.message%}\n    <br />\n</p>\n<p>\n    <br />\n</p>\n<p>\n    <br />\n</p> Thanks and Regards\n<p></p>\n<p>{%global.companyName%}\n    <br />\n</p>\n<p></p>\n<p></p>', 'ticket', 1),
(4, NULL, 'Agent Account Created', 'Welcome to {%global.companyName%} Helpdesk Support System', '    <p></p>\n    <p></p>\n    <p></p>\n    <p style=\"text-align: center; \">{%global.companyLogo%}</p>\n    <p style=\"text-align: center; \">\n        <span style=\"font-size: 18px;\">\n            <b>Thank you for joining!!</b>\n        </span>\n    </p>\n    <p style=\"text-align: center; \">\n        <i>\n            <br />\n        </i>\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">Hello&nbsp;{%user.userName%},</p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">\n        <br />\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">Your account has been successfully created.</p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\"\n        align=\"left\">\n        <br />\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">\n        <span style=\"line-height: 100%;\">Click on the link to set your password </span>{%user.accountValidationLink%}\n        <span style=\"line-height: 100%;\">&nbsp;and get started with the </span>{%global.companyName%}\n        <span style=\"line-height: 100%;\">&nbsp;services.</span>\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">\n        <span style=\"line-height: 100%;\">\n            <br />\n        </span>\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">Thanks and Regards\n        <br />\n    </p>\n    <p>{%global.companyName%}</p>\n    <p>\n        <br />\n    </p>\n    <p></p>', 'user', 1),
(5, NULL, 'Ticket Assign', 'Ticket #{% ticket.id %} assign to you', '    <p></p>\n    <p style=\"text-align: center;\">{%global.companyLogo%}</p>\n    <p style=\"text-align: center;\">\n        <br />\n    </p>\n    <p style=\"text-align: center;\">\n        <b>\n            <span style=\"font-size: 18px;\">Ticket assigned- Get ready!!</span>\n        </b>\n    </p>\n    <p style=\"text-align: center; \">\n        <br />\n    </p> Hello&nbsp;{%ticket.agentName%},\n    <br />\n    <br />\n    <p></p>\n    <p>A ticket&nbsp;{%ticket.id%} has been assigned to you. You are requested to follow this link&nbsp;{%ticket.agentLink%} to get the\n        access of the ticket.</p>\n    <p>\n        <br />\n    </p>\n    <p>Here go the ticket message:</p>\n    <p>{%ticket.message%}\n        <br />\n    </p>\n    <p>\n        <br />\n    </p>\n    <p>Thanks and Regards</p>\n    <p>{%global.companyName%}\n        <br />\n    </p>\n    <p></p>\n    <p>\n        <br />\n    </p>\n    <p></p>\n    <p>\n        <br />\n    </p>\n    <p></p>\n    <p></p>\n    <p></p>\n    <p></p>', 'ticket', 1),
(6, NULL, 'Customer Reply To The Agent', 'Customer Reply Ticket #{% ticket.id %}', '    <p></p>\n    <p></p>\n    <p style=\"text-align: center; \">{%global.companyLogo%}</p>\n    <p style=\"text-align: center; \">\n        <br />\n    </p>\n    <p style=\"text-align: center; \">\n        <b>\n            <span style=\"font-size: 18px;\">New Response!!</span>\n        </b>\n    </p>\n    <p style=\"text-align: center; \">\n        <b>\n            <span style=\"font-size: 18px;\">\n                <br />\n            </span>\n        </b>\n    </p> Hello {%ticket.agentName%},</p>\n    <p></p>\n    <p>\n        <br />\n    </p>\n    <p></p>\n    <p></p>\n    <p>\n        <span style=\"line-height: 1.42857143;\">New reply have been added to ticket #{%ticket.id%} you can login to ticket system through this link&nbsp;{%ticket.agentLink%}.</span>\n    </p>\n    <p>\n        <span style=\"line-height: 1.42857143;\">&nbsp;</span>\n    </p>\n    <p>\n        <span style=\"line-height: 1.42857143;\">Customer reply:\n            <br />\n        </span>{%ticket.threadMessage%}{%ticket.attachments%}</p>\n    <p>\n        <br />\n    </p>\n    <p>Thanks and Regards</p>\n    <p>{%global.companyName%}\n        <br />\n    </p>\n    <p>\n        <br />\n    </p>\n    <p></p>', 'ticket', 1),
(7, NULL, 'Ticket generated success mail to customer', 'New ticket #{% ticket.id %} Received', '<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p style=\"text-align: center;\">{%global.companyLogo%}</p>\n<p style=\"text-align: center;\">\n    <br />\n</p>\n<p style=\"text-align: center;\">\n    <b>\n        <span style=\"font-size: 18px;\">Ticket generated!!</span>\n    </b>\n</p>\n<p style=\"text-align: center; \">\n    <br />\n</p>\n<br />\n<p></p>\n<p>Hello&nbsp;{%ticket.customerName%},</p>\n<p>\n    <br />\n</p>\n<p></p>\n<p>Thank you so much for taking the time to connect us!</p>\n<p>\n    <br />\n</p>\n<p>Your ticket #{%ticket.id%} has been received. You can check ticket through this link {%ticket.customerLink%} and you can also reply via this email.</p>\n<p>\n<p>\n    <br />\n</p>\n<p>Our support staff will get back to you shortly (it might take a bit longer on evenings and weekends). Feel free to ask for any support request we will be happy to help.</p>\n<p>\n    <span style=\"line-height: 1.42857143;\">\n        <br />\n    </span>\n</p>\n<p>Thanks and Regards</p>\n<p>{%global.companyName%}\n    <br />\n</p>\n<br />\n<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p></p>\n<p></p>', 'ticket', 1),
(8, NULL, 'Customer Account Created', 'Welcome to {%global.companyName%} Helpdesk', '    <p></p>\n    <p></p>\n    <p></p>\n    <p style=\"text-align: center; \">{%global.companyLogo%}</p>\n    <p style=\"text-align: center; \">\n        <br />\n    </p>\n    <p style=\"text-align: center; \">\n        <span style=\"font-size: 18px;\">\n            <b>Thank you for joining!!</b>\n        </span>\n    </p>\n    <p style=\"text-align: center; \">\n        <i>\n            <br />\n        </i>\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">Hello&nbsp;{%user.userName%},</p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">\n        <br />\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">Your account has been successfully created. We welcome&nbsp;you to the community of&nbsp;{%global.companyName%}.</p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\"\n        align=\"left\">\n        <br />\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">It is our privilege to have you as our customer. We are pretty much sure that you will love the fact that how simple it is\n        to get started with the services. We are dedicated to making your working life simpler.</p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\"\n        align=\"left\">\n        <br />\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">\n        <span style=\"line-height: 100%;\">Click on the link to set your password </span>{%user.accountValidationLink%}\n        <span style=\"line-height: 100%;\">&nbsp;and get started with the </span>{%global.companyName%}\n        <span style=\"line-height: 100%;\">&nbsp;services.</span>\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">\n        <span style=\"line-height: 100%;\">\n            <br />\n        </span>\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">Hoping that you will enjoy this experience.</p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">\n        <br />\n    </p>\n    <p style=\"margin-bottom: 0cm; line-height: 100%\" align=\"left\">Thanks and Regards\n        <br />\n    </p>\n    <p>{%global.companyName%}</p>\n    <p>\n        <br />\n    </p>\n    <p></p>', 'user', 1);

-- --------------------------------------------------------

--
-- Table structure for table `uv_lead_support_teams`
--

CREATE TABLE `uv_lead_support_teams` (
  `leadUserInstanceId` int(11) NOT NULL,
  `supportTeamId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_prepared_responses`
--

CREATE TABLE `uv_prepared_responses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'public',
  `actions` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `status` tinyint(1) DEFAULT 1,
  `date_added` datetime NOT NULL,
  `date_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_prepared_response_support_groups`
--

CREATE TABLE `uv_prepared_response_support_groups` (
  `group_id` int(11) NOT NULL,
  `savedReply_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_prepared_response_support_teams`
--

CREATE TABLE `uv_prepared_response_support_teams` (
  `subgroup_id` int(11) NOT NULL,
  `savedReply_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_related_articles`
--

CREATE TABLE `uv_related_articles` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `related_article_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_related_articles`
--

INSERT INTO `uv_related_articles` (`id`, `article_id`, `related_article_id`) VALUES
(1, 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `uv_saved_filters`
--

CREATE TABLE `uv_saved_filters` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filtering` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `date_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_saved_replies`
--

CREATE TABLE `uv_saved_replies` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `template_id` int(11) DEFAULT NULL,
  `is_predefind` tinyint(1) DEFAULT 1,
  `message_inline` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `template_for` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_saved_replies_groups`
--

CREATE TABLE `uv_saved_replies_groups` (
  `group_id` int(11) NOT NULL,
  `savedReply_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_saved_replies_teams`
--

CREATE TABLE `uv_saved_replies_teams` (
  `subgroup_id` int(11) NOT NULL,
  `savedReply_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_solutions`
--

CREATE TABLE `uv_solutions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visibility` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 5,
  `date_added` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `solution_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_solution_category`
--

CREATE TABLE `uv_solution_category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT 1,
  `sorting` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'ascending',
  `date_added` datetime NOT NULL,
  `status` int(11) DEFAULT 0,
  `date_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_solution_category_mapping`
--

CREATE TABLE `uv_solution_category_mapping` (
  `id` int(11) NOT NULL,
  `solution_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_support_company`
--

CREATE TABLE `uv_support_company` (
  `id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_support_company`
--

INSERT INTO `uv_support_company` (`id`, `name`, `description`, `created_at`, `is_active`) VALUES
(2, 'Japara Noosa', 'Japara Noosa', '2021-06-30 01:46:09', 1),
(3, 'OPAL Perth Center', 'OPAL Perth Center', '2021-06-30 03:55:26', 1),
(4, 'OPAL Brisbane Center', 'OPAL Brisbane Center', '2021-06-30 03:56:23', 1),
(5, 'Japara Sydney Center', 'Japara Sydney Center', '2021-06-30 03:58:56', 1),
(6, 'Hardi Melbourne Center', 'Hardi Melbourne Center', '2021-06-30 03:59:27', 0);

-- --------------------------------------------------------

--
-- Table structure for table `uv_support_group`
--

CREATE TABLE `uv_support_group` (
  `id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `user_view` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_support_group`
--

INSERT INTO `uv_support_group` (`id`, `name`, `description`, `created_at`, `is_active`, `user_view`) VALUES
(2, 'Opal WA', 'Opal WA', '2021-05-14 11:25:24', 1, 0),
(5, 'Opal QLD', 'Opal QLD', '2021-06-14 00:57:13', 1, 0),
(6, 'Japara NSW', 'Japara NSW', '2021-06-14 01:14:18', 1, 0),
(7, 'Japara QLD', 'Japara QLD', '2021-06-15 02:20:15', 1, 0),
(8, 'Hardi VICTORIA', 'Hardi VICTORIA', '2021-06-15 02:22:26', 1, 0),
(9, 'Allity TASMANIA', 'Allity TASMANIA', '2021-06-15 02:26:22', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `uv_support_groups_companies`
--

CREATE TABLE `uv_support_groups_companies` (
  `supportGroup_id` int(11) NOT NULL,
  `supportCompany_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_support_groups_companies`
--

INSERT INTO `uv_support_groups_companies` (`supportGroup_id`, `supportCompany_id`) VALUES
(2, 3),
(5, 4),
(6, 5),
(7, 2),
(8, 6);

-- --------------------------------------------------------

--
-- Table structure for table `uv_support_groups_teams`
--

CREATE TABLE `uv_support_groups_teams` (
  `supportGroup_id` int(11) NOT NULL,
  `supportTeam_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_support_groups_teams`
--

INSERT INTO `uv_support_groups_teams` (`supportGroup_id`, `supportTeam_id`) VALUES
(2, 6),
(5, 6),
(6, 4),
(7, 4),
(8, 5),
(9, 3);

-- --------------------------------------------------------

--
-- Table structure for table `uv_support_label`
--

CREATE TABLE `uv_support_label` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_support_label`
--

INSERT INTO `uv_support_label` (`id`, `user_id`, `name`, `color_code`) VALUES
(6, 18, 'JAPARA', '#E5549F'),
(7, 18, 'HARDI', '#FEBF00'),
(8, 18, 'OPAL WA', '#337CFF'),
(9, 18, 'OPAL QLD', '#337CFF'),
(10, 18, 'ALLITY', '#FB8A3F');

-- --------------------------------------------------------

--
-- Table structure for table `uv_support_privilege`
--

CREATE TABLE `uv_support_privilege` (
  `id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `privileges` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:array)',
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_support_privilege`
--

INSERT INTO `uv_support_privilege` (`id`, `name`, `description`, `privileges`, `created_at`) VALUES
(1, 'Default Privileges', 'Default Privileges', 'a:4:{i:0;s:31:\"ROLE_AGENT_UPDATE_TICKET_STATUS\";i:1;s:33:\"ROLE_AGENT_UPDATE_TICKET_PRIORITY\";i:2;s:29:\"ROLE_AGENT_UPDATE_TICKET_TYPE\";i:3;s:19:\"ROLE_AGENT_ADD_NOTE\";}', '2021-05-14 09:36:41'),
(2, 'Can Create Ticket', 'Can Create Ticket', 'a:2:{i:0;s:24:\"ROLE_AGENT_CREATE_TICKET\";i:1;s:31:\"ROLE_AGENT_MANAGE_KNOWLEDGEBASE\";}', '2021-05-17 09:47:02');

-- --------------------------------------------------------

--
-- Table structure for table `uv_support_role`
--

CREATE TABLE `uv_support_role` (
  `id` int(11) NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_support_role`
--

INSERT INTO `uv_support_role` (`id`, `code`, `description`) VALUES
(1, 'ROLE_SUPER_ADMIN', 'Account Owner'),
(2, 'ROLE_ADMIN', 'Administrator'),
(3, 'ROLE_AGENT', 'Agent'),
(4, 'ROLE_CUSTOMER', 'Customer');

-- --------------------------------------------------------

--
-- Table structure for table `uv_support_team`
--

CREATE TABLE `uv_support_team` (
  `id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_support_team`
--

INSERT INTO `uv_support_team` (`id`, `name`, `description`, `created_at`, `is_active`) VALUES
(3, 'ALLITY', 'MAin Company', '2021-05-24 13:20:06', 1),
(4, 'JAPARA', 'Main Company', '2021-05-24 16:47:07', 1),
(5, 'Hardi', 'Main Company', '2021-06-04 05:56:26', 1),
(6, 'OPAL', 'Main Company', '2021-06-11 03:35:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `uv_tag`
--

CREATE TABLE `uv_tag` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_thread`
--

CREATE TABLE `uv_thread` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_id` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thread_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cc` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:array)',
  `bcc` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:array)',
  `reply_to` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:array)',
  `delivery_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT 0,
  `is_bookmarked` tinyint(1) NOT NULL DEFAULT 0,
  `message` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `agent_viewed_at` datetime DEFAULT NULL,
  `customer_viewed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_ticket`
--

CREATE TABLE `uv_ticket` (
  `id` int(11) NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  `priority_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mailbox_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_ids` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_new` tinyint(1) NOT NULL DEFAULT 1,
  `is_replied` tinyint(1) NOT NULL DEFAULT 0,
  `is_reply_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `is_starred` tinyint(1) NOT NULL DEFAULT 0,
  `is_trashed` tinyint(1) NOT NULL DEFAULT 0,
  `is_agent_viewed` tinyint(1) NOT NULL DEFAULT 0,
  `is_customer_viewed` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `subGroup_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_tickets_collaborators`
--

CREATE TABLE `uv_tickets_collaborators` (
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_tickets_labels`
--

CREATE TABLE `uv_tickets_labels` (
  `ticket_id` int(11) NOT NULL,
  `label_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_tickets_organizations`
--

CREATE TABLE `uv_tickets_organizations` (
  `ticket_id` int(11) NOT NULL,
  `organization_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_tickets_tags`
--

CREATE TABLE `uv_tickets_tags` (
  `ticket_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_ticket_attachments`
--

CREATE TABLE `uv_ticket_attachments` (
  `id` int(11) NOT NULL,
  `thread_id` int(11) DEFAULT NULL,
  `name` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `content_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_system` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_ticket_priority`
--

CREATE TABLE `uv_ticket_priority` (
  `id` int(11) NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_ticket_priority`
--

INSERT INTO `uv_ticket_priority` (`id`, `code`, `description`, `color_code`) VALUES
(1, 'low', 'Low', '#2DD051'),
(2, 'medium', 'Medium', '#F5D02A'),
(3, 'high', 'High', '#FA8B3C'),
(4, 'urgent', 'Urgent', '#FF6565');

-- --------------------------------------------------------

--
-- Table structure for table `uv_ticket_rating`
--

CREATE TABLE `uv_ticket_rating` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `stars` int(11) NOT NULL DEFAULT 0,
  `feedback` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_ticket_status`
--

CREATE TABLE `uv_ticket_status` (
  `id` int(11) NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_ticket_status`
--

INSERT INTO `uv_ticket_status` (`id`, `code`, `description`, `color_code`, `sort_order`) VALUES
(1, 'open', 'Open', '#7E91F0', 1),
(2, 'inprogress', 'In Progress', '#FF6A6B', 2),
(3, 'waitingoncustomer', 'Waiting on Customer', '#FFDE00', 3),
(4, 'resolved', 'Resolved', '#2CD651', 4),
(5, 'closed', 'Closed', '#767676', 5),
(6, 'Spam', 'Spam', '#00A1F2', 6);

-- --------------------------------------------------------

--
-- Table structure for table `uv_ticket_status_log`
--

CREATE TABLE `uv_ticket_status_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `changed_at` datetime NOT NULL,
  `old_status` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_status` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `uv_ticket_type`
--

CREATE TABLE `uv_ticket_type` (
  `id` int(11) NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_ticket_type`
--

INSERT INTO `uv_ticket_type` (`id`, `code`, `description`, `is_active`) VALUES
(3, 'Query', 'Query', 1),
(4, 'Issue', 'Issue', 1),
(5, 'Quote', 'Quote', 1),
(6, 'LATE CHECK-IN', 'Late Check-in', 1),
(7, 'INTERFACE FAULT', 'Interface Fault', 1);

-- --------------------------------------------------------

--
-- Table structure for table `uv_user`
--

CREATE TABLE `uv_user` (
  `id` int(11) NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proxy_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `verification_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timezone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timeformat` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_user`
--

INSERT INTO `uv_user` (`id`, `email`, `proxy_id`, `password`, `first_name`, `last_name`, `is_enabled`, `verification_code`, `timezone`, `timeformat`) VALUES
(16, 'chirs@yopmail.com', NULL, '$argon2id$v=19$m=65536,t=4,p=1$hDgnMObn9OPDlaFB66t4Lg$4H01zRlt0LClUbIRw+lvJ0Iy5mc4ZSJQSmQFP8cKJ3I', 'Chris', 'Japara', 1, 'lU1rXTprV7yE5OL5R0Wc0dnSn6blVhM5', NULL, NULL),
(18, 'chris@las.com.au', NULL, '$argon2id$v=19$m=65536,t=4,p=1$+WQSUUYz2rqy0QMH7zRRYQ$76SpjD4inZ03RidXoO0iBa8jsH1bnvRXWuJMpIZ3VjI', 'Chris', 'LAS', 1, 'smtc3pBTbUt9AP7k857Eb4zYRcorAXm1', 'Asia/Kolkata', 'm-d-y h:ia');

-- --------------------------------------------------------

--
-- Table structure for table `uv_user_instance`
--

CREATE TABLE `uv_user_instance` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skype_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signature` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_image_path` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `is_starred` tinyint(1) NOT NULL DEFAULT 0,
  `ticket_access_level` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supportRole_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_user_instance`
--

INSERT INTO `uv_user_instance` (`id`, `user_id`, `source`, `skype_id`, `contact_number`, `designation`, `signature`, `profile_image_path`, `created_at`, `updated_at`, `is_active`, `is_verified`, `is_starred`, `ticket_access_level`, `supportRole_id`) VALUES
(16, 16, 'website', NULL, '111111111', 'Organization agent', '', NULL, '2021-06-04 05:55:50', '2021-07-20 13:37:47', 1, 0, 0, '5', 3),
(18, 18, 'website', NULL, '', '', 'Chris', '/assets/profile/Zl0TA5YsVlx3Ki9A.png', '2021-06-14 06:00:22', '2021-07-07 02:29:11', 1, 0, 0, NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `uv_user_support_companies`
--

CREATE TABLE `uv_user_support_companies` (
  `userInstanceId` int(11) NOT NULL,
  `supportCompanyId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_user_support_companies`
--

INSERT INTO `uv_user_support_companies` (`userInstanceId`, `supportCompanyId`) VALUES
(16, 5),
(18, 2),
(18, 3),
(18, 4),
(18, 5),
(18, 6);

-- --------------------------------------------------------

--
-- Table structure for table `uv_user_support_groups`
--

CREATE TABLE `uv_user_support_groups` (
  `userInstanceId` int(11) NOT NULL,
  `supportGroupId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_user_support_groups`
--

INSERT INTO `uv_user_support_groups` (`userInstanceId`, `supportGroupId`) VALUES
(16, 6),
(16, 7),
(18, 2),
(18, 5),
(18, 6),
(18, 7),
(18, 8),
(18, 9);

-- --------------------------------------------------------

--
-- Table structure for table `uv_user_support_privileges`
--

CREATE TABLE `uv_user_support_privileges` (
  `userInstanceId` int(11) NOT NULL,
  `supportPrivilegeId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_user_support_privileges`
--

INSERT INTO `uv_user_support_privileges` (`userInstanceId`, `supportPrivilegeId`) VALUES
(16, 1),
(16, 2);

-- --------------------------------------------------------

--
-- Table structure for table `uv_user_support_teams`
--

CREATE TABLE `uv_user_support_teams` (
  `userInstanceId` int(11) NOT NULL,
  `supportTeamId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_user_support_teams`
--

INSERT INTO `uv_user_support_teams` (`userInstanceId`, `supportTeamId`) VALUES
(18, 3),
(18, 4),
(18, 5),
(18, 6);

-- --------------------------------------------------------

--
-- Table structure for table `uv_website`
--

CREATE TABLE `uv_website` (
  `id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme_color` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `favicon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `timezone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timeformat` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_website`
--

INSERT INTO `uv_website` (`id`, `name`, `code`, `logo`, `theme_color`, `favicon`, `created_at`, `updated_at`, `is_active`, `timezone`, `timeformat`) VALUES
(1, 'Support Center', 'helpdesk', NULL, '#0a4b6f', NULL, '2021-05-14 09:36:41', '2021-05-14 09:36:41', NULL, 'Australia/Brisbane', 'd-m-y h:ia'),
(2, 'Knowledgebase', 'knowledgebase', '/assets/website/vuvfkZzchtrbor8t.png', '#7E91F0', NULL, '2021-05-14 09:36:41', '2021-05-14 09:36:41', NULL, 'Australia/Brisbane', 'd-m-y h:ia');

-- --------------------------------------------------------

--
-- Table structure for table `uv_website_knowledgebase`
--

CREATE TABLE `uv_website_knowledgebase` (
  `id` int(11) NOT NULL,
  `website` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_background_color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `header_background_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `article_text_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket_create_option` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `homepage_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `white_list` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `black_list` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `broadcast_message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disable_customer_login` tinyint(1) NOT NULL,
  `script` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_css` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `header_links` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:array)',
  `footer_links` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '(DC2Type:array)',
  `banner_background_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_hover_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_required_to_create` tinyint(1) DEFAULT NULL,
  `remove_customer_login_button` int(11) DEFAULT 0,
  `remove_branding_content` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_website_knowledgebase`
--

INSERT INTO `uv_website_knowledgebase` (`id`, `website`, `status`, `brand_color`, `page_background_color`, `header_background_color`, `link_color`, `article_text_color`, `ticket_create_option`, `site_description`, `meta_description`, `meta_keywords`, `homepage_content`, `white_list`, `black_list`, `created_at`, `updated_at`, `broadcast_message`, `disable_customer_login`, `script`, `custom_css`, `is_active`, `header_links`, `footer_links`, `banner_background_color`, `link_hover_color`, `login_required_to_create`, `remove_customer_login_button`, `remove_branding_content`) VALUES
(1, 2, '1', '#0a4b6f', '#ffffff', '#ffffff', '#8899a9', '#333333', '1', 'Hi! how can i help you.', NULL, NULL, 'masonry', NULL, NULL, '2021-05-14 09:36:41', '2021-07-06 03:56:57', NULL, 0, NULL, NULL, 1, 'N;', 'N;', '#0a4b6f', '#7f7f7f', 0, 0, 0),
(2, 2, '1', '#7E91F0', '#FFFFFF', '#FFFFFF', '#2750C4', '#333333', '1', 'Hi! how can i help you.', NULL, NULL, 'masonry', NULL, NULL, '2021-06-02 05:29:30', '2021-06-02 05:29:30', NULL, 0, NULL, NULL, 1, 'N;', 'N;', '#7C70F4', '#2750C4', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `uv_workflow`
--

CREATE TABLE `uv_workflow` (
  `id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conditions` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `actions` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `sort_order` int(11) DEFAULT NULL,
  `is_predefind` tinyint(1) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_added` datetime NOT NULL,
  `date_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_workflow`
--

INSERT INTO `uv_workflow` (`id`, `name`, `description`, `conditions`, `actions`, `sort_order`, `is_predefind`, `status`, `date_added`, `date_updated`) VALUES
(1, 'Customer Created', 'Send customer a welcome email after their account has been created.', 'a:0:{}', 'a:1:{i:2;a:2:{s:4:\"type\";s:29:\"uvdesk.customer.mail_customer\";s:5:\"value\";s:1:\"8\";}}', 9, 1, 1, '2021-05-14 09:36:41', '2021-05-14 09:36:41'),
(2, 'Agent Created', 'Send agent a welcome email when their account is created.', 'a:0:{}', 'a:1:{i:0;a:2:{s:4:\"type\";s:23:\"uvdesk.agent.mail_agent\";s:5:\"value\";s:1:\"4\";}}', 10, 1, 1, '2021-05-14 09:36:41', '2021-05-14 09:36:41'),
(3, 'User Forgot Password', 'Send an email to user with a link to reset their password.', 'a:0:{}', 'a:1:{i:1;a:2:{s:4:\"type\";s:21:\"uvdesk.user.mail_user\";s:5:\"value\";s:1:\"1\";}}', 11, 1, 1, '2021-05-14 09:36:41', '2021-05-14 09:36:41'),
(4, 'Ticket Agent Update - Mail to Agent', 'Send an email to updated agent on ticket', 'a:0:{}', 'a:1:{i:1;a:2:{s:4:\"type\";s:24:\"uvdesk.ticket.mail_agent\";s:5:\"value\";a:2:{s:3:\"for\";a:1:{i:0;s:13:\"assignedAgent\";}s:5:\"value\";s:1:\"5\";}}}', 12, 1, 1, '2021-05-14 09:36:41', '2021-05-14 09:36:41'),
(5, 'Ticket Created', 'Automate actions when ticket is created.', 'N;', 'a:2:{i:0;a:2:{s:4:\"type\";s:27:\"uvdesk.ticket.mail_customer\";s:5:\"value\";s:1:\"7\";}i:2;a:2:{s:4:\"type\";s:24:\"uvdesk.ticket.mail_agent\";s:5:\"value\";a:2:{s:3:\"for\";a:2:{i:0;s:13:\"assignedAgent\";i:1;s:1:\"5\";}s:5:\"value\";s:1:\"3\";}}}', 13, 1, 1, '2021-06-30 04:54:10', '2021-06-30 04:54:10'),
(6, 'Agent Replied on Ticket', 'Send customer an email when reply is added on ticket.', 'a:0:{}', 'a:1:{i:0;a:2:{s:4:\"type\";s:27:\"uvdesk.ticket.mail_customer\";s:5:\"value\";s:1:\"2\";}}', 14, 1, 1, '2021-05-14 09:36:41', '2021-05-14 09:36:41'),
(7, 'Customer Replied on Ticket', 'Send agent an email when reply is added on ticket.', 'a:0:{}', 'a:1:{i:0;a:2:{s:4:\"type\";s:24:\"uvdesk.ticket.mail_agent\";s:5:\"value\";a:2:{s:3:\"for\";a:1:{i:0;s:13:\"assignedAgent\";}s:5:\"value\";s:1:\"6\";}}}', 15, 1, 1, '2021-05-14 09:36:41', '2021-05-14 09:36:41'),
(8, 'Email Subject contains HARDI', 'If the email subject contains a particular keyword or phrase it should be assigned to the relevant organization.\r\n', 'a:1:{i:0;a:4:{s:9:\"operation\";s:2:\"&&\";s:4:\"type\";s:7:\"subject\";s:5:\"match\";s:8:\"contains\";s:5:\"value\";s:5:\"HARDI\";}}', 'a:1:{i:0;a:2:{s:4:\"type\";s:26:\"uvdesk.ticket.assign_agent\";s:5:\"value\";s:1:\"5\";}}', 4, 1, 0, '2021-07-06 02:27:02', '2021-07-06 02:27:02'),
(10, 'To Address', 'If a ticket is sent to a particular email address alias it should be assigned to the relevant organization.', 'a:1:{i:0;a:4:{s:9:\"operation\";s:2:\"&&\";s:4:\"type\";s:7:\"to_mail\";s:5:\"match\";s:2:\"is\";s:5:\"value\";s:24:\"ravi.citrusbug@gmail.com\";}}', 'a:1:{i:0;a:2:{s:4:\"type\";s:25:\"uvdesk.ticket.assign_team\";s:5:\"value\";s:1:\"3\";}}', 8, 1, 1, '2021-06-23 06:39:02', '2021-06-23 06:39:02'),
(12, 'Email Subject contains Opal QLD', '', 'a:1:{i:0;a:4:{s:9:\"operation\";s:2:\"&&\";s:4:\"type\";s:7:\"subject\";s:5:\"match\";s:8:\"contains\";s:5:\"value\";s:8:\"Opal QLD\";}}', 'a:1:{i:0;a:2:{s:4:\"type\";s:26:\"uvdesk.ticket.assign_group\";s:5:\"value\";s:1:\"5\";}}', 2, 1, 0, '2021-07-06 01:53:42', '2021-07-06 01:53:42'),
(16, 'Email Subject contains Opal WA', '', 'a:1:{i:0;a:4:{s:9:\"operation\";s:2:\"&&\";s:4:\"type\";s:7:\"subject\";s:5:\"match\";s:8:\"contains\";s:5:\"value\";s:7:\"Opal WA\";}}', 'a:1:{i:0;a:2:{s:4:\"type\";s:26:\"uvdesk.ticket.assign_group\";s:5:\"value\";s:1:\"2\";}}', 3, 1, 0, '2021-07-06 01:53:47', '2021-07-06 01:53:47'),
(17, 'From Address Ricky OPAL QLD - Client', 'If the ticked comes from a specific address it should be assigned to the relevant organization.\r\n', 'a:1:{i:0;a:4:{s:9:\"operation\";s:2:\"&&\";s:4:\"type\";s:9:\"from_mail\";s:5:\"match\";s:8:\"contains\";s:5:\"value\";s:17:\"ricky@yopmail.com\";}}', 'a:1:{i:0;a:2:{s:4:\"type\";s:26:\"uvdesk.ticket.assign_agent\";s:5:\"value\";s:2:\"16\";}}', 1, 1, 1, '2021-07-15 06:37:16', '2021-07-15 06:37:16'),
(18, 'Email Subject contains Japara QLD', 'If the email subject contains a particular keyword or phrase it should be assigned to the relevant organization.\r\n', 'a:1:{i:0;a:4:{s:9:\"operation\";s:2:\"&&\";s:4:\"type\";s:7:\"subject\";s:5:\"match\";s:8:\"contains\";s:5:\"value\";s:10:\"Japara QLD\";}}', 'a:1:{i:0;a:2:{s:4:\"type\";s:26:\"uvdesk.ticket.assign_group\";s:5:\"value\";s:1:\"7\";}}', 5, 1, 0, '2021-07-06 01:53:57', '2021-07-06 01:53:57'),
(19, 'Email Subject contains Japara NSW', 'If the email subject contains a particular keyword or phrase it should be assigned to the relevant organization.\r\n', 'a:1:{i:0;a:4:{s:9:\"operation\";s:2:\"&&\";s:4:\"type\";s:7:\"subject\";s:5:\"match\";s:8:\"contains\";s:5:\"value\";s:10:\"Japara NSW\";}}', 'a:1:{i:0;a:2:{s:4:\"type\";s:26:\"uvdesk.ticket.assign_group\";s:5:\"value\";s:1:\"6\";}}', 6, 1, 0, '2021-07-06 01:58:54', '2021-07-06 01:58:54'),
(20, 'Email Subject contains Allity Tasmania', 'If the email subject contains a particular keyword or phrase it should be assigned to the relevant organization.\r\n', 'a:1:{i:0;a:4:{s:9:\"operation\";s:2:\"&&\";s:4:\"type\";s:7:\"subject\";s:5:\"match\";s:8:\"contains\";s:5:\"value\";s:15:\"Allity Tasmania\";}}', 'a:1:{i:0;a:2:{s:4:\"type\";s:26:\"uvdesk.ticket.assign_group\";s:5:\"value\";s:1:\"9\";}}', 7, 1, 0, '2021-07-06 01:54:15', '2021-07-06 01:54:15'),
(21, 'From Address Josh', 'If the ticked comes from a specific address it should be assigned to the relevant organization.\r\n', 'a:1:{i:0;a:4:{s:9:\"operation\";s:2:\"&&\";s:4:\"type\";s:9:\"from_mail\";s:5:\"match\";s:8:\"contains\";s:5:\"value\";s:16:\"josh@yopmail.com\";}}', 'a:1:{i:0;a:2:{s:4:\"type\";s:26:\"uvdesk.ticket.assign_agent\";s:5:\"value\";s:2:\"16\";}}', NULL, 1, 0, '2021-07-08 10:51:23', '2021-07-08 10:51:23');

-- --------------------------------------------------------

--
-- Table structure for table `uv_workflow_events`
--

CREATE TABLE `uv_workflow_events` (
  `id` int(11) NOT NULL,
  `workflow_id` int(11) DEFAULT NULL,
  `event_id` int(11) NOT NULL,
  `event` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uv_workflow_events`
--

INSERT INTO `uv_workflow_events` (`id`, `workflow_id`, `event_id`, `event`) VALUES
(1, 1, 1, 'uvdesk.customer.created'),
(2, 2, 2, 'uvdesk.agent.created'),
(3, 3, 3, 'uvdesk.user.forgot_password'),
(4, 4, 4, 'uvdesk.ticket.agent_updated'),
(6, 6, 6, 'uvdesk.ticket.agent_reply'),
(7, 7, 7, 'uvdesk.ticket.customer_reply'),
(35, 10, 10, 'uvdesk.ticket.created'),
(50, 5, 5, 'uvdesk.ticket.created'),
(62, 12, 12, 'uvdesk.ticket.created'),
(63, 16, 16, 'uvdesk.ticket.created'),
(65, 18, 18, 'uvdesk.ticket.created'),
(67, 20, 20, 'uvdesk.ticket.created'),
(70, 19, 19, 'uvdesk.ticket.created'),
(73, 8, 8, 'uvdesk.ticket.created'),
(74, 21, 21, 'uvdesk.ticket.created'),
(79, 17, 17, 'uvdesk.ticket.created');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `migration_versions`
--
ALTER TABLE `migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `recaptcha`
--
ALTER TABLE `recaptcha`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_admin_support_groups`
--
ALTER TABLE `uv_admin_support_groups`
  ADD PRIMARY KEY (`adminUserInstanceId`,`supportGroupId`),
  ADD KEY `IDX_215FF93837B7A2F1` (`adminUserInstanceId`),
  ADD KEY `IDX_215FF93853F5B65F` (`supportGroupId`);

--
-- Indexes for table `uv_article`
--
ALTER TABLE `uv_article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `search_idx` (`slug`);

--
-- Indexes for table `uv_article_category`
--
ALTER TABLE `uv_article_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_article_feedback`
--
ALTER TABLE `uv_article_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_BCB7F9147294869C` (`article_id`),
  ADD KEY `IDX_BCB7F914A76ED395` (`user_id`);

--
-- Indexes for table `uv_article_history`
--
ALTER TABLE `uv_article_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_article_tags`
--
ALTER TABLE `uv_article_tags`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_article_view_log`
--
ALTER TABLE `uv_article_view_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8F76FF11A76ED395` (`user_id`),
  ADD KEY `IDX_8F76FF117294869C` (`article_id`);

--
-- Indexes for table `uv_email_templates`
--
ALTER TABLE `uv_email_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_784A0D85A76ED395` (`user_id`);

--
-- Indexes for table `uv_lead_support_teams`
--
ALTER TABLE `uv_lead_support_teams`
  ADD PRIMARY KEY (`leadUserInstanceId`,`supportTeamId`),
  ADD KEY `IDX_8B5F844DD397BD7C` (`leadUserInstanceId`),
  ADD KEY `IDX_8B5F844DA77C7023` (`supportTeamId`);

--
-- Indexes for table `uv_prepared_responses`
--
ALTER TABLE `uv_prepared_responses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8AB5F066A76ED395` (`user_id`);

--
-- Indexes for table `uv_prepared_response_support_groups`
--
ALTER TABLE `uv_prepared_response_support_groups`
  ADD PRIMARY KEY (`savedReply_id`,`group_id`),
  ADD KEY `IDX_A22590198D3102C3` (`savedReply_id`),
  ADD KEY `IDX_A2259019FE54D947` (`group_id`);

--
-- Indexes for table `uv_prepared_response_support_teams`
--
ALTER TABLE `uv_prepared_response_support_teams`
  ADD PRIMARY KEY (`savedReply_id`,`subgroup_id`),
  ADD KEY `IDX_B6897DEB8D3102C3` (`savedReply_id`),
  ADD KEY `IDX_B6897DEBF5C464CE` (`subgroup_id`);

--
-- Indexes for table `uv_related_articles`
--
ALTER TABLE `uv_related_articles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_saved_filters`
--
ALTER TABLE `uv_saved_filters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E1BFBAF7A76ED395` (`user_id`);

--
-- Indexes for table `uv_saved_replies`
--
ALTER TABLE `uv_saved_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_39C8BA50A76ED395` (`user_id`);

--
-- Indexes for table `uv_saved_replies_groups`
--
ALTER TABLE `uv_saved_replies_groups`
  ADD PRIMARY KEY (`savedReply_id`,`group_id`),
  ADD KEY `IDX_C59C13668D3102C3` (`savedReply_id`),
  ADD KEY `IDX_C59C1366FE54D947` (`group_id`);

--
-- Indexes for table `uv_saved_replies_teams`
--
ALTER TABLE `uv_saved_replies_teams`
  ADD PRIMARY KEY (`savedReply_id`,`subgroup_id`),
  ADD KEY `IDX_D240CE708D3102C3` (`savedReply_id`),
  ADD KEY `IDX_D240CE70F5C464CE` (`subgroup_id`);

--
-- Indexes for table `uv_solutions`
--
ALTER TABLE `uv_solutions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_solution_category`
--
ALTER TABLE `uv_solution_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_solution_category_mapping`
--
ALTER TABLE `uv_solution_category_mapping`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_support_company`
--
ALTER TABLE `uv_support_company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_support_group`
--
ALTER TABLE `uv_support_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_support_groups_companies`
--
ALTER TABLE `uv_support_groups_companies`
  ADD PRIMARY KEY (`supportGroup_id`,`supportCompany_id`),
  ADD KEY `IDX_4211EA4ECE5F5290` (`supportGroup_id`),
  ADD KEY `IDX_4211EA4E238823AD` (`supportCompany_id`);

--
-- Indexes for table `uv_support_groups_teams`
--
ALTER TABLE `uv_support_groups_teams`
  ADD PRIMARY KEY (`supportGroup_id`,`supportTeam_id`),
  ADD KEY `IDX_761A315DCE5F5290` (`supportGroup_id`),
  ADD KEY `IDX_761A315D9718E641` (`supportTeam_id`);

--
-- Indexes for table `uv_support_label`
--
ALTER TABLE `uv_support_label`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_EFD454DDA76ED395` (`user_id`);

--
-- Indexes for table `uv_support_privilege`
--
ALTER TABLE `uv_support_privilege`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_support_role`
--
ALTER TABLE `uv_support_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_2AF5A72177153098` (`code`);

--
-- Indexes for table `uv_support_team`
--
ALTER TABLE `uv_support_team`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_tag`
--
ALTER TABLE `uv_tag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_thread`
--
ALTER TABLE `uv_thread`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_637D7E5D700047D2` (`ticket_id`),
  ADD KEY `IDX_637D7E5DA76ED395` (`user_id`);

--
-- Indexes for table `uv_ticket`
--
ALTER TABLE `uv_ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C5FD9F7D6BF700BD` (`status_id`),
  ADD KEY `IDX_C5FD9F7D497B19F9` (`priority_id`),
  ADD KEY `IDX_C5FD9F7DC54C8C93` (`type_id`),
  ADD KEY `IDX_C5FD9F7D9395C3F3` (`customer_id`),
  ADD KEY `IDX_C5FD9F7D3414710B` (`agent_id`),
  ADD KEY `IDX_C5FD9F7DFE54D947` (`group_id`),
  ADD KEY `IDX_C5FD9F7DCB20698` (`subGroup_id`),
  ADD KEY `IDX_C5FD9F7D979B1AD6` (`company_id`);

--
-- Indexes for table `uv_tickets_collaborators`
--
ALTER TABLE `uv_tickets_collaborators`
  ADD PRIMARY KEY (`ticket_id`,`user_id`),
  ADD KEY `IDX_20764CBA700047D2` (`ticket_id`),
  ADD KEY `IDX_20764CBAA76ED395` (`user_id`);

--
-- Indexes for table `uv_tickets_labels`
--
ALTER TABLE `uv_tickets_labels`
  ADD PRIMARY KEY (`ticket_id`,`label_id`),
  ADD KEY `IDX_305F9C0E700047D2` (`ticket_id`),
  ADD KEY `IDX_305F9C0E33B92F39` (`label_id`);

--
-- Indexes for table `uv_tickets_organizations`
--
ALTER TABLE `uv_tickets_organizations`
  ADD PRIMARY KEY (`ticket_id`,`organization_id`),
  ADD KEY `IDX_20D7CF91700047D2` (`ticket_id`),
  ADD KEY `IDX_20D7CF9132C8A3DE` (`organization_id`);

--
-- Indexes for table `uv_tickets_tags`
--
ALTER TABLE `uv_tickets_tags`
  ADD PRIMARY KEY (`ticket_id`,`tag_id`),
  ADD KEY `IDX_CF4DF9E3700047D2` (`ticket_id`),
  ADD KEY `IDX_CF4DF9E3BAD26311` (`tag_id`);

--
-- Indexes for table `uv_ticket_attachments`
--
ALTER TABLE `uv_ticket_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_FE918C8EE2904019` (`thread_id`);

--
-- Indexes for table `uv_ticket_priority`
--
ALTER TABLE `uv_ticket_priority`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_FFA6CF8677153098` (`code`);

--
-- Indexes for table `uv_ticket_rating`
--
ALTER TABLE `uv_ticket_rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_B1025E04700047D2` (`ticket_id`),
  ADD KEY `IDX_B1025E04A76ED395` (`user_id`);

--
-- Indexes for table `uv_ticket_status`
--
ALTER TABLE `uv_ticket_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_128B1D3A77153098` (`code`);

--
-- Indexes for table `uv_ticket_status_log`
--
ALTER TABLE `uv_ticket_status_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_62F26911A76ED395` (`user_id`),
  ADD KEY `IDX_62F26911700047D2` (`ticket_id`);

--
-- Indexes for table `uv_ticket_type`
--
ALTER TABLE `uv_ticket_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_3E0B313677153098` (`code`);

--
-- Indexes for table `uv_user`
--
ALTER TABLE `uv_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_E8D39F61E7927C74` (`email`),
  ADD UNIQUE KEY `UNIQ_E8D39F61DB26A4E` (`proxy_id`),
  ADD UNIQUE KEY `UNIQ_E8D39F61E821C39F` (`verification_code`);

--
-- Indexes for table `uv_user_instance`
--
ALTER TABLE `uv_user_instance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_B1744733A76ED395` (`user_id`),
  ADD KEY `IDX_B174473368771C43` (`supportRole_id`);

--
-- Indexes for table `uv_user_support_companies`
--
ALTER TABLE `uv_user_support_companies`
  ADD PRIMARY KEY (`userInstanceId`,`supportCompanyId`),
  ADD KEY `IDX_E5A970208B414560` (`userInstanceId`),
  ADD KEY `IDX_E5A970203C07ABDF` (`supportCompanyId`);

--
-- Indexes for table `uv_user_support_groups`
--
ALTER TABLE `uv_user_support_groups`
  ADD PRIMARY KEY (`userInstanceId`,`supportGroupId`),
  ADD KEY `IDX_B6CD76C28B414560` (`userInstanceId`),
  ADD KEY `IDX_B6CD76C253F5B65F` (`supportGroupId`);

--
-- Indexes for table `uv_user_support_privileges`
--
ALTER TABLE `uv_user_support_privileges`
  ADD PRIMARY KEY (`userInstanceId`,`supportPrivilegeId`),
  ADD KEY `IDX_9550EDB28B414560` (`userInstanceId`),
  ADD KEY `IDX_9550EDB289C60B89` (`supportPrivilegeId`);

--
-- Indexes for table `uv_user_support_teams`
--
ALTER TABLE `uv_user_support_teams`
  ADD PRIMARY KEY (`userInstanceId`,`supportTeamId`),
  ADD KEY `IDX_5F33E9F78B414560` (`userInstanceId`),
  ADD KEY `IDX_5F33E9F7A77C7023` (`supportTeamId`);

--
-- Indexes for table `uv_website`
--
ALTER TABLE `uv_website`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_2656FF0677153098` (`code`);

--
-- Indexes for table `uv_website_knowledgebase`
--
ALTER TABLE `uv_website_knowledgebase`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_DFF10F0B476F5DE7` (`website`);

--
-- Indexes for table `uv_workflow`
--
ALTER TABLE `uv_workflow`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uv_workflow_events`
--
ALTER TABLE `uv_workflow_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6AEB02A92C7C2CBA` (`workflow_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `recaptcha`
--
ALTER TABLE `recaptcha`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `uv_article`
--
ALTER TABLE `uv_article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `uv_article_category`
--
ALTER TABLE `uv_article_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `uv_article_feedback`
--
ALTER TABLE `uv_article_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uv_article_history`
--
ALTER TABLE `uv_article_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uv_article_tags`
--
ALTER TABLE `uv_article_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uv_article_view_log`
--
ALTER TABLE `uv_article_view_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `uv_email_templates`
--
ALTER TABLE `uv_email_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `uv_prepared_responses`
--
ALTER TABLE `uv_prepared_responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uv_related_articles`
--
ALTER TABLE `uv_related_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `uv_saved_filters`
--
ALTER TABLE `uv_saved_filters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `uv_saved_replies`
--
ALTER TABLE `uv_saved_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uv_solutions`
--
ALTER TABLE `uv_solutions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `uv_solution_category`
--
ALTER TABLE `uv_solution_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `uv_solution_category_mapping`
--
ALTER TABLE `uv_solution_category_mapping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `uv_support_company`
--
ALTER TABLE `uv_support_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `uv_support_group`
--
ALTER TABLE `uv_support_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `uv_support_label`
--
ALTER TABLE `uv_support_label`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `uv_support_privilege`
--
ALTER TABLE `uv_support_privilege`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `uv_support_role`
--
ALTER TABLE `uv_support_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `uv_support_team`
--
ALTER TABLE `uv_support_team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `uv_tag`
--
ALTER TABLE `uv_tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `uv_thread`
--
ALTER TABLE `uv_thread`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=397;

--
-- AUTO_INCREMENT for table `uv_ticket`
--
ALTER TABLE `uv_ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=272;

--
-- AUTO_INCREMENT for table `uv_ticket_attachments`
--
ALTER TABLE `uv_ticket_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `uv_ticket_priority`
--
ALTER TABLE `uv_ticket_priority`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `uv_ticket_rating`
--
ALTER TABLE `uv_ticket_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uv_ticket_status`
--
ALTER TABLE `uv_ticket_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `uv_ticket_status_log`
--
ALTER TABLE `uv_ticket_status_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `uv_ticket_type`
--
ALTER TABLE `uv_ticket_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `uv_user`
--
ALTER TABLE `uv_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `uv_user_instance`
--
ALTER TABLE `uv_user_instance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `uv_website`
--
ALTER TABLE `uv_website`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `uv_website_knowledgebase`
--
ALTER TABLE `uv_website_knowledgebase`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `uv_workflow`
--
ALTER TABLE `uv_workflow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `uv_workflow_events`
--
ALTER TABLE `uv_workflow_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `uv_admin_support_groups`
--
ALTER TABLE `uv_admin_support_groups`
  ADD CONSTRAINT `FK_215FF93837B7A2F1` FOREIGN KEY (`adminUserInstanceId`) REFERENCES `uv_user_instance` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_215FF93853F5B65F` FOREIGN KEY (`supportGroupId`) REFERENCES `uv_support_group` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_article_feedback`
--
ALTER TABLE `uv_article_feedback`
  ADD CONSTRAINT `FK_BCB7F9147294869C` FOREIGN KEY (`article_id`) REFERENCES `uv_article` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_BCB7F914A76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_article_view_log`
--
ALTER TABLE `uv_article_view_log`
  ADD CONSTRAINT `FK_8F76FF117294869C` FOREIGN KEY (`article_id`) REFERENCES `uv_article` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_8F76FF11A76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_email_templates`
--
ALTER TABLE `uv_email_templates`
  ADD CONSTRAINT `FK_784A0D85A76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user_instance` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_lead_support_teams`
--
ALTER TABLE `uv_lead_support_teams`
  ADD CONSTRAINT `FK_8B5F844DA77C7023` FOREIGN KEY (`supportTeamId`) REFERENCES `uv_support_team` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_8B5F844DD397BD7C` FOREIGN KEY (`leadUserInstanceId`) REFERENCES `uv_user_instance` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_prepared_responses`
--
ALTER TABLE `uv_prepared_responses`
  ADD CONSTRAINT `FK_8AB5F066A76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user_instance` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `uv_prepared_response_support_groups`
--
ALTER TABLE `uv_prepared_response_support_groups`
  ADD CONSTRAINT `FK_A22590198D3102C3` FOREIGN KEY (`savedReply_id`) REFERENCES `uv_prepared_responses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_A2259019FE54D947` FOREIGN KEY (`group_id`) REFERENCES `uv_support_group` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_prepared_response_support_teams`
--
ALTER TABLE `uv_prepared_response_support_teams`
  ADD CONSTRAINT `FK_B6897DEB8D3102C3` FOREIGN KEY (`savedReply_id`) REFERENCES `uv_prepared_responses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_B6897DEBF5C464CE` FOREIGN KEY (`subgroup_id`) REFERENCES `uv_support_team` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_saved_filters`
--
ALTER TABLE `uv_saved_filters`
  ADD CONSTRAINT `FK_E1BFBAF7A76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user_instance` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_saved_replies`
--
ALTER TABLE `uv_saved_replies`
  ADD CONSTRAINT `FK_39C8BA50A76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user_instance` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_saved_replies_groups`
--
ALTER TABLE `uv_saved_replies_groups`
  ADD CONSTRAINT `FK_C59C13668D3102C3` FOREIGN KEY (`savedReply_id`) REFERENCES `uv_saved_replies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_C59C1366FE54D947` FOREIGN KEY (`group_id`) REFERENCES `uv_support_group` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_saved_replies_teams`
--
ALTER TABLE `uv_saved_replies_teams`
  ADD CONSTRAINT `FK_D240CE708D3102C3` FOREIGN KEY (`savedReply_id`) REFERENCES `uv_saved_replies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_D240CE70F5C464CE` FOREIGN KEY (`subgroup_id`) REFERENCES `uv_support_team` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_support_groups_companies`
--
ALTER TABLE `uv_support_groups_companies`
  ADD CONSTRAINT `FK_4211EA4E238823AD` FOREIGN KEY (`supportCompany_id`) REFERENCES `uv_support_company` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_4211EA4ECE5F5290` FOREIGN KEY (`supportGroup_id`) REFERENCES `uv_support_group` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_support_groups_teams`
--
ALTER TABLE `uv_support_groups_teams`
  ADD CONSTRAINT `FK_761A315D9718E641` FOREIGN KEY (`supportTeam_id`) REFERENCES `uv_support_team` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_761A315DCE5F5290` FOREIGN KEY (`supportGroup_id`) REFERENCES `uv_support_group` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_support_label`
--
ALTER TABLE `uv_support_label`
  ADD CONSTRAINT `FK_EFD454DDA76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_thread`
--
ALTER TABLE `uv_thread`
  ADD CONSTRAINT `FK_637D7E5D700047D2` FOREIGN KEY (`ticket_id`) REFERENCES `uv_ticket` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_637D7E5DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `uv_ticket`
--
ALTER TABLE `uv_ticket`
  ADD CONSTRAINT `FK_C5FD9F7D3414710B` FOREIGN KEY (`agent_id`) REFERENCES `uv_user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_C5FD9F7D497B19F9` FOREIGN KEY (`priority_id`) REFERENCES `uv_ticket_priority` (`id`),
  ADD CONSTRAINT `FK_C5FD9F7D6BF700BD` FOREIGN KEY (`status_id`) REFERENCES `uv_ticket_status` (`id`),
  ADD CONSTRAINT `FK_C5FD9F7D9395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `uv_user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_C5FD9F7D979B1AD6` FOREIGN KEY (`company_id`) REFERENCES `uv_support_company` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_C5FD9F7DC54C8C93` FOREIGN KEY (`type_id`) REFERENCES `uv_ticket_type` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_C5FD9F7DCB20698` FOREIGN KEY (`subGroup_id`) REFERENCES `uv_support_team` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_C5FD9F7DFE54D947` FOREIGN KEY (`group_id`) REFERENCES `uv_support_group` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `uv_tickets_collaborators`
--
ALTER TABLE `uv_tickets_collaborators`
  ADD CONSTRAINT `FK_20764CBA700047D2` FOREIGN KEY (`ticket_id`) REFERENCES `uv_ticket` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_20764CBAA76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_tickets_labels`
--
ALTER TABLE `uv_tickets_labels`
  ADD CONSTRAINT `FK_305F9C0E33B92F39` FOREIGN KEY (`label_id`) REFERENCES `uv_support_label` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_305F9C0E700047D2` FOREIGN KEY (`ticket_id`) REFERENCES `uv_ticket` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_tickets_organizations`
--
ALTER TABLE `uv_tickets_organizations`
  ADD CONSTRAINT `FK_20D7CF9132C8A3DE` FOREIGN KEY (`organization_id`) REFERENCES `uv_support_team` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_20D7CF91700047D2` FOREIGN KEY (`ticket_id`) REFERENCES `uv_ticket` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_tickets_tags`
--
ALTER TABLE `uv_tickets_tags`
  ADD CONSTRAINT `FK_CF4DF9E3700047D2` FOREIGN KEY (`ticket_id`) REFERENCES `uv_ticket` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_CF4DF9E3BAD26311` FOREIGN KEY (`tag_id`) REFERENCES `uv_tag` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_ticket_attachments`
--
ALTER TABLE `uv_ticket_attachments`
  ADD CONSTRAINT `FK_FE918C8EE2904019` FOREIGN KEY (`thread_id`) REFERENCES `uv_thread` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_ticket_rating`
--
ALTER TABLE `uv_ticket_rating`
  ADD CONSTRAINT `FK_B1025E04700047D2` FOREIGN KEY (`ticket_id`) REFERENCES `uv_ticket` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_B1025E04A76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_ticket_status_log`
--
ALTER TABLE `uv_ticket_status_log`
  ADD CONSTRAINT `FK_62F26911700047D2` FOREIGN KEY (`ticket_id`) REFERENCES `uv_ticket` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_62F26911A76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_user_instance`
--
ALTER TABLE `uv_user_instance`
  ADD CONSTRAINT `FK_B174473368771C43` FOREIGN KEY (`supportRole_id`) REFERENCES `uv_support_role` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_B1744733A76ED395` FOREIGN KEY (`user_id`) REFERENCES `uv_user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_user_support_companies`
--
ALTER TABLE `uv_user_support_companies`
  ADD CONSTRAINT `FK_E5A970203C07ABDF` FOREIGN KEY (`supportCompanyId`) REFERENCES `uv_support_company` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_E5A970208B414560` FOREIGN KEY (`userInstanceId`) REFERENCES `uv_user_instance` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_user_support_groups`
--
ALTER TABLE `uv_user_support_groups`
  ADD CONSTRAINT `FK_B6CD76C253F5B65F` FOREIGN KEY (`supportGroupId`) REFERENCES `uv_support_group` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_B6CD76C28B414560` FOREIGN KEY (`userInstanceId`) REFERENCES `uv_user_instance` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_user_support_privileges`
--
ALTER TABLE `uv_user_support_privileges`
  ADD CONSTRAINT `FK_9550EDB289C60B89` FOREIGN KEY (`supportPrivilegeId`) REFERENCES `uv_support_privilege` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_9550EDB28B414560` FOREIGN KEY (`userInstanceId`) REFERENCES `uv_user_instance` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_user_support_teams`
--
ALTER TABLE `uv_user_support_teams`
  ADD CONSTRAINT `FK_5F33E9F78B414560` FOREIGN KEY (`userInstanceId`) REFERENCES `uv_user_instance` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_5F33E9F7A77C7023` FOREIGN KEY (`supportTeamId`) REFERENCES `uv_support_team` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `uv_website_knowledgebase`
--
ALTER TABLE `uv_website_knowledgebase`
  ADD CONSTRAINT `FK_DFF10F0B476F5DE7` FOREIGN KEY (`website`) REFERENCES `uv_website` (`id`);

--
-- Constraints for table `uv_workflow_events`
--
ALTER TABLE `uv_workflow_events`
  ADD CONSTRAINT `FK_6AEB02A92C7C2CBA` FOREIGN KEY (`workflow_id`) REFERENCES `uv_workflow` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
