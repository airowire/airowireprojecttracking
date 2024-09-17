-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 17, 2024 at 01:48 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `amt`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `slno` int(11) NOT NULL,
  `did` int(11) NOT NULL,
  `comment` text NOT NULL,
  `comment_file` varchar(255) DEFAULT NULL,
  `completion_percentage` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`slno`, `did`, `comment`, `comment_file`, `completion_percentage`, `created_at`) VALUES
(8, 7, 'werggredf', NULL, 0, '2024-08-09 12:14:15'),
(9, 7, 'hiiiii', NULL, 0, '2024-08-14 09:45:52'),
(10, 7, 'hjj', NULL, 0, '2024-08-14 09:59:32'),
(11, 7, 'hi', NULL, 0, '2024-08-14 10:52:12'),
(12, 7, 'wert', NULL, 0, '2024-08-14 10:54:24'),
(13, 7, 'dfghgfdfvb', NULL, 60, '2024-08-14 11:14:38'),
(16, 8, 'Hello', NULL, 30, '2024-08-15 03:07:59'),
(17, 7, 'dfghjf', NULL, 0, '2024-08-15 03:21:45'),
(18, 8, 'Hi', NULL, 0, '2024-08-15 03:57:18'),
(19, 8, 'JJDJJ', NULL, 70, '2024-09-04 09:55:22'),
(20, 7, 'drg', NULL, 60, '2024-09-15 06:06:49'),
(21, 7, 'fiytfyiiytf', NULL, 40, '2024-09-17 11:01:34'),
(22, 7, 'hi', NULL, 0, '2024-09-17 11:45:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`slno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `slno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
