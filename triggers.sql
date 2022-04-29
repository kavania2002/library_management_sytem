-- Updating Fine in Dates Table and adds due date as 14 days + issue_date
USE `lms`;

DELIMITER ;
DROP TRIGGER IF EXISTS `lms`.`set_fine_duedate`;

DELIMITER $$
USE `lms`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `set_fine_duedate` BEFORE UPDATE ON `dates` FOR EACH ROW BEGIN
	if new.`issue_date` is NOT NULL then
		set new.`due_date` = date_add(new.`issue_date`, interval 14 day);
	end if;
	if new.`return_date` is NOT NULL then
		if new.`return_date` > new.`due_date` then
			set new.`fine` = datediff(due_date, return_date);
		else
			set new.`fine` = 0;
		end if;
	end if;
END$$
DELIMITER ;






-- Not more than 1 book in dates table
DROP TRIGGER IF EXISTS `lms`.`check_if_issued`;

DELIMITER $$
USE `lms`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `check_if_issued` BEFORE INSERT ON `dates` FOR EACH ROW BEGIN
	declare rt datetime;
	declare error_msg varchar(200);
	set rt = (select return_date from `dates` where new.user_id = user_id);
	if rt is NULL then
		set error_msg = `One student can issue only one book at a time`;
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
	end if;	
END$$
DELIMITER ;





-- Throwing error if all the books are issued
DROP TRIGGER IF EXISTS `lms`.`check_copies`;

DELIMITER $$
USE `lms`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `check_copies` AFTER INSERT ON `dates` FOR EACH ROW BEGIN
	declare no_of_copies int;
    declare error_msg varchar(200);
    declare book_name varchar(45);
    set book_name = (select `book`.title from `book` where `book`.book_id = new.book_id);
    set no_of_copies = (select `admin`.copies from `admin` where `book`.title = book_name);
    if no_of_copies=0 then
		set error_msg = `The book is not available right now`;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
	end if;
END$$
DELIMITER ;






-- No of copies deduce/increase
DROP TRIGGER IF EXISTS `lms`.`maintain_count_copies`;

DELIMITER $$
USE `lms`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `maintain_count_copies` AFTER INSERT ON `dates` FOR EACH ROW begin
	declare no_of_copies int;    
    declare book_name varchar(45);
    set book_name = (select `book`.title from `book` where `book`.book_id = new.book_id);
    set no_of_copies = (select copies from `admin` where `admin`.title = book_name);    
    update `admin` set copies = no_of_copies - 1 where `admin`.title = book_name;
END$$
DELIMITER ;






-- Error checking in contact no before inserting as well as when updating
DROP TRIGGER IF EXISTS `lms`.`check_number`;

DELIMITER $$
USE `lms`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `check_number` BEFORE INSERT ON `reader` FOR EACH ROW BEGIN
  declare cnt int;
  declare contact varchar(10);
  declare error_msg varchar(100);
  set cnt = 0;
  set contact = (select new.`contact_no` from `reader`);
  set cnt = (select length(contact));
    
  if cnt <> 10 then
    set error_msg = `Please insert a valid nunber`;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
  end if;    
END$$
DELIMITER ;





DROP TRIGGER IF EXISTS `lms`.`check_number_update`;

DELIMITER $$
USE `lms`$$
CREATE DEFINER = CURRENT_USER TRIGGER `lms`.`check_number_update` BEFORE UPDATE ON `reader` FOR EACH ROW
BEGIN
  declare cnt int;
  declare contact varchar(10);
  declare error_msg varchar(100);
  set cnt = 0;
  set contact = (select new.`contact_no` from `reader`);
  set cnt = (select length(contact));
    
  if cnt <> 10 then
    set error_msg = `Please insert a valid nunber`;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
  end if;    

END$$
DELIMITER ;



-- Email verification
CREATE DEFINER=`root`@`localhost` TRIGGER `check_email_before` BEFORE INSERT ON `reader` FOR EACH ROW begin
	declare email_id varchar(100);
	declare error_msg varchar(100);
	set email_id = (select new.email from `reader`);
	if email_id regexp '^[^@]+@[^@]+\.[^@]{2,}$' then
		set error_msg = `Please enter a valid email address`;
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
	end if;	
end



CREATE DEFINER=`root`@`localhost` TRIGGER `check_email_update` BEFORE UPDATE ON `reader` FOR EACH ROW begin
	declare email_id varchar(100);
	declare error_msg varchar(100);
	set email_id = (select new.email from `reader`);
	if email_id is NOT NULL then
		if email_id regexp '^[^@]+@[^@]+\.[^@]{2,}$' then
			set error_msg = `Please enter a valid email address`;
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
		end if;	
	end if;
end





-- Price can't be negative before insert and update table
DELIMITER $$
USE `lms`$$
CREATE DEFINER = CURRENT_USER TRIGGER `lms`.`check_price_insert` BEFORE INSERT ON `book` FOR EACH ROW
BEGIN
	declare p int;
    declare error_msg varchar(100);
    set p = (select new.price from `book`);
    if p < 0 then
		set error_msg = `Price can't be negative`;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
	end if;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS `lms`.`check_price_UPDATE`;

DELIMITER $$
USE `lms`$$
CREATE DEFINER = CURRENT_USER TRIGGER `lms`.`check_price_UPDATE` BEFORE UPDATE ON `book` FOR EACH ROW
BEGIN
	declare p int;
    declare error_msg varchar(100);
    set p = (select new.price from `book`);
    if p < 0 then
		set error_msg = `Price can't be negative`;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
	end if;
END$$
DELIMITER ;
