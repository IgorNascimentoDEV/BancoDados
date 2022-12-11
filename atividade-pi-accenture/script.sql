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
-- Table `mydb`.`Candidato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Candidato` (
  `idCandidato` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(15) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `email` VARCHAR(90) NOT NULL,
  `pretencaoSalario` DOUBLE(7,2) ZEROFILL NOT NULL,
  `notaIdioma` INT NOT NULL,
  `notaLogica` INT NOT NULL,
  `notaSql` INT NOT NULL,
  `statusCandidato` VARCHAR(15) NOT NULL,
  `nivel` VARCHAR(4) NULL,
  `descricaoTecnica` TINYTEXT NULL,
  `habilidadesTecnicas` TINYTEXT NULL,
  `habilidadesInterp` TINYTEXT NULL,
  PRIMARY KEY (`idCandidato`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrevista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrevista` (
  `idEntrevista` INT NOT NULL AUTO_INCREMENT,
  `dataEntrevista` DATETIME NOT NULL,
  `Candidato_idCandidato` INT NULL,
  PRIMARY KEY (`idEntrevista`),
  CONSTRAINT `fk_Entrevista_Candidato1`
    FOREIGN KEY (`Candidato_idCandidato`)
    REFERENCES `mydb`.`Candidato` (`idCandidato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vaga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vaga` (
  `idVaga` INT NOT NULL AUTO_INCREMENT,
  `nomeVaga` VARCHAR(45) NOT NULL,
  `descricaoVaga` TINYTEXT NOT NULL,
  `habilidadeReq` TINYTEXT NOT NULL,
  `idioma` VARCHAR(45) NOT NULL,
  `tempoAlocacao` DATE NOT NULL,
  `localidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idVaga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `CEP` VARCHAR(9) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(60) NOT NULL,
  `rua` VARCHAR(60) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `Candidato_idCandidato` INT NOT NULL,
  PRIMARY KEY (`CEP`),
  CONSTRAINT `fk_Endereco_Candidato1`
    FOREIGN KEY (`Candidato_idCandidato`)
    REFERENCES `mydb`.`Candidato` (`idCandidato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Telefone` (
  `numero` INT NOT NULL,
  `Candidato_idCandidato` INT NOT NULL,
  PRIMARY KEY (`numero`),
  CONSTRAINT `fk_telefone_Candidato`
    FOREIGN KEY (`Candidato_idCandidato`)
    REFERENCES `mydb`.`Candidato` (`idCandidato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vaga_has_Candidato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vaga_has_Candidato` (
  `Vaga_idVaga` INT NOT NULL,
  `Candidato_idCandidato` INT NOT NULL,
  PRIMARY KEY (`Vaga_idVaga`, `Candidato_idCandidato`),
  CONSTRAINT `fk_Vaga_has_Candidato_Vaga1`
    FOREIGN KEY (`Vaga_idVaga`)
    REFERENCES `mydb`.`Vaga` (`idVaga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vaga_has_Candidato_Candidato1`
    FOREIGN KEY (`Candidato_idCandidato`)
    REFERENCES `mydb`.`Candidato` (`idCandidato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Alter Table
-- -----------------------------------------------------
ALTER TABLE `Candidato` AUTO_INCREMENT=10;
ALTER TABLE `Entrevista` AUTO_INCREMENT=1000;
ALTER TABLE `Vaga` AUTO_INCREMENT=100000;
ALTER TABLE `Candidato` RENAME COLUMN `status` TO `statusCandidato`;
ALTER TABLE `Vaga` RENAME COLUMN `idioma` TO `idiomaReq`;
ALTER TABLE `Telefone` MODIFY COLUMN `numero` VARCHAR(15);

-- -----------------------------------------------------
-- Inserts
-- -----------------------------------------------------

INSERT INTO `Candidato`(cpf, `nome`, `email`, `pretencaoSalario`, `notaIdioma`, `notaLogica`, `notaSql`, `statusCandidato`, `descricaoTecnica`)
VALUE('668.647.910-17', 'Iago', 'iago2000@gmail.com', 3000.00, 8, 7, 9, 'Entrevistar', 'DBA com 6 anos de experiencia'),
('012.038.050-12', 'Junior', 'junior69@gmail.com', 2000.00, 9, 8, 6, 'Entrevistar', 'Programador java Spring boot angular 1 ano de experiencia' ),
('976.769.610-50', 'Carlos', 'carlinhos1906@hotmail.com', 6000.00, 5, 6, 10, 'Entrevistar', 'Gestor de projetos com 5 anos de experiencia'),
('650.108.250-15', 'Richarlison', 'pombogrugru@hotmail', 5000.00, 7, 9, 8, 'Entrevistar', 'Progamador c# com conhecimentos em bd SqlServe'),
('396.687.550-06', 'Vinicius', 'vinijunior@gmail.com', 8000.00, 8, 6, 7, 'Entrevistar', 'Engenheiro de banco de dados diploma em ciencia da computação'),
('947.114.890-10', 'João', 'joao@Yahoo.com', 9000.00, 6, 8, 9, 'Entrevistar', 'Especialista em CLOUD AWS');

INSERT INTO `Candidato`(`cpf`, `nome`, `email`, `pretencaoSalario`, `notaIdioma`, `notaLogica`, `notaSql`, `statusCandidato`, `nivel`, `descricaoTecnica`, `habilidadesTecnicas`, `habilidadesInterp`)
VALUE('431.474.740-46', 'Camila', 'camila123@gmail.com', 2500.00, 6, 5, 8, 'Aprovados', 'CL06', 'Progamadora pleno front end', 'HTML5, CSS3, JavaScript', 'boa comunicação, simpatica'),
('000.178.810-80', 'Maria', 'mariazinha6969@gmail.com', 3000.00, 7, 9, 8, 'Aprovados', 'CL12', 'Scrum Master', 'conhecimentos em ferramentas de gerenciamento', 'Certificado em metodologia agil'),
('861.713.850-50', 'Antony', 'jogadordelol@gmail.com', 2500.00, 3, 2, 5, 'Inapto', 'CL13','Tecnico em informatica', 'tecnico em TI', 'Timido, comunicação não muito boa'),
('198.639.230-95', 'Igor', 'contatoigor@gmail.com', 6000.00, 8 , 9, 10, 'Contratados', 'CL06', 'Desenvolvedor fullStack', 'Java, spring, angular, MySql', 'Trabalho em equipe, comunicação clara e objetica'),
('679.993.370-30', 'Walter', 'contatowalter@gmail.com', 7000.00, 10, 8, 9, 'Contratados', 'CL08', 'Engenheiro de dados pleno', 'MySql, plSql, sqlServe, MongoBD', 'Inglês avançado, equilibrio emocional'),
('105.014.920-38', 'Everton', 'contatoeverton@gmail.com', 9000.00, 7, 10, 8, 'Contratados', 'CL13', 'Desenvolvedor Java Senior', 'spring, java, OracleBD', 'Lider de equipe, sabe alemão');

INSERT INTO Vaga (`nomeVaga`, `descricaoVaga`, `habilidadeReq`, `idiomaReq`, `tempoAlocacao`, `localidade`)
VALUES('Gestor de RH', 'Atrasa salário', 'MeioCérebro', 'Português(Opcional)', '2030-09-06','Recife - PE'),
('Administrador de Banco de Dados', 'Planejar e executar as manutenções em bancos de dados', 'SQL Server, PostgreSQL, SQL', 'Português, Inglês, Espanhol', '2023-05-05','Recife - PE'),
('Dev Java Junior', 'Desenvolver e implementar sistemas e aplicações em Java', 'Java', 'Português', '2023-01-05','Olinda - PE'),
('Dev C# Junior', 'Desenvolver e implementar sistemas e aplicações em C#', 'C# ', 'Português', '2023-01-05','Olinda - PE'),
('Dev Python Junior', 'Desenvolver e implementar sistemas e aplicações em Python', 'Python', 'Português', '2023-01-05','Olinda - PE'),
('Dev C++ Junior', 'Desenvolver e implementar sistemas e aplicações em C++', 'C++', 'Português, Inglês', '2023-01-05','Olinda - PE'),
('Dev C# Sênior', 'Desenvolver e implementar sistemas e aplicações em C#', 'C#', 'Português, Inglês', '2023-05-05','Recife - PE'),
('Dev Python Sênior', 'Desenvolver e implementar sistemas e aplicações em Python', 'Python', 'Inglês', '2023-05-05','Recife - PE'),
('Dev Banco de Dados', 'Desenvolver e implementar bases de dados', 'C#, SQL Server , SQL', 'Português, Inglês', '2023-05-05','Recife - PE'),
('Dev Banco de Dados', 'Desenvolver e implementar bases de dados', 'Python, PostgreSQL, SQL', 'Português, Inglês', '2023-05-05','Recife - PE'),
('Dev Fullstack Junior', 'DELETEME pls :(', 'Wordpress', 'error404', '2012-12-25','Pombos - PE');

INSERT INTO `Endereco`(CEP, uf, cidade, pais, bairro, rua, numero, complemento, Candidato_idCandidato)
VALUE('56512-120', 'PE', 'Arcoverde', 'Brasil', 'São Cristóvão', 'Rua Pedro Albuquerque Pedrosa', 109, 'casa', 11),
('55560-970', 'PE', 'Barreiros', 'Brasil', 'Centro', 'Rua Ayres Belo', 34, 'Casa', 10),
('53570-260', 'PE', 'Abreu e Lima', 'Brasil', 'Desterro', 'Rua Arruda', 69, 'Casa', 21),
('55940-970', 'PE', 'Condado', 'Brasil', 'Centro', 'Avenida Quinze de Novembro', 23, 'Casa', 20),
('56820-973', 'PE', 'Carnaíba', 'Brasil', 'Distrito de Ibitiranga', 'Praça Joaquim Galdino', 104, 'Casa', 18),
('55592-972', 'PE', 'Ipojuca', 'Brasil', 'Nossa Senhora do O', 'Rua do Colégio', 59, 'Casa', 15),
('53360-725', 'PE', 'Olinda', 'Brasil', 'Tabajara', 'Rua Porto Alegre', 69, 'Casa', 17),
('54800-970', 'PE', 'Moreno', 'Brasil', 'Centro', 'Rua Primeiro de Maio', 64, 'Casa', 19),
('52061-530', 'PE', 'Recife', 'Brasil', 'Casa Forte', 'Rua Investigador José de Carvalho', 19, 'Casa', 16),
('50731-273', 'PE', 'Recife', 'Brasil', 'Iputinga', '3ª Travessa Cordislândia', 16, 'Casa', 14),
('51170-600', 'PE', 'Recife', 'Brasil', 'Imbiribeira', 'Rua Leonor Soares Pessoa', 24, 'Casa', 12),
('53427-480', 'PE', 'Paulista', 'Brasil', 'Maria Farinha', 'Rua João Félix de Albuquerque', 29, 'Casa', 13);

INSERT INTO `telefone`(numero, Candidato_idCandidato)
VALUE('(81) 41237-2503', 13),
('(81) 31959-4114', 14),
('(81) 72911-9206', 18),
('(81) 72378-3072', 12),
('(81) 57072-2734', 17),
('(81) 37013-5938', 21),
('(81) 54325-7613', 11),
('(81) 34794-6613', 20),
('(81) 27147-7169', 16),
('(81) 41163-3889', 19),
('(81) 48291-3881', 15),
('(81) 49074-5143', 10);

INSERT INTO `Entrevista` (`dataEntrevista`, `Candidato_idCandidato`)
VALUE('2023-01-03 10:00:00', 10),
('2023-01-03 11:00:00', 11),
('2023-01-03 14:00:00', 12),
('2023-01-03 15:00:00', 13),
('2023-01-04 10:00:00', 14),
('2023-01-04 11:00:00', 15),
('2022-11-01 10:00:00', 16),
('2022-11-01 11:00:00', 17),
('2022-11-01 14:00:00', 18),
('2022-10-03 10:00:00', 19),
('2022-10-03 11:00:00', 20),
('2022-10-03 14:00:00', 21);


INSERT INTO `vaga_has_candidato`(Vaga_idVaga, Candidato_idCandidato)
VALUE(100000, 10),
(100001, 11),
(100002, 12),
(100003, 13),
(100004, 14),
(100005, 15),
(100006, 16),
(100007, 17),
(100008, 18),
(100009, 19),
(100010, 20);

-- -----------------------------------------------------
-- View 
-- -----------------------------------------------------
CREATE VIEW relatorio01 AS
	SELECT nome,statusCandidato FROM `candidato`
		WHERE statusCandidato = 'Entrevistar'
			ORDER BY nome;
            
CREATE VIEW relatorio02 AS
	SELECT nome,statusCandidato FROM `candidato`
		WHERE statusCandidato = 'Aprovados'
			ORDER BY nome;
 
CREATE VIEW relatorio03 AS
	SELECT nome,statusCandidato FROM `candidato`
		WHERE statusCandidato = 'Inapto'
			ORDER BY nome;
            
CREATE VIEW relatorio04 AS
	SELECT nome,statusCandidato FROM `candidato`
		WHERE statusCandidato = 'Contratados'
			ORDER BY nome;

CREATE VIEW relatorio05 AS
	SELECT nome,statusCandidato FROM `candidato`
		WHERE nivel = 'CL06'
			ORDER BY nome;

CREATE VIEW relatorio06 AS
	SELECT nome,statusCandidato FROM `candidato`
		WHERE nivel = 'CL13'
			ORDER BY nome;
            
CREATE VIEW relatorio07 AS
	SELECT nomeVaga,localidade FROM `vaga`
		WHERE tempoAlocacao = '2023-01-05'
			ORDER BY nomeVaga;
            
CREATE VIEW relatorio08 AS
	SELECT nomeVaga,localidade FROM `vaga`
		WHERE localidade = 'Recife - PE'
			ORDER BY nomeVaga;
            
CREATE VIEW relatorio09 AS
	SELECT nomeVaga,localidade FROM `vaga`
		WHERE localidade = 'Olinda - PE'
			ORDER BY nomeVaga;
            
CREATE VIEW relatorio10 AS
	SELECT Candidato_idCandidato,cidade,bairro FROM `endereco`
		WHERE cidade = 'Recife'
			ORDER BY Candidato_idCandidato;


-- -----------------------------------------------------
-- Selects(DQL)
-- -----------------------------------------------------

/*1º Relatório: Lista de candidatos que ainda não foram entrevistados trazendo seu nome, número de telefone;*/

/*2º Relatório: Lista de candidatos Inaptos trazendo o seu nome e endereço;*/

/*3º Relatório: Lista de candidatos contratados trazendo o nome sua pretensão salarial e o id da vaga;*/

/*4º Relatório: Lista de candidatos aprovados trazendo nome, sua pretensão salarial e sua cidade;*/

/*5º Relatório: Lista de candidatos que tiraram uma nota maior ou igual a 8 em Inglês trazendo seu nome, id da vaga e seu número de telefone;*/

/*6º Relatório: Lista de candidatos que tiraram uma nota maior ou igual a 9 em SQL trazendo seu nome pretensão salarial e cidade;*/

/*7º Relatório: Lista de candidatos que tiraram uma nota maior ou igual a 7 em lógica de programação trazendo seu nome, seu cep e seu número;*/

/*8º Relatório: Lista de candidatos com o nível CL13  trazendo sua descrição técnica, email e seu número;*/

/*9º Relatório: Lista de candidatos que moram em Recife trazendo seu nome, sua cidade e sua rua;*/

/*10º Relatório: Lista de candidatos que moram em Olinda trazendo seu nome, seu número e seu bairro;*/

/*11º Relatório: Lista de candidatos que têm o nível CL06 e que moram em Recife trazendo o id do candidato e seu bairro;*/

/*12º Relatório: Lista de Candidatos que tem sua pretenção salarial entre 2.000 e 5.000 trazendo seu nome, seu nível e sua cidade;*/

/*13º Relatório: Lista de Vagas com o tempo de alocação para o mês 5 de 2023 trazendo o nome da vaga o seu tempo de alocação e o id do candidato;*/

/*14º Relatório: Lista de Vagas que tem Inglês como idioma requerido trazendo o nome da vaga, o id do candidato e seu número;*/

/*15º Relatório: Lista de Vagas que tem tenha como descrição “Desenvolver e implementar bases de dados” trazendo seu nome e o id do candidato;*/

/*16º Relatório: Lista de Vagas com a localidade de Recife trazendo seu nome o tempo de alocação e seu candidato;*/

/*17º Relatório: Lista de Vagas com a localidade de Olinda trazendo seu nome o tempo de alocação e seu candidato;*/

/*18º Relatório: Lista de entrevista que foram ou irão ser realizadas de 11 horas trazendo o seu dia e o id do candidato;*/

/*19º Relatório: Lista de entrevista que iram ocorrer em 2022 trazendo sua data e hora e o id do seu candidato;*/

/*20º Relatório: Lista de entrevista que iram ocorrer em 2023 trazendo sua data e hora e o id do seu candidato;*/

-- -----------------------------------------------------
-- Procedures e funções
-- -----------------------------------------------------

DELIMITER $$
CREATE PROCEDURE buscarCandidatoPorID (id int)
BEGIN
SELECT CONCAT('O candidato é ', nome) AS nome
FROM `candidato`
WHERE idCandidato = id;
END$$
DELIMITER ;

CALL buscarCandidatoPorID(18);
/*DROP PROCEDURE buscarCandidatoPorID;*/


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

	
/*DROP DATABASE `mydb`;*/
