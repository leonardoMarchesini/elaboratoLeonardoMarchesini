-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Mag 29, 2021 alle 16:21
-- Versione del server: 10.4.19-MariaDB
-- Versione PHP: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elaborato`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `account`
--

CREATE TABLE `account` (
  `id` varchar(255) NOT NULL,
  `codInterest` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `photoUrl` varchar(255) NOT NULL,
  `bio` varchar(25) NOT NULL,
  `displayName` varchar(25) NOT NULL,
  `countComment` int(11) NOT NULL DEFAULT 0,
  `countPost` int(11) NOT NULL DEFAULT 0,
  `cap` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `account`
--

INSERT INTO `account` (`id`, `codInterest`, `email`, `username`, `photoUrl`, `bio`, `displayName`, `countComment`, `countPost`, `cap`) VALUES
('101170123594043380309', 2, 'francesco.barsotti@itiszuccante.edu.it', 'sco.bar02', 'https://lh3.googleusercontent.com/a/AATXAJwP8B1oSlBu0u6aZpb3wY4R98lkp5YeoOdgV3Qs=s96-c', 'Chitarrista Nato!', 'Francesco Barsotti', 1, 0, '30175'),
('108120163591643370309', 3, 'nicolo.zardin@itiszuccante.edu.it', 'nick.zard07', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/V8BNOaftJmYwEymrtjIdm3dvJ_IrXbDowCLcDEAEiGQoBbhD___________8BGJ6i0f_______wE/s70-p-k-rw-no/photo.jpg', 'In palestra', 'Nicolo Zardin', 0, 0, '30034'),
('113178699341023266448', 1, 'leonardo.marchesini@itiszuccante.edu.it', 'leoma', 'https://lh3.googleusercontent.com/a-/AOh14Giz6JwUmhKadu5FsFcsTnW2xTUyAzREDv9mz6vy=s96-c', 'Testone', 'Leonardo Marchesini', 2, 2, '30174'),
('178120153598643671959', 4, 'jacopo.ferian@itiszuccante.edu.it', 'oligominerale', 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/V8BNOaftJmYKR8jdHckpQtlyn5nLZ6sQACLcDEAEiGQoBahD___________8BGKevgvj______wE/s70-p-k-rw-no/photo.jpg', 'Sto studiando', 'Jacopo Ferian', 1, 2, '30034');

-- --------------------------------------------------------

--
-- Struttura della tabella `artist`
--

CREATE TABLE `artist` (
  `codA` int(11) NOT NULL,
  `postId` varchar(40) NOT NULL,
  `nome` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `artist`
--

INSERT INTO `artist` (`codA`, `postId`, `nome`) VALUES
(1, 'VEoA8gkexofncl2zEp3k', 'Roberto Benigni'),
(2, 'VaIGZxZ3lrN9c6YEsSo2', 'Robert Plant'),
(3, 'WgmC5HfTvzHzb8fALmLr', 'Eddie Hall'),
(4, 'ojlUDIOwlnBKELdhq1Hx', 'Rihanna');

-- --------------------------------------------------------

--
-- Struttura della tabella `comment`
--

CREATE TABLE `comment` (
  `commentId` int(11) NOT NULL,
  `userId` varchar(255) NOT NULL,
  `postId` varchar(40) NOT NULL,
  `text` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `comment`
--

INSERT INTO `comment` (`commentId`, `userId`, `postId`, `text`) VALUES
(1, '101170123594043380309', 'VaIGZxZ3lrN9c6YEsSo2', 'WOW, CHE VOCE!'),
(2, '178120153598643671959', 'WgmC5HfTvzHzb8fALmLr', 'Senza parole'),
(3, '113178699341023266448', 'ojlUDIOwlnBKELdhq1Hx', 'Fantastica'),
(4, '113178699341023266448', 'ojlUDIOwlnBKELdhq1Hx', 'Bellissimo');

-- --------------------------------------------------------

--
-- Struttura della tabella `interest`
--

CREATE TABLE `interest` (
  `codInterest` int(11) NOT NULL,
  `refId` varchar(255) NOT NULL,
  `classicDance` varchar(1) NOT NULL DEFAULT '0',
  `comedy` varchar(1) NOT NULL DEFAULT '0',
  `sport` varchar(55) NOT NULL DEFAULT '0',
  `neomelodica` varchar(1) NOT NULL DEFAULT '0',
  `pop` varchar(1) NOT NULL DEFAULT '0',
  `rock` varchar(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `interest`
--

INSERT INTO `interest` (`codInterest`, `refId`, `classicDance`, `comedy`, `sport`, `neomelodica`, `pop`, `rock`) VALUES
(1, '113178699341023266448', '0', '1', '0', '1', '1', '1'),
(2, '178120153598643671959', '0', '1', '1', '0', '1', '1'),
(3, '108120163591643370309', '1', '0', '0', '1', '1', '0'),
(4, '101170123594043380309', '0', '1', '1', '1', '1', '1');

-- --------------------------------------------------------

--
-- Struttura della tabella `post`
--

CREATE TABLE `post` (
  `postId` varchar(40) NOT NULL,
  `userId` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `place` varchar(22) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date` varchar(55) NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `img` varchar(225) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `post`
--

INSERT INTO `post` (`postId`, `userId`, `title`, `place`, `timestamp`, `date`, `likes`, `img`) VALUES
('ojlUDIOwlnBKELdhq1Hx', '113178699341023266448', 'Rock in Mestre at the Francesco Baracca Stadium', '30174', '2021-05-29 14:13:58', '26/11/2021', 15, 'https://firebasestorage.googleapis.com/v0/b/smartsocial-bad2d.appspot.com/o/coez-roma-2018-foto-concerto-7-luglio-13-740x493.jpg?alt=media&token=5e1c40d9-95b1-4576-8fbb-f686a6e0b56a'),
('VaIGZxZ3lrN9c6YEsSo2', '101170123594043380309', 'VENICE BEACH MUSIC FEST 15, A FREE MUSIC AND ARTS FESTIVAL', '30175', '2021-05-29 14:04:41', '15/08/2021', 8, 'https://firebasestorage.googleapis.com/v0/b/smartsocial-bad2d.appspot.com/o/VMBF14Agosto.jpg?alt=media&token=5636b257-d23f-45d3-83a9-838b307f4396'),
('VEoA8gkexofncl2zEp3k', '178120153598643671959', 'Weekend in Oriago between comic events and fun, in Piazza San Marco', '30034', '2021-05-29 14:15:02', '28/06/2021', 2, 'https://www.napolike.it/wp-content/uploads/2019/08/eventi-weekend-napoli-16-17-18-agosto-2019.jpg'),
('WgmC5HfTvzHzb8fALmLr', '113178699341023266448', 'Arnold`s Finals broadcasts on the big screen at the Magenta bar', '30174', '2021-05-29 14:08:49', '12/09/2021', 15, 'https://firebasestorage.googleapis.com/v0/b/smartsocial-bad2d.appspot.com/o/4-scaled-1170x655_c.jpg?alt=media&token=c9a28c72-0914-4f80-9be5-d4c49884fd8f');

-- --------------------------------------------------------

--
-- Struttura della tabella `vote`
--

CREATE TABLE `vote` (
  `codVote` int(11) NOT NULL,
  `postId` varchar(40) NOT NULL,
  `userId` varchar(255) NOT NULL,
  `vote` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `vote`
--

INSERT INTO `vote` (`codVote`, `postId`, `userId`, `vote`) VALUES
(1, 'ojlUDIOwlnBKELdhq1Hx', '101170123594043380309', 4),
(2, 'VaIGZxZ3lrN9c6YEsSo2', '178120153598643671959', 3),
(3, 'VEoA8gkexofncl2zEp3k', '113178699341023266448', 2),
(4, 'WgmC5HfTvzHzb8fALmLr', '113178699341023266448', 5);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`),
  ADD KEY `codInterest` (`codInterest`);

--
-- Indici per le tabelle `artist`
--
ALTER TABLE `artist`
  ADD PRIMARY KEY (`codA`),
  ADD KEY `postId` (`postId`);

--
-- Indici per le tabelle `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`commentId`),
  ADD KEY `postId` (`postId`),
  ADD KEY `userId` (`userId`);

--
-- Indici per le tabelle `interest`
--
ALTER TABLE `interest`
  ADD PRIMARY KEY (`codInterest`),
  ADD KEY `refId` (`refId`);

--
-- Indici per le tabelle `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`postId`),
  ADD KEY `userId` (`userId`);

--
-- Indici per le tabelle `vote`
--
ALTER TABLE `vote`
  ADD PRIMARY KEY (`codVote`),
  ADD KEY `postId` (`postId`),
  ADD KEY `userId` (`userId`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `artist`
--
ALTER TABLE `artist`
  MODIFY `codA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `comment`
--
ALTER TABLE `comment`
  MODIFY `commentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `interest`
--
ALTER TABLE `interest`
  MODIFY `codInterest` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `vote`
--
ALTER TABLE `vote`
  MODIFY `codVote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`codInterest`) REFERENCES `interest` (`codInterest`);

--
-- Limiti per la tabella `artist`
--
ALTER TABLE `artist`
  ADD CONSTRAINT `artist_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `post` (`postId`);

--
-- Limiti per la tabella `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `post` (`postId`);

--
-- Limiti per la tabella `vote`
--
ALTER TABLE `vote`
  ADD CONSTRAINT `vote_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `post` (`postId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
