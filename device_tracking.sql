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
-- Table structure for table `device_tracking`
--

CREATE TABLE `device_tracking` (
  `id` int(11) NOT NULL,
  `pid` varchar(255) NOT NULL,
  `pname` varchar(255) NOT NULL,
  `pono` varchar(255) NOT NULL,
  `Assigned_Engineer` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `Po_Upload` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Delievery_Initiated',
  `posigneddoc` varchar(255) DEFAULT 'NODATA',
  `pdesc` varchar(255) NOT NULL,
  `pgroup` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `device_tracking`
--

INSERT INTO `device_tracking` (`id`, `pid`, `pname`, `pono`, `Assigned_Engineer`, `location`, `Po_Upload`, `status`, `posigneddoc`, `pdesc`, `pgroup`) VALUES
(7, 'ANPL-1234', 'FTO 03 DRL HYD WIRLES DEPLO', '16546354', 'yogesh', 'HYD', 'static/img/po/file-sample_150kB.pdf', 'project_start', 'static/img/posigned/file-sample_150kB.pdf', 'materila received at fto 03 office.', 'FT'),
(8, 'ANPL-123', 'DRL FT', 'rtegfc123433', 'yogesh', 'HYD', 'static/img/po/file-sample_150kB.pdf', 'Delivery Initiated', 'static/img/posigned/file-sample_150kB.pdf', 'KM', 'MES'),
(9, 'WSFGF', 'WEDFGFSD', 'QWEDFSD', 'Sai', 'QASDFD', 'static/img/po/file-sample_150kB.pdf', 'Delivered', 'NODATA', '', 'MES'),
(10, 'a3345324', 'dfgcef', 'cfgrc', 'Mallikarjun', 'FFF', 'static/img/po/EPFAct1952.pdf', 'completed', 'NODATA', '', 'FT');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `device_tracking`
--
ALTER TABLE `device_tracking`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `device_tracking`
--
ALTER TABLE `device_tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
