const dotenv = require("dotenv");
dotenv.config();

const mysql = require("mysql");

let connection = mysql.createConnection({
    host: 'localhost',
    user: process.env.user,
    password: process.env.password,
    database: process.env.db
});

connection.connect();

module.exports = connection;