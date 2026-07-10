USE summertides;

-- ---------------------------------------------------------------------
-- Drop tables in dependency order (children before parents) so this
-- script can be re-run safely.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS stage_sponsors;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS performances;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS sponsors;
DROP TABLE IF EXISTS vendors;
DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS stages;
DROP TABLE IF EXISTS attendees;

-- ---------------------------------------------------------------------
-- ATTENDEES
-- People who register for / attend the festival.
-- ---------------------------------------------------------------------
CREATE TABLE attendees (
    attendee_id        INT AUTO_INCREMENT PRIMARY KEY,
    first_name          VARCHAR(50)  NOT NULL,
    last_name           VARCHAR(50)  NOT NULL,
    email                VARCHAR(100) NOT NULL UNIQUE,
    phone                VARCHAR(20),
    age                  INT,
    city                 VARCHAR(50),
    country              VARCHAR(50) DEFAULT 'Kenya',
    registration_date    DATE
);

-- ---------------------------------------------------------------------
-- STAGES
-- Physical performance stages at the festival grounds.
-- ---------------------------------------------------------------------
CREATE TABLE stages (
    stage_id             INT AUTO_INCREMENT PRIMARY KEY,
    stage_name           VARCHAR(50) NOT NULL UNIQUE,
    capacity             INT,
    location_description VARCHAR(100)
);

-- ---------------------------------------------------------------------
-- ARTISTS
-- Musicians / DJs booked to perform at the festival.
-- ---------------------------------------------------------------------
CREATE TABLE artists (
    artist_id            INT AUTO_INCREMENT PRIMARY KEY,
    artist_name          VARCHAR(100) NOT NULL,
    genre                VARCHAR(50)  NOT NULL,
    country              VARCHAR(50)  NOT NULL,
    booking_fee          DECIMAL(10,2) DEFAULT 0
);

-- ---------------------------------------------------------------------
-- TICKETS
-- One row per ticket purchased by an attendee.
-- ---------------------------------------------------------------------
CREATE TABLE tickets (
    ticket_id            INT AUTO_INCREMENT PRIMARY KEY,
    attendee_id          INT NOT NULL,
    ticket_type          VARCHAR(20) NOT NULL,
    price                DECIMAL(10,2) NOT NULL,
    purchase_date        DATE NOT NULL,
    festival_day         DATE NOT NULL,
    CONSTRAINT fk_tickets_attendee
        FOREIGN KEY (attendee_id) REFERENCES attendees(attendee_id)
        ON DELETE CASCADE
);

-- ---------------------------------------------------------------------
-- PERFORMANCES
-- Schedule linking an artist to a stage at a specific date/time.
-- ---------------------------------------------------------------------
CREATE TABLE performances (
    performance_id       INT AUTO_INCREMENT PRIMARY KEY,
    artist_id            INT NOT NULL,
    stage_id             INT NOT NULL,
    festival_day         DATE NOT NULL,
    start_time           TIME NOT NULL,
    end_time             TIME NOT NULL,
    CONSTRAINT fk_performances_artist
        FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_performances_stage
        FOREIGN KEY (stage_id) REFERENCES stages(stage_id)
        ON DELETE CASCADE
);

-- ---------------------------------------------------------------------
-- VENDORS
-- Food, drink, merchandise, and art vendors operating at the festival.
-- ---------------------------------------------------------------------
CREATE TABLE vendors (
    vendor_id            INT AUTO_INCREMENT PRIMARY KEY,
    vendor_name          VARCHAR(100) NOT NULL,
    category             VARCHAR(50)  NOT NULL,
    rating               DECIMAL(2,1)
);

-- ---------------------------------------------------------------------
-- SALES
-- Individual purchases made by attendees from vendors.
-- ---------------------------------------------------------------------
CREATE TABLE sales (
    sale_id              INT AUTO_INCREMENT PRIMARY KEY,
    vendor_id            INT NOT NULL,
    attendee_id          INT NOT NULL,
    sale_amount          DECIMAL(10,2) NOT NULL,
    sale_date            DATE NOT NULL,
    CONSTRAINT fk_sales_vendor
        FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_sales_attendee
        FOREIGN KEY (attendee_id) REFERENCES attendees(attendee_id)
        ON DELETE CASCADE
);

-- ---------------------------------------------------------------------
-- SPONSORS
-- Companies/organisations that fund the festival.
-- ---------------------------------------------------------------------
CREATE TABLE sponsors (
    sponsor_id           INT AUTO_INCREMENT PRIMARY KEY,
    sponsor_name         VARCHAR(100) NOT NULL UNIQUE,
    contribution_amount  DECIMAL(12,2) NOT NULL,
    contact_email        VARCHAR(100)
);

-- ---------------------------------------------------------------------
-- STAGE_SPONSORS
-- Junction table implementing the many-to-many relationship between
-- stages and sponsors (a sponsor can fund several stages, and a stage
-- can be funded by several sponsors).
-- ---------------------------------------------------------------------
CREATE TABLE stage_sponsors (
    stage_id             INT NOT NULL,
    sponsor_id           INT NOT NULL,
    sponsorship_amount   DECIMAL(12,2),
    PRIMARY KEY (stage_id, sponsor_id),
    CONSTRAINT fk_stagesponsors_stage
        FOREIGN KEY (stage_id) REFERENCES stages(stage_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_stagesponsors_sponsor
        FOREIGN KEY (sponsor_id) REFERENCES sponsors(sponsor_id)
        ON DELETE CASCADE
);

-- ---------------------------------------------------------------------
-- Confirm all tables were created.
-- ---------------------------------------------------------------------
SHOW TABLES;