###### README.md
---

[![MySQL-Perso CI](https://github.com/teremuhamblin/MySQL-perso/actions/workflows/ci.yml/badge.svg)](https://github.com/teremuhamblin/MySQL-perso/actions/workflows/ci.yml)

---
# MySQL-perso
- Version 4.0 
- Personal Data Core v4.0
---
- Système MySQL personnel évolué, conçu pour stocker, consulter et gérer des notes avec une architecture extensible.  
- Version 4.0 : ajout d’une API REST, d’un Dashboard Web minimal, d’un mode SecureOps, d’une documentation avancée et d’un pipeline CI/CD renforcé.
---

### 🎯 Mission & Objectifs
```md
MySQL‑perso v4.0 devient un mini‑système complet, capable de :
- Stocker des notes personnelles dans une base MySQL stable  
- Exposer une API REST pour interagir avec les données  
- Fournir un Dashboard Web simple (HTML/PWA)  
- Intégrer un mode SecureOps pour durcir l’accès  
- Maintenir une structure professionnelle compatible GitHub Actions  
- Préparer l’évolution vers une version 5.0 modulaire
```
---

[![pages-build-deployment](https://github.com/teremuhamblin/MySQL-perso/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/teremuhamblin/MySQL-perso/actions/workflows/pages/pages-build-deployment)

---
### 🗄️ Base de données
```sql
- Nom ; **mypersonal.db**
- Table principale : **notes**
```
- Structure
```sql
CREATE TABLE notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    createdat TIMESTAMP DEFAULT CURRENTTIMESTAMP
);
```
### 📝 Exemple d’insertion
```sql
INSERT INTO notes (title, content)
VALUES ('Exemple', 'Ceci est une note personnelle.');
```
### 🔌 API REST (v4.0)
- Endpoints principaux
```text
GET    /notes          # Liste des notes
GET    /notes/:id      # Récupérer une note
POST   /notes          # Ajouter une note
PUT    /notes/:id      # Modifier une note
DELETE /notes/:id      # Supprimer une note
```
- Exemple de requête
```bash
curl -X POST http://localhost:3000/notes \
     -H "Content-Type: application/json" \
     -d '{"title":"Test","content":"Note via API"}'
```
### 📊 Dashboard Web (v4.0)
- Le dossier `dashboard/` contient :
```md
   - Une interface HTML minimaliste  
   - Un script JS pour appeler l’API  
   - Un style CSS simple  
   - Une version PWA optionnelle (préparée pour v5.0)
```
- Fonctionnalités :
```md
   - Affichage des notes  
   - Ajout / suppression  
   - Rafraîchissement automatique  
   - Mode sombre (optionnel)
```
### 🛡️ SecureOps Mode (v4.0)
- Le fichier **secureops/secureops.conf** permet :
```text
   - Restriction IP  
   - Limitation des requêtes API  
   - Désactivation des routes sensibles  
   - Mode lecture seule  
   - Protection anti‑scan basique  
```
### 🚀 CI/CD — GitHub Actions (v4.0)
- **ci.yml**

![CI](https://img.shields.io/badge/CI-GitHub_Actions-success?logo=githubactions)
![Lint](https://img.shields.io/badge/Markdown-Linting-success)
![Build](https://img.shields.io/badge/Build-Pass-success)
![Release](https://img.shields.io/badge/Release-Automated-success)
```text
   - Vérification syntaxique SQL  
   - Lint Markdown  
   - Lint JavaScript API + Dashboard  
   - Vérification structure du projet  
   - Pipeline stable sans dépendances externes
```
- **pages-build-deployment**

![Schema](https://img.shields.io/badge/SQL-Schema-success)
![Inserts](https://img.shields.io/badge/SQL-Inserts-success)
![Queries](https://img.shields.io/badge/SQL-Queries-success)
![Users](https://img.shields.io/badge/SQL-Users-success)
```md
   - Déploiement automatique du Dashboard Web
```

---
### 📈 Autres
- Voir les fichiers :
```md
MySQL-perso/Docs/
     - ROADMAP.md
     - CHANGELOG.md
```
