---

# 🧱 **schema.sql**  
*(création de la base + table)*

```sql
-- Création de la base
CREATE DATABASE IF NOT EXISTS my_personal_db;
USE my_personal_db;

-- Table des notes
CREATE TABLE IF NOT EXISTS notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
