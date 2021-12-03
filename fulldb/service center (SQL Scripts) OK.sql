CREATE TABLE payroll_statistics (
  staff_id INT(11) NOT NULL,
  repair_request_id INT(11) NOT NULL,
  date_accrual DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (staff_id, repair_request_id),
  INDEX fk_payroll_statistics_repair_request1_idx (repair_request_id ASC),
  CONSTRAINT fk_payroll_statistics_staff1
    FOREIGN KEY (staff_id)
    REFERENCES staff (id),
  CONSTRAINT fk_payroll_statistics_repair_request1
    FOREIGN KEY (repair_request_id)
    REFERENCES repair_request (id) )
ENGINE = InnoDB;

CREATE TABLE accepted_technique (
  id INT(11) NOT NULL AUTO_INCREMENT,
  clients_id INT(11) NOT NULL,
  vehicle_type_id INT(11),
  name_technique VARCHAR(255),
  model VARCHAR(255) NOT NULL,
  PRIMARY KEY (id, clients_id, vehicle_type_id),
  INDEX fk_accepted_technique_clients1_idx (clients_id ASC),
  INDEX fk_accepted_technique_vehicle_type1_idx (vehicle_type_id ASC),
  CONSTRAINT fk_accepted_technique_clients1
    FOREIGN KEY (clients_id)
    REFERENCES clients (id),
  CONSTRAINT fk_accepted_technique_vehicle_type1
    FOREIGN KEY (vehicle_type_id)
    REFERENCES vehicle_type (id) )
ENGINE = InnoDB;

CREATE TABLE product_categories (
  id INT(11) NOT NULL AUTO_INCREMENT,
  category_name VARCHAR(255) NOT NULL,
  stock_id INT(11) NOT NULL,
  PRIMARY KEY (id, stock_id),
  INDEX fk_product_categories_stock1_idx (stock_id ASC),
  CONSTRAINT fk_product_categories_stock1
    FOREIGN KEY (stock_id)
    REFERENCES stock (id) )
ENGINE = InnoDB;

CREATE TABLE commodity_items (
  id INT(11) NOT NULL AUTO_INCREMENT,
  product_categories_id INT(11) NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  cost VARCHAR(255) NOT NULL ,
  PRIMARY KEY (id, product_categories_id),
  INDEX fk_commodity_items_product_categories1_idx (product_categories_id ASC),
  CONSTRAINT fk_commodity_items_product_categories1
    FOREIGN KEY (product_categories_id)
    REFERENCES product_categories (id) )
ENGINE = InnoDB;

CREATE TABLE  vehicle_type (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id_UNIQUE (id ASC) )
ENGINE = InnoDB;

CREATE TABLE  repair_request (
  id INT(11) NOT NULL AUTO_INCREMENT,
  clients_id INT(11) NOT NULL,
  accepted_technique_id INT(11) NOT NULL,
  task VARCHAR(255) NOT NULL,
  repair_amount VARCHAR(255),
  expenses VARCHAR(255),
  profit VARCHAR(255),
  creat_date DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id, clients_id, accepted_technique_id),
  INDEX fk_repair_request_clients1_idx (clients_id ASC) ,
  INDEX fk_repair_request_accepted_technique1_idx (accepted_technique_id ASC),
  CONSTRAINT fk_repair_request_clients1
    FOREIGN KEY (clients_id)
    REFERENCES clients (id),
  CONSTRAINT fk_repair_request_accepted_technique1
    FOREIGN KEY (accepted_technique_id)
    REFERENCES accepted_technique (id) )
ENGINE = InnoDB;

CREATE TABLE stock (
  id INT(11) NOT NULL AUTO_INCREMENT,
  warehouse_name varchar(255) NOT NULL,
  address varchar(255) NOT NULL,
  PRIMARY KEY (id) ) 
ENGINE=InnoDB;

CREATE TABLE staff (
  id INT(11) NOT NULL AUTO_INCREMENT,
  positions_id INT(11) NOT NULL,
  surname varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  middle_name varchar(255) NOT NULL,
  Telephone bigint NOT NULL,
  email varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  date_creat DATETIME NOT NULL DEFAULT NOW(),
  update_date DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (id,positions_id),
  UNIQUE KEY id_UNIQUE (id),
  UNIQUE KEY Telephone_UNIQUE (Telephone),
  UNIQUE KEY email_UNIQUE (email),
  KEY fk_staff_positions1_idx (positions_id),
  CONSTRAINT fk_staff_positions1 FOREIGN KEY (positions_id) REFERENCES positions (id) ) 
ENGINE=InnoDB;

CREATE TABLE individual (
  clients_id int NOT NULL,
  Surname varchar(255) NOT NULL,
  Name varchar(255) NOT NULL,
  middle_name varchar(255) NOT NULL,
  PRIMARY KEY (clients_id),
  CONSTRAINT fk_individual_clients FOREIGN KEY (clients_id) REFERENCES clients (id) )
ENGINE=InnoDB;

CREATE TABLE entity (
  clients_id int NOT NULL,
  organization_name varchar(255) NOT NULL,
  PRIMARY KEY (clients_id),
  CONSTRAINT fk_entity_clients1 FOREIGN KEY (clients_id) REFERENCES clients (id) )
ENGINE=InnoDB;

CREATE TABLE clients (
  id int NOT NULL AUTO_INCREMENT,
  telephone bigint DEFAULT NULL,
  address varchar(255),
  PRIMARY KEY (id),
  UNIQUE KEY id_UNIQUE (id),
  UNIQUE KEY Telephone_UNIQUE (telephone) )
ENGINE=InnoDB;

CREATE TABLE positions (
  id int NOT NULL AUTO_INCREMENT,
  job_title varchar(255) NOT NULL,
  PRIMARY KEY (id) )
ENGINE=InnoDB;
