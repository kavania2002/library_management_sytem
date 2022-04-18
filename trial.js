import express from "express";
import mysql from "mysql";
// require('dotenv').config({path:__dirname+'/./../../.env'})
import dotenv from "dotenv";
dotenv.config();


let connection = mysql.createConnection({
    host: 'localhost',
    user: process.env.user,
    password: process.env.password,
    database: process.env.db
});

let a = 5;

connection.connect();

// connection.query('select * from sample', (error, results, fields) => {
//     if (error) throw error;
//     console.log(results[0]);
//     const result = Object.values(JSON.parse(JSON.stringify(results)));
//     console.log(result);
// });


connection.end();