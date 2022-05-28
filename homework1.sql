-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Mag 28, 2022 alle 15:36
-- Versione del server: 10.4.20-MariaDB
-- Versione PHP: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `homework1`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `comments_for_posts`
--

CREATE TABLE `comments_for_posts` (
  `user` varchar(255) NOT NULL,
  `post_id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `comments_for_posts`
--

INSERT INTO `comments_for_posts` (`user`, `post_id`, `comment`) VALUES
('matteosan', 13, 'Fede tu saresti capace di rifiutare tranquillamente un 30! :D'),
('matteosan', 6, 'Da non dimenticare il ping pong, passavo un sacco di tempo a giocare a ping pong in Apple!'),
('Schembra00', 14, 'Bravo Matteo! ');

--
-- Trigger `comments_for_posts`
--
DELIMITER $$
CREATE TRIGGER `INCREASE_NUM_COMMENTS` AFTER INSERT ON `comments_for_posts` FOR EACH ROW UPDATE posts
    SET num_comments = num_comments + 1
    WHERE id = new.post_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `likes_for_posts`
--

CREATE TABLE `likes_for_posts` (
  `id_like` int(11) NOT NULL,
  `user` varchar(255) NOT NULL,
  `post_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `likes_for_posts`
--

INSERT INTO `likes_for_posts` (`id_like`, `user`, `post_id`) VALUES
(19, 'Schembra00', 6),
(20, 'Conc00', 7),
(23, 'matteosan', 7),
(27, 'FedeNic', 7),
(28, 'FedeNic', 13),
(29, 'matteosan', 13),
(30, 'matteosan', 6),
(31, 'matteosan', 14),
(32, 'matteosan', 15),
(33, 'GiusMalg', 6);

--
-- Trigger `likes_for_posts`
--
DELIMITER $$
CREATE TRIGGER `DECREASE_NUM_LIKES` AFTER DELETE ON `likes_for_posts` FOR EACH ROW UPDATE posts
    SET num_likes = num_likes - 1
    WHERE id = old.post_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `INCREASE_NUM_LIKES` AFTER INSERT ON `likes_for_posts` FOR EACH ROW UPDATE posts
    SET num_likes = num_likes + 1
    WHERE id = new.post_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(1200) NOT NULL,
  `username` varchar(255) NOT NULL,
  `num_likes` int(11) DEFAULT NULL,
  `num_comments` int(11) DEFAULT NULL,
  `publish_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `posts`
--

INSERT INTO `posts` (`id`, `title`, `content`, `username`, `num_likes`, `num_comments`, `publish_date`) VALUES
(6, 'I dipendenti di Amazon, Apple programmano tutto il giorno?', 'Ho lavorato ad Amazon per 2 anni e mezzo. La mia giornata tipo era:Arrivavo alle 11,Caffè/tè e chiaccherata coi colleghi per 15/20 minuti.Tornavo al lavoro e rispondevo alle mail. Facevo chiamate per dare aggiornamenti sui miei task giornalieri.\r\nLeggevo le documentazioni oppure codice.', 'Schembra00', 3, 1, '2022-05-27'),
(7, 'Cos\'è l\'Al Norman? La Prima Intelligenza Artificiale Psicopatica ', 'Un team del Massachusetts Institute ha creato un algoritmo chiamato Norman, tratto dal film \"Psycho\" di Hitchcock e lo ha addestrato a considerare il mondo come un posto sempre violento. Al software sono state mostrate immagini di persone che morivano in maniera violenta, al limite del gore. ', 'Conc00', 3, 0, '2022-05-27'),
(13, 'È possibile rifiutare un 30 ad un esame universitario?', 'L\'ho visto fare, ad una mia amica. Analisi II, che già solo a passarlo dovevi accendere un cero, almeno trent\'anni fa.\r\n\r\nLa professoressa era ovviamente contrariata, ma diede comunque una chance. Disse che avrebbe fatto un\'ulteriore domanda. Se andava bene, c\'era la lode, se andava male, andava a casa senza esame, cosa che la mia amica avrebbe fatto comunque.', 'FedeNic', 2, 1, '2022-05-28'),
(14, 'Il 5G è dannoso per la salute?', 'È stato dimostrato che la radiazione a onde millimetriche a 60,42 GHz e con una densità di potenza incidente massima di 1 mW/cm2 non altera la vitalità cellulare, l\'espressione genica e la conformazione delle proteine. Quindi neanche nelle condizioni più sfavorevoli risulta dannoso.', 'matteosan', 1, 1, '2022-05-28'),
(15, 'Cos\'è il deep learning? Come funziona?', 'La traduzione strettamente letterale di questo termine, di chiara matrice anglosassone, è apprendimento approfondito. Ed è proprio questo il centro del suo significato, perché il deep learning, sottocategoria del Machine Learning, non fa altro che creare modelli di apprendimento su più livelli.', 'matteosan', 1, 0, '2022-05-28');

-- --------------------------------------------------------

--
-- Struttura della tabella `users`
--

CREATE TABLE `users` (
  `name` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `users`
--

INSERT INTO `users` (`name`, `lastname`, `email`, `username`, `password`) VALUES
('Spampinato', 'Concetto', 'concetto.spampinato@outlook.it', 'Conc00', 'Serpente01'),
('ee', 'eee', 'eeee@gmail.com', 'eee', 'Serpente01'),
('Federico', 'Nicotra', 'federico.nicotra@gmail.com', 'FedeNic', 'Serpente01'),
('Giuseppe', 'Malgeri', 'giuseppe.malgeri@unict.it', 'GiusMalg', 'Serpente01'),
('Matteo', 'Santanocito', 'mattsantanocito@gmail.com', 'matteosan', 'Serpente01'),
('Schembra', 'Giovanni', 'schembra.giovanni@tiscali.it', 'Schembra00', 'Serpente01'),
('Volodymyr ', 'Zelenskyj', 'volodymyr.zelenskyj@saveuckraine.it', 'Zele1978', 'Serpente01');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `comments_for_posts`
--
ALTER TABLE `comments_for_posts`
  ADD KEY `post_id` (`post_id`);

--
-- Indici per le tabelle `likes_for_posts`
--
ALTER TABLE `likes_for_posts`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `user` (`user`),
  ADD KEY `post_id` (`post_id`);

--
-- Indici per le tabelle `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indici per le tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `likes_for_posts`
--
ALTER TABLE `likes_for_posts`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT per la tabella `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `comments_for_posts`
--
ALTER TABLE `comments_for_posts`
  ADD CONSTRAINT `comments_for_posts_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `likes_for_posts`
--
ALTER TABLE `likes_for_posts`
  ADD CONSTRAINT `likes_for_posts_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`username`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_for_posts_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE;

--
-- Limiti per la tabella `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
