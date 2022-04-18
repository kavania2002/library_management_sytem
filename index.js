import dotenv from "dotenv";
dotenv.config();

import express from "express";
import mysql from "mysql";

// console.log(process.env.password);

let connection = mysql.createConnection({
    host: 'localhost',
    user: process.env.user,
    password: process.env.password,
    database: process.env.db
});

connection.connect();

// connection.query(`insert into sample values('Yagnesh',25)`, (error, results, fields) => {
//     if (error) console.log(error);
//     console.log(results);
// });

connection.query(`select * from sample`, (error, results, fields) => {
    if (error) console.log(error);
    // console.log(results);
    const result = Object.values(JSON.parse(JSON.stringify(results)));
    console.log(result);
})

connection.end();