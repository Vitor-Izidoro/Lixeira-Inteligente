SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lixeirasena
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lixeirasena` DEFAULT CHARACTER SET utf8;
USE `lixeirasena`;

-- -----------------------------------------------------
-- Table `lixeirasena`.`lixeira`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lixeirasena`.`lixeira` (
  `id_lixeira` INT NOT NULL AUTO_INCREMENT,
  `estado` TINYINT NOT NULL,
  `localizacao` VARCHAR(145) NOT NULL,
  `capacidade` INT NOT NULL,
  `data_hora_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_lixeira`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lixeirasena`.`sensor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lixeirasena`.`sensor` (
  `id_sensor` INT NOT NULL AUTO_INCREMENT,
  `tipo_sensor` VARCHAR(145) NOT NULL,
  `id_lixeira` INT NOT NULL,
  `topic` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`id_sensor`),
  INDEX `id_lixeira_idx` (`id_lixeira` ASC),
  CONSTRAINT `fk_sensor_lixeira`
    FOREIGN KEY (`id_lixeira`)
    REFERENCES `lixeirasena`.`lixeira` (`id_lixeira`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lixeirasena`.`atuador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lixeirasena`.`atuador` (
  `id_atuador` INT NOT NULL AUTO_INCREMENT,
  `tipo_atuador` VARCHAR(145) NOT NULL,
  `id_lixeira` INT NOT NULL,
  `topic` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`id_atuador`),
  INDEX `id_lixeira_idx` (`id_lixeira` ASC),
  UNIQUE INDEX `id_atuador_UNIQUE` (`id_atuador` ASC),
  CONSTRAINT `fk_atuador_lixeira`
    FOREIGN KEY (`id_lixeira`)
    REFERENCES `lixeirasena`.`lixeira` (`id_lixeira`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lixeirasena`.`sensor_historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lixeirasena`.`sensor_historico` (
  `idsensor_historico` INT NOT NULL AUTO_INCREMENT,
  `id_sensor` INT NOT NULL,
  `data_hora_registro` DATETIME NOT NULL,
  `dado` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`idsensor_historico`),
  CONSTRAINT `fk_sensor_historico_sensor`
    FOREIGN KEY (`id_sensor`)
    REFERENCES `lixeirasena`.`sensor` (`id_sensor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lixeirasena`.`atuador_historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lixeirasena`.`atuador_historico` (
  `idatuador_historico` INT NOT NULL AUTO_INCREMENT,
  `id_atuador` INT NOT NULL,
  `data_hora_registro` DATETIME NOT NULL,
  `dado` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`idatuador_historico`),
  INDEX `id_atuador_idx` (`id_atuador` ASC),
  CONSTRAINT `fk_atuador_historico_atuador`
    FOREIGN KEY (`id_atuador`)
    REFERENCES `lixeirasena`.`atuador` (`id_atuador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lixeirasena`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lixeirasena`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `id_lixeira` INT NOT NULL,
  `nome` VARCHAR(145) NOT NULL,
  `email` VARCHAR(145) NOT NULL,
  `senha` VARCHAR(145) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `id_lixeira_idx` (`id_lixeira` ASC),
  CONSTRAINT `fk_usuario_lixeira`
    FOREIGN KEY (`id_lixeira`)
    REFERENCES `lixeirasena`.`lixeira` (`id_lixeira`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lixeirasena`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lixeirasena`.`admin` (
  `id_admin` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(145) NOT NULL,
  `senha` VARCHAR(145) NOT NULL,
  `admincol` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`id_admin`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lixeirasena`.`registro_historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lixeirasena`.`registro_historico` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `id_admin` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `data_cadastro` DATETIME NULL,
  INDEX `id_admin_idx` (`id_admin` ASC),
  INDEX `id_usuario_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_historico_admin`
    FOREIGN KEY (`id_admin`)
    REFERENCES `lixeirasena`.`admin` (`id_admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `lixeirasena`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lixeirasena`.`estatistico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS lixeirasena.estatistico (
  id_estatistico INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL,
  nome VARCHAR(145) NOT NULL,
  senha VARCHAR(145) NOT NULL,
  PRIMARY KEY (id_estatistico))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `lixeirasena`.`operador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS lixeirasena.operador (
  id_operador INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL,
  nome VARCHAR(145) NOT NULL,
  senha VARCHAR(145) NOT NULL,
  PRIMARY KEY (id_operador))
ENGINE = InnoDB;

ALTER TABLE sensor ADD COLUMN caminho_imagem VARCHAR(255);
ALTER TABLE atuador ADD COLUMN caminho_imagem VARCHAR(255);

INSERT INTO admin (nome, email, senha, admincol)
VALUES ('admin', 'admin@admin.com', 'adminpassword', 'geral');
INSERT INTO `lixeirasena`.`estatistico` (`id_estatistico`, `nome`, `email`, `senha`) VALUES ('1', 'b', 'b', 'b');
VALUES ('admin', 'admin@admin.com', 'adminpassword', 'geral');

UPDATE sensor SET caminho_imagem = '../static/img/sensor.png' WHERE id_sensor = 1;
UPDATE sensor SET caminho_imagem = '../static/img/hand-sensor.png' WHERE id_sensor = 2;
UPDATE atuador SET caminho_imagem = '../static/img/servo.png' WHERE id_atuador = 1;
UPDATE atuador SET caminho_imagem = '../static/img/led.png' WHERE id_atuador IN (2, 3, 4);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;