-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dbch22
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbch22
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbch22` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `dbch22` ;

-- -----------------------------------------------------
-- Table `dbch22`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbch22`.`cart` (
  `id` INT NOT NULL,
  `confirm_id` INT NULL DEFAULT NULL,
  `has_product_id` INT NULL DEFAULT NULL,
  `total` DOUBLE NULL DEFAULT NULL,
  `quantity_products` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbch22`.`confirms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbch22`.`confirms` (
  `id` INT NOT NULL,
  `id_client` INT NOT NULL,
  `id_payment` INT NULL DEFAULT NULL,
  `id_cart` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_idx` (`id_client` ASC) VISIBLE,
  INDEX `cart_idx` (`id_cart` ASC) VISIBLE,
  CONSTRAINT `id`
    FOREIGN KEY (`id_client`)
    REFERENCES `dbch22`.`clients` (`id`),
  CONSTRAINT `cart`
    FOREIGN KEY (`id_cart`)
    REFERENCES `dbch22`.`cart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbch22`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbch22`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `confirm_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `confirm_idx` (`confirm_id` ASC) VISIBLE,
  CONSTRAINT `confirm`
    FOREIGN KEY (`confirm_id`)
    REFERENCES `dbch22`.`confirms` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbch22`.`materiales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbch22`.`materiales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbch22`.`tipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbch22`.`tipos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbch22`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbch22`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `dire` VARCHAR(400) NOT NULL,
  `cost` DOUBLE NOT NULL,
  `mat_id` INT NOT NULL,
  `typ_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `mat_idx` (`mat_id` ASC) VISIBLE,
  INDEX `typ_idx` (`typ_id` ASC) VISIBLE,
  CONSTRAINT `mat`
    FOREIGN KEY (`mat_id`)
    REFERENCES `dbch22`.`materiales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `typ`
    FOREIGN KEY (`typ_id`)
    REFERENCES `dbch22`.`tipos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbch22`.`has_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbch22`.`has_products` (
  `id_cart` INT NOT NULL,
  `id_product` INT NOT NULL,
  INDEX `fk_cart_idx` (`id_cart` ASC) VISIBLE,
  INDEX `fk_prodcut_idx` (`id_product` ASC) VISIBLE,
  CONSTRAINT `fk_cart`
    FOREIGN KEY (`id_cart`)
    REFERENCES `dbch22`.`cart` (`id`),
  CONSTRAINT `fk_prodcut`
    FOREIGN KEY (`id_product`)
    REFERENCES `dbch22`.`productos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbch22`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbch22`.`payments` (
  `id` INT NOT NULL,
  `card` VARCHAR(45) NULL,
  `confirms_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payments_confirms1_idx` (`confirms_id` ASC) VISIBLE,
  CONSTRAINT `fk_payments_confirms1`
    FOREIGN KEY (`confirms_id`)
    REFERENCES `dbch22`.`confirms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
