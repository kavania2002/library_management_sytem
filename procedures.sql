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