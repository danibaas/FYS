-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema zbaasdr
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zbaasdr
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zbaasdr` DEFAULT CHARACTER SET utf8 ;
USE `zbaasdr` ;

-- -----------------------------------------------------
-- Table `zbaasdr`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Account` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Achievement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Achievement` (
  `achievementid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`achievementid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Achieved`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Achieved` (
  `Achievement_achievementid` INT NOT NULL,
  `Account_user_id` INT NOT NULL,
  PRIMARY KEY (`Achievement_achievementid`, `Account_user_id`),
  INDEX `fk_Achievement_has_Account_Account1_idx` (`Account_user_id` ASC) VISIBLE,
  INDEX `fk_Achievement_has_Account_Achievement_idx` (`Achievement_achievementid` ASC) VISIBLE,
  CONSTRAINT `fk_Achievement_has_Account_Achievement`
    FOREIGN KEY (`Achievement_achievementid`)
    REFERENCES `zbaasdr`.`Achievement` (`achievementid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Achievement_has_Account_Account1`
    FOREIGN KEY (`Account_user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Highscore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Highscore` (
  `score` FLOAT NOT NULL,
  `Account_user_id` INT NOT NULL,
  INDEX `fk_Highscore_Account1_idx` (`Account_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Highscore_Account1`
    FOREIGN KEY (`Account_user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Money`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Money` (
  `coins` INT NOT NULL,
  `Account_user_id` INT NOT NULL,
  PRIMARY KEY (`Account_user_id`),
  INDEX `fk_Money_Account1_idx` (`Account_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Money_Account1`
    FOREIGN KEY (`Account_user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Item` (
  `itemid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`itemid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Shop` (
  `Item_itemid` INT NOT NULL,
  `Account_user_id` INT NOT NULL,
  PRIMARY KEY (`Item_itemid`, `Account_user_id`),
  INDEX `fk_Item_has_Account_Account1_idx` (`Account_user_id` ASC) VISIBLE,
  INDEX `fk_Item_has_Account_Item1_idx` (`Item_itemid` ASC) VISIBLE,
  CONSTRAINT `fk_Item_has_Account_Item1`
    FOREIGN KEY (`Item_itemid`)
    REFERENCES `zbaasdr`.`Item` (`itemid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_has_Account_Account1`
    FOREIGN KEY (`Account_user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Gamerun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Gamerun` (
  `startTime` INT NOT NULL,
  `enemiesKilled` INT NOT NULL,
  `bossesKilled` INT NOT NULL,
  `score` INT NOT NULL,
  `Account_user_id` INT NOT NULL,
  PRIMARY KEY (`startTime`, `Account_user_id`),
  INDEX `fk_Gamerun_Account1_idx` (`Account_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Gamerun_Account1`
    FOREIGN KEY (`Account_user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Statistic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Statistic` (
  `totalRuns` INT NOT NULL,
  `totalEnemiesKilled` INT NOT NULL,
  `totalBossesKilled` INT NOT NULL,
  `highScore` INT NOT NULL,
  `Account_user_id` INT NOT NULL,
  PRIMARY KEY (`Account_user_id`),
  CONSTRAINT `fk_Statistic_Account1`
    FOREIGN KEY (`Account_user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
