USE my_personal_db;

-- Lire toutes les notes
SELECT * FROM notes;

-- Lire une note spécifique
SELECT * FROM notes WHERE id = 1;

-- Modifier une note
UPDATE notes
SET content = 'Contenu mis à jour.'
WHERE id = 1;

-- Supprimer une note
DELETE FROM notes WHERE id = 1;
