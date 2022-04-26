const express = require("express");

const app = express();

const readersR = require("./routes/books");
app.use('/books', readersR);


app.listen(3000, ()=> {
    console.log("Server running at http://localhost:3000/");
});