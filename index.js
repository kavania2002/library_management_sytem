const cors = require('cors');

const express = require("express");

const app = express();
app.use(cors({
    origin: 'http://localhost:3000',
    credentials: true
  }));
  
const booksR = require("./routes/books");
app.use('/books', booksR);

const readersR = require("./routes/readers");
app.use('/readers', readersR);

app.listen(8000, ()=> {
    console.log("Server running at http://localhost:8000/");
});

