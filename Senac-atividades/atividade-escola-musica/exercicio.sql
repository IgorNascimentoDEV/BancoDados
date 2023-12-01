-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema postoInflamavel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema postoInflamavel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `postoInflamavel` DEFAULT CHARACTER SET utf8 ;
USE `postoInflamavel` ;

-- -----------------------------------------------------
-- Table `postoInflamavel`.`Empregado`
-- -----------------------------------------------------

/*DDL*/
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Empregado` (
  `CPF` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `nomeSocial` VARCHAR(60) NULL,
  `sexo` CHAR(1) NOT NULL,
  `salario` DECIMAL(6,2) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `email` VARCHAR(45) NULL,
  `dataAdm` DATETIME NOT NULL,
  `dataDem` DATETIME NULL,
  `statusEmp` TINYINT NOT NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Endereco` (
  `Empregado_CPF` VARCHAR(14) NOT NULL,
  `UF` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(60) NOT NULL,
  `numero` INT NOT NULL,
  `comp` VARCHAR(45) NULL,
  `cep` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`Empregado_CPF`),
  CONSTRAINT `fk_Endereco_Empregado1`
    FOREIGN KEY (`Empregado_CPF`)
    REFERENCES `postoInflamavel`.`Empregado` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Ferias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Ferias` (
  `idFerias` INT NOT NULL AUTO_INCREMENT,
  `anoRef` YEAR(4) NOT NULL,
  `dataIni` DATE NOT NULL,
  `dataFim` DATE NOT NULL,
  `qtdDias` INT NOT NULL,
  `Empregado_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idFerias`, `Empregado_CPF`),
  CONSTRAINT `fk_Ferias_Empregado1`
    FOREIGN KEY (`Empregado_CPF`)
    REFERENCES `postoInflamavel`.`Empregado` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Dependente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Dependente` (
  `cpf` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `parentesco` VARCHAR(15) NOT NULL,
  `Empregado_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`cpf`, `Empregado_CPF`),
  INDEX `fk_Dependente_Empregado1_idx` (`Empregado_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Dependente_Empregado1`
    FOREIGN KEY (`Empregado_CPF`)
    REFERENCES `postoInflamavel`.`Empregado` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Gerente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Gerente` (
  `Empregado_CPF` VARCHAR(14) NOT NULL,
  `funcaoGrat` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`Empregado_CPF`),
  CONSTRAINT `fk_Gerente_Empregado1`
    FOREIGN KEY (`Empregado_CPF`)
    REFERENCES `postoInflamavel`.`Empregado` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Departamento` (
  `idDepartamento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `localDep` VARCHAR(45) NOT NULL,
  `horario` VARCHAR(45) NOT NULL,
  `Gerente_Empregado_CPF` VARCHAR(14) NULL,
  PRIMARY KEY (`idDepartamento`),
  INDEX `fk_Departamento_Gerente1_idx` (`Gerente_Empregado_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Departamento_Gerente1`
    FOREIGN KEY (`Gerente_Empregado_CPF`)
    REFERENCES `postoInflamavel`.`Gerente` (`Empregado_CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Vendas` (
  `idVendas` INT NOT NULL AUTO_INCREMENT,
  `dataVenda` DATETIME NOT NULL,
  `valorTotal` DECIMAL(7,2) NOT NULL,
  `desconto` DECIMAL(4,2) ZEROFILL NULL,
  `Empregado_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idVendas`),
  INDEX `fk_Vendas_Empregado1_idx` (`Empregado_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Vendas_Empregado1`
    FOREIGN KEY (`Empregado_CPF`)
    REFERENCES `postoInflamavel`.`Empregado` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`FormaPag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`FormaPag` (
  `idFormaPag` INT NOT NULL AUTO_INCREMENT,
  `tipoPag` VARCHAR(45) NOT NULL,
  `valorPag` DECIMAL(7,2) NOT NULL,
  `qtdParcelas` INT NULL,
  `Vendas_idVendas` INT NOT NULL,
  INDEX `fk_FormaPag_Vendas1_idx` (`Vendas_idVendas` ASC) VISIBLE,
  PRIMARY KEY (`idFormaPag`),
  CONSTRAINT `fk_FormaPag_Vendas1`
    FOREIGN KEY (`Vendas_idVendas`)
    REFERENCES `postoInflamavel`.`Vendas` (`idVendas`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Estoque` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `codigoBarra` VARCHAR(80) NOT NULL,
  `valor` DECIMAL(7,2) ZEROFILL NOT NULL,
  `quantidade` DECIMAL(7,2) UNSIGNED NOT NULL,
  `validade` DATE NULL,
  `descricao` VARCHAR(150) NULL,
  `lote` VARCHAR(45) NULL,
  `marca` VARCHAR(45) NULL,
  PRIMARY KEY (`idProduto`),
  UNIQUE INDEX `codigoBarra_UNIQUE` (`codigoBarra` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`ItensVenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`ItensVenda` (
  `Estoque_idProduto` INT NOT NULL,
  `Vendas_idVendas` INT NOT NULL,
  `qtdProduto` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`Estoque_idProduto`, `Vendas_idVendas`),
  INDEX `fk_Produto_has_Vendas_Vendas1_idx` (`Vendas_idVendas` ASC) VISIBLE,
  INDEX `fk_Produto_has_Vendas_Produto1_idx` (`Estoque_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Vendas_Produto1`
    FOREIGN KEY (`Estoque_idProduto`)
    REFERENCES `postoInflamavel`.`Estoque` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Vendas_Vendas1`
    FOREIGN KEY (`Vendas_idVendas`)
    REFERENCES `postoInflamavel`.`Vendas` (`idVendas`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Fornecedor` (
  `cnpj/cpf` VARCHAR(18) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `valorFrete` DECIMAL(6,2) NULL,
  `email` VARCHAR(45) NULL,
  `statusFron` TINYINT NOT NULL,
  PRIMARY KEY (`cnpj/cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Compras` (
  `idCompras` INT NOT NULL AUTO_INCREMENT,
  `Fornecedor_cnpj/cpf` VARCHAR(18) NOT NULL,
  `Estoque_idProduto` INT NOT NULL,
  `dataComp` DATETIME NOT NULL,
  `qtdComp` DECIMAL(6,2) NOT NULL,
  `valorComp` DECIMAL(6,2) NOT NULL,
  `obs` VARCHAR(280) NULL,
  PRIMARY KEY (`idCompras`, `Fornecedor_cnpj/cpf`, `Estoque_idProduto`),
  INDEX `fk_Fornecedor_has_Estoque_Estoque1_idx` (`Estoque_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Estoque_Fornecedor1_idx` (`Fornecedor_cnpj/cpf` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Estoque_Fornecedor1`
    FOREIGN KEY (`Fornecedor_cnpj/cpf`)
    REFERENCES `postoInflamavel`.`Fornecedor` (`cnpj/cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Fornecedor_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idProduto`)
    REFERENCES `postoInflamavel`.`Estoque` (`idProduto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Telefone` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(11) NOT NULL,
  `Departamento_idDepartamento` INT NULL,
  `Empregado_CPF` VARCHAR(14) NULL,
  `Fornecedor_cnpj/cpf` VARCHAR(18) NULL,
  PRIMARY KEY (`idTelefone`),
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE,
  INDEX `fk_Telefone_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  INDEX `fk_Telefone_Empregado1_idx` (`Empregado_CPF` ASC) VISIBLE,
  INDEX `fk_Telefone_Fornecedor1_idx` (`Fornecedor_cnpj/cpf` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `postoInflamavel`.`Departamento` (`idDepartamento`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Telefone_Empregado1`
    FOREIGN KEY (`Empregado_CPF`)
    REFERENCES `postoInflamavel`.`Empregado` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Telefone_Fornecedor1`
    FOREIGN KEY (`Fornecedor_cnpj/cpf`)
    REFERENCES `postoInflamavel`.`Fornecedor` (`cnpj/cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Ocupacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Ocupacao` (
  `cbo` VARCHAR(8) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cbo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`FormaPagComp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`FormaPagComp` (
  `idFormaPagComp` INT NOT NULL AUTO_INCREMENT,
  `tipoFormaPag` VARCHAR(45) NOT NULL,
  `valor` VARCHAR(45) NOT NULL,
  `Compras_idCompras` INT NOT NULL,
  `Compras_Fornecedor_cnpj/cpf` VARCHAR(18) NOT NULL,
  `Compras_Estoque_idProduto` INT NOT NULL,
  PRIMARY KEY (`idFormaPagComp`),
  INDEX `fk_FormaPagComp_Compras1_idx` (`Compras_idCompras` ASC, `Compras_Fornecedor_cnpj/cpf` ASC, `Compras_Estoque_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_FormaPagComp_Compras1`
    FOREIGN KEY (`Compras_idCompras` , `Compras_Fornecedor_cnpj/cpf` , `Compras_Estoque_idProduto`)
    REFERENCES `postoInflamavel`.`Compras` (`idCompras` , `Fornecedor_cnpj/cpf` , `Estoque_idProduto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `postoInflamavel`.`Trabalhar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `postoInflamavel`.`Trabalhar` (
  `Empregado_CPF` VARCHAR(14) NOT NULL,
  `Departamento_idDepartamento` INT NOT NULL,
  `Ocupacao_cbo` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`Empregado_CPF`, `Departamento_idDepartamento`, `Ocupacao_cbo`),
  INDEX `fk_Trabalhar_Departamento1_idx` (`Departamento_idDepartamento` ASC) VISIBLE,
  INDEX `fk_Trabalhar_Ocupacao1_idx` (`Ocupacao_cbo` ASC) VISIBLE,
  CONSTRAINT `fk_Trabalhar_Empregado1`
    FOREIGN KEY (`Empregado_CPF`)
    REFERENCES `postoInflamavel`.`Empregado` (`CPF`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Trabalhar_Departamento1`
    FOREIGN KEY (`Departamento_idDepartamento`)
    REFERENCES `postoInflamavel`.`Departamento` (`idDepartamento`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabalhar_Ocupacao1`
    FOREIGN KEY (`Ocupacao_cbo`)
    REFERENCES `postoInflamavel`.`Ocupacao` (`cbo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


/*Destravar a base de dados para permitir delete sem where*/
SET SQL_SAFE_UPDATES = 0;

/*Travar a base de dados para permitir delete sem where*/
/*SET SQL_SAFE_UPDATES = 1;*/

-- Alter Table --
alter table empregado add column ctps varchar(15) after email;

alter table departamento add column email varchar(60) unique not null after nome;

alter table departamento add column descricao varchar(200) after horario;



/*DML*/

insert into empregado (cpf, nome, salario, sexo, statusEmp, email, ctps, dataNasc, dataAdm)
	value ("025.111.258-97", "Danilo Farias", 1852.56, 'M', 1, "dansoaresfarias@gmail.com", "986532741", '1986-09-07', '2018-05-03 13:30:00');

insert into empregado (cpf, nome, salario, sexo, statusEmp, email, ctps, dataNasc, dataAdm)
	values ("070.154.874-57", "Hugo Diniz", 1800.00, 'M', 1, "hugo@senac.com.br", "0987654321", '1993-01-08', '2019-06-04 13:30:00'),
		("112.345.678-90", "Juliana Ramalho", 2654.84, 'F', 1, "juramalho@gmail.com", "895623", '1993-12-20', '2015-05-18 08:15:00'),
		("777.888.999-34", "Diego Coutinho", 2345.67, 'M', 1, "diegocoutinho@fac.pe.senac.br", "93763828377", '1985-11-22', '2019-07-14 12:41:21'),
		("014.128.358-00", "Ben Hur Queiroz", 1311.56, 'M', 1, "benhur@gmail.com", "111533341", '1976-01-07', '2012-03-03 15:30:00'),
        ("055.432.798-57", "Fellipe Diniz", 1489.56, 'M', 1, "fellipediniz@gmail.com", "326498741", '1989-06-08', '2020-02-09 13:30:00'),
        ("077.188.387-02", "Godofredo Souza", 1701.56, 'M', 1, "godo@gmail.com", "188775341", '1980-08-01', '2019-11-03 09:30:00'),
        ("098.765.432-11", "César Pinho", 2450.00, 'M', 1, "pinhocesar@senac.com.br", "2233456789", '1992-06-18', '2022-07-05 15:00:00'),
		("102.406.954-01", "Mácio Júnior", 1800.00, 'M', 1, "macio@senac.com.br", "1020304050", '1993-11-11', '2020-07-10 12:00:02'),
        ("120.380.134-18", "Joao Victor", 3500.00, 'M', 1, "joaobarreto@email.com", "123456789", '1999-02-15', '2022-06-03 12:20:00'),
        ("120.749.910-88", "Luiz Andre", 1222.00, 'M',   1, "luizalcorreia@fac.pe.senac.br", "828929818",'2002-06-28','2021-07-11 12:08:00'),
		("100.300.650-76", "Thiago Rodrigues", 1680.00, 'M', 1, "thiago@gmail.com", "147859670", '1996-03-04', '2022-06-01 08:15:00'),
		("112.088.387-02", "Godolores Castro", 2052.56, 'F', 1, "godolores@gmail.com", "499725381", '1979-03-18', '2011-06-03 10:05:00');

insert into endereco (uf, cidade, bairro, rua, numero, comp, cep, Empregado_CPF)
	value ("PE", "Recife", "Boa Vista", "Rua Dom Bosco", 1542, "Ap 1502", "50050-070", "025.111.258-97");
    
insert into endereco (uf, cidade, bairro, rua, numero, comp, cep, Empregado_CPF)
	values ("PE", "Recife", "Boa Viagem", "Rua Segredo", 51, "Ap 1803", "51020-170", "070.154.874-57"),
		("PE", "Recife", "Boa Viagem", "Rua Passarinho", 1345, "Ap 357", "51111-000", "112.345.678-90"),
		("PE", "Recife", "Prado", "Rua Capitão Zuera", 453, "Ap 56", "38888-058", "777.888.999-34"),
		("PE", "Recife", "Madalena", "Rua Ricardo Salazar", 45, "Ap 501-A", "50720-123", "014.128.358-00"),
        ("PE", "Recife", "Campo Grande", "Rua Faz Chover", 1000, "Casa 02", "50887-170", "055.432.798-57"),
		("PE", "Jaboatao", "Cha Grande", "Rua Desce e Sobe", 1, "Primeiro Andar", "51227-170", "077.188.387-02"),
		("PE", "Olinda", "Bairro Novo", "Rua Faz Chover", 40, "Apto 15", "50087-170", "098.765.432-11"),
		("PE", "Recife", "Hipódromo", 'Rua Fulano de Tal', 100, "casa", "51041-500", "102.406.954-01"),
		("PE", "São Lourenço da mata", "Centro", "Rua Holanda", 08, "Quadra E", "54735-110", "120.380.134-18"),
        ("PE", "Olinda", "Jardim Atlantico", "Rua Rutilo", 8, " ", "53060-360", "120.749.910-88"),
        ("PE", "Recife", "Campo Grande", "Rua N S da Glória", 164, "casa", "52031-050", "100.300.650-76"),
        ("PE", "Recife", "iputinga", "Rua João do caminhão", 102, "Ap 200", "55309-083", "112.088.387-02");

insert into gerente (empregado_cpf, funcaoGrat)
	values ("070.154.874-57", 1500),
		("098.765.432-11", 1500),
        ("112.345.678-90", 1500),
        ("120.749.910-88", 1500),
        ("100.300.650-76", 1500),
        ("014.128.358-00", 1500);

insert into departamento (nome, email, descricao, localDep, horario) 
	values ("Administrativo", "adm@postoInflamavel.com", "Departamento Administrativo", "Sala - 1", "08h às 17h"),
		("Financeiro", "financeiro@postoInflamavel.com", "Departamento Financeiro", "Sala - 2", "08h às 17h"),
        ("RH", "rh@postoInflamavel.com", "Departamento Recursos Humano", "Sala - 3", "08h às 17h"),
        ("Conviniência", "loja@postoInflamavel.com", "Loja de Conviniência", "Loja", "07h às 23h"),
        ("Frente Loja", "frentistas@postoInflamavel.com", "Departamento Frente Loja", "Pátio", "07h às 23h"),
        ("TI", "ti@postoInflamavel.com", "Departamento de Tecnologia da Informação", "Sala - 4", "08h às 17h");
        
update departamento set gerente_empregado_cpf = "070.154.874-57"
	where iddepartamento = 1;
    
update departamento set gerente_empregado_cpf = "098.765.432-11"
	where iddepartamento = 2;
    
update departamento set gerente_empregado_cpf = "112.345.678-90"
	where iddepartamento = 3;
    
update departamento set gerente_empregado_cpf = "120.749.910-88"
	where iddepartamento = 4;
    
update departamento set gerente_empregado_cpf = "100.300.650-76"
	where iddepartamento = 5;

update departamento set gerente_empregado_cpf = "014.128.358-00"
	where iddepartamento = 6;
     
insert into dependente 
	values ("123.456.789-98", "Daniel Farias", '2021-10-25', "Filho","025.111.258-97"),
		("123.456.789-34", "Maria José", '2015-02-25', "Filha","112.345.678-90"),
        ("123.456.789-45", "Igor José", '2000-11-24', "Filho","112.345.678-90"),
        ("123.456.789-56", "Aline Lima", '2001-02-25', "Filha","112.088.387-02"),
        ("123.456.789-67", "Pedro Costa", '2020-03-02', "Filho","112.088.387-02"),
        ("123.456.789-78", "José Farias", '2020-11-12', "Filho","102.406.954-01"),
        ("123.456.789-89", "Bento Soares", '2022-05-15', "Filho","077.188.387-02"),
        ("123.456.789-10", "Elisa Farias", '2020-12-25', "Filha","100.300.650-76"),
        ("123.456.789-20", "Diogo Silva", '2010-11-28', "Filho","120.749.910-88"),
        ("123.456.789-30", "Dayane Silva", '2020-02-02', "Filha","014.128.358-00"),
        ("123.456.789-40", "Diego Costa", '2021-06-03', "Filho","098.765.432-11");
        
insert into ocupacao (cbo, nome)
	values ("212405" , "Analista de desenvolvimento de sistemas"),
    ("317110" , "Desenvolvedor de sistemas"),
    ("521140" , "Atendente balconista"),
    ("521135" , "Frentista"),
    ("252105" , "Administrador"),
    ("411010" , "Assistente administrativo"),
    ("252210" , "Assistente de contadoria fiscal"),
    ("252405" , "Analista de recursos humanos");

insert into trabalhar 
	values ("070.154.874-57", 1, "252105"),
		("112.345.678-90", 3, "252405"),
		("777.888.999-34", 6, "317110"),
		("014.128.358-00", 6, "212405"),
		("055.432.798-57", 2, "252210"),
		("077.188.387-02", 5, "521135"),
		("098.765.432-11", 2, "252210"),
		("102.406.954-01", 1, "411010"),
		("120.380.134-18", 1, "411010"),
		("120.749.910-88", 5, "521135"),
		("100.300.650-76", 4, "521140"),
		("112.088.387-02", 4, "521140"),
		("025.111.258-97", 5, "521135"),
		("120.380.134-18", 5, "411010"),
		("102.406.954-01", 4, "411010");

insert into ferias (Empregado_CPF, anoRef, dataIni, dataFim, qtdDias)
	values ("070.154.874-57", 2021, '2022-01-10', '2022-01-19', 20),
		("112.345.678-90", 2020, '2021-02-10', '2021-03-09', 30),
		("777.888.999-34", 2021, '2022-06-01', '2022-06-14', 15),
		("014.128.358-00", 2020, '2021-07-02', '2021-07-16', 15),
		("055.432.798-57", 2020, '2021-01-10', '2021-01-19', 20),
		("014.128.358-00", 2021, '2022-02-10', '2022-02-19', 20),
		("098.765.432-11", 2021, '2022-03-10', '2022-03-19', 20),
		("098.765.432-11", 2020, '2021-05-10', '2021-05-09', 30),
		("120.380.134-18", 2020, '2021-10-05', '2021-11-04', 30),
		("120.749.910-88", 2020, '2021-02-18', '2021-03-19', 30),
		("100.300.650-76", 2021, '2022-08-10', '2022-09-09', 30),
		("112.088.387-02", 2020, '2021-01-02', '2021-02-01', 30),
		("112.088.387-02", 2021, '2022-06-15', '2022-06-30', 15),
		("120.380.134-18", 2021, '2022-07-10', '2022-07-19', 20),
		("102.406.954-01", 2020, '2021-09-08', '2021-10-07', 30),
		("102.406.954-01", 2021, '2022-09-08', '2022-10-07', 30);

insert into estoque (nome, quantidade, valor, codigoBarra, categoria)
	values ("Gasolina", 6579.8, 6.99, "0010992874", "Combustível"),
			("Álcool", 4579.8, 5.99, "0010992875", "Combustível"),
            ("Diesel", 7679.8, 6.49, "0010992876", "Combustível"),
            ("Água Minalba 500ml", 53, 2, "0010992877", "Bebida"),
            ("Água Minalba 1500ml", 28, 5, "0010992864", "Bebida"),
            ("Coca Cola Lata 350ml", 55, 3.5, "0010992844", "Bebida"),
            ("Fanta Lata 350ml", 15, 3.49, "0010992873", "Bebida"),
            ("Sprite Lata 350ml", 20, 3.5, "0010992872", "Bebida"),
            ("Pipoca Gravatá Salgada", 59, 2, "0010992871", "Alimento"),
            ("Pipoca Gravatá Doce", 34, 2, "0010992869", "Alimento"),
            ("Coxinha Frango", 25, 6.99, "0010992845", "Alimento"),
            ("Enroladinho", 3, 6.99, "0010992846", "Alimento"),
            ("Coxinha Fango c/Catupiry", 24, 6.99, "0010992847", "Alimento"),
            ("Risole", 30, 6.99, "0010992848", "Alimento");
            
insert into fornecedor 
	values ("97.776.353/0001", "Ipiranga Distribuidora",  0, "ipidisp@ipiranga.br", 1),
			("97.776.354/0001", "CocaCola Distribuidora", 0, "disp@coca.br", 1),
            ("97.776.355/0001", "Pipocas Gravatá Distribuidora", 200.0, "disp@pipocasgta.br", 1),
            ("97.776.356/0001", "Minalba Distribuidora", 200.0, "disp@minalba.br", 1),
            ("97.776.357/0001", "Maria do Salgado", 30.0, "mariasal@gmail.com", 1),
            ("97.776.358/0001", "Dona Glória do Salgado", 25.0, "glorinha@gmail.com", 1),
            ("97.776.359/0001", "Iaia Águas Dist", 0, "iaiadisp@iaia.br", 0);
            
insert into compras (`Fornecedor_CNPJ/CPF`, Estoque_idProduto, dataComp, qtdComp, valorComp)
		values ("97.776.353/0001", 1, '2016-04-12 11:25:00', 5000, 4),
				("97.776.353/0001", 2, '2022-04-12 11:25:00', 3000, 3),
                ("97.776.353/0001", 3, '2022-05-12 11:25:00', 4000, 5),
                ("97.776.356/0001", 4, '2022-05-12 11:25:00', 30, 1),
                ("97.776.356/0001", 5, '2022-06-12 11:25:00', 50, 2),    
                ("97.776.354/0001", 6, '2022-05-12 11:25:00', 20, 3),
                ("97.776.354/0001", 7, '2022-04-12 11:25:00', 45, 3),
                ("97.776.354/0001", 8, '2022-04-12 11:25:00', 40, 3),
                ("97.776.354/0001", 9, '2022-06-12 11:25:00', 10, 1),
                ("97.776.354/0001", 10, '2022-06-12 11:25:00', 60, 1),
                ("97.776.358/0001", 11, '2022-06-08 11:25:00', 20, 4),
                ("97.776.358/0001", 12, '2022-06-08 11:25:00', 20, 4),
                ("97.776.358/0001", 13, '2022-06-08 11:25:00', 30, 4),
                ("97.776.358/0001", 14, '2022-06-08 11:25:00', 30, 4);
    
insert into vendas (dataVenda, desconto, valorTotal, Empregado_CPF) 
	values ('2022-06-01 10:30:00', 0.0, 70.0, "077.188.387-02"),
			('2022-06-01 11:30:00', 0.0, 150.0, "100.300.650-76"),
            ('2022-06-01 11:35:00', 0.0, 100.0, "100.300.650-76"),
            ('2022-06-01 12:05:00', 0.0, 180.0, "100.300.650-76"),
            ('2022-06-01 12:15:00', 0.0, 100.0, "077.188.387-02"),
            ('2022-06-01 13:35:00', 0.0, 200.0, "100.300.650-76"),            
            ('2022-06-02 13:35:00', 0.0, 230.0, "077.188.387-02"),
            ('2022-06-01 10:35:00', 0.0, 10.0, "025.111.258-97"),
            ('2022-06-01 11:30:00', 0.0, 12.0, "025.111.258-97"),
            ('2022-06-01 12:08:00', 0.0, 23.0, "025.111.258-97"),
            ('2022-06-01 12:36:00', 0.0, 44.0, "120.380.134-18"),
			('2022-06-02 10:35:00', 0.0, 15.0, "120.380.134-18"),
            ('2022-06-02 11:30:00', 0.0, 18.0, "120.380.134-18"),
            ('2022-06-02 12:08:00', 0.0, 29.0, "120.380.134-18"),
            ('2022-06-02 12:36:00', 0.0, 13.0, "120.380.134-18");
       
insert into itensvenda 
	values (1, 1, 30.0),
			(2, 1, 12.0),
            (3, 2, 18.5),
            (4, 3, 14.0),
            (5, 3, 11.0),
            (6, 2, 30.0),
            (6, 1, 3.0),
            (7, 1, 30.0),
            (8, 4, 5),
            (9, 5, 2),
            (10, 6, 3),
            (11, 7, 2),
            (11, 13, 2),
            (12, 14, 3),
            (13, 8, 1),
            (13, 12, 2),
            (14, 9, 6);

insert into formapag (tipoPag, qtdParcelas, valorPag, Vendas_idVendas)
	values ("Débito", 0, 70.0 ,1),
			("Débito", 0, 150.0 ,2),
            ("Crédito", 0, 100.0 ,3),
            ("Débito", 0, 180.0 ,4),
            ("Pix", 0, 100.0 ,5),
            ("Débito", 0, 200.0 ,6),
            ("Crédito", 0, 230.0 ,7),
            ("Dinheiro", 0, 10.0 ,8),
            ("Pix", 0, 12.0 ,9),
            ("Dinheiro", 0, 23.0 ,10),
            ("Débito", 0, 44.0 ,11),
            ("Dinheiro", 0, 15.0 ,12),
            ("Crédito", 0, 18.0 ,13),
            ("Dinheiro", 0, 29.0 ,14),
            ("Pix", 0, 13.0 ,15);

 insert into telefone (numero, empregado_cpf, departamento_iddepartamento, `fornecedor_cnpj/cpf`)
	values ("81981905671", "070.154.874-57", null, null),
		("8121263306", null, 1, null),
        ("81212633602", null, 2, null),
        ("81212633562", null, 3, null),
        ("81212633432", null, 4, null),
        ("8132445678", null, null, "97.776.353/0001"),
        ("8135331817", null, null, "97.776.355/0001"),
        ("8135331237", null, null, "97.776.354/0001"),
        ("81999334455", "098.765.432-11", null, null),
        ("81999887766", "098.765.432-11", null, null),
        ("81999889900", "070.154.874-57", null, null),
        ("81999889911", "112.345.678-90", null, null),
        ("81999889922", "120.380.134-18", null, null),
        ("81999889933", "025.111.258-97", null, null),
        ("81999889944", "100.300.650-76", null, null);
        
/*DQL*/

/*
Relatório 1 - Lista dos empregados admitidos entre 2022-01-01 e 2022-03-31, trazendo as 
colunas (Nome Empregado, CPF Empregado, Data Admissão,  Salário, Cidade Moradia, Número de 
Telefone), ordenado por data de admissão decrescente;
*/
select e.nome, e.cpf, e.dataAdm, e.salario, c.cidade, t.numero
	from empregado e
		inner join endereco c on c.empregado_cpf = e.cpf and e.dataAdm >= '2022-01-01' 
        inner join telefone t on t.empregado_cpf = e.cpf
        and dataAdm <='2023-03-31'
			order by e.dataAdm desc;
            
/*
Relatório 2 - Lista dos empregados que ganham menos que a média salarial dos funcionários 
do Posto de Gasolina, trazendo as colunas (Nome Empregado, CPF Empregado, Data Admissão,  
Salário, Cidade Moradia), ordenado por nome do empregado;
*/

select e.nome, e.cpf, e.dataAdm, e.salario, c.cidade
	from empregado e
		inner join endereco c on c.empregado_cpf = e.cpf and e.salario <= (select avg(salario) from empregado)
			order by e.nome;
			
/*
Relatório 3 - Lista dos empregados que são da cidade do Recife e possuem dependentes, 
trazendo as colunas (Nome Empregado, CPF Empregado, Data Admissão,  Salário, Cidade Moradia,
 Quantidade de Dependentes), ordenado por nome do empregado;
*/
            