USE summertides;

SELECT
    ticket_id,
    ticket_type,
    price,
    CASE
        WHEN price < 4000 THEN 'Budget'
        WHEN price < 9000 THEN 'Standard'
        ELSE 'VIP'
    END AS price_category
FROM tickets;

SELECT
    first_name,
    last_name,
    age,
    CASE
        WHEN age < 25 THEN 'Youth'
        WHEN age BETWEEN 25 AND 40 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group
FROM attendees;

SELECT
    vendor_name,
    rating,
    CASE
        WHEN rating >= 4.5 THEN 'Excellent'
        WHEN rating >= 3.5 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS rating_category
FROM vendors;

SELECT
    artist_name,
    country,
    CASE
        WHEN country = 'Kenya' THEN 'Local'
        ELSE 'International'
    END AS artist_origin
FROM artists;