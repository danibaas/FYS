-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema zbaasdr
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zbaasdr
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zbaasdr` DEFAULT CHARACTER SET latin1 ;
USE `zbaasdr` ;

-- -----------------------------------------------------
-- Table `zbaasdr`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Account` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(150) NULL DEFAULT NULL,
  `coins` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Achievement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Achievement` (
  `achievementid` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`achievementid`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Achieved`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Achieved` (
  `user_id` INT(11) NOT NULL,
  `achievementid` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`, `achievementid`),
  INDEX `achievementid` (`achievementid` ASC) VISIBLE,
  CONSTRAINT `Achieved_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`),
  CONSTRAINT `Achieved_ibfk_2`
    FOREIGN KEY (`achievementid`)
    REFERENCES `zbaasdr`.`Achievement` (`achievementid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Gamerun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Gamerun` (
  `user_id` INT(11) NOT NULL,
  `startTime` INT(11) NOT NULL,
  `enemiesKilled` INT(11) NULL DEFAULT NULL,
  `bossesKilled` INT(11) NULL DEFAULT NULL,
  `score` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `startTime`),
  CONSTRAINT `Gamerun_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Highscore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Highscore` (
  `user_id` INT(11) NULL DEFAULT NULL,
  `score` FLOAT NULL DEFAULT NULL,
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `Highscore_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Item` (
  `itemid` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL DEFAULT NULL,
  `value` INT(11) NULL DEFAULT NULL,
  `level` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`itemid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Inventory` (
  `user_id` INT(11) NOT NULL,
  `itemid` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`, `itemid`),
  INDEX `itemid` (`itemid` ASC) VISIBLE,
  CONSTRAINT `Inventory_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`),
  CONSTRAINT `Inventory_ibfk_2`
    FOREIGN KEY (`itemid`)
    REFERENCES `zbaasdr`.`Item` (`itemid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `zbaasdr`.`Statistic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zbaasdr`.`Statistic` (
  `user_id` INT(11) NOT NULL,
  `totalRuns` INT(11) NULL DEFAULT NULL,
  `totalEnemiesKilled` INT(11) NULL DEFAULT NULL,
  `totalBossesKilled` INT(11) NULL DEFAULT NULL,
  `highScore` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `Statistic_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `zbaasdr`.`Account` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
