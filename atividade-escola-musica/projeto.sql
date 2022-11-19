CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Orquestra` (
  `idOrquestra` INT NOT NULL AUTO_INCREMENT,
  `cidade` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `dataIni` DATE NOT NULL,
  PRIMARY KEY (`idOrquestra`),
  UNIQUE INDEX `nomeOrquestra_UNIQUE` (`idOrquestra` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Instrumento` (
  `idInstrumentos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idInstrumentos`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Musico` (
  `idMusicos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `nacionalidade` VARCHAR(45) NOT NULL,
  `nascimento` DATE NOT NULL,
  `Orquestra_idOrquestra` INT NOT NULL,
  `Instrumento_idInstrumentos` INT NOT NULL,
  PRIMARY KEY (`idMusicos`, `Orquestra_idOrquestra`),
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

CREATE TABLE IF NOT EXISTS `mydb`.`Sinfonia` (
  `idSinfonia` INT NOT NULL AUTO_INCREMENT,
  `compositor` VARCHAR(45) NOT NULL,
  `dataCriacao` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSinfonia`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Apresentacao` (
  `Orquestra_idOrquestra` INT NOT NULL,
  `Sinfonia_idSinfonia` INT NOT NULL,
  `dataApresent` DATE NOT NULL,
  PRIMARY KEY (`Orquestra_idOrquestra`, `Sinfonia_idSinfonia`),
  INDEX `fk_Orquestra_has_Sinfonia_Sinfonia1_idx` (`Sinfonia_idSinfonia` ASC) VISIBLE,
  INDEX `fk_Orquestra_has_Sinfonia_Orquestra1_idx` (`Orquestra_idOrquestra` ASC) VISIBLE,
  CONSTRAINT `fk_Orquestra_has_Sinfonia_Orquestra1`
    FOREIGN KEY (`Orquestra_idOrquestra`)
    REFERENCES `mydb`.`Orquestra` (`idOrquestra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orquestra_has_Sinfonia_Sinfonia1`
    FOREIGN KEY (`Sinfonia_idSinfonia`)
    REFERENCES `mydb`.`Sinfonia` (`idSinfonia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Alter Tables
-- -----------------------------------------------------

ALTER TABLE `Orquestra`
	ADD `status` BOOL NOT NULL;
    
ALTER TABLE `Orquestra` 
    ADD `CEP` VARCHAR(9) NOT NULL;
    
ALTER TABLE `Musico`
	ADD `telefone` VARCHAR (15);
    
ALTER TABLE `Instrumento`
	ADD `dataAquisicao` DATE NOT NULL;
    
ALTER TABLE `Sinfonia`
	MODIFY COLUMN `dataCriacao` INT NOT NULL;
    
    
-- -----------------------------------------------------
-- Inserts
-- -----------------------------------------------------


INSERT INTO Orquestra (idOrquestra, cidade, pais, nome, dataIni, status, CEP)  
	VALUES ("01", "Recife", "Brasil", "Orquestra Sinfônica de Rio Preto", "2022-08-08", "1", "69926-970"),
		   ("02", "São Paulo", "Brasil", "Filarmônica de Berlim", "2022-02-26", "0", "57270-972"),
		   ("03", "New York", "EUA", "Sinfônica de Chicago", "2022-12-24", "0", "57435-970"),
		   ("04", "Berlim", "Alemanha", "Sinfônica da Rádio Bavária", "2022-03-23", "1", "57570-970" ),
		   ("05", "Sydney", "Australia", "Filarmônica de Viena", "2022-09-25", "0", "57500-970"),
           ("06", "Jaboatão", "Brasil", "Orquestra Brasileira de Guitarras", "2022-10-26", "0", "57130-970"),
           ("07", "Caruaru", "Brasil", "Filarmônica 25 de Março", "2022-05-02", "0", "56509-814"),
           ("08", "Salvador", "EUA", "Orquestra Juvenis e Infantis da Bahia", "2022-01-03", "0", "55045-065"),
           ("09", "Igarassu", "Brasil", "Orquestra Tabajara", "2022-12-03", "1", "53610-282"),
           ("10", "Palmares", "EUA", "Sociedade Filarmônica 13 de Junho", "2022-06-12", "0", "55540-973");
         
INSERT INTO Instrumento (idInstrumentos, nome, tipo, dataAquisicao)
	VALUES ("01", "violão", "Corda", "2020-02-01"),
		   ("02", "acordeão", "Sopro", "2021-03-06"),
           ("03", "guitarra", "Corda", "2022-12-06"),
           ("04", "teclado", "eletrônicos", "2020-09-01"),
           ("05", "sino", " percussão", "2019-06-01"),
           ("06", "Chocalhos", "Idiofones", "2018-05-13"),
           ("07", "Bateria", "percussão", "2022-08-10"),
           ("08", " piano", "Corda", "2022-10-08"),
           ("09", "violino", "Corda ", "2020-11-06"),
           ("10", "trompeta", "sopro", "2021-09-13");
			
INSERT INTO Musico (idMusicos, nome, nacionalidade, nascimento, Orquestra_idOrquestra, Instrumento_idInstrumentos,telefone)
	VALUES ("01", "Hugo Diniz","brasileiro", '1993-01-08', "02", "01","(79) 96723-3575"),
		("02", "Juliana Ramalho","Americano", '1993-12-20', "01", "03","(92) 99914-5233"),
		("03", "Diego Coutinho","brasileiro", '1985-11-22', "05", "04","(83) 97411-8666"),
		("04", "Ben Hur Queiroz","Chines", '1976-01-07', "03", "01","(64) 98071-2076"),
        ("05", "Fellipe Diniz","Mexicano", '1989-06-08', "01", "03","(93) 98940-7213"),
        ("06", "Mácio Júnior","Australiano", '1989-06-08', "07", "06","(73) 99783-0291"),
        ("07", "Joao Victor","Indiano", '1989-06-08', "08", "01","(54) 99745-1854"),
        ("08", "Maria dolores","brasileiro", '1989-06-08', "06", "07","(15) 98662-8920"),
        ("09", "Joao Victor","Portugues", '1989-06-08', "01", "03","(96) 98383-4636"),
        ("10", "Thiago Rodrigues","Canadense ", '1989-06-08', "09", "10","(61) 98663-8723");

INSERT INTO tipo(idTipo, tipo, Musico_idMusicos)
	VALUES ("01", "Violinista", "07"),
		   ("02","Violista", "01"),
           ("03","Percussionista", "08"),
           ("04","guitarrista", "02"),
           ("05", "tecladista", "03"),
           ("06", "trompetista", "10"),
           ("07", "acordeonista", "04"),
           ("08", "Tenor", "06"),
           ("09", "pianista", "09"),
           ("10", "percussãonista", "05");
           
INSERT INTO Sinfonia (idSinfonia, compositor, dataCriacao, nome)
	VALUES ("01", "Beethoven", "1824", "Symphony No. 9"),
		("02", "Tchaikovsky", "1878", "Symphony No. 4"),
        ("03", "Mozart", "1788", "Symphony No. 41"),
        ("04", "Beethoven", "1806", "Symphony No. 4"),
        ("05", "Rachmaninov", "1802", "Symphony No. 2"),
        ("06", "Tchaikovsky", "1840", "Symphony No. 6 "),
        ("07", "Brahms", "1885", "Symphony No. 4"),
        ("08", "Mahler ", "1894", "Symphony No. 2"),
        ("09", "Dvořák ", "1893", "Symphony No. 9"),
        ("10", "Berlioz", "1830", "Symphony fantastique");
    
INSERT INTO Apresentacao (Orquestra_idOrquestra, Sinfonia_idSinfonia, dataApresent)
	VALUES ("01", "03", "2022-12-24"),
		("06", "04", "2021-02-28"),
        ("10", "02", "2028-11-14"),
        ("06", "08", "2020-06-30"),
        ("07", "09", "2017-09-16"),
        ("09", "01", "2018-01-24"),
        ("03", "02", "2020-07-05"),
        ("04", "10", "2023-11-02"),
        ("06", "02", "2018-02-24"),
		("05", "06", "2022-02-04");
	
-- -----------------------------------------------------
-- Selects
-- -----------------------------------------------------

SELECT * from Orquestra;
SELECT * from Instrumento;
SELECT * from Musico;
SELECT * from Tipo;
SELECT * from Sinfonia;
SELECT * from Apresentacao;


/*01-Relatório: Lista de músicos com a data de nascimento anterior a “1989-06-09” 
trazendo o nome do músico e sua data de nascimento.*/
select m.nome, m.nascimento
	from musico m
		where m.nascimento <= '1989-06-08'
			order by m.nome;

/*02-Relatório: Lista de instrumentos que tiveram sua data de aquisição entre 2019-06-01 e 2021-09-13,
 trazendo o nome e a data de aquisição.*/
select i.nome, i.dataAquisicao
	from instrumento i
		where i.dataAquisicao >= '2019-06-01' and i.dataAquisicao <= '2021-09-13'
			order by i.nome;
            
            
/*03-Relatório: Orquestras que vai acontecer no Brasil este a partir de "2022-09-25", trazendo o 
nome e a dataIni*/
select o.nome, o.dataIni
	from orquestra o
		where o.pais = 'Brasil' and o.dataIni >= '2022-09-25'
			order by o.nome;
            

/04-Relatório: De Orquestras com status 1  trazendo o nome e o país./
select  o.nome, o.pais
	from orquestra o
		where o.status = '1'
			order by o.nome;
            
            
/*05-Relatório: Relatório de músicos que tocam instrumentos de percussão trazendo o nome do musico e o
nome do instrumento(JOIN)*/
select m.nome, i.nome
	from musico m
		inner join instrumento i on m.Instrumento_idInstrumentos = i.idinstrumentos where i.tipo = 'percussão'
          order by m.nome;
          
/*06-Relatório: Lista de apresentações entre 2018-01-24 e 2020-07-05 trazendo o nome da orquestra 
e a data.(JOIN)*/
select o.nome, a.dataApresent
	from orquestra o
		inner join apresentacao a on a.Orquestra_idOrquestra = o.idOrquestra where a.dataApresent >='2018-01-24' and a.dataApresent <= '2020-07-05'
			order by o.nome;
            
/*07-Relatório: lista de instrumentos com a data de aquisição a partir de 2020-02-01 trazendo o 
nome e a data.*/
select i.nome, i.dataAquisicao
	from instrumento i
		where i.dataAquisicao >= '2020-02-01'
			order by i.dataAquisicao desc;
            
/*08-Relatório: Lista de músicos que tenha o tipo igual a violinista trazendo o nome do musico e o 
id do tipo (JOIN)*/
select m.nome, t.idTipo   
	from musico m
		inner join tipo t on t.Musico_idMusicos = m.idMusicos
			where t.tipo = 'violinista';
            

/9-Relatório: Lista da sinfonia por Beethoven trazendo o nome e a data de criação./
select 	s.nome, s.dataCriacao
	from sinfonia s 
		where s.compositor = 'Beethoven';
        
        
/10-Relatório:Lista de sinfonia composta entre 1830 e 1885 trazendo o nome e a data de criação./
select s.nome, s.dataCriacao
	from sinfonia s
		where s.dataCriacao >= '1830' and s.dataCriacao <= '1885';

/11-Relatório: Lista de sinfonias de nome "Symphony No. 4" trazendo compositor e data da Criação/
select s.nome, s.compositor, s.dataCriacao
	from sinfonia s
		where s.nome = "Symphony No. 4";
        
/12-Relatório: Lista de músicos de nacionalidade brasileira trazendo nome, nascimento e telefone/
select m.nome, m.nacionalidade, m.nascimento, m.telefone
	from Musico m
			where m.nacionalidade = "brasileiro";
            
/13-Relatório: Lista de Orquestra com o status  “0” trazendo o nome, a cidade e a data;/
select o.nome, o.cidade, o.dataIni, o.status
	from orquestra o
		where o.status = '0';
        
/14-Relatório: Lista de instrumentos de tipo corda trazendo o nome e a data de aquisição./
select i.nome, i.dataAquisicao, i.tipo
	from instrumento i
		where i.tipo = 'corda';
            
/15-Relatório: Lista de músicos que tocam Guitarra, trazendo o nome do músico e o Id do instrumento./
select m.nome, m.Instrumento_idInstrumentos, i.nome
	from musico m
		inner join instrumento i on m.Instrumento_idInstrumentos = i.idInstrumentos
			where i.nome = 'guitarra';

/16 Relatório: Lista de apresentações que tenha o nome da sinfonia igual a “Symphony No. 9” trazendo o autor e a data./
select a.dataApresent, s.nome, s.compositor
	from Apresentacao a
		inner join sinfonia s on a.Sinfonia_idSinfonia = s.idSinfonia
		where s.nome = "Symphony No. 9";

/17 Relatório: Lista das orquestra feita nos “EUA” trazendo  o nome, país , CEP e o status./
select  o.nome, o.pais, o.CEP, o.status
	from orquestra o
		where o.pais = 'EUA';

/18 Relatório: Lista de músicos que tocam violão trazendo nome e nacionalidade./
select m.nome, m.nacionalidade
	from musico m
		inner join instrumento i on m.Instrumento_idInstrumentos = i.idInstrumentos
			where i.nome = 'violão';
            
/19 Relatório: Lista de músicos que participam da orquestra de Recife trazendo o nome e o telefone./
select m.nome, m.telefone, o.cidade
	from musico m
		inner join orquestra o on m.Orquestra_idOrquestra = o.idOrquestra
			where o.cidade = 'Recife';

/20 Relatório; Lista das apresentações das sinfonias do compositor "Tchaikovsky” trazendo a data de apresentação./
    select a.dataApresent, s.nome, s.compositor
	from Apresentacao a
		inner join sinfonia s on a.Sinfonia_idSinfonia = s.idSinfonia
		where s.compositor = "Tchaikovsky";

-- -----------------------------------------------------
-- View 
-- -----------------------------------------------------

CREATE VIEW relatorio1
AS select m.nome, m.nascimento
	from musico m
		where m.nascimento <= '1989-06-08'
			order by m.nome;

CREATE VIEW relatorio2
AS select i.nome, i.dataAquisicao
	from instrumento i
		where i.dataAquisicao >= '2019-06-01' and i.dataAquisicao <= '2021-09-13'
			order by i.nome;
            
            
CREATE VIEW relatorio3
AS select o.nome, o.dataIni
	from orquestra o
		where o.pais = 'Brasil' and o.dataIni >= '2022-09-25'
			order by o.nome;
            

CREATE VIEW relatorio4
AS select  o.nome, o.pais
	from orquestra o
		where o.status = '1'
			order by o.nome;
            
            
CREATE VIEW relatorio5
AS select m.nome "nomeMúsico", i.nome "nomeInstrumento"
	from musico m
		inner join instrumento i on m.Instrumento_idInstrumentos = i.idinstrumentos
			where i.tipo = 'percussão';
          
CREATE VIEW relatorio6
AS select o.nome, a.dataApresent
	from orquestra o
		inner join apresentacao a on a.Orquestra_idOrquestra = o.idOrquestra where a.dataApresent >='2018-01-24' and a.dataApresent <= '2020-07-05'
			order by o.nome;
            
CREATE VIEW relatorio7
AS select i.nome, i.dataAquisicao
	from instrumento i
		where i.dataAquisicao >= '2020-02-01'
			order by i.dataAquisicao desc;
            
CREATE VIEW relatorio8
AS select m.nome, t.idTipo   
	from musico m
		inner join tipo t on t.Musico_idMusicos = m.idMusicos
			where t.tipo = 'violinista';
            

CREATE VIEW relatorio9
AS select s.nome, s.dataCriacao
	from sinfonia s 
		where s.compositor = 'Beethoven';
        
        
CREATE VIEW relatorio10
AS select s.nome, s.dataCriacao
	from sinfonia s
		where s.dataCriacao >= '1830' and s.dataCriacao <= '1885';

-- -----------------------------------------------------
-- Update 
-- -----------------------------------------------------

UPDATE `mydb`.`Orquestra` SET `status` = '1' WHERE (`idOrquestra` = '2');
UPDATE `mydb`.`Orquestra` SET `status` = '0' WHERE (`idOrquestra` = '1');
UPDATE `mydb`.`Instrumento` SET `nome` = 'Violão', `tipo` = 'Corda' WHERE (`idInstrumentos` = '2');
UPDATE `mydb`.`Instrumento` SET `nome` = 'Gaita', `tipo` = 'Sopro' WHERE (`idInstrumentos` = '1');
UPDATE `mydb`.`Musico` SET `nacionalidade` = 'Mexicano' WHERE (`idMusicos` = '1') and (`Orquestra_idOrquestra` = '2');
UPDATE `mydb`.`Musico` SET `nacionalidade` = 'Alemão' WHERE (`idMusicos` = '2') and (`Orquestra_idOrquestra` = '1');
UPDATE `mydb`.`Sinfonia` SET `compositor` = 'Wolfgang' WHERE (`idSinfonia` = '3');
UPDATE `mydb`.`Sinfonia` SET `compositor` = 'Ludwig' WHERE (`idSinfonia` = '1');
UPDATE `mydb`.`Apresentacao` SET `dataApresent` = '2022-12-25' WHERE (`Orquestra_idOrquestra` = '1') and (`Sinfonia_idSinfonia` = '3');
UPDATE `mydb`.`Apresentacao` SET `dataApresent` = '2022-10-31' WHERE (`Orquestra_idOrquestra` = '2') and (`Sinfonia_idSinfonia` = '4');

-- -----------------------------------------------------
-- Delete
-- -----------------------------------------------------

DELETE FROM `mydb`.`Apresentacao` WHERE (`Orquestra_idOrquestra` = '1') and (`Sinfonia_idSinfonia` = '3');
DELETE FROM `mydb`.`Apresentacao` WHERE (`Orquestra_idOrquestra` = '3') and (`Sinfonia_idSinfonia` = '2');
DELETE FROM `mydb`.`Apresentacao` WHERE (`Orquestra_idOrquestra` = '4') and (`Sinfonia_idSinfonia` = '10');
DELETE FROM `mydb`.`Apresentacao` WHERE (`Orquestra_idOrquestra` = '5') and (`Sinfonia_idSinfonia` = '6');
DELETE FROM `mydb`.`Apresentacao` WHERE (`Orquestra_idOrquestra` = '6') and (`Sinfonia_idSinfonia` = '2');
DELETE FROM `mydb`.`Apresentacao` WHERE (`Orquestra_idOrquestra` = '6') and (`Sinfonia_idSinfonia` = '4');
DELETE FROM `mydb`.`Apresentacao` WHERE (`Orquestra_idOrquestra` = '6') and (`Sinfonia_idSinfonia` = '8');
DELETE FROM `mydb`.`Apresentacao` WHERE (`Orquestra_idOrquestra` = '7') and (`Sinfonia_idSinfonia` = '9');
DELETE FROM `mydb`.`Apresentacao` WHERE (`Orquestra_idOrquestra` = '9') and (`Sinfonia_idSinfonia` = '1');
DELETE FROM `mydb`.`Apresentacao` WHERE (`Orquestra_idOrquestra` = '10') and (`Sinfonia_idSinfonia` = '2');

DROP DATABASE mydb;