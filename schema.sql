-- =====================================================================
--  SCHEMA.SQL — MySQL-Perso v7.0 CyberDefense Edition
--  Multi-environnements, durcissement structurel, indexation, Zero-Trust
-- =====================================================================

-- 0. Mode strict + sécurité
SET sql_mode = 'STRICT_ALL_TABLES,NO_ENGINE_SUBSTITUTION';

-- 0.1 Contexte environnement (DEV / STAGING / PROD)
SET @env := 'DEV';

-- =====================================================================
-- 1. Création des bases par environnement
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

-- Base cible dynamique
SET @target_db :=
  CASE
    WHEN @env = 'DEV' THEN 'my_personal_db_dev'
    WHEN @env = 'STAGING' THEN 'my_personal_db_staging'
    WHEN @env = 'PROD' THEN 'my_personal_db_prod'
    ELSE 'my_personal_db_dev'
  END;

-- Sélection dynamique de la base
SET @sql_use := CONCAT('USE ', @target_db, ';');
PREPARE stmt_use FROM @sql_use;
EXECUTE stmt_use;
DEALLOCATE PREPARE stmt_use;

-- =====================================================================
-- 2. Table des notes (durcie CyberDefense)
-- =====================================================================
SET @sql_notes := CONCAT("
CREATE TABLE IF NOT EXISTS notes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    -- Titre limité, indexé pour recherche rapide
    title VARCHAR(150) NOT NULL,

    -- Contenu textuel, utf8mb4 complet
    content TEXT NOT NULL,

    -- Tag optionnel pour API REST v4.0
    tag VARCHAR(50) DEFAULT NULL,

    -- Date de création
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Date de mise à jour
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Index pour recherche rapide
    INDEX idx_title (title),
    INDEX idx_tag (tag),
    INDEX idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
");

PREPARE stmt_notes FROM @sql_notes;
EXECUTE stmt_notes;
DEALLOCATE PREPARE stmt_notes;

-- =====================================================================
-- 3. Table audit (CyberDefense)
-- =====================================================================
SET @sql_audit := CONCAT("
CREATE TABLE IF NOT EXISTS audit_log (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(100) NOT NULL,
    note_id INT UNSIGNED DEFAULT NULL,
    user VARCHAR(100) DEFAULT NULL,
    ip_address VARCHAR(45) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_action (action),
    INDEX idx_note (note_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
");

PREPARE stmt_audit FROM @sql_audit;
EXECUTE stmt_audit;
DEALLOCATE PREPARE stmt_audit;

-- =====================================================================
--  NOTES :
--  - Multi-environnements : DEV / STAGING / PROD gérés dynamiquement.
--  - Indexation avancée pour API REST + PWA v4.0.
--  - Table audit pour CyberDefense (traçabilité).
--  - Mode strict activé pour cohérence totale.
--  - Compatible CI/CD, Docker, cloud.
-- =====================================================================
