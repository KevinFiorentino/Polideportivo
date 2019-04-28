-- MySQL Script generated by MySQL Workbench
-- 10/09/18 21:23:08
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dbodbc
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `dbodbc` ;
CREATE SCHEMA IF NOT EXISTS `dbodbc` DEFAULT CHARACTER SET utf8 ;
USE `dbodbc` ;

-- -----------------------------------------------------
-- Table `dbodbc`.`tipologin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbodbc`.`tipologin` ;

CREATE TABLE IF NOT EXISTS `dbodbc`.`tipologin` (
  `idTipoLogin` INT(11) NOT NULL AUTO_INCREMENT,
  `tipoLogin` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idTipoLogin`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbodbc`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbodbc`.`usuario` ;

CREATE TABLE IF NOT EXISTS `dbodbc`.`usuario` (
  `idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` INT(11) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbodbc`.`login`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbodbc`.`login` ;

CREATE TABLE IF NOT EXISTS `dbodbc`.`login` (
  `idLogin` INT(11) NOT NULL AUTO_INCREMENT,
  `user` VARCHAR(45) NOT NULL,
  `pass` VARCHAR(45) NOT NULL,
  `idTipoLogin` INT(11) NOT NULL,
  INDEX `fk_Login_TipoLogin_idx` (`idTipoLogin` ASC),
  INDEX `fk_login_usuario1_idx` (`idLogin` ASC),
  PRIMARY KEY (`idLogin`),
  CONSTRAINT `fk_Login_TipoLogin`
    FOREIGN KEY (`idTipoLogin`)
    REFERENCES `dbodbc`.`tipologin` (`idTipoLogin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_login_usuario1`
    FOREIGN KEY (`idLogin`)
    REFERENCES `dbodbc`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `dbodbc`.`Localidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbodbc`.`Localidad` ;

CREATE TABLE IF NOT EXISTS `dbodbc`.`Localidad` (
  `idLocalidad` INT NOT NULL AUTO_INCREMENT,
  `localidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLocalidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbodbc`.`Filial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbodbc`.`Filial` ;

CREATE TABLE IF NOT EXISTS `dbodbc`.`Filial` (
  `idFilial` INT NOT NULL AUTO_INCREMENT,
  `horarioDesde` TIME NULL,
  `horarioHasta` TIME NULL,
  `diaMantenimiento` VARCHAR(45) NULL,
  `idLocalidad` INT NOT NULL,
  PRIMARY KEY (`idFilial`),
  INDEX `fk_Filial_Localidad1_idx` (`idLocalidad` ASC),
  CONSTRAINT `fk_Filial_Localidad1`
    FOREIGN KEY (`idLocalidad`)
    REFERENCES `dbodbc`.`Localidad` (`idLocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbodbc`.`Deporte`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbodbc`.`Deporte` ;

CREATE TABLE IF NOT EXISTS `dbodbc`.`Deporte` (
  `idDeporte` INT NOT NULL AUTO_INCREMENT,
  `deporte` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDeporte`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbodbc`.`TipoCancha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbodbc`.`TipoCancha` ;

CREATE TABLE IF NOT EXISTS `dbodbc`.`TipoCancha` (
  `idTipoCancha` INT NOT NULL AUTO_INCREMENT,
  `tipoCancha` VARCHAR(45) NOT NULL,
  `idDeporte` INT NOT NULL,
  PRIMARY KEY (`idTipoCancha`),
  INDEX `fk_TipoCancha_Deporte1_idx` (`idDeporte` ASC),
  CONSTRAINT `fk_TipoCancha_Deporte1`
    FOREIGN KEY (`idDeporte`)
    REFERENCES `dbodbc`.`Deporte` (`idDeporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbodbc`.`Cancha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbodbc`.`Cancha` ;

CREATE TABLE IF NOT EXISTS `dbodbc`.`Cancha` (
  `idCancha` INT NOT NULL AUTO_INCREMENT,
  `idTipoCancha` INT NOT NULL,
  `idFilial` INT NOT NULL,
  PRIMARY KEY (`idCancha`),
  INDEX `fk_Cancha_TipoCancha1_idx` (`idTipoCancha` ASC),
  INDEX `fk_Cancha_Filial1_idx` (`idFilial` ASC),
  CONSTRAINT `fk_Cancha_TipoCancha1`
    FOREIGN KEY (`idTipoCancha`)
    REFERENCES `dbodbc`.`TipoCancha` (`idTipoCancha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cancha_Filial1`
    FOREIGN KEY (`idFilial`)
    REFERENCES `dbodbc`.`Filial` (`idFilial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbodbc`.`Turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dbodbc`.`Turno` ;

CREATE TABLE IF NOT EXISTS `dbodbc`.`Turno` (
  `idTurno` INT NOT NULL AUTO_INCREMENT,
  `fechaHora` DATETIME NOT NULL,
  `vigente` TINYINT(1) NOT NULL,
  `idFilial` INT NOT NULL,
  `idCancha` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idTurno`),
  INDEX `fk_Turno_Filial1_idx` (`idFilial` ASC),
  INDEX `fk_Turno_Cancha1_idx` (`idCancha` ASC),
  INDEX `fk_Turno_usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Turno_Filial1`
    FOREIGN KEY (`idFilial`)
    REFERENCES `dbodbc`.`Filial` (`idFilial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turno_Cancha1`
    FOREIGN KEY (`idCancha`)
    REFERENCES `dbodbc`.`Cancha` (`idCancha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turno_usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `dbodbc`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `dbodbc`.`tipologin`
-- -----------------------------------------------------
START TRANSACTION;
USE `dbodbc`;
INSERT INTO `dbodbc`.`tipologin` (`idTipoLogin`, `tipoLogin`) VALUES (1, 'Socio');
INSERT INTO `dbodbc`.`tipologin` (`idTipoLogin`, `tipoLogin`) VALUES (2, 'Administrador');

COMMIT;


-- -----------------------------------------------------
-- Data for table `dbodbc`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `dbodbc`;
INSERT INTO `dbodbc`.`usuario` (`idUsuario`, `nombre`, `apellido`, `direccion`, `telefono`, `email`) VALUES (1, 'Kevin', 'Fiorentino', 'UNLa', 1131768187, 'kevin@gmail.com');
INSERT INTO `dbodbc`.`usuario` (`idUsuario`, `nombre`, `apellido`, `direccion`, `telefono`, `email`) VALUES (2, 'Pablo', 'Violi', 'UNLa', 1155555555, 'pablo@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `dbodbc`.`login`
-- -----------------------------------------------------
START TRANSACTION;
USE `dbodbc`;
INSERT INTO `dbodbc`.`login` (`idLogin`, `user`, `pass`, `idTipoLogin`) VALUES (1, 'socio', '1111', 1);
INSERT INTO `dbodbc`.`login` (`idLogin`, `user`, `pass`, `idTipoLogin`) VALUES (2, 'admin', '1111', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `dbodbc`.`Localidad`
-- -----------------------------------------------------
START TRANSACTION;
USE `dbodbc`;
INSERT INTO `dbodbc`.`Localidad` (`idLocalidad`, `localidad`) VALUES (1, 'Lanus');
INSERT INTO `dbodbc`.`Localidad` (`idLocalidad`, `localidad`) VALUES (2, 'Banfield');
INSERT INTO `dbodbc`.`Localidad` (`idLocalidad`, `localidad`) VALUES (3, 'Lomas');

COMMIT;


-- -----------------------------------------------------
-- Data for table `dbodbc`.`Filial`
-- -----------------------------------------------------
START TRANSACTION;
USE `dbodbc`;
INSERT INTO `dbodbc`.`Filial` (`idFilial`, `horarioDesde`, `horarioHasta`, `diaMantenimiento`, `idLocalidad`) VALUES (1, '09:00', '19:00', '4', 1);
INSERT INTO `dbodbc`.`Filial` (`idFilial`, `horarioDesde`, `horarioHasta`, `diaMantenimiento`, `idLocalidad`) VALUES (2, '11:00', '22:00', '3', 2);
INSERT INTO `dbodbc`.`Filial` (`idFilial`, `horarioDesde`, `horarioHasta`, `diaMantenimiento`, `idLocalidad`) VALUES (3, '9:00', '20:00', '2', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `dbodbc`.`Deporte`
-- -----------------------------------------------------
START TRANSACTION;
USE `dbodbc`;
INSERT INTO `dbodbc`.`Deporte` (`idDeporte`, `deporte`) VALUES (1, 'Tenis');
INSERT INTO `dbodbc`.`Deporte` (`idDeporte`, `deporte`) VALUES (2, 'Futbol');
INSERT INTO `dbodbc`.`Deporte` (`idDeporte`, `deporte`) VALUES (3, 'Basquet');

COMMIT;


-- -----------------------------------------------------
-- Data for table `dbodbc`.`TipoCancha`
-- -----------------------------------------------------
START TRANSACTION;
USE `dbodbc`;
INSERT INTO `dbodbc`.`TipoCancha` (`idTipoCancha`, `tipoCancha`, `idDeporte`) VALUES (1, 'Polvo Ladrillo', 1);
INSERT INTO `dbodbc`.`TipoCancha` (`idTipoCancha`, `tipoCancha`, `idDeporte`) VALUES (2, 'Cesped', 1);
INSERT INTO `dbodbc`.`TipoCancha` (`idTipoCancha`, `tipoCancha`, `idDeporte`) VALUES (3, 'Cemento', 1);
INSERT INTO `dbodbc`.`TipoCancha` (`idTipoCancha`, `tipoCancha`, `idDeporte`) VALUES (4, 'Sintetico', 2);
INSERT INTO `dbodbc`.`TipoCancha` (`idTipoCancha`, `tipoCancha`, `idDeporte`) VALUES (5, 'Cemento', 2);
INSERT INTO `dbodbc`.`TipoCancha` (`idTipoCancha`, `tipoCancha`, `idDeporte`) VALUES (6, 'Arena', 2);
INSERT INTO `dbodbc`.`TipoCancha` (`idTipoCancha`, `tipoCancha`, `idDeporte`) VALUES (7, 'Madera', 3);
INSERT INTO `dbodbc`.`TipoCancha` (`idTipoCancha`, `tipoCancha`, `idDeporte`) VALUES (8, 'Cemento', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `dbodbc`.`Cancha`
-- -----------------------------------------------------
START TRANSACTION;
USE `dbodbc`;
INSERT INTO `dbodbc`.`Cancha` (`idCancha`, `idTipoCancha`, `idFilial`) VALUES (1, 1, 1);
INSERT INTO `dbodbc`.`Cancha` (`idCancha`, `idTipoCancha`, `idFilial`) VALUES (2, 2, 1);
INSERT INTO `dbodbc`.`Cancha` (`idCancha`, `idTipoCancha`, `idFilial`) VALUES (3, 4, 2);
INSERT INTO `dbodbc`.`Cancha` (`idCancha`, `idTipoCancha`, `idFilial`) VALUES (4, 4, 2);
INSERT INTO `dbodbc`.`Cancha` (`idCancha`, `idTipoCancha`, `idFilial`) VALUES (5, 1, 3);
INSERT INTO `dbodbc`.`Cancha` (`idCancha`, `idTipoCancha`, `idFilial`) VALUES (6, 4, 3);

COMMIT;
