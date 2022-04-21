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

/*  */