# GUIDELINES — MySQL-perso

Ce document définit les règles internes du projet **MySQL-perso**.  
Il sert de référence pour la structure, la qualité, la maintenance et les contributions.

---

## 1. Structure du projet

Le dépôt doit respecter l’organisation suivante :

- `schema.sql` : création de la base et des tables  
- `insert.sql` : données d’exemple  
- `queries.sql` : requêtes utiles  
- `user.sql` : création de l’utilisateur MySQL dédié  
- `docs/` : documentation (README, ROADMAP, CHANGELOG)  
- `.github/workflows/` : CI minimale pour vérification des fichiers  

Toute modification doit préserver cette structure.

---

## 2. Règles SQL

- Utiliser des noms de tables et colonnes **simples et explicites**  
- Toujours inclure `IF NOT EXISTS` pour éviter les collisions  
- Préférer `VARCHAR` pour les champs textuels courts  
- Utiliser `TIMESTAMP DEFAULT CURRENT_TIMESTAMP` pour les dates automatiques  
- Ne jamais inclure de données sensibles dans les scripts d’insertion  

---

## 3. Documentation

Chaque évolution du projet doit être documentée dans :

- `ROADMAP.md` : planification des versions  
- `CHANGELOG.md` : historique des changements  
- `docs/` : détails techniques si nécessaire  

Les documents doivent rester **courts, clairs, opérationnels**.

---

## 4. Qualité & Maintenance

- Vérifier la cohérence des scripts avant commit  
- Garder les fichiers `.sql` **lisibles et commentés**  
- Ne jamais pousser un fichier vide dans le dépôt  
- Respecter la logique militaire : **simple, efficace, sans surplus**

---

## 5. Contributions

Toute modification doit :

1. Être justifiée  
2. Respecter la structure existante  
3. Être documentée dans le CHANGELOG  
4. Ne pas introduire de dépendances inutiles  

Les contributions doivent rester **minimalistes** pour préserver la nature du projet.

---

## 6. CI/CD

Le workflow GitHub Actions doit :

- Vérifier la présence et la validité des fichiers `.sql`  
- Vérifier la structure du dépôt  
- Ne pas exécuter MySQL (projet léger, sans runtime)  

Les workflows doivent rester **simples et stables**.

---

## 7. Versioning

Le projet suit une version logique :

- v1.x : base SQL minimale  
- v2.x : documentation complète  
- v3.x : CI/CD et structure professionnelle  
- v4.x : API + dashboard (si activé)

Chaque version doit être décrite dans le CHANGELOG.

---

## 8. Objectif du projet

Fournir un **mini‑système MySQL personnel**, propre, stable, réutilisable, sans dépendances lourdes.  
Le projet doit rester **compact**, **compréhensible**, et **opérationnel** pour tout usage personnel ou formation.
