const express = require("express");
const router = express.Router();

var connection = require("../connection");

router.get("/all", (req, res) => {
  connection.query("select * from book", (error, results, fields) => {
    if (error) throw error;
    const result = resultConvert(results);
    res.send(resultConvert(results));
  });
});

function resultConvert(input) {
  const result = Object.values(JSON.parse(JSON.stringify(input)));
  return result;
}

module.exports = router;

// CREATE DEFINER=`root`@`localhost` TRIGGER `check_number` BEFORE INSERT ON `reader` FOR EACH ROW BEGIN
// 	declare contact, cnt int;
//     declare error_msg varchar(100);
//     set cnt = 0;
// 	set contact = (select new.`contact_no` from `reader`);
//     while contact > 0 do
// 		set cnt = cnt + 1;
//         set contact = contact/10;
//     end while;
    
//     if cnt <> 5 then
// 		set error_msg = `Please insert a valid number`;
//         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_msg;
//     end if;    
// END