-- =====================================================================
-- File:        11_views.sql
-- Project:     SummerTides Festival Database
-- Purpose:     Create reusable views for the organisers' most common
--              reports, then query each one to prove it works.
-- =====================================================================

USE summertides;

-- ---------------------------------------------------------------------
-- VIEW 1: vip_attendees
-- All attendees who purchased VIP tickets.
-- ---------------------------------------------------------------------
DROP VIEW IF EXISTS vip_attendees;

CREATE VIEW vip_attendees AS
SELECT
    a.attendee_id,
    a.first_name,
    a.last_name,
    a.email,
    t.ticket_id,
    t.festival_day
FROM attendees a
INNER JOIN tickets t ON t.attendee_id = a.attendee_id
WHERE t.ticket_type = 'VIP';

-- Verify it works.
SELECT * FROM vip_attendees;

-- ---------------------------------------------------------------------
-- VIEW 2: artist_schedule
-- Artist name, stage, performance date, start time, end time.
-- ---------------------------------------------------------------------
DROP VIEW IF EXISTS artist_schedule;

CREATE VIEW artist_schedule AS
SELECT
    ar.artist_name,
    st.stage_name,
    p.festival_day AS performance_date,
    p.start_time,
    p.end_time
FROM performances p
INNER JOIN artists ar ON ar.artist_id = p.artist_id
INNER JOIN stages st ON st.stage_id = p.stage_id;

-- Verify it works.
SELECT * FROM artist_schedule
ORDER BY performance_date, start_time;

-- ---------------------------------------------------------------------
-- VIEW 3: vendor_sales_summary
-- Vendor name, total sales, average sale value, number of transactions.
-- ---------------------------------------------------------------------
DROP VIEW IF EXISTS vendor_sales_summary;

CREATE VIEW vendor_sales_summary AS
SELECT
    v.vendor_id,
    v.vendor_name,
    SUM(s.sale_amount)            AS total_sales,
    ROUND(AVG(s.sale_amount), 2)  AS average_sale_value,
    COUNT(s.sale_id)              AS number_of_transactions
FROM vendors v
INNER JOIN sales s ON s.vendor_id = v.vendor_id
GROUP BY v.vendor_id, v.vendor_name;

-- Verify it works.
SELECT * FROM vendor_sales_summary
ORDER BY total_sales DESC;