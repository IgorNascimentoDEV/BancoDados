-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`vagas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vagas` (
  `idvagas` INT NOT NULL,
  `nome_vaga` VARCHAR(45) NOT NULL,
  `habilidades_necessarias` VARCHAR(45) NOT NULL,
  `temp_alocacao` DATE NOT NULL,
  `idioma` VARCHAR(45) NOT NULL,
  `localidade` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idvagas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Candidato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Candidato` (
  `cpf` VARCHAR(15) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descricaoTecnica` VARCHAR(90) NULL,
  `email` VARCHAR(45) NOT NULL,
  `pretencao_Salario` DOUBLE(7,2) NOT NULL,
  `nota_ingles` INT NOT NULL,
  `nota_logica` INT NOT NULL,
  `nota_sql` INT NOT NULL,
  `nivel` VARCHAR(20) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `vagas_idvagas` INT NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `fk_Candidato_vagas1_idx` (`vagas_idvagas` ASC) VISIBLE,
  CONSTRAINT `fk_Candidato_vagas1`
    FOREIGN KEY (`vagas_idvagas`)
    REFERENCES `mydb`.`vagas` (`idvagas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrevista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrevista` (
  `data_entrevista` DATETIME NOT NULL,
  `Candidato_cpf` VARCHAR(15) NOT NULL,
  `habilidades_tecnicas` TEXT(200) NOT NULL,
  `habilidades_interpessoal` TEXT(200) NOT NULL,
  PRIMARY KEY (`data_entrevista`),
  INDEX `fk_Entrevista_Candidato1_idx` (`Candidato_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_Entrevista_Candidato1`
    FOREIGN KEY (`Candidato_cpf`)
    REFERENCES `mydb`.`Candidato` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `idEndereco` INT NOT NULL,
  `Candidato_cpf` VARCHAR(15) NOT NULL,
  `Uf` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `numero` INT NOT NULL,
  PRIMARY KEY (`idEndereco`),
  INDEX `fk_Endereco_Candidato_idx` (`Candidato_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Candidato`
    FOREIGN KEY (`Candidato_cpf`)
    REFERENCES `mydb`.`Candidato` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefone` (
  `idtelefone` INT NOT NULL,
  `Candidato_cpf` VARCHAR(15) NULL,
  `numero` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`idtelefone`),
  INDEX `fk_telefone_Candidato1_idx` (`Candidato_cpf` ASC),
  CONSTRAINT `fk_telefone_Candidato1`
    FOREIGN KEY (`Candidato_cpf`)
    REFERENCES `mydb`.`Candidato` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
