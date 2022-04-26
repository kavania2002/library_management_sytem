const express = require("express");
const router = express.Router();

var connection = require("../connection");

router.get("/all", (req, res) => {
  connection.query("select * from book", (error, results, fields) => {
    if (error) throw error;
    console.log(results[0]);
    const result = resultConvert(results);
    res.send(resultConvert(results));
  });
});

function resultConvert(input) {
  const result = Object.values(JSON.parse(JSON.stringify(input)));
  console.log(result);
  return result;
}

module.exports = router;
