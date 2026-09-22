-- =====================================================================
--  USER.SQL — MySQL-Perso v7.0 CyberDefense Edition
--  Rôles, séparation des privilèges, Zero-Trust, multi-environnements,
--  durcissement CyberDefense + préparation SecureOps
-- =====================================================================

-- 0. Mode strict + durcissement global
SET sql_mode = 'STRICT_ALL_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
SET default_authentication_plugin = 'mysql_native_password';

-- 0.1 Contexte environnement (DEV / STAGING / PROD)
--     À piloter via variable externe (CI/CD, script, etc.)
--     Exemple : SET @env := 'DEV';
SET @env := 'DEV';

-- =====================================================================
-- 1. Création des bases par environnement (optionnel)
-- =====================================================================
CREATE DATABASE IF NOT EXISTS my_personal_db_dev
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE DATABASE IF NOT EXISTS my_personal_db_staging
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE DATABASE IF NOT EXISTS my_personal_db_prod
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- Base cible dynamique selon l’environnement
SET @target_db :=
  CASE
    WHEN @env = 'DEV' THEN 'my_personal_db_dev'
    WHEN @env = 'STAGING' THEN 'my_personal_db_staging'
    WHEN @env = 'PROD' THEN 'my_personal_db_prod'
    ELSE 'my_personal_db_dev'
  END;

-- =====================================================================
-- 2. Suppression propre des rôles et utilisateurs (idempotence CI/CD)
-- =====================================================================
DROP ROLE IF EXISTS 'role_reader';
DROP ROLE IF EXISTS 'role_writer';
DROP ROLE IF EXISTS 'role_admin';

DROP USER IF EXISTS 'myuser'@'localhost';

-- =====================================================================
-- 3. Création des rôles (séparation des privilèges CyberDefense)
-- =====================================================================

-- Rôle lecteur : lecture seule
CREATE ROLE 'role_reader';

-- Rôle writer : lecture + écriture
CREATE ROLE 'role_writer';

-- Rôle admin : opérations structurelles (strictement contrôlé)
CREATE ROLE 'role_admin';

-- Attribution des privilèges aux rôles sur la base cible
SET @sql_reader := CONCAT('GRANT SELECT ON ', @target_db, '.* TO ''role_reader'';');
SET @sql_writer := CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ', @target_db, '.* TO ''role_writer'';');
SET @sql_admin  := CONCAT('GRANT CREATE, DROP, INDEX, ALTER ON ', @target_db, '.* TO ''role_admin'';');

PREPARE stmt_reader FROM @sql_reader;
EXECUTE stmt_reader;
DEALLOCATE PREPARE stmt_reader;

PREPARE stmt_writer FROM @sql_writer;
EXECUTE stmt_writer;
DEALLOCATE PREPARE stmt_writer;

PREPARE stmt_admin FROM @sql_admin;
EXECUTE stmt_admin;
DEALLOCATE PREPARE stmt_admin;

-- =====================================================================
-- 4. Création de l’utilisateur dédié (durci CyberDefense)
-- =====================================================================
CREATE USER 'myuser'@'localhost'
IDENTIFIED WITH mysql_native_password BY 'ChangeThisPassword!2026'
REQUIRE NONE
PASSWORD EXPIRE INTERVAL 90 DAY
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LOCK_TIME 2
ACCOUNT UNLOCK;

-- =====================================================================
-- 5. Attribution des rôles à l’utilisateur
-- =====================================================================
-- Par défaut : rôle writer (application)
GRANT 'role_writer' TO 'myuser'@'localhost';

-- Optionnel : activer le rôle admin pour maintenance contrôlée
-- GRANT 'role_admin' TO 'myuser'@'localhost';

-- Rôle lecteur pour API read-only / endpoints publics
-- GRANT 'role_reader' TO 'myuser'@'localhost';

SET DEFAULT ROLE 'role_writer' FOR 'myuser'@'localhost';

-- =====================================================================
-- 6. Zero-Trust global : suppression des privilèges non nécessaires
-- =====================================================================
REVOKE ALL PRIVILEGES, GRANT OPTION
ON *.* FROM 'myuser'@'localhost';

-- =====================================================================
-- 7. Audit & CyberDefense (si composants disponibles)
-- =====================================================================
-- Activation de l’audit des connexions et requêtes
-- INSTALL COMPONENT 'file://component_audit_log';
-- SET GLOBAL audit_log_policy = 'ALL';

-- Journalisation renforcée (si supportée)
-- SET GLOBAL log_error_verbosity = 3;

-- =====================================================================
-- 8. Application des privilèges
-- =====================================================================
FLUSH PRIVILEGES;

-- =====================================================================
--  NOTES CYBERDEFENSE :
--  - @env permet de cibler DEV / STAGING / PROD avec un seul script.
--  - Rôles = séparation stricte des privilèges (reader / writer / admin).
--  - Zero-Trust : aucun privilège global, aucun GRANT OPTION.
--  - Mot de passe à remplacer par un secret réel (vault, CI/CD, .env).
--  - Compatible MySQL 8.x, Docker, GitHub Actions, cloud.
--  - Préparé pour SecureOps, PWA v4.0, API REST v4.0.
-- =====================================================================
