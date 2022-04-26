/*Creating the Librarian Table*/
CREATE TABLE `lms`.`librarian` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`));

/* Creating Reader's Table */
CREATE TABLE `lms`.`reader` (
  `user_id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NULL,
  `address` LONGTEXT NULL,
  `contact_no` INT NULL,
  PRIMARY KEY (`user_id`));

/* Authentication Table */
CREATE TABLE `lms`.`authentication` (
  `login_id` VARCHAR(500) NOT NULL,
  `password` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`login_id`),
  UNIQUE INDEX `login_id_UNIQUE` (`login_id` ASC) VISIBLE);

/* Reports Table */
CREATE TABLE `lms`.`reports` (
  `reg_no` VARCHAR(100) NOT NULL,
  `book_no` VARCHAR(100) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`reg_no`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `lms`.`reader` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

/* Publisher Table */
CREATE TABLE `lms`.`publisher` (
  `publisher_id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`publisher_id`));

/* Online Journals/Report */
CREATE TABLE `lms`.`online_res` (
  `issn` VARCHAR(100) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `author` VARCHAR(100) NULL,
  `language` VARCHAR(45) NULL,
  `publisher_id` INT NOT NULL,
  PRIMARY KEY (`issn`),
  INDEX `publisher_id_idx` (`publisher_id` ASC) VISIBLE,
  CONSTRAINT `publisher_id`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `lms`.`publisher` (`publisher_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

/* Periodicals Table */
CREATE TABLE `lms`.`periodicals` (
  `isbn` INT NOT NULL,
  `genre` VARCHAR(45) NULL,
  `publisher_id` INT NULL,
  `title` VARCHAR(45) NULL,
  `price` FLOAT NULL,
  `language` VARCHAR(45) NULL,
  PRIMARY KEY (`isbn`),
  INDEX `publisher_id_idx` (`publisher_id` ASC) VISIBLE,
  CONSTRAINT `periodicals to publisher`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `lms`.`publisher` (`publisher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

/* Books Table */
CREATE TABLE `lms`.`book` (
  `book_id` VARCHAR(100) NOT NULL,
  `isbn` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NULL,
  `price` FLOAT NULL,
  `genre` VARCHAR(45) NULL,
  `edition` FLOAT NULL,
  `authors` VARCHAR(100) NULL,
  `language` VARCHAR(45) NULL,
  `publisher_id` INT NULL,
  PRIMARY KEY (`book_id`),
  INDEX `books to publisher_idx` (`publisher_id` ASC) VISIBLE,
  CONSTRAINT `books to publisher`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `lms`.`publisher` (`publisher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

/* Date Table */
CREATE TABLE `lms`.`dates` (
  `user_id` INT NOT NULL,
  `book_id` VARCHAR(100) NULL,
  `periodicals_isbn` INT NULL,
  `onlineres_issn` VARCHAR(100) NULL,
  `issue_date` DATETIME NULL,
  `due_date` DATETIME NULL,
  `return_date` DATETIME NULL,
  `fine` FLOAT NULL,
  `reports_id` VARCHAR(100) NULL,
  INDEX `date to book_idx` (`book_id` ASC) VISIBLE,
  INDEX `date to periodicals_idx` (`periodicals_isbn` ASC) VISIBLE,
  INDEX `date to onlineres_idx` (`onlineres_issn` ASC) VISIBLE,
  INDEX `date to user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `date to book`
    FOREIGN KEY (`book_id`)
    REFERENCES `lms`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `date to periodicals`
    FOREIGN KEY (`periodicals_isbn`)
    REFERENCES `lms`.`periodicals` (`isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `date to onlineres`
    FOREIGN KEY (`onlineres_issn`)
    REFERENCES `lms`.`online_res` (`issn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `date to user`
    FOREIGN KEY (`user_id`)
    REFERENCES `lms`.`reader` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  CONSTRAINT `date to reports`
    FOREIGN KEY (`reports_id`)
    REFERENCES `lms`.`reports` (`reg_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

/*  */