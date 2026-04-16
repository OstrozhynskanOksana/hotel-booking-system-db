# Hotel Booking System Database Project - Lab №5

## Overview
In this lab work the existing database schema of a hotel booking system was analyzed to identify data redundancy and anomalies. The main goal is to normalize the database to the Third Normal Form (3NF) in order to improve data integrity and eliminate duplication.

## The database consists of the following tables: 
* hotel 
* customer
* room 
* administrator 
* reservation
* review

Each table has a primary key and relationships are implemented using foreign keys.

## Functional Dependencies
hotel_id → name, address, city, country, phone_number, star_rating  
customer_id → full_name, email, password  
email → customer_id, full_name, password  
room_id → room_number, room_type, price_per_night, hotel_id  
administrator_id → full_name, email, hotel_id  
email → administrator_id, full_name, hotel_id  
reservation_id → check_in_date, check_out_date, number_of_guests, reservation_status, customer_id, room_id  
review_id → rating, comment, review_date, customer_id, room_id  

## Normal Forms Analysis

### First Normal Form (1NF)
All tables satisfy 1NF because each field contains atomic values, there are no repeating groups and no multiple values are stored in a single column.

### Second Normal Form (2NF)
All tables are in 2NF because each table has a single-column primary key and there are no partial dependencies.

### Third Normal Form (3NF)
In the hotel table we have a transitive dependency of city on country. They should be put in a separate table. Also, the reservation status and room type should be put in separate tables to avoid data duplication

## Normalization Improvements

## Query (3NF)

```sql
CREATE TABLE City (
    cityId SERIAL PRIMARY KEY,
    cityName VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL
);

ALTER TABLE Hotel 
    DROP COLUMN city, 
    DROP COLUMN country,
    ADD COLUMN cityId INT,
    ADD CONSTRAINT fk_hotel_city 
    FOREIGN KEY (cityId)
    REFERENCES City(cityId);
```

Changes to avoid duplications

```sql
CREATE TABLE room_type (
    room_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

CREATE TABLE reservation_status (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);


--------------------------------------
ALTER TABLE room ADD COLUMN room_type_id INTEGER;
ALTER TABLE reservation ADD COLUMN status_id INTEGER;

UPDATE room r
SET room_type_id = rt.room_type_id
FROM room_type rt
WHERE r.room_type = rt.type_name;

UPDATE reservation res
SET status_id = rs.status_id
FROM reservation_status rs
WHERE res.reservation_status = rs.status_name;

ALTER TABLE room
ADD CONSTRAINT fk_room_type
FOREIGN KEY (room_type_id)
REFERENCES room_type(room_type_id);

ALTER TABLE reservation
ADD CONSTRAINT fk_status
FOREIGN KEY (status_id)
REFERENCES reservation_status(status_id);

ALTER TABLE room DROP COLUMN room_type;
ALTER TABLE reservation DROP COLUMN reservation_status;
```

## ERD (3NF)

<img width="1365" height="581" alt="image" src="https://github.com/user-attachments/assets/d0a78282-a0ee-4e48-b702-e3833cec77aa" />



