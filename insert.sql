-- =====================================================================
--  INSERT.SQL — MySQL-Perso v7.0 CyberDefense Edition
--  Multi-environnements, durcissement, idempotence, SecureOps-ready
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
-- 2. Insertions idempotentes (CyberDefense)
-- =====================================================================
--  Chaque insertion vérifie si la note existe déjà.
--  Empêche les doublons en CI/CD, Docker, migrations, etc.

SET @sql_insert1 := CONCAT("
INSERT INTO notes (title, content, tag)
SELECT 'Première note', 'Ceci est ma première note personnelle.', 'info'
WHERE NOT EXISTS (
    SELECT 1 FROM notes WHERE title = 'Première note'
);
");

SET @sql_insert2 := CONCAT("
INSERT INTO notes (title, content, tag)
SELECT 'Courses', 'Acheter du lait, du pain, des œufs.', 'perso'
WHERE NOT EXISTS (
    SELECT 1 FROM notes WHERE title = 'Courses'
);
");

SET @sql_insert3 := CONCAT("
INSERT INTO notes (title, content, tag)
SELECT 'Idée', 'Créer un mini projet MySQL perso v1.0.', 'idee'
WHERE NOT EXISTS (
    SELECT 1 FROM notes WHERE title = 'Idée'
);
");

-- Exécution des insertions
PREPARE stmt_i1 FROM @sql_insert1;
EXECUTE stmt_i1;
DEALLOCATE PREPARE stmt_i1;

PREPARE stmt_i2 FROM @sql_insert2;
EXECUTE stmt_i2;
DEALLOCATE PREPARE stmt_i2;

PREPARE stmt_i3 FROM @sql_insert3;
EXECUTE stmt_i3;
DEALLOCATE PREPARE stmt_i3;

-- =====================================================================
-- 3. Journalisation CyberDefense (audit)
-- =====================================================================
--  Si la table audit_log existe (schema v7.0), on journalise les inserts.

SET @sql_audit := CONCAT("
INSERT INTO audit_log (action, note_id, user, ip_address)
SELECT 'INSERT_NOTE', n.id, CURRENT_USER(), '127.0.0.1'
FROM notes n
WHERE n.title IN ('Première note', 'Courses', 'Idée');
");

PREPARE stmt_audit FROM @sql_audit;
EXECUTE stmt_audit;
DEALLOCATE PREPARE stmt_audit;

-- =====================================================================
--  NOTES :
--  - Multi-environnements : DEV / STAGING / PROD.
--  - Insertions idempotentes : aucun doublon.
--  - Tag ajouté pour API REST v4.0 + PWA v4.0.
--  - Journalisation CyberDefense dans audit_log.
--  - Compatible CI/CD, Docker, cloud.
-- =====================================================================
