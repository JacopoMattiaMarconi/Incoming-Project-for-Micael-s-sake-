-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              10.4.28-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win64
-- HeidiSQL Versione:            12.4.0.6659
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dump della struttura del database passaporti
CREATE DATABASE IF NOT EXISTS `passaporti` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `passaporti`;

-- Dump della struttura di tabella passaporti.anagrafiche
CREATE TABLE IF NOT EXISTS `anagrafiche` (
  `codiceFiscale` char(16) NOT NULL,
  `tesseraSanitaria` char(8) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cognome` varchar(30) NOT NULL,
  `dataNascita` date NOT NULL,
  `luogoNascita` varchar(30) NOT NULL,
  `sesso` enum('M','F') NOT NULL,
  `figliMinori` enum('SI','NO') NOT NULL,
  `passaportoDiplomatico` enum('SI','NO') NOT NULL,
  PRIMARY KEY (`codiceFiscale`),
  UNIQUE KEY `tesseraSanitaria` (`tesseraSanitaria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella passaporti.anagrafiche: ~5 rows (circa)
INSERT INTO `anagrafiche` (`codiceFiscale`, `tesseraSanitaria`, `nome`, `cognome`, `dataNascita`, `luogoNascita`, `sesso`, `figliMinori`, `passaportoDiplomatico`) VALUES
	('CMLFNC01T14L219I', '39024930', 'CAMILLA', 'FRANCHI', '2001-12-14', 'TORINO', 'F', 'NO', 'NO'),
	('CNTCRL61C13D612C', '20482105', 'CARLO', 'CONTI', '1961-03-13', 'FIRENZE', 'M', 'NO', 'NO'),
	('MNCLNE74D20L781I', '64259640', 'ELENA', 'MANCINI', '1974-04-20', 'VERONA', 'F', 'SI', 'NO'),
	('NCLDRZ63H06G273H', '42902381', 'NICOLA', 'UDERZO', '1963-06-06', 'PALERMO', 'M', 'NO', 'SI'),
	('VLNNDR87E16A794I', '47294739', 'ANDREA', 'VALENTE', '1987-05-16', 'BERGAMO', 'M', 'NO', 'NO');

-- Dump della struttura di tabella passaporti.cittadini
CREATE TABLE IF NOT EXISTS `cittadini` (
  `codiceFiscale` char(16) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cognome` varchar(30) NOT NULL,
  `dataNascita` date NOT NULL,
  `luogoNascita` varchar(30) NOT NULL,
  `password` varchar(64) NOT NULL,
  `salt` varchar(32) NOT NULL,
  PRIMARY KEY (`codiceFiscale`),
  CONSTRAINT `codiceFiscale` FOREIGN KEY (`codiceFiscale`) REFERENCES `anagrafiche` (`codiceFiscale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella passaporti.cittadini: ~1 rows (circa)
INSERT INTO `cittadini` (`codiceFiscale`, `nome`, `cognome`, `dataNascita`, `luogoNascita`, `password`, `salt`) VALUES
	('CNTCRL61C13D612C', 'CARLO', 'CONTI', '1961-03-13', 'FIRENZE', '��?�Y�@\n,})2�l�`vd�S��%����', '>gEG=e76+/:kY?5O;zihbF;d&');

-- Dump della struttura di tabella passaporti.personale
CREATE TABLE IF NOT EXISTS `personale` (
  `idPersonale` char(5) NOT NULL,
  `password` varchar(8) NOT NULL,
  PRIMARY KEY (`idPersonale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella passaporti.personale: ~7 rows (circa)
INSERT INTO `personale` (`idPersonale`, `password`) VALUES
	('00000', 'password'),
	('39112', 'k ??,(?'),
	('VR103', '123'),
	('VR113', '123'),
	('VR300', '888'),
	('VR392', '123'),
	('VR394', '123');

-- Dump della struttura di tabella passaporti.richieste
CREATE TABLE IF NOT EXISTS `richieste` (
  `idRichiesta` int(11) NOT NULL AUTO_INCREMENT,
  `codiceFiscaleRichiedente` char(16) NOT NULL,
  `idSedeAppuntamento` int(11) NOT NULL,
  `motivoRichiesta` enum('ritiro passaporto','rilascio passaporto per la prima volta','furto','rilascio del passaporto per scadenza del precedente','smarrimento','deterioramento') NOT NULL,
  `dataAppuntamento` date NOT NULL,
  `dataRichiesta` date NOT NULL DEFAULT current_timestamp(),
  `statoRichiesta` enum('aperta','in elaborazione','pronta','chiusa') NOT NULL DEFAULT 'aperta',
  PRIMARY KEY (`idRichiesta`),
  UNIQUE KEY `codiceFiscaleRichiedente` (`codiceFiscaleRichiedente`),
  KEY `idSede` (`idSedeAppuntamento`),
  CONSTRAINT `codiceFiscaleRichiedente` FOREIGN KEY (`codiceFiscaleRichiedente`) REFERENCES `anagrafiche` (`codiceFiscale`),
  CONSTRAINT `idSede` FOREIGN KEY (`idSedeAppuntamento`) REFERENCES `sedi` (`idSede`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella passaporti.richieste: ~0 rows (circa)
INSERT INTO `richieste` (`idRichiesta`, `codiceFiscaleRichiedente`, `idSedeAppuntamento`, `motivoRichiesta`, `dataAppuntamento`, `dataRichiesta`, `statoRichiesta`) VALUES
	(1, 'CNTCRL61C13D612C', 3, 'smarrimento', '2023-08-13', '2023-05-20', 'aperta');

-- Dump della struttura di tabella passaporti.sedi
CREATE TABLE IF NOT EXISTS `sedi` (
  `idSede` int(11) NOT NULL AUTO_INCREMENT,
  `nomeSede` varchar(30) NOT NULL,
  `comuneSede` varchar(30) NOT NULL,
  `provinciaSede` varchar(30) NOT NULL,
  `indirizzoSede` varchar(30) NOT NULL,
  `numeroCivicoSede` int(5) NOT NULL,
  `telefono` char(10) NOT NULL,
  `CAP` char(5) NOT NULL,
  PRIMARY KEY (`idSede`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella passaporti.sedi: ~3 rows (circa)
INSERT INTO `sedi` (`idSede`, `nomeSede`, `comuneSede`, `provinciaSede`, `indirizzoSede`, `numeroCivicoSede`, `telefono`, `CAP`) VALUES
	(1, 'Questura di Verona', 'Verona', 'Verona', 'Lungadige Antonio Galtarossa', 11, '0458090490', '37133'),
	(2, 'Questura di Firenze', 'Firenze', 'Firenze', 'via della Fortezza', 17, '0554977602', '50129'),
	(3, 'Commissariato P.S. Rifredi-Per', 'Firenze', 'Firenze', 'via Sgambati ', 21, '0554977602', '50129');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
