-- =====================================================================
-- File:        12_bonus.sql
-- Project:     SummerTides Festival Database
-- Purpose:     Advanced business questions combining joins, filtering,
--              grouping, and aggregate functions.
-- =====================================================================

USE summertides;

-- 1. Which artist performs the most?
SELECT
    ar.artist_name,
    COUNT(p.performance_id) AS performance_count
FROM artists ar
INNER JOIN performances p ON p.artist_id = ar.artist_id
GROUP BY ar.artist_id, ar.artist_name
ORDER BY performance_count DESC
LIMIT 1;

-- 2. Which stage hosts the highest number of performances?
SELECT
    st.stage_name,
    COUNT(p.performance_id) AS performance_count
FROM stages st
INNER JOIN performances p ON p.stage_id = st.stage_id
GROUP BY st.stage_id, st.stage_name
ORDER BY performance_count DESC
LIMIT 1;

-- 3. Which vendor generated the highest revenue?
SELECT
    v.vendor_name,
    SUM(s.sale_amount) AS total_revenue
FROM vendors v
INNER JOIN sales s ON s.vendor_id = v.vendor_id
GROUP BY v.vendor_id, v.vendor_name
ORDER BY total_revenue DESC
LIMIT 1;

-- 4. Which attendee spent the most money (tickets + vendor sales)?
SELECT
    a.first_name,
    a.last_name,
    COALESCE(ticket_totals.ticket_total, 0)
        + COALESCE(sales_totals.sales_total, 0) AS total_spent
FROM attendees a
LEFT JOIN (
    SELECT attendee_id, SUM(price) AS ticket_total
    FROM tickets
    GROUP BY attendee_id
) AS ticket_totals ON ticket_totals.attendee_id = a.attendee_id
LEFT JOIN (
    SELECT attendee_id, SUM(sale_amount) AS sales_total
    FROM sales
    GROUP BY attendee_id
) AS sales_totals ON sales_totals.attendee_id = a.attendee_id
ORDER BY total_spent DESC
LIMIT 1;

-- 5. Which city has the highest number of attendees?
SELECT
    city,
    COUNT(*) AS attendee_count
FROM attendees
GROUP BY city
ORDER BY attendee_count DESC
LIMIT 1;

-- 6. Which festival day generated the highest ticket revenue?
SELECT
    festival_day,
    SUM(price) AS ticket_revenue
FROM tickets
GROUP BY festival_day
ORDER BY ticket_revenue DESC
LIMIT 1;

-- 7. Which sponsor contributed the most funding?
SELECT
    sponsor_name,
    contribution_amount
FROM sponsors
ORDER BY contribution_amount DESC
LIMIT 1;

-- 8. What is the total expected ticket revenue?
SELECT SUM(price) AS total_expected_ticket_revenue
FROM tickets;

-- 9. Which ticket type was purchased the most?
SELECT
    ticket_type,
    COUNT(*) AS times_purchased
FROM tickets
GROUP BY ticket_type
ORDER BY times_purchased DESC
LIMIT 1;