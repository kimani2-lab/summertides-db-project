# SummerTides Festival — Data Dictionary

This document describes every table and column in the `summertides` database.

---

## attendees
People who register for the festival.

| Column | Type | Constraints | Description |
|---|---|---|---|
| attendee_id | INT | PK, AUTO_INCREMENT | Unique identifier for the attendee |
| first_name | VARCHAR(50) | NOT NULL | Attendee's first name |
| last_name | VARCHAR(50) | NOT NULL | Attendee's last name |
| email | VARCHAR(100) | NOT NULL, UNIQUE | Attendee's email address |
| phone | VARCHAR(20) | nullable | Attendee's phone number (optional) |
| age | INT | CHECK (0–120) | Attendee's age |
| city | VARCHAR(50) | | City the attendee lives in |
| country | VARCHAR(50) | DEFAULT 'Kenya' | Country the attendee lives in |
| registration_date | DATE | DEFAULT CURRENT_DATE | Date the attendee registered |

## stages
Physical performance stages on the festival grounds.

| Column | Type | Constraints | Description |
|---|---|---|---|
| stage_id | INT | PK, AUTO_INCREMENT | Unique identifier for the stage |
| stage_name | VARCHAR(50) | NOT NULL, UNIQUE | Name of the stage |
| capacity | INT | CHECK (> 0) | Maximum number of people the stage area can hold |
| location_description | VARCHAR(100) | | Where on the grounds the stage is located |

## artists
Musicians/DJs booked to perform.

| Column | Type | Constraints | Description |
|---|---|---|---|
| artist_id | INT | PK, AUTO_INCREMENT | Unique identifier for the artist |
| artist_name | VARCHAR(100) | NOT NULL | Name of the artist or band |
| genre | VARCHAR(50) | NOT NULL | Musical genre |
| country | VARCHAR(50) | NOT NULL | Artist's home country |
| booking_fee | DECIMAL(10,2) | DEFAULT 0, CHECK (>= 0) | Fee paid to book the artist |

## tickets
One row per ticket purchased by an attendee.

| Column | Type | Constraints | Description |
|---|---|---|---|
| ticket_id | INT | PK, AUTO_INCREMENT | Unique identifier for the ticket |
| attendee_id | INT | FK → attendees.attendee_id, NOT NULL | Who bought the ticket |
| ticket_type | VARCHAR(20) | NOT NULL, CHECK IN ('Standard','VIP','Backstage') | Tier of ticket purchased |
| price | DECIMAL(10,2) | NOT NULL, CHECK (>= 0) | Price paid for the ticket |
| purchase_date | DATE | NOT NULL | Date the ticket was bought |
| festival_day | DATE | NOT NULL, CHECK IN festival dates | Which festival day the ticket admits entry to |

## performances
Schedule linking an artist to a stage at a specific date/time.

| Column | Type | Constraints | Description |
|---|---|---|---|
| performance_id | INT | PK, AUTO_INCREMENT | Unique identifier for the performance slot |
| artist_id | INT | FK → artists.artist_id, NOT NULL | Performing artist |
| stage_id | INT | FK → stages.stage_id, NOT NULL | Stage the performance happens on |
| festival_day | DATE | NOT NULL, CHECK IN festival dates | Date of the performance |
| start_time | TIME | NOT NULL | Performance start time |
| end_time | TIME | NOT NULL, CHECK (> start_time) | Performance end time |

*Unique constraint:* `(stage_id, festival_day, start_time)` — a stage cannot host two performances at the same start time on the same day.

## vendors
Food, drink, merchandise, and art vendors operating at the festival.

| Column | Type | Constraints | Description |
|---|---|---|---|
| vendor_id | INT | PK, AUTO_INCREMENT | Unique identifier for the vendor |
| vendor_name | VARCHAR(100) | NOT NULL | Vendor's business name |
| category | VARCHAR(50) | NOT NULL | Food / Drinks / Merchandise / Art |
| rating | DECIMAL(2,1) | CHECK (0–5) | Vendor's average customer rating |

## sales
Individual purchases made by attendees from vendors.

| Column | Type | Constraints | Description |
|---|---|---|---|
| sale_id | INT | PK, AUTO_INCREMENT | Unique identifier for the sale |
| vendor_id | INT | FK → vendors.vendor_id, NOT NULL | Vendor that made the sale |
| attendee_id | INT | FK → attendees.attendee_id, NOT NULL | Attendee who made the purchase |
| sale_amount | DECIMAL(10,2) | NOT NULL, CHECK (> 0) | Amount of the sale |
| sale_date | DATE | NOT NULL | Date the sale occurred |

## sponsors
Companies/organisations that fund the festival.

| Column | Type | Constraints | Description |
|---|---|---|---|
| sponsor_id | INT | PK, AUTO_INCREMENT | Unique identifier for the sponsor |
| sponsor_name | VARCHAR(100) | NOT NULL, UNIQUE | Sponsor's name |
| contribution_amount | DECIMAL(12,2) | NOT NULL, CHECK (>= 0) | Total amount contributed |
| contact_email | VARCHAR(100) | | Sponsor's contact email |

## stage_sponsors
Junction table implementing the many-to-many relationship between stages and sponsors.

| Column | Type | Constraints | Description |
|---|---|---|---|
| stage_id | INT | PK (composite), FK → stages.stage_id | Sponsored stage |
| sponsor_id | INT | PK (composite), FK → sponsors.sponsor_id | Sponsoring company |
| sponsorship_amount | DECIMAL(12,2) | CHECK (>= 0) | Amount that sponsor put toward that specific stage |

---

## Relationships Summary

- One **attendee** can buy many **tickets** (1‑to‑many).
- One **attendee** can make many **sales** purchases (1‑to‑many).
- One **artist** can have many **performances** (1‑to‑many).
- One **stage** can host many **performances** (1‑to‑many).
- One **vendor** can have many **sales** (1‑to‑many).
- **Stages** and **sponsors** relate many‑to‑many through **stage_sponsors**.