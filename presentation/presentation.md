# SummerTides Festival Database
### Project Presentation / Demo Notes

---

## 1. The Problem

SummerTides Festival organizers were running everything on spreadsheets:

- Duplicate attendee records
- Missing ticket information
- Scheduling conflicts between artists and stages
- No reliable way to report on sales, sponsorships, or attendance

**Goal:** replace the spreadsheets with a relational database that answers the organizers' real questions reliably.

---

## 2. The Solution — Database Design

Nine tables, covering every part of the festival:

- **attendees** — who's coming
- **tickets** — what they paid, for which day
- **artists** — who's performing
- **stages** — where they perform
- **performances** — the schedule (artist + stage + time)
- **vendors** — food/drink/merch/art sellers
- **sales** — vendor transactions
- **sponsors** — who's funding the festival
- **stage_sponsors** — which sponsor funds which stage (many‑to‑many)

See `ER_Diagram.md` for the full entity relationship diagram and `data_dictionary.md` for column-level detail.

---

## 3. Key Design Decisions

- Every table has a single-column surrogate `AUTO_INCREMENT` primary key for simplicity and stable foreign keys.
- `stage_sponsors` is a junction table — sponsorship is genuinely many‑to‑many (a sponsor can back multiple stages; a stage can carry multiple sponsors).
- Business rules are enforced with `CHECK` constraints rather than left to application code: ticket types, festival dates, valid age ranges, non‑negative prices, and rating scales are all guarded at the database level.
- A `UNIQUE` constraint on `(stage_id, festival_day, start_time)` prevents double-booking a stage.

---

## 4. Sample Data

- 20 attendees across 8 cities (Kenya, Uganda, Tanzania)
- 15 artists spanning 10 genres, 5 different countries
- 6 stages, 30 scheduled performances across 3 festival days
- 40 tickets (Standard / VIP / Backstage)
- 10 vendors, 50 recorded sales
- 8 sponsors, 12 stage-sponsorship deals

---

## 5. What the Database Can Answer

- Which artist is performing where, and when (`artist_schedule` view)
- Who bought VIP tickets (`vip_attendees` view)
- Which vendor is generating the most revenue (`vendor_sales_summary` view)
- Which stage is busiest, which artist performs most, which city has the most attendees, and more (`12_bonus.sql`)

---

## 6. Demo Flow

1. Run `01_create_database.sql` → `02_create_tables.sql` → `03_insert_data.sql` → `04_constraints.sql` to build the database.
2. Walk through `05_select.sql` → `10_joins.sql` to show retrieval, filtering, sorting, CASE logic, aggregation, and joins.
3. Query the three views in `11_views.sql` live to show they return correct, up-to-date results.
4. Close with two or three bonus questions from `12_bonus.sql` (e.g. "which artist performs the most?", "which vendor generated the highest revenue?").

---

## 7. What We'd Add Next

- A `staff` / `security` table for operational planning
- Ticket check-in / attendance tracking (scanned vs. no-show)
- A `refunds` table for cancelled ticket purchases
- Indexes on frequently filtered columns (`city`, `festival_day`) as data volume grows