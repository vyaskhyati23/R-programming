-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema newsdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema newsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `newsdb` DEFAULT CHARACTER SET utf8 ;
USE `newsdb` ;

-- -----------------------------------------------------
-- Table `newsdb`.`News`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `newsdb`.`News` (
  `newsid` INT NOT NULL,
  `url` VARCHAR(200) NOT NULL,
  `timedelta` INT NULL,
  `num_hrefs` INT NULL,
  `num_self_hrefs` INT NULL,
  `num_imgs` INT NULL,
  `num_videos` INT NULL,
  `self_reference_min_shares` INT NULL,
  `self_reference_max_shares` INT NULL,
  `self_reference_avg_sharess` FLOAT NULL,
  `title_subjectivity` FLOAT NULL,
  `title_sentiment_polarity` FLOAT NULL,
  `abs_title_subjectivity` FLOAT NULL,
  `abs_title_sentment_polarity` FLOAT NULL,
  `shares` INT NULL,
  PRIMARY KEY (`newsid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `newsdb`.`Tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `newsdb`.`Tokens` (
  `newsid` INT NOT NULL,
  `n_tokens_title` INT NULL,
  `n_tokens_content` INT NULL,
  `n_unique_tokens` FLOAT NULL,
  `n_non_stop_words` FLOAT NULL,
  `n_non_stop_unique_tokens` FLOAT NULL,
  `average_token_length` FLOAT NULL,
  `num_keywords` INT NULL,
  `kw_min_min` INT NULL,
  `kw_max_min` INT NULL,
  `kw_avg_min` FLOAT NULL,
  `kw_min_max` INT NULL,
  `kw_max_max` INT NULL,
  `kw_avg_max` FLOAT NULL,
  `kw_min_avg` FLOAT NULL,
  `kw_max_avg` FLOAT NULL,
  `kw_avg_avg` FLOAT NULL,
  `global_subjectivity` FLOAT NULL,
  `global_sentiment_polarity` FLOAT NULL,
  `global_rate_positive_words` FLOAT NULL,
  `global_rate_negative_words` FLOAT NULL,
  `rate_positive_words` FLOAT NULL,
  `rate_negative_words` FLOAT NULL,
  `avg_positive_polarity` FLOAT NULL,
  `min_positive_polarity` FLOAT NULL,
  `max_positive_polarity` FLOAT NULL,
  `avg_negative_polarity` FLOAT NULL,
  `min_negative_polarity` FLOAT NULL,
  `max_negative_polarity` FLOAT NULL,
  INDEX `newsid_idx` (`newsid` ASC),
  CONSTRAINT `newsid`
    FOREIGN KEY (`newsid`)
    REFERENCES `newsdb`.`News` (`newsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `newsdb`.`DataChannelType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `newsdb`.`DataChannelType` (
  `data_channel_is_lifestyle` INT NULL,
  `data_channel_is_entertainment` INT NULL,
  `newsid` INT NOT NULL,
  `data_channel_is_bus` INT NULL,
  `data_channel_is_socmed` INT NULL,
  `data_channel_is_tech` INT NULL,
  `data_channel_is_world` INT NULL,
  INDEX `newsid_idx` (`newsid` ASC),
  CONSTRAINT `newsid`
    FOREIGN KEY (`newsid`)
    REFERENCES `newsdb`.`News` (`newsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `newsdb`.`DayPublished`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `newsdb`.`DayPublished` (
  `newsid` INT NOT NULL,
  `weekday_is_monday` INT NULL,
  `weekday_is_tuesday` INT NULL,
  `weekday_is_wednesday` INT NULL,
  `weekday_is_thursday` INT NULL,
  `weekday_is_friday` INT NULL,
  `weekday_is_saturday` INT NULL,
  `weekday_is_sunday` INT NULL,
  INDEX `newsid_idx` (`newsid` ASC),
  CONSTRAINT `newsid`
    FOREIGN KEY (`newsid`)
    REFERENCES `newsdb`.`News` (`newsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `newsdb`.`LDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `newsdb`.`LDA` (
  `newsid` INT NOT NULL,
  `LDA_00` FLOAT NULL,
  `LDA_01` FLOAT NULL,
  `LDA_02` FLOAT NULL,
  `LDA_03` FLOAT NULL,
  `LDA_04` FLOAT NULL,
  INDEX `newsid_idx` (`newsid` ASC),
  CONSTRAINT `newsid`
    FOREIGN KEY (`newsid`)
    REFERENCES `newsdb`.`News` (`newsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
