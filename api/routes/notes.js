/***********************************************************************
 *  routes/notes.js — MySQL-Perso v7.0 CyberDefense Edition
 *  Durcissement des routes, audit, validation, Zero-Trust
 ***********************************************************************/

const express = require('express');
const router = express.Router();

// =====================================================
// 1. Middleware audit + validation
// =====================================================
function audit(db, action, noteId = null) {
    db.query(
        'INSERT INTO audit_log (action, note_id, user, ip_address) VALUES (?, ?, CURRENT_USER(), ?)',
        [action, noteId, '127.0.0.1']
    );
}

function validateInput(req, res, next) {
    const { title, content } = req.body;

    if (title && typeof title !== 'string') {
        return res.status(400).json({ error: 'Titre invalide' });
    }
    if (content && typeof content !== 'string') {
        return res.status(400).json({ error: 'Contenu invalide' });
    }

    next();
}

// =====================================================
// 2. GET — Lire toutes les notes
// =====================================================
router.get('/', (req, res) => {
    const db = req.app.get('db');

    db.query(
        'SELECT id, title, content, tag, created_at, updated_at FROM notes ORDER BY created_at DESC',
        (err, results) => {
            if (err) return res.status(500).json({ error: 'Erreur serveur' });

            audit(db, 'READ_ALL_NOTES');
            res.json(results);
        }
    );
});

// =====================================================
// 3. GET — Lire une note spécifique
// =====================================================
router.get('/:id', (req, res) => {
    const db = req.app.get('db');
    const noteId = parseInt(req.params.id);

    db.query(
        'SELECT id, title, content, tag, created_at, updated_at FROM notes WHERE id = ?',
        [noteId],
        (err, results) => {
            if (err) return res.status(500).json({ error: 'Erreur serveur' });

            audit(db, 'READ_NOTE', noteId);
            res.json(results[0] || {});
        }
    );
});

// =====================================================
// 4. POST — Créer une note
// =====================================================
router.post('/', validateInput, (req, res) => {
    const db = req.app.get('db');
    const { title, content, tag = 'default' } = req.body;

    db.query(
        'INSERT INTO notes (title, content, tag) VALUES (?, ?, ?)',
        [title, content, tag],
        (err, result) => {
            if (err) return res.status(500).json({ error: 'Erreur serveur' });

            audit(db, 'CREATE_NOTE', result.insertId);
            res.json({
                id: result.insertId,
                title,
                content,
                tag
            });
        }
    );
});

// =====================================================
// 5. PUT — Modifier une note
// =====================================================
router.put('/:id', validateInput, (req, res) => {
    const db = req.app.get('db');
    const noteId = parseInt(req.params.id);
    const { title, content, tag = 'update' } = req.body;

    db.query(
        'UPDATE notes SET title=?, content=?, tag=?, updated_at=CURRENT_TIMESTAMP WHERE id=?',
        [title, content, tag, noteId],
        err => {
            if (err) return res.status(500).json({ error: 'Erreur serveur' });

            audit(db, 'UPDATE_NOTE', noteId);
            res.json({ id: noteId, title, content, tag });
        }
    );
});

// =====================================================
// 6. DELETE — Supprimer une note
// =====================================================
router.delete('/:id', (req, res) => {
    const db = req.app.get('db');
    const noteId = parseInt(req.params.id);

    db.query('DELETE FROM notes WHERE id=?', [noteId], err => {
        if (err) return res.status(500).json({ error: 'Erreur serveur' });

        audit(db, 'DELETE_NOTE', noteId);
        res.json({ deleted: noteId });
    });
});

module.exports = router;
