const express = require('express');

const app = express();

app.get('/home', (req, res) => res.json(require('./data/home.js')()));
app.get('/book/[0-9]+', (req, res) => res.json(require('./data/book_detail.js')()));

app.listen(3000, () => console.log('Example app listening on port 3000!'));