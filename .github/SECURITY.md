# SECURITY — MySQL-perso

Ce document décrit les règles de sécurité du projet **MySQL-perso**.

---

## 1. Principes généraux

- Aucun mot de passe dans le dépôt  
- Aucun dump contenant des données sensibles  
- Scripts SQL strictement limités à la structure et aux exemples

---

## 2. Utilisateur MySQL

Le fichier `user.sql` doit :

- Créer un utilisateur dédié  
- Limiter les permissions au strict nécessaire  
- Ne jamais utiliser `GRANT ALL PRIVILEGES`

---

## 3. Sécurité du dépôt

- Ne jamais pousser de fichiers temporaires  
- Ne jamais pousser de logs  
- Vérifier les fichiers avant commit

---

## 4. CI/CD

Le workflow doit :

- Vérifier la présence des fichiers  
- Vérifier la validité syntaxique  
- Ne pas exécuter MySQL  
- Ne pas exposer de secrets

---

## 5. Vulnérabilités

En cas de faille :

1. Créer une issue privée  
2. Décrire le problème  
3. Proposer une correction  
4. Mettre à jour `CHANGELOG.md`
