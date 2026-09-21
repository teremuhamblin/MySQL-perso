###### README.md >> markdown
# MySQL-perso
- Mini Projet Personnel

>Projet MySQL simple pour stocker des notes personnelles.

### Contenu
```text
- `schema.sql` : création de la base et de la table
- `insert.sql` : exemples d'insertion
- `queries.sql` : requêtes utiles
- `user.sql` : création d'un utilisateur MySQL dédié
```

### Utilisation
1. Importer `schema.sql`
2. Importer `insert.sql` (optionnel)
3. Utiliser `queries.sql` pour lire ou modifier les données
4. Exécuter `user.sql` pour créer un utilisateur MySQL dédié

### Base de données
Nom : `my_personal_db`  
Table : `notes`

### Exemple de note
```sql
INSERT INTO notes (title, content)
VALUES ('Exemple', 'Ceci est une note personnelle.');
```
