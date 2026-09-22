/***********************************************************************
 *  server.js — MySQL-Perso v7.0 CyberDefense Edition
 *  Durcissement API, multi-environnements, audit, SecureOps, Zero-Trust
 ***********************************************************************/

const express = require('express');
const mysql = require('mysql2');
const notesRoutes = require('./routes/notes');
const fs = require('fs');

// =====================================================
// 1. Chargement SecureOps v7.0
// =====================================================
const secureOps = JSON.parse(
    fs.readFileSync('./secureops/secureops.conf.json', 'utf8')
);

// Mode strict API
const READ_ONLY = secureOps.readonly === true;
const RATE_LIMIT = secureOps.rate_limit || 25;

// =====================================================
// 2. Multi-environnements (DEV / STAGING / PROD)
// =====================================================
const ENV = process.env.APP_ENV || 'DEV';

const DB_NAME =
    ENV === 'DEV' ? 'my_personal_db_dev' :
    ENV === 'STAGING' ? 'my_personal_db_staging' :
    ENV === 'PROD' ? 'my_personal_db_prod' :
    'my_personal_db_dev';

// =====================================================
// 3. Connexion MySQL durcie
// =====================================================
const db = mysql.createPool({
    host: 'localhost',
    user: 'myuser',
    password: 'ChangeThisPassword!2026',
    database: DB_NAME,
    connectionLimit: 10,
    charset: 'utf8mb4'
});

// Vérification connexion
db.getConnection((err, conn) => {
    if (err) {
        console.error('[ERREUR] Impossible de se connecter à MySQL :', err);
        process.exit(1);
    }
    console.log(`[OK] MySQL connecté sur base : ${DB_NAME}`);
    conn.release();
});

// =====================================================
// 4. Initialisation API Express
// =====================================================
const app = express();
app.use(express.json());

// =====================================================
// 5. Anti-scan / Anti-abuse (limiteur simple)
// =====================================================
let requestCounter = 0;
setInterval(() => { requestCounter = 0; }, 60000);

app.use((req, res, next) => {
    requestCounter++;
    if (requestCounter > RATE_LIMIT) {
        return res.status(429).json({
            error: 'Rate limit exceeded — SecureOps v7.0'
        });
    }
    next();
});

// =====================================================
// 6. Mode lecture seule (READ_ONLY)
// =====================================================
app.use((req, res, next) => {
    if (READ_ONLY && ['POST', 'PUT', 'PATCH', 'DELETE'].includes(req.method)) {
        return res.status(403).json({
            error: 'Mode lecture seule activé — SecureOps v7.0'
        });
    }
    next();
});

// =====================================================
// 7. Injection de la DB dans les routes
// =====================================================
app.set('db', db);
app.use('/notes', notesRoutes);

// =====================================================
// 8. Démarrage API
// =====================================================
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`API MySQL-Perso v7.0 opérationnelle sur http://localhost:${PORT}`);
});
