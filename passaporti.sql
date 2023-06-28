-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Giu 28, 2023 alle 21:56
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
-- Database: `passaporti`
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
  `salt` varchar(32) NOT NULL,
  `numeroPassaporto` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `cittadini`
--

INSERT INTO `cittadini` (`codiceFiscale`, `nome`, `cognome`, `dataNascita`, `luogoNascita`, `password`, `salt`, `numeroPassaporto`) VALUES
('CMLFNC01T14L219I', 'CAMILLA', 'FRANCHI', '2001-12-14', 'TORINO', '���@�S��g4��4�G��X�IP\r�ʠ', '=\"Qd!Jno\\T)6lr%IT-g8/;\\@uo', NULL),
('CNTCRL61C13D612C', 'CARLO', 'CONTI', '1961-03-13', 'FIRENZE', '����y��ӛ|/��Ei.2n��\Z5��*S`��=�', '8Tq\'_C/jBw&Qm-7&5=j7', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `disponibilita`
--

CREATE TABLE `disponibilita` (
  `idDisponibilita` int(11) NOT NULL,
  `slot` int(11) NOT NULL,
  `dataDisponibilita` date NOT NULL,
  `oraInizio` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `oraFine` timestamp NOT NULL DEFAULT current_timestamp(),
  `idSede` int(11) NOT NULL,
  `codiceFiscaleCittadino` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
-- Dump dei dati per la tabella `personale`
--

INSERT INTO `personale` (`idPersonale`, `password`, `salt`) VALUES
('00000', '����:��1���5�\\�P�$|�H��Q�*TF�', 'VrG;A]0,hLdHU\"!E,#KR=Ikd$:UF_J^W'),
('39112', '���k��r�B8��j4�_m�$֪t��`�;��I', 'j-IR<mcp3Cs13Q^,`N4d1o.Ca6q2C@Gb'),
('VR103', '|��dĬ���r94e\Zч�v��\"z�e9w\n\\', 'N(M(%-,$(*G!j5.t&B\'f=ue?dZ@aO:!'),
('VR113', '��$��.쌯���=��9�D]�cgi{�lM\'Z�', 'H_1jS3/,UW,:H18I{jlKH@6WhVxr:NEh'),
('VR300', 'FǄ\0�~��m��W�	m� �L�����8-.<t', 'W2x[v.R7x1*\'f*YrTw[#d<^vfa]}c;I'),
('VR392', '���qC���@ٓu���ξғ���YgY', 'o\'aA%6t-k86O@j7ZVP(6c$>[hRTQsvxL'),
('VR394', 'Xc\n����5�k�\0��5*�w�:Ƽ^��F�8�$', '(C\"ta,VR898%y,eHBdx%*Fy(FL<bOF/@');

-- --------------------------------------------------------

--
-- Struttura della tabella `richieste`
--

CREATE TABLE `richieste` (
  `idRichiesta` int(11) NOT NULL,
  `codiceFiscaleRichiedente` char(16) NOT NULL,
  `idSedeAppuntamento` int(11) DEFAULT NULL,
  `motivoRichiesta` enum('Ritiro passaporto','Rilascio passaporto per la prima volta','Furto','Rilascio passaporto per scadenza del precedente','Smarrimento','Deterioramento') NOT NULL,
  `dataAppuntamento` date DEFAULT NULL,
  `dataRichiesta` date NOT NULL DEFAULT current_timestamp(),
  `statoRichiesta` enum('aperta','in elaborazione','pronta','chiusa') NOT NULL DEFAULT 'aperta'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `richieste`
--

INSERT INTO `richieste` (`idRichiesta`, `codiceFiscaleRichiedente`, `idSedeAppuntamento`, `motivoRichiesta`, `dataAppuntamento`, `dataRichiesta`, `statoRichiesta`) VALUES
(8, 'CNTCRL61C13D612C', NULL, 'Smarrimento', '2023-06-06', '2023-05-01', 'chiusa'),
(9, 'CNTCRL61C13D612C', NULL, 'Ritiro passaporto', NULL, '2023-06-21', 'chiusa'),
(11, 'CNTCRL61C13D612C', 2, 'Smarrimento', '2023-06-12', '2023-05-08', 'chiusa'),
(12, 'CNTCRL61C13D612C', NULL, 'Ritiro passaporto', NULL, '2023-06-01', 'chiusa'),
(13, 'CMLFNC01T14L219I', NULL, 'Furto', NULL, '2023-06-28', 'chiusa'),
(17, 'CMLFNC01T14L219I', NULL, 'Ritiro passaporto', NULL, '2023-06-28', 'chiusa'),
(18, 'CNTCRL61C13D612C', NULL, 'Smarrimento', NULL, '2023-06-28', 'aperta');

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
(2, 'Questura di Firenze', 'Firenze', 'Firenze', 'via della Fortezza', 17, '0554977602', '50129'),
(3, 'Commissariato P.S. Rifredi-Per', 'Firenze', 'Firenze', 'via Sgambati ', 21, '0554977602', '50129');

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
-- Indici per le tabelle `disponibilita`
--
ALTER TABLE `disponibilita`
  ADD PRIMARY KEY (`idDisponibilita`),
  ADD KEY `idSedeDisponibilita` (`idSede`) USING BTREE,
  ADD KEY `codicefiscale` (`codiceFiscaleCittadino`);

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
  ADD KEY `idSede` (`idSedeAppuntamento`),
  ADD KEY `codiceFiscaleRichiedente` (`codiceFiscaleRichiedente`) USING BTREE;

--
-- Indici per le tabelle `sedi`
--
ALTER TABLE `sedi`
  ADD PRIMARY KEY (`idSede`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `disponibilita`
--
ALTER TABLE `disponibilita`
  MODIFY `idDisponibilita` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `richieste`
--
ALTER TABLE `richieste`
  MODIFY `idRichiesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
-- Limiti per la tabella `disponibilita`
--
ALTER TABLE `disponibilita`
  ADD CONSTRAINT `codfisc` FOREIGN KEY (`codiceFiscaleCittadino`) REFERENCES `cittadini` (`codiceFiscale`),
  ADD CONSTRAINT `sede` FOREIGN KEY (`idSede`) REFERENCES `sedi` (`idSede`);

--
-- Limiti per la tabella `richieste`
--
ALTER TABLE `richieste`
  ADD CONSTRAINT `codiceFiscaleRichiedente` FOREIGN KEY (`codiceFiscaleRichiedente`) REFERENCES `cittadini` (`codiceFiscale`),
  ADD CONSTRAINT `idSede` FOREIGN KEY (`idSedeAppuntamento`) REFERENCES `sedi` (`idSede`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
