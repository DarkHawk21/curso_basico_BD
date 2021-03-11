-- MySQL Script generated by MySQL Workbench
-- Wed Mar 10 19:56:24 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tienda_curso
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tienda_curso
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tienda_curso` DEFAULT CHARACTER SET utf8 ;
USE `tienda_curso` ;

-- -----------------------------------------------------
-- Table `tienda_curso`.`categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_curso`.`categoria` ;

CREATE TABLE IF NOT EXISTS `tienda_curso`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`idcategoria`),
  UNIQUE INDEX `idcategoria_UNIQUE` (`idcategoria` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_curso`.`articulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_curso`.`articulo` ;

CREATE TABLE IF NOT EXISTS `tienda_curso`.`articulo` (
  `idarticulo` INT NOT NULL AUTO_INCREMENT,
  `idcategoria` INT NULL,
  `codigo` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `precio_venta` DECIMAL(11,2) NULL,
  `stock` INT NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`idarticulo`),
  UNIQUE INDEX `idarticulo_UNIQUE` (`idarticulo` ASC) VISIBLE,
  INDEX `fk_articulo_categoria_idx` (`idcategoria` ASC) VISIBLE,
  CONSTRAINT `fk_articulo_categoria`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `tienda_curso`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_curso`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_curso`.`rol` ;

CREATE TABLE IF NOT EXISTS `tienda_curso`.`rol` (
  `idrol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`idrol`),
  UNIQUE INDEX `idrol_UNIQUE` (`idrol` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_curso`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_curso`.`usuario` ;

CREATE TABLE IF NOT EXISTS `tienda_curso`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `idrol` INT NULL,
  `nombre` VARCHAR(45) NULL,
  `tipo_documento` VARCHAR(45) NULL,
  `num_documento` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `clave` VARCHAR(255) NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `idusuario_UNIQUE` (`idusuario` ASC) VISIBLE,
  INDEX `fk_usuario_rol1_idx` (`idrol` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_rol1`
    FOREIGN KEY (`idrol`)
    REFERENCES `tienda_curso`.`rol` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_curso`.`proveedores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_curso`.`proveedores` ;

CREATE TABLE IF NOT EXISTS `tienda_curso`.`proveedores` (
  `idproveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre_persona` VARCHAR(45) NULL,
  `tipo_documento` VARCHAR(45) NULL,
  `num_documento` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idproveedor`),
  UNIQUE INDEX `idpersona_UNIQUE` (`idproveedor` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_curso`.`ingreso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_curso`.`ingreso` ;

CREATE TABLE IF NOT EXISTS `tienda_curso`.`ingreso` (
  `idingreso` INT NOT NULL AUTO_INCREMENT,
  `idproveedor` INT NULL,
  `idusuario` INT NULL,
  `tipo_comprobante` VARCHAR(45) NULL,
  `serie_comprobante` VARCHAR(45) NULL,
  `num_comprobante` VARCHAR(45) NULL,
  `fecha` DATETIME NULL,
  `impuesto` DECIMAL(4,2) NULL,
  `total` DECIMAL(11,2) NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`idingreso`),
  UNIQUE INDEX `idingreso_UNIQUE` (`idingreso` ASC) VISIBLE,
  INDEX `fk_ingreso_usuario1_idx` (`idusuario` ASC) VISIBLE,
  INDEX `fk_ingreso_proveedores1_idx` (`idproveedor` ASC) VISIBLE,
  CONSTRAINT `fk_ingreso_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `tienda_curso`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingreso_proveedores1`
    FOREIGN KEY (`idproveedor`)
    REFERENCES `tienda_curso`.`proveedores` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_curso`.`detalle_ingreso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_curso`.`detalle_ingreso` ;

CREATE TABLE IF NOT EXISTS `tienda_curso`.`detalle_ingreso` (
  `iddetalle_ingreso` INT NOT NULL AUTO_INCREMENT,
  `idingreso` INT NULL,
  `idarticulo` INT NULL,
  `cantidad` INT NULL,
  `precio` DECIMAL(11,2) NULL,
  PRIMARY KEY (`iddetalle_ingreso`),
  UNIQUE INDEX `iddetalle_ingreso_UNIQUE` (`iddetalle_ingreso` ASC) VISIBLE,
  INDEX `fk_detalle_ingreso_articulo1_idx` (`idarticulo` ASC) VISIBLE,
  INDEX `fk_detalle_ingreso_ingreso1_idx` (`idingreso` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_ingreso_articulo1`
    FOREIGN KEY (`idarticulo`)
    REFERENCES `tienda_curso`.`articulo` (`idarticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_ingreso_ingreso1`
    FOREIGN KEY (`idingreso`)
    REFERENCES `tienda_curso`.`ingreso` (`idingreso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_curso`.`venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_curso`.`venta` ;

CREATE TABLE IF NOT EXISTS `tienda_curso`.`venta` (
  `idventa` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NULL,
  `idusuario` INT NULL,
  `tipo_comprobante` VARCHAR(45) NULL,
  `serie_comprobante` VARCHAR(45) NULL,
  `num_comprobante` VARCHAR(45) NULL,
  `fecha` DATETIME NULL,
  `impuesto` DECIMAL(4,2) NULL,
  `total` DECIMAL(11,2) NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`idventa`),
  UNIQUE INDEX `idventa_UNIQUE` (`idventa` ASC) VISIBLE,
  INDEX `fk_venta_usuario1_idx` (`idusuario` ASC) VISIBLE,
  INDEX `fk_venta_proveedores1_idx` (`idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_venta_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `tienda_curso`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_proveedores1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `tienda_curso`.`proveedores` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda_curso`.`detalle_venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda_curso`.`detalle_venta` ;

CREATE TABLE IF NOT EXISTS `tienda_curso`.`detalle_venta` (
  `iddetalle_venta` INT NOT NULL AUTO_INCREMENT,
  `idventa` INT NULL,
  `idarticulo` INT NULL,
  `cantidad` INT NULL,
  `precio` DECIMAL(11,2) NULL,
  `descuento` DECIMAL(11,2) NULL,
  PRIMARY KEY (`iddetalle_venta`),
  UNIQUE INDEX `iddetalle_venta_UNIQUE` (`iddetalle_venta` ASC) VISIBLE,
  INDEX `fk_detalle_venta_venta1_idx` (`idventa` ASC) VISIBLE,
  INDEX `fk_detalle_venta_articulo1_idx` (`idarticulo` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_venta_venta1`
    FOREIGN KEY (`idventa`)
    REFERENCES `tienda_curso`.`venta` (`idventa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_articulo1`
    FOREIGN KEY (`idarticulo`)
    REFERENCES `tienda_curso`.`articulo` (`idarticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
