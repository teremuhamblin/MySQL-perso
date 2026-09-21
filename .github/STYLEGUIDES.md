---

STYLEGUIDE.md

`md

STYLEGUIDE — MySQL-perso

Guide de style pour les scripts SQL du projet MySQL-perso.

---

1. Nommage

- Noms de tables : minuscules, simples  
- Noms de colonnes : explicites  
- Pas d’abréviations obscures

Exemple : notes, title, content, created_at

---

2. Structure SQL

- Toujours utiliser IF NOT EXISTS  
- Toujours définir une clé primaire  
- Utiliser TIMESTAMP DEFAULT CURRENT_TIMESTAMP pour les dates  
- Préférer VARCHAR pour les champs courts

---

3. Formatage

- Une instruction par bloc  
- Indentation propre  
- Commentaires courts et utiles

Exemple :

`sql
-- Création de la table des notes
CREATE TABLE IF NOT EXISTS notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    createdat TIMESTAMP DEFAULT CURRENTTIMESTAMP
);
`

---

4. Requêtes

- Préférer les requêtes simples  
- Éviter les sous-requêtes inutiles  
- Documenter les requêtes complexes

---

5. Fichiers

- schema.sql : structure  
- insert.sql : données d’exemple  
- queries.sql : requêtes utiles  
- user.sql : utilisateur MySQL dédié
`

---
