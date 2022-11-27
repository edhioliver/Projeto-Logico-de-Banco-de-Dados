-- MySQL Script generated by MySQL Workbench
-- Sat Nov 26 22:16:44 2022
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`Pessoa Física`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pessoa Física` (
  `idPessoa Física` INT NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPessoa Física`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pessoa Jurídica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pessoa Jurídica` (
  `idPessoa Jurídica` INT NOT NULL,
  `CNPJ` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPessoa Jurídica`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Identificação` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `Pessoa Física_idPessoa Física` INT NOT NULL,
  `Pessoa Jurídica_idPessoa Jurídica` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `Pessoa Física_idPessoa Física`, `Pessoa Jurídica_idPessoa Jurídica`),
  INDEX `fk_Cliente_Pessoa Física1_idx` (`Pessoa Física_idPessoa Física` ASC) VISIBLE,
  INDEX `fk_Cliente_Pessoa Jurídica1_idx` (`Pessoa Jurídica_idPessoa Jurídica` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Pessoa Física1`
    FOREIGN KEY (`Pessoa Física_idPessoa Física`)
    REFERENCES `mydb`.`Pessoa Física` (`idPessoa Física`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Pessoa Jurídica1`
    FOREIGN KEY (`Pessoa Jurídica_idPessoa Jurídica`)
    REFERENCES `mydb`.`Pessoa Jurídica` (`idPessoa Jurídica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Frete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Frete` (
  `idPedido` INT NOT NULL,
  `Status do Pedido` VARCHAR(45) NULL,
  `Descrição` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Frete` FLOAT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL,
  `Categoria` VARCHAR(45) NOT NULL,
  `Descrição` VARCHAR(45) NULL,
  `Valor` FLOAT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Razão social` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disponibilizando_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Disponibilizando_Produto` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_has_Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto_has_Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `mydb`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Relação de Produto/Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Relação de Produto/Pedido` (
  `Pedido_idPedido` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Produto_idProduto`),
  INDEX `fk_Pedido_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Produto_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Produto_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Frete` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrega` (
  `idEntrega` INT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Frete_idPedido` INT NOT NULL,
  `Frete_Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idEntrega`, `Frete_idPedido`, `Frete_Cliente_idCliente`),
  INDEX `fk_Entrega_Frete1_idx` (`Frete_idPedido` ASC, `Frete_Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Frete1`
    FOREIGN KEY (`Frete_idPedido` , `Frete_Cliente_idCliente`)
    REFERENCES `mydb`.`Frete` (`idPedido` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Terceiro-Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Terceiro-Vendedor` (
  `idTerceiro-Vendedor` INT NOT NULL,
  `Razão Social` VARCHAR(45) NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idTerceiro-Vendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos por Vendedor(terceiro)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos por Vendedor(terceiro)` (
  `Terceiro-Vendedor_idTerceiro-Vendedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Terceiro-Vendedor_idTerceiro-Vendedor`, `Produto_idProduto`),
  INDEX `fk_Terceiro-Vendedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Terceiro-Vendedor_has_Produto_Terceiro-Vendedor1_idx` (`Terceiro-Vendedor_idTerceiro-Vendedor` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro-Vendedor_has_Produto_Terceiro-Vendedor1`
    FOREIGN KEY (`Terceiro-Vendedor_idTerceiro-Vendedor`)
    REFERENCES `mydb`.`Terceiro-Vendedor` (`idTerceiro-Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro-Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cartão`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cartão` (
  `idCartão` INT NOT NULL,
  `Número do Cartão` VARCHAR(45) NOT NULL,
  `Tipo do Cartão` VARCHAR(45) NOT NULL,
  `Data de Validade` DATE NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Cliente_Pessoa Física_idPessoa Física` INT NOT NULL,
  `Cliente_Pessoa Jurídica_idPessoa Jurídica` INT NOT NULL,
  PRIMARY KEY (`idCartão`, `Cliente_idCliente`, `Cliente_Pessoa Física_idPessoa Física`, `Cliente_Pessoa Jurídica_idPessoa Jurídica`),
  INDEX `fk_Cartão_Cliente1_idx` (`Cliente_idCliente` ASC, `Cliente_Pessoa Física_idPessoa Física` ASC, `Cliente_Pessoa Jurídica_idPessoa Jurídica` ASC) VISIBLE,
  CONSTRAINT `fk_Cartão_Cliente1`
    FOREIGN KEY (`Cliente_idCliente` , `Cliente_Pessoa Física_idPessoa Física` , `Cliente_Pessoa Jurídica_idPessoa Jurídica`)
    REFERENCES `mydb`.`Cliente` (`idCliente` , `Pessoa Física_idPessoa Física` , `Pessoa Jurídica_idPessoa Jurídica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento` (
  `idPagamento` INT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Pagamentocol` VARCHAR(45) NULL,
  `Entrega_idEntrega` INT NOT NULL,
  `Entrega_Frete_idPedido` INT NOT NULL,
  `Entrega_Frete_Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPagamento`, `Entrega_idEntrega`, `Entrega_Frete_idPedido`, `Entrega_Frete_Cliente_idCliente`),
  INDEX `fk_Pagamento_Entrega1_idx` (`Entrega_idEntrega` ASC, `Entrega_Frete_idPedido` ASC, `Entrega_Frete_Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Entrega1`
    FOREIGN KEY (`Entrega_idEntrega` , `Entrega_Frete_idPedido` , `Entrega_Frete_Cliente_idCliente`)
    REFERENCES `mydb`.`Entrega` (`idEntrega` , `Frete_idPedido` , `Frete_Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Analisando Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Analisando Pagamento` (
  `Pagamento_idPagamento` INT NOT NULL,
  `Cartão_idCartão` INT NOT NULL,
  `Cartão_Cliente_idCliente` INT NOT NULL,
  `Relação de Produto/Pedido_Pedido_idPedido` INT NOT NULL,
  `Relação de Produto/Pedido_Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Cartão_idCartão`, `Cartão_Cliente_idCliente`, `Relação de Produto/Pedido_Pedido_idPedido`, `Relação de Produto/Pedido_Produto_idProduto`),
  INDEX `fk_Pagamento_has_Cartão_Cartão1_idx` (`Cartão_idCartão` ASC, `Cartão_Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Pagamento_has_Cartão_Pagamento1_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  INDEX `fk_Analisando Pagamento_Relação de Produto/Pedido1_idx` (`Relação de Produto/Pedido_Pedido_idPedido` ASC, `Relação de Produto/Pedido_Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_has_Cartão_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `mydb`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagamento_has_Cartão_Cartão1`
    FOREIGN KEY (`Cartão_idCartão` , `Cartão_Cliente_idCliente`)
    REFERENCES `mydb`.`Cartão` (`idCartão` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Analisando Pagamento_Relação de Produto/Pedido1`
    FOREIGN KEY (`Relação de Produto/Pedido_Pedido_idPedido` , `Relação de Produto/Pedido_Produto_idProduto`)
    REFERENCES `mydb`.`Relação de Produto/Pedido` (`Pedido_idPedido` , `Produto_idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
