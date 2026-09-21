###### README.md
# MySQL-perso
- Version 4.0 
- Personal Data Core v4.0

> Système MySQL personnel évolué, conçu pour stocker, consulter et gérer des notes avec une architecture extensible.  
> Version 4.0 : ajout d’une API REST, d’un Dashboard Web minimal, d’un mode SecureOps, d’une documentation avancée et d’un pipeline CI/CD renforcé.

---

### 🎯 Mission & Objectifs
MySQL‑perso v4.0 devient un mini‑système complet, capable de :
- Stocker des notes personnelles dans une base MySQL stable  
- Exposer une API REST pour interagir avec les données  
- Fournir un Dashboard Web simple (HTML/PWA)  
- Intégrer un mode SecureOps pour durcir l’accès  
- Maintenir une structure professionnelle compatible GitHub Actions  
- Préparer l’évolution vers une version 5.0 modulaire

---

📦 Contenu du projet
`
mysql-perso/
├── schema.sql                # Création de la base + table
├── insert.sql                # Exemples d'insertion
├── queries.sql               # Requêtes utiles
├── user.sql                  # Création d'un utilisateur MySQL dédié
├── api/
│   ├── server.js             # API REST Node.js
│   └── routes/
│       └── notes.js          # Routes CRUD
├── dashboard/
│   ├── index.html            # Dashboard Web minimal
│   ├── app.js                # Logique front
│   └── style.css             # Interface simple
├── secureops/
│   └── secureops.conf        # Paramètres de durcissement
├── docs/
│   ├── api.md                # Documentation API
│   └── database.md           # Documentation SQL
└── .github/
    └── workflows/
        ├── ci.yml            # CI renforcée
        └── pages.yml         # Déploiement GitHub Pages
`

---

🗄️ Base de données

Nom
mypersonaldb

Table principale
notes

Structure
`sql
CREATE TABLE notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    createdat TIMESTAMP DEFAULT CURRENTTIMESTAMP
);
`

---

📝 Exemple d’insertion
`sql
INSERT INTO notes (title, content)
VALUES ('Exemple', 'Ceci est une note personnelle.');
`

---

🔌 API REST (v4.0)

Endpoints principaux
`
GET    /notes          # Liste des notes
GET    /notes/:id      # Récupérer une note
POST   /notes          # Ajouter une note
PUT    /notes/:id      # Modifier une note
DELETE /notes/:id      # Supprimer une note
`

Exemple de requête
`bash
curl -X POST http://localhost:3000/notes \
     -H "Content-Type: application/json" \
     -d '{"title":"Test","content":"Note via API"}'
`

---

📊 Dashboard Web (v4.0)

Le dossier dashboard/ contient :

- Une interface HTML minimaliste  
- Un script JS pour appeler l’API  
- Un style CSS simple  
- Une version PWA optionnelle (préparée pour v5.0)

Fonctionnalités :

- Affichage des notes  
- Ajout / suppression  
- Rafraîchissement automatique  
- Mode sombre (optionnel)

---

🛡️ SecureOps Mode (v4.0)

Le fichier secureops/secureops.conf permet :

- Restriction IP  
- Limitation des requêtes API  
- Désactivation des routes sensibles  
- Mode lecture seule  
- Protection anti‑scan basique  

Ce mode est inspiré de tes standards BISAT.

---

🚀 CI/CD — GitHub Actions (v4.0)

ci.yml
- Vérification syntaxique SQL  
- Lint Markdown  
- Lint JavaScript API + Dashboard  
- Vérification structure du projet  
- Pipeline stable sans dépendances externes

pages-build-deployment
- Déploiement automatique du Dashboard Web

---

📈 Roadmap (v1.0 → v4.0)

v1.0 — Fondation
- Scripts SQL de base  
- README minimal  

v2.0 — Consolidation
- README structuré  
- CI minimal  
- JSON d’exemple  

v3.0 — Professionnalisation
- README complet  
- Badges CI/CD  
- Structure propre  
- Documentation avancée  

v4.0 — Système complet
- API REST Node.js  
- Dashboard Web  
- SecureOps Mode  
- Documentation API + SQL  
- CI/CD renforcé  
- Préparation PWA  

---

📜 Changelog (Résumé)

v4.0
- Ajout API REST  
- Ajout Dashboard Web  
- Ajout SecureOps Mode  
- Documentation API + SQL  
- CI/CD renforcé  
- README v4.0 complet  

v3.0
- Réécriture complète du README  
- Badges CI/CD  
- Structure de projet finalisée  

v2.0
- Ajout JSON  
- CI minimal  

v1.0
- Création du projet  

---

🔭 Prochaine étape (v5.0)

- Passage en PWA complète  
- Authentification JWT  
- Chiffrement des notes  
- Mode hors‑ligne  
- Export/Import crypté  
- Intégration AppCommon v1.0  
- Module BISAT‑OSINT (optionnel)

---
