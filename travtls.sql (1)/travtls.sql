-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2025 at 05:46 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `travtls`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  `seat_class` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `passenger_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `booking_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `user_id`, `source`, `destination`, `seat_class`, `price`, `passenger_name`, `email`, `mobile`, `booking_date`) VALUES
(1, 12345, 'Chennai (MAA)', 'Mumbai (BOM)', 'Business Class', 0.00, 'Harini ', 'harining12456@gmail.com', '321546', '2025-02-28 10:09:52'),
(2, 12345, 'Chennai (MAA)', 'Mumbai (BOM)', 'Business Class', 0.00, 'Harini ', 'harining12456@gmail.com', '8523697410', '2025-02-28 10:22:14'),
(3, 12345, 'Hyderabad (HYD)', 'Mumbai (BOM)', 'Business Class', 0.00, 'Harry ', 'harining12456@gmail.com', '3123467890', '2025-02-28 10:30:32'),
(4, 12345, 'Chennai (MAA)', 'Mumbai (BOM)', 'Business Class', 0.00, 'Bhavani', 'bhavani88@gmail.com', '9630852741', '2025-03-01 04:08:27'),
(5, 12345, 'Chennai (MAA)', 'Hyderabad (HYD)', 'Business Class', 0.00, 'poojitha', 'poojithav@gmail.com', '9390532458', '2025-03-01 10:11:55'),
(6, 12345, 'Hyderabad (HYD)', 'Mumbai (BOM)', 'Business Class', 0.00, 'Harini ', 'harining12456@gmail.com', '9638527441', '2025-03-04 11:06:45'),
(7, 12345, 'Chennai (MAA)', 'Hyderabad (HYD)', 'Business Class', 0.00, 'Harini ', 'harining12456@gmail.com', '9118531725', '2025-03-04 11:12:27'),
(8, 12345, 'Chennai (MAA)', 'Hyderabad (HYD)', 'Business Class', 0.00, 'Hari ', 'harining12456@gmail.com', '369852147', '2025-03-12 05:56:01');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--
-- Error reading structure for table travtls.bookings: #1932 - Table &#039;travtls.bookings&#039; doesn&#039;t exist in engine
-- Error reading data for table travtls.bookings: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `travtls`.`bookings`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE `flights` (
  `id` int(11) NOT NULL,
  `airline` varchar(100) DEFAULT NULL,
  `price` varchar(20) DEFAULT NULL,
  `departure` varchar(20) DEFAULT NULL,
  `arrival` varchar(20) DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `destination` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`id`, `airline`, `price`, `departure`, `arrival`, `source`, `destination`) VALUES
(1, 'IndiGo', '₹4700', '06:00 AM', '08:00 AM', 'Bengaluru (BLR)', 'Mumbai (BOM)'),
(2, 'Air India', '₹4900', '10:00 AM', '12:00 PM', 'Bengaluru (BLR)', 'Mumbai (BOM)'),
(3, 'Vistara', '₹5100', '02:00 PM', '04:00 PM', 'Bengaluru (BLR)', 'Mumbai (BOM)'),
(4, 'IndiGo', '₹4600', '07:00 AM', '09:00 AM', 'Chennai (MAA)', 'Mumbai (BOM)'),
(5, 'Air India', '₹4800', '11:00 AM', '01:00 PM', 'Chennai (MAA)', 'Mumbai (BOM)'),
(6, 'Vistara', '₹5000', '03:00 PM', '05:00 PM', 'Chennai (MAA)', 'Mumbai (BOM)'),
(7, 'IndiGo', '₹4500', '08:00 AM', '10:00 AM', 'Hyderabad (HYD)', 'Mumbai (BOM)'),
(8, 'Air India', '₹4700', '12:00 PM', '02:00 PM', 'Hyderabad (HYD)', 'Mumbai (BOM)'),
(9, 'Vistara', '₹4900', '04:00 PM', '06:00 PM', 'Hyderabad (HYD)', 'Mumbai (BOM)'),
(10, 'IndiGo', '₹4400', '09:00 AM', '11:00 AM', 'Jaipur (JAI)', 'Mumbai (BOM)'),
(11, 'Air India', '₹4600', '01:00 PM', '03:00 PM', 'Jaipur (JAI)', 'Mumbai (BOM)'),
(12, 'Vistara', '₹4800', '05:00 PM', '07:00 PM', 'Jaipur (JAI)', 'Mumbai (BOM)'),
(13, 'IndiGo', '₹4300', '10:00 AM', '12:00 PM', 'Kolkata (CCU)', 'Mumbai (BOM)'),
(14, 'Air India', '₹4500', '02:00 PM', '04:00 PM', 'Kolkata (CCU)', 'Mumbai (BOM)'),
(15, 'Vistara', '₹4700', '06:00 PM', '08:00 PM', 'Kolkata (CCU)', 'Mumbai (BOM)'),
(16, 'IndiGo', '₹4200', '11:00 AM', '01:00 PM', 'Lucknow (LKO)', 'Mumbai (BOM)'),
(17, 'Air India', '₹4400', '03:00 PM', '05:00 PM', 'Lucknow (LKO)', 'Mumbai (BOM)'),
(18, 'Vistara', '₹4600', '07:00 PM', '09:00 PM', 'Lucknow (LKO)', 'Mumbai (BOM)'),
(19, 'IndiGo', '₹4100', '12:00 PM', '02:00 PM', 'Madurai (IXM)', 'Mumbai (BOM)'),
(20, 'Air India', '₹4300', '04:00 PM', '06:00 PM', 'Madurai (IXM)', 'Mumbai (BOM)'),
(21, 'Vistara', '₹4500', '08:00 PM', '10:00 PM', 'Madurai (IXM)', 'Mumbai (BOM)'),
(22, 'IndiGo', '₹4000', '01:00 PM', '03:00 PM', 'Nagpur (NAG)', 'Mumbai (BOM)'),
(23, 'Air India', '₹4200', '05:00 PM', '07:00 PM', 'Nagpur (NAG)', 'Mumbai (BOM)'),
(24, 'Vistara', '₹4400', '09:00 PM', '11:00 PM', 'Nagpur (NAG)', 'Mumbai (BOM)'),
(25, 'IndiGo', '₹3900', '02:00 PM', '04:00 PM', 'Patna (PAT)', 'Mumbai (BOM)'),
(26, 'Air India', '₹4100', '06:00 PM', '08:00 PM', 'Patna (PAT)', 'Mumbai (BOM)'),
(27, 'Vistara', '₹4300', '10:00 PM', '12:00 AM', 'Patna (PAT)', 'Mumbai (BOM)'),
(28, 'IndiGo', '₹3800', '03:00 PM', '05:00 PM', 'Pune (PNQ)', 'Mumbai (BOM)'),
(29, 'Air India', '₹4000', '07:00 PM', '09:00 PM', 'Pune (PNQ)', 'Mumbai (BOM)'),
(30, 'Vistara', '₹4200', '11:00 PM', '01:00 AM', 'Pune (PNQ)', 'Mumbai (BOM)'),
(31, 'IndiGo', '₹3700', '04:00 PM', '06:00 PM', 'Raipur (RPR)', 'Mumbai (BOM)'),
(32, 'Air India', '₹3900', '08:00 PM', '10:00 PM', 'Raipur (RPR)', 'Mumbai (BOM)'),
(33, 'Vistara', '₹4100', '12:00 AM', '02:00 AM', 'Raipur (RPR)', 'Mumbai (BOM)'),
(34, 'IndiGo', '₹3600', '05:00 PM', '07:00 PM', 'Vishakhapatnam (VTZ)', 'Mumbai (BOM)'),
(35, 'Air India', '₹3800', '09:00 PM', '11:00 PM', 'Vishakhapatnam (VTZ)', 'Mumbai (BOM)'),
(36, 'Vistara', '₹4000', '01:00 AM', '03:00 AM', 'Vishakhapatnam (VTZ)', 'Mumbai (BOM)'),
(37, 'IndiGo', '₹3700', '06:00 AM', '07:30 AM', 'Bengaluru (BLR)', 'Chennai (MAA)'),
(38, 'Air India', '₹3900', '10:00 AM', '11:30 AM', 'Bengaluru (BLR)', 'Chennai (MAA)'),
(39, 'Vistara', '₹4100', '02:00 PM', '03:30 PM', 'Bengaluru (BLR)', 'Chennai (MAA)'),
(40, 'IndiGo', '₹3600', '07:00 AM', '08:30 AM', 'Hyderabad (HYD)', 'Chennai (MAA)'),
(41, 'Air India', '₹3800', '11:00 AM', '12:30 PM', 'Hyderabad (HYD)', 'Chennai (MAA)'),
(42, 'Vistara', '₹4000', '03:00 PM', '04:30 PM', 'Hyderabad (HYD)', 'Chennai (MAA)'),
(43, 'IndiGo', '₹3500', '08:00 AM', '09:45 AM', 'Jaipur (JAI)', 'Chennai (MAA)'),
(44, 'Air India', '₹3700', '12:00 PM', '01:45 PM', 'Jaipur (JAI)', 'Chennai (MAA)'),
(45, 'Vistara', '₹3900', '04:00 PM', '05:45 PM', 'Jaipur (JAI)', 'Chennai (MAA)'),
(46, 'IndiGo', '₹3400', '09:00 AM', '10:30 AM', 'Kolkata (CCU)', 'Chennai (MAA)'),
(47, 'Air India', '₹3600', '01:00 PM', '02:30 PM', 'Kolkata (CCU)', 'Chennai (MAA)'),
(48, 'Vistara', '₹3800', '05:00 PM', '06:30 PM', 'Kolkata (CCU)', 'Chennai (MAA)'),
(49, 'IndiGo', '₹3300', '10:00 AM', '11:45 AM', 'Lucknow (LKO)', 'Chennai (MAA)'),
(50, 'Air India', '₹3500', '02:00 PM', '03:45 PM', 'Lucknow (LKO)', 'Chennai (MAA)'),
(51, 'Vistara', '₹3700', '06:00 PM', '07:45 PM', 'Lucknow (LKO)', 'Chennai (MAA)'),
(52, 'IndiGo', '₹3200', '11:00 AM', '12:30 PM', 'Madurai (IXM)', 'Chennai (MAA)'),
(53, 'Air India', '₹3400', '03:00 PM', '04:30 PM', 'Madurai (IXM)', 'Chennai (MAA)'),
(54, 'Vistara', '₹3600', '07:00 PM', '08:30 PM', 'Madurai (IXM)', 'Chennai (MAA)'),
(55, 'IndiGo', '₹3100', '12:00 PM', '01:45 PM', 'Nagpur (NAG)', 'Chennai (MAA)'),
(56, 'Air India', '₹3300', '04:00 PM', '05:45 PM', 'Nagpur (NAG)', 'Chennai (MAA)'),
(57, 'Vistara', '₹3500', '08:00 PM', '09:45 PM', 'Nagpur (NAG)', 'Chennai (MAA)'),
(58, 'IndiGo', '₹3000', '01:00 PM', '02:45 PM', 'Patna (PAT)', 'Chennai (MAA)'),
(59, 'Air India', '₹3200', '05:00 PM', '06:45 PM', 'Patna (PAT)', 'Chennai (MAA)'),
(60, 'Vistara', '₹3400', '09:00 PM', '10:45 PM', 'Patna (PAT)', 'Chennai (MAA)'),
(61, 'IndiGo', '₹2900', '02:00 PM', '03:30 PM', 'Pune (PNQ)', 'Chennai (MAA)'),
(62, 'Air India', '₹3100', '06:00 PM', '07:30 PM', 'Pune (PNQ)', 'Chennai (MAA)'),
(63, 'Vistara', '₹3300', '10:00 PM', '11:30 PM', 'Pune (PNQ)', 'Chennai (MAA)'),
(64, 'IndiGo', '₹2800', '03:00 PM', '04:45 PM', 'Raipur (RPR)', 'Chennai (MAA)'),
(65, 'Air India', '₹3000', '07:00 PM', '08:45 PM', 'Raipur (RPR)', 'Chennai (MAA)'),
(66, 'Vistara', '₹3200', '11:00 PM', '12:45 AM', 'Raipur (RPR)', 'Chennai (MAA)'),
(67, 'IndiGo', '₹2700', '04:00 PM', '05:30 PM', 'Vishakhapatnam (VTZ)', 'Chennai (MAA)'),
(68, 'Air India', '₹2900', '08:00 PM', '09:30 PM', 'Vishakhapatnam (VTZ)', 'Chennai (MAA)'),
(69, 'Vistara', '₹3100', '12:00 AM', '01:30 AM', 'Vishakhapatnam (VTZ)', 'Chennai (MAA)'),
(70, 'IndiGo', '₹3600', '06:00 AM', '07:30 AM', 'Chennai (MAA)', 'Bengaluru (BLR)'),
(71, 'Air India', '₹3800', '10:00 AM', '11:30 AM', 'Chennai (MAA)', 'Bengaluru (BLR)'),
(72, 'Vistara', '₹4000', '02:00 PM', '03:30 PM', 'Chennai (MAA)', 'Bengaluru (BLR)'),
(73, 'IndiGo', '₹3500', '07:00 AM', '08:30 AM', 'Hyderabad (HYD)', 'Bengaluru (BLR)'),
(74, 'Air India', '₹3700', '11:00 AM', '12:30 PM', 'Hyderabad (HYD)', 'Bengaluru (BLR)'),
(75, 'Vistara', '₹3900', '03:00 PM', '04:30 PM', 'Hyderabad (HYD)', 'Bengaluru (BLR)'),
(76, 'IndiGo', '₹3400', '08:00 AM', '09:45 AM', 'Jaipur (JAI)', 'Bengaluru (BLR)'),
(77, 'Air India', '₹3600', '12:00 PM', '01:45 PM', 'Jaipur (JAI)', 'Bengaluru (BLR)'),
(78, 'Vistara', '₹3800', '04:00 PM', '05:45 PM', 'Jaipur (JAI)', 'Bengaluru (BLR)'),
(79, 'IndiGo', '₹3300', '09:00 AM', '10:30 AM', 'Kolkata (CCU)', 'Bengaluru (BLR)'),
(80, 'Air India', '₹3500', '01:00 PM', '02:30 PM', 'Kolkata (CCU)', 'Bengaluru (BLR)'),
(81, 'Vistara', '₹3700', '05:00 PM', '06:30 PM', 'Kolkata (CCU)', 'Bengaluru (BLR)'),
(82, 'IndiGo', '₹3200', '10:00 AM', '11:45 AM', 'Lucknow (LKO)', 'Bengaluru (BLR)'),
(83, 'Air India', '₹3400', '02:00 PM', '03:45 PM', 'Lucknow (LKO)', 'Bengaluru (BLR)'),
(84, 'Vistara', '₹3600', '06:00 PM', '07:45 PM', 'Lucknow (LKO)', 'Bengaluru (BLR)'),
(85, 'IndiGo', '₹3100', '11:00 AM', '12:30 PM', 'Madurai (IXM)', 'Bengaluru (BLR)'),
(86, 'Air India', '₹3300', '03:00 PM', '04:30 PM', 'Madurai (IXM)', 'Bengaluru (BLR)'),
(87, 'Vistara', '₹3500', '07:00 PM', '08:30 PM', 'Madurai (IXM)', 'Bengaluru (BLR)'),
(88, 'IndiGo', '₹3000', '12:00 PM', '01:45 PM', 'Nagpur (NAG)', 'Bengaluru (BLR)'),
(89, 'Air India', '₹3200', '04:00 PM', '05:45 PM', 'Nagpur (NAG)', 'Bengaluru (BLR)'),
(90, 'Vistara', '₹3400', '08:00 PM', '09:45 PM', 'Nagpur (NAG)', 'Bengaluru (BLR)'),
(91, 'IndiGo', '₹2900', '01:00 PM', '02:45 PM', 'Patna (PAT)', 'Bengaluru (BLR)'),
(92, 'Air India', '₹3100', '05:00 PM', '06:45 PM', 'Patna (PAT)', 'Bengaluru (BLR)'),
(93, 'Vistara', '₹3300', '09:00 PM', '10:45 PM', 'Patna (PAT)', 'Bengaluru (BLR)'),
(94, 'IndiGo', '₹2800', '02:00 PM', '03:30 PM', 'Pune (PNQ)', 'Bengaluru (BLR)'),
(95, 'Air India', '₹3000', '06:00 PM', '07:30 PM', 'Pune (PNQ)', 'Bengaluru (BLR)'),
(96, 'Vistara', '₹3200', '10:00 PM', '11:30 PM', 'Pune (PNQ)', 'Bengaluru (BLR)'),
(97, 'IndiGo', '₹2700', '03:00 PM', '04:45 PM', 'Raipur (RPR)', 'Bengaluru (BLR)'),
(98, 'Air India', '₹2900', '07:00 PM', '08:45 PM', 'Raipur (RPR)', 'Bengaluru (BLR)'),
(99, 'Vistara', '₹3100', '11:00 PM', '12:45 AM', 'Raipur (RPR)', 'Bengaluru (BLR)'),
(100, 'IndiGo', '₹2600', '04:00 PM', '05:30 PM', 'Vishakhapatnam (VTZ)', 'Bengaluru (BLR)'),
(101, 'Air India', '₹2800', '08:00 PM', '09:30 PM', 'Vishakhapatnam (VTZ)', 'Bengaluru (BLR)'),
(102, 'Vistara', '₹3000', '12:00 AM', '01:30 AM', 'Vishakhapatnam (VTZ)', 'Bengaluru (BLR)'),
(103, 'IndiGo', '₹3700', '06:00 AM', '07:30 AM', 'Chennai (MAA)', 'Hyderabad (HYD)'),
(104, 'Air India', '₹3900', '10:00 AM', '11:30 AM', 'Chennai (MAA)', 'Hyderabad (HYD)'),
(105, 'Vistara', '₹4100', '02:00 PM', '03:30 PM', 'Chennai (MAA)', 'Hyderabad (HYD)'),
(106, 'IndiGo', '₹3600', '07:00 AM', '08:30 AM', 'Bengaluru (BLR)', 'Hyderabad (HYD)'),
(107, 'Air India', '₹3800', '11:00 AM', '12:30 PM', 'Bengaluru (BLR)', 'Hyderabad (HYD)'),
(108, 'Vistara', '₹4000', '03:00 PM', '04:30 PM', 'Bengaluru (BLR)', 'Hyderabad (HYD)'),
(109, 'IndiGo', '₹3500', '08:00 AM', '09:45 AM', 'Jaipur (JAI)', 'Hyderabad (HYD)'),
(110, 'Air India', '₹3700', '12:00 PM', '01:45 PM', 'Jaipur (JAI)', 'Hyderabad (HYD)'),
(111, 'Vistara', '₹3900', '04:00 PM', '05:45 PM', 'Jaipur (JAI)', 'Hyderabad (HYD)'),
(112, 'IndiGo', '₹3400', '09:00 AM', '10:30 AM', 'Kolkata (CCU)', 'Hyderabad (HYD)'),
(113, 'Air India', '₹3600', '01:00 PM', '02:30 PM', 'Kolkata (CCU)', 'Hyderabad (HYD)'),
(114, 'Vistara', '₹3800', '05:00 PM', '06:30 PM', 'Kolkata (CCU)', 'Hyderabad (HYD)'),
(115, 'IndiGo', '₹3300', '10:00 AM', '11:45 AM', 'Lucknow (LKO)', 'Hyderabad (HYD)'),
(116, 'Air India', '₹3500', '02:00 PM', '03:45 PM', 'Lucknow (LKO)', 'Hyderabad (HYD)'),
(117, 'Vistara', '₹3700', '06:00 PM', '07:45 PM', 'Lucknow (LKO)', 'Hyderabad (HYD)'),
(118, 'IndiGo', '₹3200', '11:00 AM', '12:30 PM', 'Madurai (IXM)', 'Hyderabad (HYD)'),
(119, 'Air India', '₹3400', '03:00 PM', '04:30 PM', 'Madurai (IXM)', 'Hyderabad (HYD)'),
(120, 'Vistara', '₹3600', '07:00 PM', '08:30 PM', 'Madurai (IXM)', 'Hyderabad (HYD)'),
(121, 'IndiGo', '₹3100', '12:00 PM', '01:45 PM', 'Nagpur (NAG)', 'Hyderabad (HYD)'),
(122, 'Air India', '₹3300', '04:00 PM', '05:45 PM', 'Nagpur (NAG)', 'Hyderabad (HYD)'),
(123, 'Vistara', '₹3500', '08:00 PM', '09:45 PM', 'Nagpur (NAG)', 'Hyderabad (HYD)'),
(124, 'IndiGo', '₹3000', '01:00 PM', '02:45 PM', 'Patna (PAT)', 'Hyderabad (HYD)'),
(125, 'Air India', '₹3200', '05:00 PM', '06:45 PM', 'Patna (PAT)', 'Hyderabad (HYD)'),
(126, 'Vistara', '₹3400', '09:00 PM', '10:45 PM', 'Patna (PAT)', 'Hyderabad (HYD)'),
(127, 'IndiGo', '₹2900', '02:00 PM', '03:30 PM', 'Pune (PNQ)', 'Hyderabad (HYD)'),
(128, 'Air India', '₹3100', '06:00 PM', '07:30 PM', 'Pune (PNQ)', 'Hyderabad (HYD)'),
(129, 'Vistara', '₹3300', '10:00 PM', '11:30 PM', 'Pune (PNQ)', 'Hyderabad (HYD)'),
(130, 'IndiGo', '₹2800', '03:00 PM', '04:45 PM', 'Raipur (RPR)', 'Hyderabad (HYD)'),
(131, 'Air India', '₹3000', '07:00 PM', '08:45 PM', 'Raipur (RPR)', 'Hyderabad (HYD)'),
(132, 'Vistara', '₹3200', '11:00 PM', '12:45 AM', 'Raipur (RPR)', 'Hyderabad (HYD)'),
(133, 'IndiGo', '₹2700', '04:00 PM', '05:30 PM', 'Vishakhapatnam (VTZ)', 'Hyderabad (HYD)'),
(134, 'Air India', '₹2900', '08:00 PM', '09:30 PM', 'Vishakhapatnam (VTZ)', 'Hyderabad (HYD)'),
(135, 'Vistara', '₹3100', '12:00 AM', '01:30 AM', 'Vishakhapatnam (VTZ)', 'Hyderabad (HYD)'),
(136, 'IndiGo', '₹4500', '06:00 AM', '08:30 AM', 'Chennai (MAA)', 'Delhi (DEL)'),
(137, 'Air India', '₹4700', '10:00 AM', '12:30 PM', 'Chennai (MAA)', 'Delhi (DEL)'),
(138, 'Vistara', '₹4900', '02:00 PM', '04:30 PM', 'Chennai (MAA)', 'Delhi (DEL)'),
(139, 'IndiGo', '₹4400', '07:00 AM', '09:30 AM', 'Bengaluru (BLR)', 'Delhi (DEL)'),
(140, 'Air India', '₹4600', '11:00 AM', '01:30 PM', 'Bengaluru (BLR)', 'Delhi (DEL)'),
(141, 'Vistara', '₹4800', '03:00 PM', '05:30 PM', 'Bengaluru (BLR)', 'Delhi (DEL)'),
(142, 'IndiGo', '₹4300', '08:00 AM', '09:15 AM', 'Jaipur (JAI)', 'Delhi (DEL)'),
(143, 'Air India', '₹4500', '12:00 PM', '01:15 PM', 'Jaipur (JAI)', 'Delhi (DEL)'),
(144, 'Vistara', '₹4700', '04:00 PM', '05:15 PM', 'Jaipur (JAI)', 'Delhi (DEL)'),
(145, 'IndiGo', '₹4200', '09:00 AM', '11:30 AM', 'Kolkata (CCU)', 'Delhi (DEL)'),
(146, 'Air India', '₹4400', '01:00 PM', '03:30 PM', 'Kolkata (CCU)', 'Delhi (DEL)'),
(147, 'Vistara', '₹4600', '05:00 PM', '07:30 PM', 'Kolkata (CCU)', 'Delhi (DEL)'),
(148, 'IndiGo', '₹4100', '10:00 AM', '11:15 AM', 'Lucknow (LKO)', 'Delhi (DEL)'),
(149, 'Air India', '₹4300', '02:00 PM', '03:15 PM', 'Lucknow (LKO)', 'Delhi (DEL)'),
(150, 'Vistara', '₹4500', '06:00 PM', '07:15 PM', 'Lucknow (LKO)', 'Delhi (DEL)'),
(151, 'IndiGo', '₹4000', '11:00 AM', '01:30 PM', 'Madurai (IXM)', 'Delhi (DEL)'),
(152, 'Air India', '₹4200', '03:00 PM', '05:30 PM', 'Madurai (IXM)', 'Delhi (DEL)'),
(153, 'Vistara', '₹4400', '07:00 PM', '09:30 PM', 'Madurai (IXM)', 'Delhi (DEL)'),
(154, 'IndiGo', '₹3900', '12:00 PM', '01:45 PM', 'Nagpur (NAG)', 'Delhi (DEL)'),
(155, 'Air India', '₹4100', '04:00 PM', '05:45 PM', 'Nagpur (NAG)', 'Delhi (DEL)'),
(156, 'Vistara', '₹4300', '08:00 PM', '09:45 PM', 'Nagpur (NAG)', 'Delhi (DEL)'),
(157, 'IndiGo', '₹3800', '01:00 PM', '02:15 PM', 'Patna (PAT)', 'Delhi (DEL)'),
(158, 'Air India', '₹4000', '05:00 PM', '06:15 PM', 'Patna (PAT)', 'Delhi (DEL)'),
(159, 'Vistara', '₹4200', '09:00 PM', '10:15 PM', 'Patna (PAT)', 'Delhi (DEL)'),
(160, 'IndiGo', '₹3700', '02:00 PM', '04:30 PM', 'Pune (PNQ)', 'Delhi (DEL)'),
(161, 'Air India', '₹3900', '06:00 PM', '08:30 PM', 'Pune (PNQ)', 'Delhi (DEL)'),
(162, 'Vistara', '₹4100', '10:00 PM', '12:30 AM', 'Pune (PNQ)', 'Delhi (DEL)'),
(163, 'IndiGo', '₹3600', '03:00 PM', '04:45 PM', 'Raipur (RPR)', 'Delhi (DEL)'),
(164, 'Air India', '₹3800', '07:00 PM', '08:45 PM', 'Raipur (RPR)', 'Delhi (DEL)'),
(165, 'Vistara', '₹4000', '11:00 PM', '12:45 AM', 'Raipur (RPR)', 'Delhi (DEL)'),
(166, 'IndiGo', '₹3500', '04:00 PM', '06:30 PM', 'Vishakhapatnam (VTZ)', 'Delhi (DEL)'),
(167, 'Air India', '₹3700', '08:00 PM', '10:30 PM', 'Vishakhapatnam (VTZ)', 'Delhi (DEL)'),
(168, 'Vistara', '₹3900', '12:00 AM', '02:30 AM', 'Vishakhapatnam (VTZ)', 'Delhi (DEL)'),
(169, 'IndiGo', '₹4600', '06:00 AM', '08:45 AM', 'Chennai (MAA)', 'Kolkata (CCU)'),
(170, 'Air India', '₹4800', '10:00 AM', '12:45 PM', 'Chennai (MAA)', 'Kolkata (CCU)'),
(171, 'Vistara', '₹5000', '02:00 PM', '04:45 PM', 'Chennai (MAA)', 'Kolkata (CCU)'),
(172, 'IndiGo', '₹4500', '07:00 AM', '09:30 AM', 'Bengaluru (BLR)', 'Kolkata (CCU)'),
(173, 'Air India', '₹4700', '11:00 AM', '01:30 PM', 'Bengaluru (BLR)', 'Kolkata (CCU)'),
(174, 'Vistara', '₹4900', '03:00 PM', '05:30 PM', 'Bengaluru (BLR)', 'Kolkata (CCU)'),
(175, 'IndiGo', '₹4400', '08:00 AM', '10:15 AM', 'Jaipur (JAI)', 'Kolkata (CCU)'),
(176, 'Air India', '₹4600', '12:00 PM', '02:15 PM', 'Jaipur (JAI)', 'Kolkata (CCU)'),
(177, 'Vistara', '₹4800', '04:00 PM', '06:15 PM', 'Jaipur (JAI)', 'Kolkata (CCU)'),
(178, 'IndiGo', '₹4300', '09:00 AM', '11:30 AM', 'Delhi (DEL)', 'Kolkata (CCU)'),
(179, 'Air India', '₹4500', '01:00 PM', '03:30 PM', 'Delhi (DEL)', 'Kolkata (CCU)'),
(180, 'Vistara', '₹4700', '05:00 PM', '07:30 PM', 'Delhi (DEL)', 'Kolkata (CCU)'),
(181, 'IndiGo', '₹4200', '10:00 AM', '12:15 PM', 'Lucknow (LKO)', 'Kolkata (CCU)'),
(182, 'Air India', '₹4400', '02:00 PM', '04:15 PM', 'Lucknow (LKO)', 'Kolkata (CCU)'),
(183, 'Vistara', '₹4600', '06:00 PM', '08:15 PM', 'Lucknow (LKO)', 'Kolkata (CCU)'),
(184, 'IndiGo', '₹4100', '11:00 AM', '01:30 PM', 'Madurai (IXM)', 'Kolkata (CCU)'),
(185, 'Air India', '₹4300', '03:00 PM', '05:30 PM', 'Madurai (IXM)', 'Kolkata (CCU)'),
(186, 'Vistara', '₹4500', '07:00 PM', '09:30 PM', 'Madurai (IXM)', 'Kolkata (CCU)'),
(187, 'IndiGo', '₹4000', '12:00 PM', '02:45 PM', 'Nagpur (NAG)', 'Kolkata (CCU)'),
(188, 'Air India', '₹4200', '04:00 PM', '06:45 PM', 'Nagpur (NAG)', 'Kolkata (CCU)'),
(189, 'Vistara', '₹4400', '08:00 PM', '10:45 PM', 'Nagpur (NAG)', 'Kolkata (CCU)'),
(190, 'IndiGo', '₹3900', '01:00 PM', '02:30 PM', 'Patna (PAT)', 'Kolkata (CCU)'),
(191, 'Air India', '₹4100', '05:00 PM', '06:30 PM', 'Patna (PAT)', 'Kolkata (CCU)'),
(192, 'Vistara', '₹4300', '09:00 PM', '10:30 PM', 'Patna (PAT)', 'Kolkata (CCU)'),
(193, 'IndiGo', '₹3800', '02:00 PM', '04:45 PM', 'Pune (PNQ)', 'Kolkata (CCU)'),
(194, 'Air India', '₹4000', '06:00 PM', '08:45 PM', 'Pune (PNQ)', 'Kolkata (CCU)'),
(195, 'Vistara', '₹4200', '10:00 PM', '12:45 AM', 'Pune (PNQ)', 'Kolkata (CCU)'),
(196, 'IndiGo', '₹3700', '03:00 PM', '05:15 PM', 'Raipur (RPR)', 'Kolkata (CCU)'),
(197, 'Air India', '₹3900', '07:00 PM', '09:15 PM', 'Raipur (RPR)', 'Kolkata (CCU)'),
(198, 'Vistara', '₹4100', '11:00 PM', '01:15 AM', 'Raipur (RPR)', 'Kolkata (CCU)'),
(199, 'IndiGo', '₹3600', '04:00 PM', '06:30 PM', 'Vishakhapatnam (VTZ)', 'Kolkata (CCU)'),
(200, 'Air India', '₹3800', '08:00 PM', '10:30 PM', 'Vishakhapatnam (VTZ)', 'Kolkata (CCU)'),
(201, 'Vistara', '₹4000', '12:00 AM', '02:30 AM', 'Vishakhapatnam (VTZ)', 'Kolkata (CCU)'),
(202, 'IndiGo', '₹4200', '06:00 AM', '08:00 AM', 'Chennai (MAA)', 'Goa (GOI)'),
(203, 'Air India', '₹4400', '10:00 AM', '12:00 PM', 'Chennai (MAA)', 'Goa (GOI)'),
(204, 'Vistara', '₹4600', '02:00 PM', '04:00 PM', 'Chennai (MAA)', 'Goa (GOI)'),
(205, 'IndiGo', '₹4100', '07:00 AM', '09:00 AM', 'Bengaluru (BLR)', 'Goa (GOI)'),
(206, 'Air India', '₹4300', '11:00 AM', '01:00 PM', 'Bengaluru (BLR)', 'Goa (GOI)'),
(207, 'Vistara', '₹4500', '03:00 PM', '05:00 PM', 'Bengaluru (BLR)', 'Goa (GOI)'),
(208, 'IndiGo', '₹4000', '08:00 AM', '10:30 AM', 'Jaipur (JAI)', 'Goa (GOI)'),
(209, 'Air India', '₹4200', '12:00 PM', '02:30 PM', 'Jaipur (JAI)', 'Goa (GOI)'),
(210, 'Vistara', '₹4400', '04:00 PM', '06:30 PM', 'Jaipur (JAI)', 'Goa (GOI)'),
(211, 'IndiGo', '₹3900', '09:00 AM', '11:45 AM', 'Delhi (DEL)', 'Goa (GOI)'),
(212, 'Air India', '₹4100', '01:00 PM', '03:45 PM', 'Delhi (DEL)', 'Goa (GOI)'),
(213, 'Vistara', '₹4300', '05:00 PM', '07:45 PM', 'Delhi (DEL)', 'Goa (GOI)'),
(214, 'IndiGo', '₹3800', '10:00 AM', '12:30 PM', 'Lucknow (LKO)', 'Goa (GOI)'),
(215, 'Air India', '₹4000', '02:00 PM', '04:30 PM', 'Lucknow (LKO)', 'Goa (GOI)'),
(216, 'Vistara', '₹4200', '06:00 PM', '08:30 PM', 'Lucknow (LKO)', 'Goa (GOI)'),
(217, 'IndiGo', '₹3700', '11:00 AM', '01:30 PM', 'Madurai (IXM)', 'Goa (GOI)'),
(218, 'Air India', '₹3900', '03:00 PM', '05:30 PM', 'Madurai (IXM)', 'Goa (GOI)'),
(219, 'Vistara', '₹4100', '07:00 PM', '09:30 PM', 'Madurai (IXM)', 'Goa (GOI)'),
(220, 'IndiGo', '₹3600', '12:00 PM', '02:15 PM', 'Nagpur (NAG)', 'Goa (GOI)'),
(221, 'Air India', '₹3800', '04:00 PM', '06:15 PM', 'Nagpur (NAG)', 'Goa (GOI)'),
(222, 'Vistara', '₹4000', '08:00 PM', '10:15 PM', 'Nagpur (NAG)', 'Goa (GOI)'),
(223, 'IndiGo', '₹3500', '01:00 PM', '03:30 PM', 'Patna (PAT)', 'Goa (GOI)'),
(224, 'Air India', '₹3700', '05:00 PM', '07:30 PM', 'Patna (PAT)', 'Goa (GOI)'),
(225, 'Vistara', '₹3900', '09:00 PM', '11:30 PM', 'Patna (PAT)', 'Goa (GOI)'),
(226, 'IndiGo', '₹3400', '02:00 PM', '03:45 PM', 'Pune (PNQ)', 'Goa (GOI)'),
(227, 'Air India', '₹3600', '06:00 PM', '07:45 PM', 'Pune (PNQ)', 'Goa (GOI)'),
(228, 'Vistara', '₹3800', '10:00 PM', '11:45 PM', 'Pune (PNQ)', 'Goa (GOI)'),
(229, 'IndiGo', '₹3300', '03:00 PM', '05:15 PM', 'Raipur (RPR)', 'Goa (GOI)'),
(230, 'Air India', '₹3500', '07:00 PM', '09:15 PM', 'Raipur (RPR)', 'Goa (GOI)'),
(231, 'Vistara', '₹3700', '11:00 PM', '01:15 AM', 'Raipur (RPR)', 'Goa (GOI)'),
(232, 'IndiGo', '₹3200', '04:00 PM', '06:45 PM', 'Vishakhapatnam (VTZ)', 'Goa (GOI)'),
(233, 'Air India', '₹3400', '08:00 PM', '10:45 PM', 'Vishakhapatnam (VTZ)', 'Goa (GOI)'),
(234, 'Vistara', '₹3600', '12:00 AM', '02:45 AM', 'Vishakhapatnam (VTZ)', 'Goa (GOI)');

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

CREATE TABLE `passengers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `flight_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`id`, `name`, `email`, `mobile`, `flight_id`, `created_at`) VALUES
(1, 'Harimi', 'harining12456@gmail.com', '9110531725', 4, '2025-02-26 08:53:26'),
(2, 'Harimi', 'harining12456@gmail.com', '9110531725', 4, '2025-02-26 08:56:11'),
(3, 'Likith ', 'likith@gmail.com', '9638527410', 4, '2025-02-26 09:57:05'),
(4, 'Tejesh ', 'teju123@gmail.com', '8523697410', 4, '2025-02-26 10:12:34'),
(5, 'Hari', 'hari@gmail.com', '2580741369', 6, '2025-02-26 10:24:19'),
(6, 'Harini ', 'harining12456@gmail.com', '3698521470', 70, '2025-02-26 10:27:08'),
(7, 'kalyani', 'kalyani27@gmail.com', '3214569780', 6, '2025-02-26 10:45:28'),
(8, 'Srujana', 'srujana22@gmail.com', '9638524110', 6, '2025-02-26 10:52:25'),
(9, 'Harini ', 'harining12456@gmail.com', '3214569870', 5, '2025-02-26 12:08:32'),
(10, 'Harini ', 'harining12456@gmail.com', '9110531725', 4, '2025-02-26 12:14:58'),
(11, 'hari ', 'hari12@gmail.com', '3692580147', 4, '2025-02-26 12:24:15'),
(12, 'Harini ', 'harining12456@gmail.com', '1234567890', 5, '2025-02-26 12:28:24'),
(13, 'kalyan', 'kalyan27@gmail.com', '9632580741', 5, '2025-02-27 06:02:01'),
(14, 'hari', 'hari@gmail.com', '9638520711', 4, '2025-02-27 07:30:33'),
(15, 'hari', 'hari@gmail.com', '9638520711', 4, '2025-02-27 07:31:43'),
(16, 'sravya ', 'sravya@gmail.com', '1234567890', 6, '2025-02-27 07:42:23'),
(17, 'shannu', 'test@gmail.com', '9638524177', 5, '2025-02-27 07:51:07'),
(18, 'test', 'test@gmail.com', '9632580741', 5, '2025-02-27 07:53:49'),
(19, 'tesy', 'hahvdzush', '994345187', 7, '2025-02-27 07:57:20'),
(20, 'bruj', 'vdyu', '965845', 1, '2025-02-27 08:02:16'),
(21, 'sruthi', 'sruthi12@gmail.com', '1234567890', 4, '2025-02-27 08:20:19'),
(22, 'test1', 'test@gmail.com', '1234567', 4, '2025-02-27 08:33:33'),
(23, 'hsyeue', 'bajwieyvsbs', '94651318404', 4, '2025-02-27 09:49:48'),
(24, 'hagayuw', 'hnevdkls', '618875316', 4, '2025-02-27 09:50:56'),
(25, 'hari', 'harining12456@gmail.com', '3690852147', 4, '2025-02-27 10:02:55'),
(26, 'ha gsujw', 'bajwueysg', '9461812454', 4, '2025-02-27 10:06:06'),
(27, 'hari ', 'harining12456@gmail.com', '3214567890', 4, '2025-02-27 10:10:25'),
(28, 'yegk', 'gklofxnk', '255', 4, '2025-02-27 10:12:57'),
(29, 'hsjwhs', 'babebe ', '97843', 4, '2025-02-27 10:24:18'),
(30, 'hfdb', 'xvnml', '98233', 4, '2025-02-27 10:26:54'),
(31, 'bajwk', 'bskwk', '94634', 4, '2025-02-27 10:31:07'),
(32, 'bajwk', 'bskwk', '94634', 4, '2025-02-27 10:39:05'),
(33, 'hari ', 'harining12456@gmail.com', '36985221', 4, '2025-02-27 11:20:59'),
(34, 'harini', 'harining12456@gmail.com', '9632587410', 103, '2025-02-28 04:01:08'),
(35, 'admin', 'admin@gmail.com', '123456789', 4, '2025-02-28 04:07:13'),
(36, 'hari', 'hari@', '3125487', 105, '2025-02-28 04:13:13'),
(37, 'hari', 'harining12456@gmail.com', '963852', 6, '2025-02-28 04:18:27'),
(38, 'hdayu', 'hfe5uhj', '9985695', 4, '2025-02-28 04:21:00'),
(39, 'hari', 'hageyjwjs', '66431948', 5, '2025-02-28 04:33:16'),
(40, 'Harini ', 'harining12456@gmail.com', '91185348457', 5, '2025-02-28 04:39:25'),
(41, 'sruthi', 'sruthi12@gmail.com', '3692580147', 4, '2025-02-28 04:52:30'),
(42, 'sruthi', 'sruthi12@gmail.com', '3692580147', 4, '2025-02-28 04:52:31'),
(43, 'sruthi', 'sruthi12@gmail.com', '3692580147', 4, '2025-02-28 04:52:32'),
(44, 'harini', 'harining12456@gmail.com', '9110531725', 25, '2025-02-28 04:56:18'),
(45, 'Harry', 'harini27@gmail.com', '9110531725', 4, '2025-02-28 08:20:58'),
(46, 'Harini ', 'harining12456@gmail.com', '9110531725', 7, '2025-02-28 08:42:51'),
(47, 'Harini', 'harining12456@gmail.com', '9110531725', 4, '2025-02-28 08:47:58'),
(48, 'sruthi', 'sruthi12@gmail.com', '9630852741', 5, '2025-02-28 08:59:39'),
(49, 'Harini ', 'harining12456@gmail.com', '9632580741', 5, '2025-02-28 09:06:43'),
(50, 'Harini ', 'harining12456@gmail.com', '321546', 6, '2025-02-28 09:09:25'),
(51, 'Harini ', 'harining12456@gmail.com', '8523697410', 6, '2025-02-28 09:21:38'),
(52, 'Harry ', 'harining12456@gmail.com', '3123467890', 8, '2025-02-28 09:30:08'),
(53, 'Bhavani', 'bhavani88@gmail.com', '9630852741', 6, '2025-03-01 03:07:43'),
(54, 'poojitha', 'poojithav@gmail.com', '9390532458', 104, '2025-03-01 09:11:27'),
(55, 'Harini ', 'harining12456@gmail.com', '9638527441', 7, '2025-03-04 10:06:07'),
(56, 'Harini ', 'harining12456@gmail.com', '9638527441', 7, '2025-03-04 10:06:08'),
(57, 'Harini ', 'harining12456@gmail.com', '9118531725', 104, '2025-03-04 10:12:06'),
(58, 'Hari ', 'harining12456@gmail.com', '369852147', 103, '2025-03-12 04:55:41');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile_number` varchar(20) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`) VALUES
(1, 'admin', 'admin@gmail.com', '12345', '2025-02-13 04:34:49'),
(2, 'admin', 'admin27@gmail.com', '$2y$10$LqV.QTljxZbJEwtZdEa26uh7VBP9bBssvFXM.lrBZIkA.2x55QhU.', '2025-02-13 04:42:34'),
(3, 'admin', 'admin2004@gmail.com', '12345', '2025-02-13 04:44:45'),
(4, 'Harini', 'harini@gmail.com', '12345', '2025-02-13 07:24:29'),
(5, 'hari', 'hari12@gmail.com', '12345', '2025-02-13 08:45:43'),
(6, 'Sruthi', 'sruthi12@gmail.com', '000000', '2025-02-13 08:46:28'),
(7, 'Harry', 'harini27@gmail.com', '12345678', '2025-02-13 09:23:21'),
(8, 'manas', 'manas@gmail.com', '098765', '2025-02-17 03:29:34'),
(9, 'test', 'test@gmail.com', '1', '2025-02-24 08:26:52'),
(10, 'tejesh', 'tejesh123@gmail.com', '1234567890', '2025-03-12 03:35:51'),
(11, 'harini', 'harining12456@gmail.com', '1234', '2025-03-12 04:49:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`);

--
-- Indexes for table `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `passengers`
--
ALTER TABLE `passengers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flight_id` (`flight_id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `mobile_number` (`mobile_number`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `flights`
--
ALTER TABLE `flights`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=235;

--
-- AUTO_INCREMENT for table `passengers`
--
ALTER TABLE `passengers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `passengers`
--
ALTER TABLE `passengers`
  ADD CONSTRAINT `passengers_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
