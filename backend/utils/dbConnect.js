import mysql from "mysql2";
import dotenv from 'dotenv';
dotenv.config();


// create the connection to database
const db = mysql.createPool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    // socketPath: "/cloudsql/" + process.env.CLOUD_SQL_CONNECTION_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    multipleStatements: true,
    connectionLimit: 20
});

export default db;