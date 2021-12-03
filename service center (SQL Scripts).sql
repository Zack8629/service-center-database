-- MySQL Workbench Synchronization
-- Generated: 2020-09-13 22:50
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Zack

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `service_center`.`staff` 
DROP FOREIGN KEY `fk_staff_positions1`;

ALTER TABLE `service_center`.`individual` 
DROP FOREIGN KEY `fk_individual_clients`;

ALTER TABLE `service_center`.`entity` 
DROP FOREIGN KEY `fk_entity_clients1`;

ALTER TABLE `service_center`.`staff` 
COLLATE = utf8mb4_general_ci ,
ADD INDEX `fk_staff_positions1_idx` (`positions_id` ASC) VISIBLE,
DROP INDEX `fk_staff_positions1_idx` ;
;

ALTER TABLE `service_center`.`clients` 
COLLATE = utf8mb4_general_ci ;

ALTER TABLE `service_center`.`individual` 
COLLATE = utf8mb4_general_ci , COMMENT = 'Физ лицо' ;

ALTER TABLE `service_center`.`stock` 
COLLATE = utf8mb4_general_ci ;

CREATE TABLE IF NOT EXISTS `service_center`.`payroll_statistics` (
  `staff_id` INT(11) NOT NULL COMMENT 'ид сотрудника',
  `repair_request_id` INT(11) NOT NULL COMMENT 'ид заявки на ремонт',
  `date_accrual` DATETIME NOT NULL DEFAULT NOW() COMMENT 'Дата начисления выплаты',
  PRIMARY KEY (`staff_id`, `repair_request_id`),
  INDEX `fk_payroll_statistics_repair_request1_idx` (`repair_request_id` ASC) VISIBLE,
  CONSTRAINT `fk_payroll_statistics_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `service_center`.`staff` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payroll_statistics_repair_request1`
    FOREIGN KEY (`repair_request_id`)
    REFERENCES `service_center`.`repair_request` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Статистика ЗП';

CREATE TABLE IF NOT EXISTS `service_center`.`accepted_technique` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ид техники',
  `clients_id` INT(11) NOT NULL COMMENT 'ид клиента, чья техника',
  `vehicle_type_id` INT(11) NOT NULL COMMENT 'ид типа технки',
  `name_technique` VARCHAR(255) NOT NULL COMMENT 'Название техники',
  `model` VARCHAR(255) NOT NULL COMMENT 'Модель техники',
  PRIMARY KEY (`id`, `clients_id`, `vehicle_type_id`),
  INDEX `fk_accepted_technique_clients1_idx` (`clients_id` ASC) VISIBLE,
  INDEX `fk_accepted_technique_vehicle_type1_idx` (`vehicle_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_accepted_technique_clients1`
    FOREIGN KEY (`clients_id`)
    REFERENCES `service_center`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accepted_technique_vehicle_type1`
    FOREIGN KEY (`vehicle_type_id`)
    REFERENCES `service_center`.`vehicle_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Техника принятая на ремонт';

CREATE TABLE IF NOT EXISTS `service_center`.`product_categories` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ид категории',
  `category_name` VARCHAR(255) NOT NULL COMMENT 'название категории',
  `stock_id` INT(11) NOT NULL COMMENT 'ид склада',
  PRIMARY KEY (`id`, `stock_id`),
  INDEX `fk_product_categories_stock1_idx` (`stock_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_categories_stock1`
    FOREIGN KEY (`stock_id`)
    REFERENCES `service_center`.`stock` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Катигории товаров';

CREATE TABLE IF NOT EXISTS `service_center`.`commodity_items` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ид товара',
  `product_categories_id` INT(11) NOT NULL COMMENT 'ид категории',
  `product_name` VARCHAR(255) NOT NULL COMMENT 'название товара',
  `cost` VARCHAR(255) NOT NULL COMMENT 'стоимость',
  PRIMARY KEY (`id`, `product_categories_id`),
  INDEX `fk_commodity_items_product_categories1_idx` (`product_categories_id` ASC) VISIBLE,
  CONSTRAINT `fk_commodity_items_product_categories1`
    FOREIGN KEY (`product_categories_id`)
    REFERENCES `service_center`.`product_categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Товарные позиции';

CREATE TABLE IF NOT EXISTS `service_center`.`vehicle_type` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ид типа техеники',
  `name` VARCHAR(255) NOT NULL COMMENT 'наименование типа',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Тип техники';

CREATE TABLE IF NOT EXISTS `service_center`.`repair_request` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ид заявки на ремонт',
  `clients_id` INT(11) NOT NULL COMMENT 'ид клиента',
  `accepted_technique_id` INT(11) NOT NULL COMMENT 'ид техниеи сданной на ремонт',
  `task` VARCHAR(255) NOT NULL COMMENT 'Что необходимо сделать',
  `repair_amount` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Согласованная сумма ремонта',
  `expenses` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Затраты',
  `profit` VARCHAR(255) NULL DEFAULT NULL COMMENT 'прибыль',
  `creat_date` DATETIME NOT NULL DEFAULT NOW() COMMENT 'дата создания заявки',
  PRIMARY KEY (`id`, `clients_id`, `accepted_technique_id`),
  INDEX `fk_repair_request_clients1_idx` (`clients_id` ASC) VISIBLE,
  INDEX `fk_repair_request_accepted_technique1_idx` (`accepted_technique_id` ASC) VISIBLE,
  CONSTRAINT `fk_repair_request_clients1`
    FOREIGN KEY (`clients_id`)
    REFERENCES `service_center`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_repair_request_accepted_technique1`
    FOREIGN KEY (`accepted_technique_id`)
    REFERENCES `service_center`.`accepted_technique` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Заявки на ремонт';

ALTER TABLE `service_center`.`staff` 
ADD CONSTRAINT `fk_staff_positions1`
  FOREIGN KEY (`positions_id`)
  REFERENCES `service_center`.`positions` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `service_center`.`individual` 
ADD CONSTRAINT `fk_individual_clients`
  FOREIGN KEY (`clients_id`)
  REFERENCES `service_center`.`clients` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `service_center`.`entity` 
ADD CONSTRAINT `fk_entity_clients1`
  FOREIGN KEY (`clients_id`)
  REFERENCES `service_center`.`clients` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
