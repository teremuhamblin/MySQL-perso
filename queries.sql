-- =====================================================================
--  QUERIES.SQL — MySQL-Perso v7.0 CyberDefense Edition
--  Multi-environnements, requêtes durcies, audit, API-ready
-- =====================================================================

-- 0. Mode strict
SET sql_mode = 'STRICT_ALL_TABLES,NO_ENGINE_SUBSTITUTION';

-- 0.1 Contexte environnement (DEV / STAGING / PROD)
SET @env := 'DEV';

-- =====================================================================
-- 1. Sélection dynamique de la base cible
-- =====================================================================
SET @target_db :=
  CASE
    WHEN @env = 'DEV' THEN 'my_personal_db_dev'
    WHEN @env = 'STAGING' THEN 'my_personal_db_staging'
    WHEN @env = 'PROD' THEN 'my_personal_db_prod'
    ELSE 'my_personal_db_dev'
  END;

SET @sql_use := CONCAT('USE ', @target_db, ';');
PREPARE stmt_use FROM @sql_use;
EXECUTE stmt_use;
DEALLOCATE PREPARE stmt_use;

-- =====================================================================
-- 2. Lire toutes les notes (durci + tri + API-ready)
-- =====================================================================
--  Tri par date, index utilisé (idx_created)
SELECT id, title, content, tag, created_at, updated_at
FROM notes
ORDER BY created_at DESC;

-- =====================================================================
-- 3. Lire une note spécifique (durci + audit)
-- =====================================================================
SET @note_id := 1;

SELECT id, title, content, tag, created_at, updated_at
FROM notes
WHERE id = @note_id;

-- Audit CyberDefense
INSERT INTO audit_log (action, note_id, user, ip_address)
VALUES ('READ_NOTE', @note_id, CURRENT_USER(), '127.0.0.1');

-- =====================================================================
-- 4. Modifier une note (durci + mise à jour + audit)
-- =====================================================================
SET @note_id := 1;
SET @new_content := 'Contenu mis à jour.';
SET @new_tag := 'update';

UPDATE notes
SET content = @new_content,
    tag = @new_tag,
    updated_at = CURRENT_TIMESTAMP
WHERE id = @note_id;

-- Audit CyberDefense
INSERT INTO audit_log (action, note_id, user, ip_address)
VALUES ('UPDATE_NOTE', @note_id, CURRENT_USER(), '127.0.0.1');

-- =====================================================================
-- 5. Supprimer une note (durci + audit)
-- =====================================================================
SET @note_id := 1;

DELETE FROM notes
WHERE id = @note_id;

-- Audit CyberDefense
INSERT INTO audit_log (action, note_id, user, ip_address)
VALUES ('DELETE_NOTE', @note_id, CURRENT_USER(), '127.0.0.1');

-- =====================================================================
--  NOTES :
--  - Multi-environnements : DEV / STAGING / PROD.
--  - Requêtes durcies : variables, audit, tri, indexation.
--  - Audit CyberDefense : READ / UPDATE / DELETE.
--  - API-ready : champs tag, updated_at, tri par date.
--  - Compatible CI/CD, Docker, cloud.
-- =====================================================================
