USE summertides;

-- Display attendees alphabetically.
SELECT first_name, last_name
FROM attendees
ORDER BY last_name ASC, first_name ASC;

-- Show artists ordered by genre.
SELECT artist_name, genre
FROM artists
ORDER BY genre ASC;

SELECT vendor_name, rating
FROM vendors
ORDER BY rating DESC;

SELECT ticket_id,
       attendee_id,
       ticket_type,
       price
FROM tickets
ORDER BY price DESC
LIMIT 5;

SELECT first_name,
       last_name,
       registration_date
FROM attendees
ORDER BY registration_date ASC
LIMIT 10;

SELECT ticket_id,
       attendee_id,
       purchase_date
FROM tickets
ORDER BY purchase_date DESC
LIMIT 10;

SELECT vendor_name,
       rating
FROM vendors
ORDER BY rating DESC
LIMIT 3;

SELECT vendor_name,
       rating
FROM vendors
ORDER BY rating DESC
LIMIT 2 OFFSET 3;