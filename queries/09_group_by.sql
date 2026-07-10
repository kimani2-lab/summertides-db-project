-- =====================================================================
-- File:        09_group_by.sql
-- Project:     SummerTides Festival Database
-- Purpose:     Generate organiser reports using COUNT, SUM, AVG, MIN,
--              MAX, GROUP BY, and HAVING.
-- =====================================================================

USE summertides;

-- 1. How many attendees are registered?
SELECT COUNT(*) AS total_attendees
FROM attendees;

-- 2. What is the average ticket price?
SELECT ROUND(AVG(price), 2) AS average_ticket_price
FROM tickets;

-- 3. What is the highest and lowest ticket price?
SELECT
    MAX(price) AS highest_ticket_price,
    MIN(price) AS lowest_ticket_price
FROM tickets;

-- 4. How many attendees come from each city?
SELECT city, COUNT(*) AS attendee_count
FROM attendees
GROUP BY city
ORDER BY attendee_count DESC;

-- 5. How many artists belong to each genre?
SELECT genre, COUNT(*) AS artist_count
FROM artists
GROUP BY genre
ORDER BY artist_count DESC;

-- 6. What is the total sales amount for each vendor?
SELECT
    v.vendor_name,
    SUM(s.sale_amount) AS total_sales
FROM vendors v
JOIN sales s ON s.vendor_id = v.vendor_id
GROUP BY v.vendor_id, v.vendor_name
ORDER BY total_sales DESC;

-- 7. Which festival day sold the most tickets?
SELECT
    festival_day,
    COUNT(*) AS tickets_sold
FROM tickets
GROUP BY festival_day
ORDER BY tickets_sold DESC;

-- 8. Display only vendors whose total sales exceed 10,000 (HAVING).
SELECT
    v.vendor_name,
    SUM(s.sale_amount) AS total_sales
FROM vendors v
JOIN sales s ON s.vendor_id = v.vendor_id
GROUP BY v.vendor_id, v.vendor_name
HAVING SUM(s.sale_amount) > 10000
ORDER BY total_sales DESC;