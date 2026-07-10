-- =====================================================================
-- File:        10_joins.sql
-- Project:     SummerTides Festival Database
-- Purpose:     Combine information across multiple tables using
--              INNER JOIN, LEFT JOIN, and multi-table joins.
-- =====================================================================

USE summertides;

-- 1. Display attendees together with their ticket information.
SELECT
    a.first_name,
    a.last_name,
    t.ticket_type,
    t.price,
    t.festival_day
FROM attendees a
INNER JOIN tickets t ON t.attendee_id = a.attendee_id
ORDER BY a.last_name;

-- 2. Show artists and the stages where they perform.
SELECT DISTINCT
    ar.artist_name,
    s.stage_name
FROM artists ar
INNER JOIN performances p ON p.artist_id = ar.artist_id
INNER JOIN stages s ON s.stage_id = p.stage_id
ORDER BY ar.artist_name;

-- 3. Display every performance together with the artist name and stage name.
SELECT
    p.performance_id,
    ar.artist_name,
    s.stage_name,
    p.festival_day,
    p.start_time,
    p.end_time
FROM performances p
INNER JOIN artists ar ON ar.artist_id = p.artist_id
INNER JOIN stages s ON s.stage_id = p.stage_id
ORDER BY p.festival_day, p.start_time;

-- 4. List every vendor together with the attendees who purchased from them.
SELECT
    v.vendor_name,
    a.first_name,
    a.last_name,
    s.sale_amount,
    s.sale_date
FROM vendors v
INNER JOIN sales s ON s.vendor_id = v.vendor_id
INNER JOIN attendees a ON a.attendee_id = s.attendee_id
ORDER BY v.vendor_name;

-- 5. Display sponsors alongside the stages they sponsor.
SELECT
    sp.sponsor_name,
    st.stage_name,
    ss.sponsorship_amount
FROM sponsors sp
INNER JOIN stage_sponsors ss ON ss.sponsor_id = sp.sponsor_id
INNER JOIN stages st ON st.stage_id = ss.stage_id
ORDER BY sp.sponsor_name;

-- 6. Show artists who do not yet have a scheduled performance.
-- (LEFT JOIN + IS NULL catches artists with no matching performance row.)
SELECT
    ar.artist_name,
    ar.genre
FROM artists ar
LEFT JOIN performances p ON p.artist_id = ar.artist_id
WHERE p.performance_id IS NULL;

-- 7. Retrieve all performances for a selected festival day (14 Aug 2026).
SELECT
    p.performance_id,
    ar.artist_name,
    s.stage_name,
    p.start_time,
    p.end_time
FROM performances p
INNER JOIN artists ar ON ar.artist_id = p.artist_id
INNER JOIN stages s ON s.stage_id = p.stage_id
WHERE p.festival_day = '2026-08-14'
ORDER BY p.start_time;