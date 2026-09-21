# Documentation API — MySQL-perso v4.0

## Base URL
`http://localhost:3000`

## Endpoints

### GET /notes
Retourne toutes les notes.

### GET /notes/:id
Retourne une note spécifique.

### POST /notes
Ajoute une note.
Body :
```json
{ "title": "Titre", "content": "Contenu" }
`

PUT /notes/:id
Modifie une note.

DELETE /notes/:id
Supprime une note.
`

---
