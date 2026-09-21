# CONTRIBUTING — MySQL-perso

Ce document définit les règles de contribution au projet **MySQL-perso**.  
Objectif : garantir une structure stable, propre et cohérente.

---

## 1. Pré-requis

- Connaissance basique de MySQL
- Respect strict de la structure du dépôt
- Documentation obligatoire pour toute modification

---

## 2. Structure à respecter

Les fichiers principaux :

- `schema.sql`
- `insert.sql`
- `queries.sql`
- `user.sql`
- `docs/` (ROADMAP, CHANGELOG, documentation)
- `.github/workflows/` (CI minimale)

Aucune modification ne doit casser cette structure.

---

## 3. Règles de contribution

1. Justifier chaque changement  
2. Documenter dans `CHANGELOG.md`  
3. Ne pas introduire de dépendances inutiles  
4. Garder les scripts SQL simples, lisibles, commentés  
5. Ne jamais pousser un fichier vide

---

## 4. Processus de contribution

1. Créer une branche dédiée  
2. Effectuer les modifications  
3. Mettre à jour la documentation  
4. Ouvrir une Pull Request  
5. Attendre validation

---

## 5. Style général

- Minimaliste  
- Fonctionnel  
- Militaire : **efficace, sans surplus**
