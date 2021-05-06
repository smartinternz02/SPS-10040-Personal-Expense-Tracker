-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: remotemysql.com
-- Generation Time: May 05, 2021 at 04:01 AM
-- Server version: 8.0.13-4
-- PHP Version: 7.2.24-0ubuntu0.18.04.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `9CaX90ZO70`
--

-- --------------------------------------------------------

--
-- Table structure for table `budget`
--

CREATE TABLE `budget` (
  `Sl` int(11) NOT NULL,
  `id` int(100) NOT NULL,
  `bamount` int(100) NOT NULL,
  `b_month` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `budget`
--

INSERT INTO `budget` (`Sl`, `id`, `bamount`, `b_month`) VALUES
(64, 61, 50000, '2021-January'),
(65, 62, 56700, '2021-January'),
(66, 62, 67000, '2021-February'),
(77, 62, 78000, '2021-March'),
(78, 7, 100, '2021-May'),
(79, 63, 1000, '2021-May');

-- --------------------------------------------------------

--
-- Table structure for table `expense_a`
--

CREATE TABLE `expense_a` (
  `ex_id` int(100) NOT NULL,
  `id` int(11) NOT NULL,
  `amount` int(100) NOT NULL,
  `category` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `expense_a`
--

INSERT INTO `expense_a` (`ex_id`, `id`, `amount`, `category`, `date`, `description`) VALUES
(166, 61, 250, 'Food', '2021-01-14', 'Amelies'),
(167, 61, 350, 'Food', '2021-01-20', 'KFC'),
(168, 61, 750, 'Entertainment', '2021-01-21', 'I-Phone'),
(169, 61, 2500, 'Entertainment', '2021-01-21', 'Laptop'),
(170, 61, 10000, 'Travel', '2021-01-28', 'Europe'),
(171, 61, 30000, 'Travel', '2021-01-01', 'World Tour'),
(172, 62, 6000, 'Entertainment', '2021-01-07', 'Entertainment'),
(173, 62, 1200, 'Entertainment', '2021-01-09', 'I-Phone'),
(174, 62, 2400, 'Entertainment', '2021-01-13', 'Laptop'),
(175, 62, 25000, 'Travel', '2021-01-20', 'World Tour'),
(177, 62, 1000, 'Food', '2021-02-10', 'ITC'),
(178, 62, 350, 'Groceries', '2021-02-12', 'Apples'),
(179, 62, 780, 'Groceries', '2021-02-19', 'Veggies'),
(180, 62, 500, 'Shopping', '2021-02-20', 'Clothing'),
(181, 62, 450, 'Utilities', '2021-02-21', 'Tools'),
(182, 62, 3400, 'Other', '2021-02-23', 'Personal'),
(183, 7, 10, 'Groceries', '2021-05-07', 'bag'),
(184, 7, 20, 'Food', '2021-05-04', 'food'),
(185, 63, 100, 'Groceries', '2021-05-04', 'Dal'),
(186, 63, 200, 'Shopping', '2021-05-03', 'Dress'),
(187, 62, 4500, 'Travel', '2021-02-25', 'Russia'),
(188, 62, 370, 'Utilities', '2021-01-14', 'Tools'),
(189, 62, 256, 'Utilities', '2021-01-07', 'Medicines'),
(190, 62, 570, 'Shopping', '2021-01-06', 'Clothing'),
(191, 62, 2500, 'Shopping', '2021-01-05', 'D&G'),
(192, 62, 500, 'Food', '2021-03-18', 'Apples');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` text COLLATE utf8_unicode_ci NOT NULL,
  `password` text COLLATE utf8_unicode_ci NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`) VALUES
(61, 'test2', '$2b$12$GS3klwLOLWHiiOp.ssMX2e8ikp7U4Ot/UdDgl7acjOAjaDQEzgjgq', 'test2@gmail.com'),
(62, 'xosteve26', '$2b$12$Ul3TOEOMhQ8GF9pLtIfqKOnEuhpUOO18Eit0uYMq637QwGgKOMQw2', 'xosteve2640@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `budget`
--
ALTER TABLE `budget`
  ADD PRIMARY KEY (`Sl`);

--
-- Indexes for table `expense_a`
--
ALTER TABLE `expense_a`
  ADD PRIMARY KEY (`ex_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `budget`
--
ALTER TABLE `budget`
  MODIFY `Sl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `expense_a`
--
ALTER TABLE `expense_a`
  MODIFY `ex_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=193;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
