const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    const db = req.app.get('db');
    db.query('SELECT * FROM notes', (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

router.get('/:id', (req, res) => {
    const db = req.app.get('db');
    db.query('SELECT * FROM notes WHERE id = ?', [req.params.id], (err, results) => {
        if (err) throw err;
        res.json(results[0] || {});
    });
});

router.post('/', (req, res) => {
    const db = req.app.get('db');
    const { title, content } = req.body;
    db.query('INSERT INTO notes (title, content) VALUES (?, ?)', [title, content], (err, result) => {
        if (err) throw err;
        res.json({ id: result.insertId, title, content });
    });
});

router.put('/:id', (req, res) => {
    const db = req.app.get('db');
    const { title, content } = req.body;
    db.query('UPDATE notes SET title=?, content=? WHERE id=?', [title, content, req.params.id], err => {
        if (err) throw err;
        res.json({ id: req.params.id, title, content });
    });
});

router.delete('/:id', (req, res) => {
    const db = req.app.get('db');
    db.query('DELETE FROM notes WHERE id=?', [req.params.id], err => {
        if (err) throw err;
        res.json({ deleted: req.params.id });
    });
});

module.exports = router;
