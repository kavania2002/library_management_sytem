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



-- Not more than 1 book in reports table


-- No of copies deduce/increase


-- Insert into publisher table while adding new books


-- Error checking in contact no


-- Email verification


-- Price can't be negative



