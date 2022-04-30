const express = require("express");
const bodyParser = require('body-parser');


const app = express();

const booksR = require("./routes/books");
app.use('/books', booksR);

const readersR = require("./routes/readers");
app.use('/readers', readersR);

const datesR = require("./routes/dates");
app.use('/dates', datesR);

app.listen(8000, ()=> {
    console.log("Server running at http://localhost:8000/");
});