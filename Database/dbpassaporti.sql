-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 15, 2023 alle 17:14
-- Versione del server: 10.4.28-MariaDB
-- Versione PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbpassaporti`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `anagrafiche`
--

CREATE TABLE `anagrafiche` (
  `codiceFiscale` char(16) NOT NULL,
  `tesseraSanitaria` char(8) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cognome` varchar(30) NOT NULL,
  `dataNascita` date NOT NULL,
  `luogoNascita` varchar(30) NOT NULL,
  `sesso` enum('M','F') NOT NULL,
  `figliMinori` enum('SI','NO') NOT NULL,
  `passaportoDiplomatico` enum('SI','NO') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `anagrafiche`
--

INSERT INTO `anagrafiche` (`codiceFiscale`, `tesseraSanitaria`, `nome`, `cognome`, `dataNascita`, `luogoNascita`, `sesso`, `figliMinori`, `passaportoDiplomatico`) VALUES
('CMLFNC01T14L219I', '39024930', 'CAMILLA', 'FRANCHI', '2001-12-14', 'TORINO', 'F', 'NO', 'NO'),
('CNTCRL61C13D612C', '20482105', 'CARLO', 'CONTI', '1961-03-13', 'FIRENZE', 'M', 'NO', 'NO'),
('MNCLNE74D20L781I', '64259640', 'ELENA', 'MANCINI', '1974-04-20', 'VERONA', 'F', 'SI', 'NO'),
('NCLDRZ63H06G273H', '42902381', 'NICOLA', 'UDERZO', '1963-06-06', 'PALERMO', 'M', 'NO', 'SI'),
('VLNNDR87E16A794I', '47294739', 'ANDREA', 'VALENTE', '1987-05-16', 'BERGAMO', 'M', 'NO', 'NO');

-- --------------------------------------------------------

--
-- Struttura della tabella `cittadini`
--

CREATE TABLE `cittadini` (
  `codiceFiscale` char(16) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cognome` varchar(30) NOT NULL,
  `dataNascita` date NOT NULL,
  `luogoNascita` varchar(30) NOT NULL,
  `password` varchar(64) NOT NULL,
  `salt` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `personale`
--

CREATE TABLE `personale` (
  `idPersonale` char(5) NOT NULL,
  `password` varchar(64) NOT NULL,
  `salt` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Struttura della tabella `richieste`
--

CREATE TABLE `richieste` (
  `idRichiesta` int(11) NOT NULL,
  `codiceFiscaleRichiedente` char(16) NOT NULL,
  `motivoRichiesta` enum('ritiro passaporto','rilascio passaporto per la prima volta','furto','rilascio del passaporto per scadenza del precedente','smarrimento','deterioramento') NOT NULL,
  `dataRichiesta` date NOT NULL DEFAULT current_timestamp(),
  `statoRichiesta` enum('aperta','in elaborazione','pronta','chiusa') NOT NULL DEFAULT 'aperta'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `sedi`
--

CREATE TABLE `sedi` (
  `idSede` int(11) NOT NULL,
  `nomeSede` varchar(30) NOT NULL,
  `comuneSede` varchar(30) NOT NULL,
  `provinciaSede` varchar(30) NOT NULL,
  `indirizzoSede` varchar(30) NOT NULL,
  `numeroCivicoSede` int(5) NOT NULL,
  `telefono` char(10) NOT NULL,
  `CAP` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `sedi`
--

INSERT INTO `sedi` (`idSede`, `nomeSede`, `comuneSede`, `provinciaSede`, `indirizzoSede`, `numeroCivicoSede`, `telefono`, `CAP`) VALUES
(1, 'Questura di Verona', 'Verona', 'Verona', 'Lungadige Antonio Galtarossa', 11, '0458090490', '37133'),
(2, 'Questura di Firenze', 'Firenze', 'Firenze', 'Via della Fortezza', 17, '0554977602', '50129'),
(3, 'Commissariato P.S. Rifredi-Per', 'Firenze', 'Firenze', 'Via Sgambati ', 21, '0554977602', '50129');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `anagrafiche`
--
ALTER TABLE `anagrafiche`
  ADD PRIMARY KEY (`codiceFiscale`),
  ADD UNIQUE KEY `tesseraSanitaria` (`tesseraSanitaria`);

--
-- Indici per le tabelle `cittadini`
--
ALTER TABLE `cittadini`
  ADD PRIMARY KEY (`codiceFiscale`);

--
-- Indici per le tabelle `personale`
--
ALTER TABLE `personale`
  ADD PRIMARY KEY (`idPersonale`);

--
-- Indici per le tabelle `richieste`
--
ALTER TABLE `richieste`
  ADD PRIMARY KEY (`idRichiesta`),
  ADD UNIQUE KEY `codiceFiscaleRichiedente` (`codiceFiscaleRichiedente`);

--
-- Indici per le tabelle `sedi`
--
ALTER TABLE `sedi`
  ADD PRIMARY KEY (`idSede`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--


--
-- AUTO_INCREMENT per la tabella `richieste`
--
ALTER TABLE `richieste`
  MODIFY `idRichiesta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `sedi`
--
ALTER TABLE `sedi`
  MODIFY `idSede` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `cittadini`
--
ALTER TABLE `cittadini`
  ADD CONSTRAINT `codiceFiscale` FOREIGN KEY (`codiceFiscale`) REFERENCES `anagrafiche` (`codiceFiscale`);

--
-- Limiti per la tabella `richieste`
--
ALTER TABLE `richieste`
  ADD CONSTRAINT `codiceFiscaleRichiedente` FOREIGN KEY (`codiceFiscaleRichiedente`) REFERENCES `anagrafiche` (`codiceFiscale`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
