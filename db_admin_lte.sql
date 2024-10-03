-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-10-2024 a las 06:27:42
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_admin_lte`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `position` enum('top','left') NOT NULL DEFAULT 'left',
  `name` varchar(100) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `link` varchar(100) NOT NULL,
  `icon` varchar(30) NOT NULL DEFAULT 'far fa-circle',
  `is_last` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `is_active` tinyint(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `menus`
--

INSERT INTO `menus` (`id`, `parent_id`, `position`, `name`, `slug`, `link`, `icon`, `is_last`, `is_active`) VALUES
(1, NULL, 'left', 'Inicio', 'starter', 'starter', 'fas fa-home', 1, 1),
(2, NULL, 'left', 'CRUD de Usuarios', 'table', '#', 'fas fa-user', 0, 1),
(4, 2, 'left', 'Administrar', 'dtables', 'tables/dtables', 'fas fa-edit', 1, 1),
(10, NULL, 'top', 'Inicio', 'home', '#', 'far fa-circle', 1, 1),
(11, NULL, 'top', 'Sobre este proyecto', 'contact', '#', 'far fa-circle', 1, 1),
(15, NULL, 'left', 'Generación de PDF', 'pdf', 'pdf', 'fas fa-file-pdf', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fullname` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `fullname`, `email`, `is_active`) VALUES
(1, 'america.roob', 'Valentin Turner', 'beahan.joshuah@example.net', 1),
(2, 'jovanny38', 'Cali Medhurst', 'eileen.rippin@example.com', 1),
(3, 'stokes.ezekiel', 'Mrs. Pearline Kunze', 'celestine02@example.net', 0),
(4, 'libby86', 'Amely Jerde', 'lind.anderson@example.net', 1),
(5, 'ikreiger', 'Shannon Schmitt', 'szboncak@example.com', 1),
(6, 'mervin.pfannerstill', 'Marlin Jacobs', 'bahringer.berenice@example.org', 0),
(7, 'jayde85', 'Mrs. Dorothy Huel', 'jazmyne93@example.com', 0),
(8, 'frami.charlotte', 'Ms. Velma Deckow Jr.', 'gledner@example.net', 1),
(9, 'pfannerstill.lolita', 'Zena Homenick', 'justyn.marvin@example.com', 1),
(10, 'jacey75', 'Eriberto Schmeler', 'julian67@example.net', 0),
(11, 'fatima.breitenberg', 'Emmanuelle Streich', 'tre97@example.net', 0),
(12, 'twila10', 'Jules Von III', 'wadams@example.org', 0),
(13, 'koelpin.melyssa', 'Kelsi Kemmer', 'roscoe.thiel@example.org', 0),
(14, 'roslyn.lind', 'Mr. Roy Davis IV', 'sswift@example.org', 0),
(15, 'raufderhar', 'Tara Padberg', 'bernadine89@example.com', 1),
(16, 'robel.lukas', 'Georgette Nicolas', 'meaghan71@example.org', 0),
(17, 'ana.armstrong', 'Garnet Muller', 'america90@example.org', 1),
(18, 'jacobs.jamal', 'Nathan Balistreri', 'halvorson.juana@example.com', 0),
(19, 'bdonnelly', 'Prof. Brandon Bogan', 'maudie25@example.org', 0),
(20, 'shanahan.alice', 'Llewellyn DuBuque', 'cmedhurst@example.com', 0),
(21, 'alfredo17', 'Dr. Efrain Mraz', 'hilma55@example.org', 0),
(22, 'yost.lazaro', 'Berniece Kuvalis', 'ryan.sheridan@example.com', 1),
(23, 'marks.orlando', 'Reymundo Schaefer IV', 'emosciski@example.org', 0),
(24, 'jimmy10', 'Josefina Altenwerth I', 'boyle.maverick@example.com', 1),
(25, 'erippin', 'Karolann Waelchi', 'lacy.brakus@example.org', 0),
(26, 'marks.jose', 'Orlo Kulas', 'cbins@example.org', 0),
(27, 'stark.jett', 'Jarrett Stracke', 'birdie.rohan@example.com', 0),
(28, 'herman.gerardo', 'Gregorio Torp', 'roscoe.boyer@example.com', 0),
(29, 'ethel.mcclure', 'Candida Hessel', 'harvey31@example.net', 0),
(30, 'ceasar.larson', 'Miss Skyla Ziemann DDS', 'gilda17@example.com', 1),
(31, 'adams.precious', 'Prof. Elton Bergstrom III', 'mvonrueden@example.org', 0),
(32, 'jbrekke', 'Harold Conroy', 'kuvalis.domenick@example.com', 1),
(33, 'beatty.evie', 'Modesta Miller', 'hattie.greenfelder@example.net', 0),
(34, 'tremblay.zack', 'Kristy Stamm IV', 'vincenzo.o\'kon@example.net', 1),
(35, 'aleen54', 'Rollin Koepp', 'braun.billie@example.net', 1),
(36, 'ucassin', 'Horace Boyer', 'arno14@example.net', 1),
(37, 'roob.amparo', 'Genoveva Corwin', 'grady.cesar@example.com', 1),
(38, 'christiana35', 'Federico Braun V', 'roob.shad@example.net', 0),
(39, 'crist.elliott', 'Mr. Garnett Dietrich III', 'mrunte@example.com', 1),
(40, 'nella96', 'Keara Carroll', 'cnolan@example.com', 0),
(41, 'bertram75', 'Glenda Dickinson II', 'meagan.douglas@example.com', 1),
(42, 'bpacocha', 'Dr. Roma Legros MD', 'tvon@example.org', 1),
(43, 'dagmar.price', 'Elvis Reynolds', 'glangosh@example.net', 1),
(44, 'derick.boyer', 'Lenore Koss', 'ueichmann@example.com', 1),
(45, 'qritchie', 'Rosalind Leffler', 'dthiel@example.com', 0),
(46, 'gabriella95', 'Velva Jenkins', 'andre43@example.com', 0),
(48, 'harber.jaeden', 'Brando Kozey', 'wlittle@example.com', 1),
(49, 'adeline.smitham', 'Bethel Kub', 'sabina.collier@example.org', 1),
(50, 'maci94', 'Dr. Moshe Leuschke II', 'herman.alverta@example.com', 0),
(51, 'cward', 'Shad DuBuque', 'rosetta94@example.com', 1),
(52, 'smitham.maxwell', 'Evert Koch', 'lueilwitz.halie@example.org', 0),
(53, 'douglas.waters', 'Amira Lehner', 'ahaley@example.com', 1),
(54, 'mellie05', 'Miss Christelle Gerlach DVM', 'rodrick.stracke@example.net', 0),
(55, 'jay86', 'Elisha Dach', 'jbartoletti@example.org', 0),
(56, 'ywisozk', 'Otho Reichel', 'jakob37@example.com', 1),
(57, 'jjacobi', 'Sage Witting', 'harvey.austen@example.net', 1),
(58, 'keenan.schowalter', 'Trudie Brekke', 'dswaniawski@example.net', 0),
(59, 'simonis.arianna', 'Jamal Howell', 'davis.joel@example.net', 1),
(60, 'fay.zena', 'Prof. Keyshawn Nicolas', 'wava.donnelly@example.net', 0),
(61, 'claude86', 'Mr. Wilford Bernier II', 'agoyette@example.org', 1),
(62, 'chester.hahn', 'Amari Ryan', 'reynolds.jacinto@example.org', 1),
(63, 'kuhic.michaela', 'Lolita Ritchie', 'brekke.vickie@example.net', 1),
(64, 'weber.johnny', 'Marvin Veum', 'ogoyette@example.com', 1),
(65, 'myah64', 'Ms. Carrie Will', 'jay27@example.com', 0),
(66, 'robel.cora', 'Effie Mosciski Jr.', 'daija.kovacek@example.net', 1),
(67, 'jcrooks', 'Martine Becker', 'jerry70@example.net', 1),
(68, 'hollie82', 'Dr. Walton Nikolaus IV', 'lstroman@example.net', 1),
(69, 'roel00', 'Max Gottlieb', 'michele71@example.org', 0),
(70, 'mariam.streich', 'Tatum White', 'rodriguez.brittany@example.org', 1),
(71, 'oral58', 'Maria Macejkovic I', 'lyla.doyle@example.com', 0),
(72, 'heidenreich.ignatius', 'Elwin Williamson', 'destinee.herzog@example.com', 1),
(73, 'christy58', 'Jarvis Kovacek', 'reynold.morissette@example.com', 1),
(74, 'mertz.alexandra', 'Ephraim Schoen DDS', 'pdicki@example.net', 0),
(75, 'sean96', 'Prof. Dereck Trantow', 'damon.aufderhar@example.com', 1),
(76, 'fatima65', 'Milan Schuster', 'sbotsford@example.net', 1),
(77, 'madisyn.larson', 'Dr. Peggie Grimes DDS', 'kellie.harvey@example.org', 0),
(78, 'satterfield.kaylin', 'Maxwell Fritsch', 'clarabelle.stehr@example.net', 0),
(79, 'jed.weber', 'Burnice Volkman', 'kris.ladarius@example.com', 1),
(80, 'davon.bernier', 'Mitchel Feil', 'mohamed42@example.net', 1),
(81, 'lubowitz.geovany', 'Javonte Hermann', 'imraz@example.net', 0),
(82, 'martin.zboncak', 'Emil Balistreri', 'braeden.jerde@example.net', 1),
(83, 'okoepp', 'Jake McLaughlin', 'streich.sonia@example.com', 1),
(84, 'rigoberto.huels', 'Casandra Torp', 'heller.teresa@example.com', 1),
(85, 'kattie96', 'Gerson Romaguera', 'lavon92@example.org', 0),
(86, 'christina46', 'Angelita Lesch', 'vconn@example.org', 1),
(87, 'wilhelm.hammes', 'Jaren Ledner', 'torphy.velva@example.org', 1),
(88, 'angeline.blick', 'Marcos Hegmann', 'ekonopelski@example.org', 1),
(89, 'rodrigo.dickens', 'Hailey Williamson', 'abner.emard@example.com', 0),
(90, 'lmiller', 'Winona Mayer', 'montana95@example.org', 0),
(91, 'nschamberger', 'Eloise Carroll DDS', 'egrimes@example.com', 1),
(92, 'batz.nellie', 'Haven Marks Sr.', 'glover.jaclyn@example.com', 0),
(93, 'genoveva.emard', 'Rosetta Cormier', 'weldon08@example.net', 0),
(94, 'eldon90', 'Derick Runolfsson', 'kellen41@example.org', 1),
(95, 'alena38', 'Dr. Helga Stokes DVM', 'klein.kamryn@example.net', 0),
(96, 'major.goodwin', 'Russ Dietrich', 'courtney72@example.com', 1),
(97, 'lou52', 'Prof. Maiya Mills II', 'ihoeger@example.com', 0),
(98, 'ueffertz', 'Dr. Jaren Sauer Jr.', 'herman.nella@example.net', 1),
(100, 'leif19', 'Greyson Boyle', 'morgan72@example.com', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_username` (`username`),
  ADD UNIQUE KEY `uq_email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
