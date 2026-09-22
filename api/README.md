# API — MySQL-Perso

Ce dossier contient l’API de l’application.  
Elle expose les routes permettant de lire, créer, modifier et supprimer des notes.

## Contenu
- **server.js** — Point d’entrée de l’API (Express + connexion MySQL)  
- **routes/notes.js** — Routes REST pour gérer les notes

## Objectif
Fournir une API simple et fonctionnelle pour interagir avec la base MySQL.

## Utilisation
Lancer l’API avec Node.js :  
`node server.js`  
Les routes sont accessibles via `/notes`.
