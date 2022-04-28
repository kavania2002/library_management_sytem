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
CREATE DEFINER = CURRENT_USER TRIGGER `lms`.`check_if_issued` BEFORE INSERT ON `dates` FOR EACH ROW
BEGIN
	declare rt datetime;
	declare error_msg varchar(200);
	set rt = (select return_date from `table` where new.book_id = book_id);
	if rt is NOT NULL then
		set error_msg = `One student can issue only one book at a time`;
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
	end if;	
END$$
DELIMITER ;

-- No of copies deduce/increase



-- Throwing error if all the books are issued
DROP TRIGGER IF EXISTS `lms`.`check_copies`;

DELIMITER $$
USE `lms`$$
CREATE DEFINER = CURRENT_USER TRIGGER `lms`.`check_copies` AFTER INSERT ON `dates` FOR EACH ROW
BEGIN
	declare no_of_copies int;
    declare error_msg varchar(200);
    set no_of_copies = (select `book`.copies from `book` where `book`.book_id = new.book_id);
    if no_of_copies=0 then
		set error_msg = `The book is not available right now`;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
	end if;
END$$
DELIMITER ;


-- Insert into publisher table while adding new books


-- Error checking in contact no


-- Email verification


-- Price can't be negative



