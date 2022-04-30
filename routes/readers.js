const express = require("express");
const router = express.Router();

var connection = require("../connection");

router.get("/all", (req, res) => {
  connection.query("select * from reader", (error, results, fields) => {
    if (error) throw error;
    const result = resultConvert(results);
    res.send(result);
  });
});

router.get("/check_due/:id", (req, res) => {

  connection.query("call (?)", req.params.id, (error, results, fields) => {
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
