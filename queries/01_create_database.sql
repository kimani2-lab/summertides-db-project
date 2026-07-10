-- Drop the database first so this script can be re-run safely without
-- manual cleanup (useful while developing/testing the project).
DROP DATABASE IF EXISTS summertides;

-- Create the database that will hold every table for the festival.
CREATE DATABASE summertides
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- Switch into the new database so all following scripts run inside it.
USE summertides;

-- Verify that the database was created and is currently selected.
-- (Running this manually in a client should return "summertides".)
SELECT DATABASE() AS current_database;

-- Verify the database appears in the server's list of databases.
SHOW DATABASES LIKE 'summertides';