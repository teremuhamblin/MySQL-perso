-- Création d'un utilisateur MySQL dédié
CREATE USER IF NOT EXISTS 'myuser'@'localhost' IDENTIFIED BY 'mypassword';

-- Donner les droits sur la base
GRANT ALL PRIVILEGES ON my_personal_db.* TO 'myuser'@'localhost';

FLUSH PRIVILEGES;
