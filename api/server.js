const express = require('express');
const mysql = require('mysql2');
const notesRoutes = require('./routes/notes');

const app = express();
app.use(express.json());

const db = mysql.createConnection({
    host: 'localhost',
    user: 'myuser',
    password: 'mypassword',
    database: 'my_personal_db'
});

db.connect(err => {
    if (err) throw err;
    console.log('MySQL connecté.');
});

app.set('db', db);
app.use('/notes', notesRoutes);

app.listen(3000, () => {
    console.log('API MySQL-perso opérationnelle sur http://localhost:3000');
});
