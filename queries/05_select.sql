USE summertides;

SELECT *
FROM attendees;

SELECT *
FROM artists;

SELECT first_name,
         last_name,
         email
FROM attendees

SELECT DISTINCT city
FROM attendees;

SELECT ticket_type,
FROM tickets;

SELECT
    CONCAT(first_name,' ',last_name) AS full_name,
    email AS contact_email,
    city AS home_city
FROM attendees;

SELECT *
FROM vendors;

SELCT *
FROM stages;


