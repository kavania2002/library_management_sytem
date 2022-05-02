const express = require("express");
const router = express.Router();

var connection = require("../connection");

router.get("/logs", (req, res) => {
    connection.query("call check_past_issues()", (error, results, fields) => {
        if (error) console.log(error);
        const result = resultConvert(results[0]);
        res.send(result);
    })
});

router.get("/logs/user/:id", (req, res) => {
    connection.query("call issues_by_users(?)", req.params.id, (error, results, fields) => {
        if (error) console.log(error);
        const result = resultConvert(results);
        res.send(result);
    });
});

router.get("/logs/today", (req, res) => {
    connection.query("call current_date_log()", (error, results, fields) => {
        if (error) console.log(error);
        // console.log(results);
        const result = resultConvert(results);
        res.send(result);
    });
});



function resultConvert(input) {
    const result = Object.values(JSON.parse(JSON.stringify(input)));
    return result;
  }
  
  module.exports = router;