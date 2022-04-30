const express = require("express");
const router = express.Router();
var connection = require("../connection");

router.get("/all", (req, res) => {
  connection.query("select * from books", (error, results, fields) => {
    if (error) throw error;
    const result = resultConvert(results);
    res.send(result);
  });
});

router.get("/:title", (req, res) => {
  connection.query("call search_book_title(?)", req.params.title, (error, results, fields) => {
    if (error) console.log(error);
    const result = resultConvert(results);
    res.send(result);
  });
});

router.get("/available/:title", (req, res) => {
  connection.query("call check_book_availability(?)", req.params.title, (error, results, fields) => {
    if (error) console.log(error);
    const result = resultConvert(results);
    res.send(result);
  });
});

router.get("/new", (req, res) => {
  connection.query("call find_new_arrivals()", (error, results, fields) => {
    if (error) console.log(error);
    const result = resultConvert(results);
    res.send(result);
  });
});

function resultConvert(input) {
  const result = Object.values(JSON.parse(JSON.stringify(input)));
  return result;
}

module.exports = router;
