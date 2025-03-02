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
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `name` VARCHAR(32) NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `SSN` INT(9) NULL DEFAULT CURRENT_TIMESTAMP,
  `id` INT NOT NULL,
  `IP` VARCHAR(45) NULL,
  `Phone` INT(10) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `mydb`.`HomeDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HomeDetails` (
  `Street` VARCHAR(64) NOT NULL,
  `zipCode` INT(5) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Street`, `zipCode`, `State`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_has_HomeDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_has_HomeDetails` (
  `user_id` INT NOT NULL,
  `HomeDetails_Street` VARCHAR(64) NOT NULL,
  `HomeDetails_zipCode` INT(5) NOT NULL,
  `HomeDetails_State` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`, `HomeDetails_Street`, `HomeDetails_zipCode`, `HomeDetails_State`),
  INDEX `fk_user_has_HomeDetails_HomeDetails1_idx` (`HomeDetails_Street` ASC, `HomeDetails_zipCode` ASC, `HomeDetails_State` ASC) VISIBLE,
  INDEX `fk_user_has_HomeDetails_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_HomeDetails_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_HomeDetails_HomeDetails1`
    FOREIGN KEY (`HomeDetails_Street` , `HomeDetails_zipCode` , `HomeDetails_State`)
    REFERENCES `mydb`.`HomeDetails` (`Street` , `zipCode` , `State`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`BankInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BankInfo` (
  `creditCard` INT(16) NOT NULL,
  `ccv` INT(3) NULL,
  `expireDate` VARCHAR(4) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`creditCard`, `user_id`),
  INDEX `fk_BankInfo_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_BankInfo_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
