-- MySQL Script generated by MySQL Workbench
-- Sun Aug 16 14:55:59 2020
-- Model: Licensing Database    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema licensing
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `licensing` ;

-- -----------------------------------------------------
-- Schema licensing
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `licensing` DEFAULT CHARACTER SET utf8 ;
USE `licensing` ;

-- -----------------------------------------------------
-- Table `licensing`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `licensing`.`Account` ;

CREATE TABLE IF NOT EXISTS `licensing`.`Account` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `owner_name` VARCHAR(64) NOT NULL,
  `email` VARCHAR(64) NOT NULL,
  `phashed` VARCHAR(512) NOT NULL,
  `type` INT NOT NULL,
  `authority` INT NOT NULL,
  `created_at` BIGINT(64) NOT NULL,
  `updated_at` BIGINT(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `ID_UNIQUE` ON `licensing`.`Account` (`id` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `licensing`.`Account` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `licensing`.`Access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `licensing`.`Access` ;

CREATE TABLE IF NOT EXISTS `licensing`.`Access` (
  `token` VARCHAR(512) NOT NULL,
  `account_id` INT NOT NULL,
  `created_at` BIGINT(64) NOT NULL,
  PRIMARY KEY (`token`, `account_id`),
  CONSTRAINT `fk_Access_Account`
    FOREIGN KEY (`account_id`)
    REFERENCES `licensing`.`Account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `ID_UNIQUE` ON `licensing`.`Access` (`token` ASC) VISIBLE;

CREATE INDEX `fk_Access_Account_idx` ON `licensing`.`Access` (`account_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `licensing`.`Project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `licensing`.`Project` ;

CREATE TABLE IF NOT EXISTS `licensing`.`Project` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `type` INT NOT NULL,
  `status` INT NOT NULL,
  `created_at` BIGINT(64) NOT NULL,
  `updated_at` BIGINT(64) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Project_Account`
    FOREIGN KEY (`account_id`)
    REFERENCES `licensing`.`Account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `ID_UNIQUE` ON `licensing`.`Project` (`id` ASC) VISIBLE;

CREATE INDEX `fk_Project_Account_idx` ON `licensing`.`Project` (`account_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `licensing`.`Service`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `licensing`.`Service` ;

CREATE TABLE IF NOT EXISTS `licensing`.`Service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `description` VARCHAR(256) NOT NULL,
  `created_at` BIGINT(64) NOT NULL,
  `updated_at` BIGINT(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `ID_UNIQUE` ON `licensing`.`Service` (`id` ASC) VISIBLE;

CREATE UNIQUE INDEX `name_UNIQUE` ON `licensing`.`Service` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `licensing`.`AssignedService`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `licensing`.`AssignedService` ;

CREATE TABLE IF NOT EXISTS `licensing`.`AssignedService` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `project_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  `assigned_at` BIGINT(64) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_AssignedService_Project`
    FOREIGN KEY (`project_id`)
    REFERENCES `licensing`.`Project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AssignedService_Service`
    FOREIGN KEY (`service_id`)
    REFERENCES `licensing`.`Service` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_AssignedService_Service_idx` ON `licensing`.`AssignedService` (`service_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `id_UNIQUE` ON `licensing`.`AssignedService` (`id` ASC) VISIBLE;

CREATE INDEX `fk_AssignedService_Project_idx` ON `licensing`.`AssignedService` (`project_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `licensing`.`Property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `licensing`.`Property` ;

CREATE TABLE IF NOT EXISTS `licensing`.`Property` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `service_id` INT NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `type` INT NOT NULL,
  `mandatory` TINYINT NOT NULL,
  `created_at` BIGINT(64) NOT NULL,
  `updated_at` BIGINT(64) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Property_Service`
    FOREIGN KEY (`service_id`)
    REFERENCES `licensing`.`Service` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `ID_UNIQUE` ON `licensing`.`Property` (`id` ASC) VISIBLE;

CREATE INDEX `fk_Property_Service_idx` ON `licensing`.`Property` (`service_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `licensing`.`ConfiguredProperty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `licensing`.`ConfiguredProperty` ;

CREATE TABLE IF NOT EXISTS `licensing`.`ConfiguredProperty` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `assigned_service_id` INT NOT NULL,
  `property_id` INT NOT NULL,
  `value` VARCHAR(512) NOT NULL,
  `created_at` BIGINT(64) NOT NULL,
  `updated_at` BIGINT(64) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ConfiguredProperty_AssignedService`
    FOREIGN KEY (`assigned_service_id`)
    REFERENCES `licensing`.`AssignedService` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ConfiguredProperty_Property`
    FOREIGN KEY (`property_id`)
    REFERENCES `licensing`.`Property` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_ConfiguredProperty_Property_idx` ON `licensing`.`ConfiguredProperty` (`property_id` ASC) VISIBLE;

CREATE INDEX `fk_ConfiguredProperty_AssignedService_idx` ON `licensing`.`ConfiguredProperty` (`assigned_service_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `id_UNIQUE` ON `licensing`.`ConfiguredProperty` (`id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
