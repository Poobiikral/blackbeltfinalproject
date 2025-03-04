-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema malware
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema malware
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `malware` DEFAULT CHARACTER SET utf8 ;
USE `malware` ;

-- -----------------------------------------------------
-- Table `malware`.`HomeDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `malware`.`HomeDetails` ;

CREATE TABLE IF NOT EXISTS `malware`.`HomeDetails` (
  `Street` VARCHAR(45) NOT NULL,
  `Zip` INT(5) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Street`, `Zip`, `State`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `malware`.`BankInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `malware`.`BankInfo` ;

CREATE TABLE IF NOT EXISTS `malware`.`BankInfo` (
  `creditCardNumber` INT(16) NOT NULL,
  `ccv` INT(3) NULL,
  `Exp` VARCHAR(10) NULL,
  PRIMARY KEY (`creditCardNumber`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `malware`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `malware`.`user` ;

CREATE TABLE IF NOT EXISTS `malware`.`user` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `SSN` INT(9) NULL,
  `IP` VARCHAR(45) NULL,
  `phoneNumber` INT(10) NULL,
  `HomeDetails_Street` VARCHAR(45) NOT NULL,
  `HomeDetails_Zip` INT(5) NOT NULL,
  `HomeDetails_State` VARCHAR(45) NOT NULL,
  `BankInfo_creditCardNumber` INT(16) NOT NULL,
  PRIMARY KEY (`id`, `HomeDetails_Street`, `HomeDetails_Zip`, `HomeDetails_State`, `BankInfo_creditCardNumber`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_user_HomeDetails_idx` (`HomeDetails_Street` ASC, `HomeDetails_Zip` ASC, `HomeDetails_State` ASC) VISIBLE,
  INDEX `fk_user_BankInfo1_idx` (`BankInfo_creditCardNumber` ASC) VISIBLE,
  CONSTRAINT `fk_user_HomeDetails`
    FOREIGN KEY (`HomeDetails_Street` , `HomeDetails_Zip` , `HomeDetails_State`)
    REFERENCES `malware`.`HomeDetails` (`Street` , `Zip` , `State`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_BankInfo1`
    FOREIGN KEY (`BankInfo_creditCardNumber`)
    REFERENCES `malware`.`BankInfo` (`creditCardNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
