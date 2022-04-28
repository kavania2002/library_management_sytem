-- Searching the Book 
USE `lms`;
DROP procedure IF EXISTS `search_books_title`;

DELIMITER $$
USE `lms`$$
CREATE PROCEDURE `search_books_title` (in book_title varchar(100))

BEGIN
	declare title varchar(200);
    set title = concat('%', book_title);
    set title = concat(title, '%');
    select title;
	select * from `book` where `book`.book_id like title;
END$$

DELIMITER ;





-- If book is available or not
USE `lms`;
DROP procedure IF EXISTS `check_book_availability`;

DELIMITER $$
USE `lms`$$
CREATE PROCEDURE `check_book_availability` (in id varchar(100))

BEGIN
	declare no_of_copies int;
    set no_of_copies = (select copies from `book` where book_id = id);
    if no_of_copies = 0 then
		select false;
	else
		select true;
	end if;
END$$

DELIMITER ;





-- Automatically add in remove/books via 

-- Check when's the due date

-- See past issues

-- Librarians can see per day logs

-- New Arrivals

-- Update personal info

-- Librarian adding new users

-- Find language specific newspaper

-- Find genre specific online res

-- Adding new Librarian