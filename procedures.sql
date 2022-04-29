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
USE `lms`;
DROP procedure IF EXISTS `add_books`;

DELIMITER $$
USE `lms`$$
CREATE PROCEDURE `add_books` (in b_book_id varchar(100), in b_isbn varchar(45), in b_title varchar(45), in b_price float, in b_genre varchar(45), in b_edition float, in b_authors varchar(100), in b_language varchar(45), in b_publisher_id int, in b_copies int)
BEGIN
	insert into `add_books`(book_id, isbn, title, price, genre, edition, authors, language, publisher_id, copies) values(b_book_id, b_isbn, b_title, b_price, b_genre, b_edition, b_authors, b_language, b_publisher_id, b_copies);
END$$

DELIMITER ;







-- Check when's the due date
USE `lms`;
DROP procedure IF EXISTS `check_due_date`;

DELIMITER $$
USE `lms`$$
CREATE PROCEDURE `check_due_date` (in id varchar(100))
BEGIN
	declare d_date datetime;
    set d_date = (select `dates`.due_date from `dates`, `book` where `book`.book_id = `dates`.book_id and `dates`.book_id = id);
    select d_date;
END$$

DELIMITER ;






-- See past all of all issues of all users
USE `lms`;
DROP procedure IF EXISTS `check_past_issues`;

DELIMITER $$
USE `lms`$$
CREATE PROCEDURE `check_past_issues` ()
BEGIN
	select `reader`.name, `book`.title, `dates`.issue_date, `dates`.return_date, `dates`.due_date from `reader`, `book`, `dates` where `reader`.user_id = `dates`.user_id and `book`.book_id = `dates`.book_id;
END$$

DELIMITER ;



-- See past issues for specific users
USE `lms`;
DROP procedure IF EXISTS `issues_by_users`;

DELIMITER $$
USE `lms`$$
CREATE PROCEDURE `issues_by_users` (in id varchar(100))
BEGIN
	select `book`.title, `reader`.name, `dates`.issue_date, `dates`.due_date, `dates`.return_date from `book`, `reader`, `dates` where `dates`.book_id = `book`.book_id and `dates`.user_id = `reader`.user_id and `reader`.user_id = id;
END$$

DELIMITER ;





-- Librarians can see per day logs

USE `lms`;
DROP procedure IF EXISTS `current_date_log`;

DELIMITER $$
USE `lms`$$
CREATE PROCEDURE `current_date_log` ()
BEGIN
	declare today date;
    set today = (select curdate());
	select `reader`.name, `book`.title, `book`.authors from `reader`, `book`, `dates` where `dates`.issue_date = today and `dates`.user_id = `reader`.user_id and `dates`.book_id = `book`.book_id;
END$$

DELIMITER ;





-- New Arrivals
USE `lms`;
DROP procedure IF EXISTS `find_new_arrivals`;

DELIMITER $$
USE `lms`$$
CREATE PROCEDURE `find_new_arrivals` ()
BEGIN
	declare today, prevDay date;
    set today = curdate();
    set prevDay = (select date_sub(today, interval 7 day));
    select `admin`.title, `book`.authors, `book`.language from `admin`, `book` where (`admin`.published_date between prevDay and today) and `admin`.title = `book`.title;
END$$

DELIMITER ;






-- Update personal info


-- Librarian adding new users

-- Find language specific newspaper

-- Find genre specific online res

-- Adding new Librarian