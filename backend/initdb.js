const mysql = require("mysql2");
const fs = require("fs");
const path = require("path");
require("dotenv").config();

const useUrl = !!process.env.MYSQL_PUBLIC_URL;
const connectionSource = useUrl ? process.env.MYSQL_PUBLIC_URL : {
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  ssl: process.env.DB_SSL === "false" ? false : { rejectUnauthorized: false },
};

const sqlFilePath = path.join(__dirname, "init.sql");
if (!fs.existsSync(sqlFilePath)) {
  console.log("No init.sql found, skipping DB initialization.");
  process.exit(0);
}

let sql = fs.readFileSync(sqlFilePath, "utf-8");

// Remove all SQL comments correctly
sql = sql.replace(/--.*$/gm, ""); // removes single line comments

const db = mysql.createConnection(connectionSource);

db.connect(async (err) => {
  if (err) {
    console.error("Could not connect to database:", err.message);
    process.exit(1);
  }
  console.log("Connected to Railway MySQL. Running initialization...");

  const statements = sql
    .split(";")
    .map(s => s.trim())
    .filter(s => s.length > 0);

  let successCount = 0;
  for (let statement of statements) {
    try {
      await db.promise().query(statement);
      successCount++;
    } catch (err2) {
      if (err2.code === "ER_TABLE_EXISTS_ERROR" || err2.code === "ER_DUP_ENTRY") {
        // Safe to ignore
      } else {
        console.error("Init error on statement:", statement.substring(0, 50) + "...");
        console.error("Error details:", err2.message);
      }
    }
  }

  console.log(`Database initialization complete. Ran ${successCount} statements.`);
  db.end();
});
