USE summertides;

-- Show attendees older than 25.
SELECT first_name, last_name, age
FROM attendees
WHERE age > 25;

-- Find attendees from Nairobi.
SELECT first_name, last_name, city
FROM attendees
WHERE city = 'Nairobi';

-- Display VIP tickets only.
SELECT *
FROM tickets
WHERE ticket_type = 'VIP';

SELECT *
FROM tickets
WHERE price > 5000;

SELECT vendor_name, category, rating
FROM vendors
WHERE rating > 4;

SELECT artist_name, genre, country
FROM artists
WHERE country = 'Kenya';

SELECT first_name, last_name
FROM attendees
WHERE first_name LIKE 'A%';

SELECT performance_id,
       artist_id,
       stage_id,
       festival_day,
       start_time,
       end_time
FROM performances
WHERE start_time BETWEEN '18:00:00'
                    AND '22:00:00';

SELECT *
FROM tickets
WHERE purchase_date = '2026-06-15';

SELECT first_name,
       last_name,
       phone
FROM attendees
WHERE phone IS NULL;

SELECT first_name,
       last_name,
       city,
       age
FROM attendees
WHERE city = 'Nairobi'
AND age > 25;

SELECT first_name,
       last_name,
       city
FROM attendees
WHERE city = 'Nairobi'
OR city = 'Mombasa';

SELECT first_name,
       last_name,
       city
FROM attendees
WHERE city IN ('Nairobi', 'Mombasa', 'Kisumu');

SELECT *
FROM tickets
WHERE NOT ticket_type = 'Standard';
