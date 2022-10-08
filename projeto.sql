									/* criação(DDL) */
                                    
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

-- -----------------------------------------------------
-- Table `mydb`.`Orquestra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orquestra` (
  `idOrquestra` INT NOT NULL AUTO_INCREMENT,
  `cidade` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `dataIni` DATE NOT NULL,
  PRIMARY KEY (`idOrquestra`),
  UNIQUE INDEX `nomeOrquestra_UNIQUE` (`idOrquestra` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Instrumento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Instrumento` (
  `idInstrumentos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idInstrumentos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Musico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Musico` (
  `idMusicos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `nacionalidade` VARCHAR(45) NOT NULL,
  `nascimento` DATE NOT NULL,
  `Orquestra_idOrquestra` INT NOT NULL,
  `Instrumento_idInstrumentos` INT NOT NULL,
  PRIMARY KEY (`idMusicos`, `Orquestra_idOrquestra`),
  UNIQUE INDEX `nacionalidade_UNIQUE` (`nacionalidade` ASC) VISIBLE,
  INDEX `fk_Musico_Orquestra1_idx` (`Orquestra_idOrquestra` ASC) VISIBLE,
  INDEX `fk_Musico_Instrumento1_idx` (`Instrumento_idInstrumentos` ASC) VISIBLE,
  CONSTRAINT `fk_Musico_Orquestra1`
    FOREIGN KEY (`Orquestra_idOrquestra`)
    REFERENCES `mydb`.`Orquestra` (`idOrquestra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Musico_Instrumento1`
    FOREIGN KEY (`Instrumento_idInstrumentos`)
    REFERENCES `mydb`.`Instrumento` (`idInstrumentos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipo` (
  `idTipo` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `Musico_idMusicos` INT NOT NULL,
  PRIMARY KEY (`idTipo`),
  INDEX `fk_Tipo_Musico1_idx` (`Musico_idMusicos` ASC) VISIBLE,
  CONSTRAINT `fk_Tipo_Musico1`
    FOREIGN KEY (`Musico_idMusicos`)
    REFERENCES `mydb`.`Musico` (`idMusicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sinfonia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sinfonia` (
  `idSinfonia` INT NOT NULL AUTO_INCREMENT,
  `compositor` VARCHAR(45) NOT NULL,
  `dataCriacao` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSinfonia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Apresenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Apresenta` (
  `Sinfonias_idSinfonia` INT NOT NULL,
  `DataDeApresentacaoOrquestraSinfonia` DATE NOT NULL,
  `Orquestra_idOrquestra` INT NOT NULL,
  PRIMARY KEY (`Sinfonias_idSinfonia`),
  INDEX `fk_Orquestra_has_Sinfonias_Sinfonias1_idx` (`Sinfonias_idSinfonia` ASC) VISIBLE,
  INDEX `fk_Apresenta_Orquestra1_idx` (`Orquestra_idOrquestra` ASC) VISIBLE,
  CONSTRAINT `fk_Orquestra_has_Sinfonias_Sinfonias1`
    FOREIGN KEY (`Sinfonias_idSinfonia`)
    REFERENCES `mydb`.`Sinfonia` (`idSinfonia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Apresenta_Orquestra1`
    FOREIGN KEY (`Orquestra_idOrquestra`)
    REFERENCES `mydb`.`Orquestra` (`idOrquestra`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


								/*	destruir (DDL)	*/
                                
/* drop schema mydb; */ 


								/*	alterar (DDL)	*/
      
      /*
alter table musico modify column nacionalidade varchar(15);

alter table apresentar add hora time not null;
*/



							/*	inserts (DML)	*/
     
use mydb;

insert into orquestra (idOrquestra, cidade, pais, nome, dataIni)  
	values ("1", "Recife", "Brasil", "Passinho", "2022-08-08"),
		   ("2", "São Paulo", "Brasil", "Filarmônica de Berlim", "2022-02-26"),
		   ("3", "New York", "EUA", "Sinfônica de Chicago", "2022-12-24"),
		   ("4", "Berlim", "Alemanha", "Sinfônica da Rádio Bavária", "2022-03-23"),
		   ("4", "Sydney", "Australia", "Filarmônica de Viena", "2022-09-25");
           
insert into instrumento (idInstrumentos, nome, tipo)
	values ("1", "violão", "Corda"),
		   ("2", "acordeão", "Sopro"),
           ("3", "guitarra", "corda"),
           ("4", "teclado", "eletrônicos"),
           ("5", "sino", " percussão");

insert into musico (idMusicos, nome, nacionalidade, nascimento, Orquestra_idOrquestra, Instrumento_idInstrumentos)
	values ("1", "Hugo Diniz","brasilerio", '1993-01-08', "2", "1"),
		("2", "Juliana Ramalho","Americano", '1993-12-20', "1", "3"),
		("3", "Diego Coutinho","Frances", '1985-11-22', "5", "5"),
		("4", "Ben Hur Queiroz","Chines", '1976-01-07', "3", "2"),
        ("5", "Fellipe Diniz","Mexicano", '1989-06-08', "4", "4");

insert into apresenta (Sinfonias_idSinfonia, DataDeApresentacaoOrquestraSinfonia, Orquestra_idOrquestra)
	value ()
