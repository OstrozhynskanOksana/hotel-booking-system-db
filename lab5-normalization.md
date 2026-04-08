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
Most tables satisfy 3NF because all non-key attributes depend only on the primary key and there are no transitive dependencies. The attributes such as room_type and reservation_status contain repeated textual values and can be improved.

## Normalization Improvements

The attribute room_type was extracted into a separate table to eliminate duplication and ensure consistency of values. The same approach was applied to reservation_status.

## Query (3NF)

```sql
CREATE TABLE room_type (
    room_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

CREATE TABLE reservation_status (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE room (
    room_id SERIAL PRIMARY KEY,
    room_number INTEGER NOT NULL,
    price_per_night NUMERIC(10,2),
    hotel_id INTEGER REFERENCES hotel(hotel_id),
    room_type_id INTEGER REFERENCES room_type(room_type_id)
);

CREATE TABLE reservation (
    reservation_id SERIAL PRIMARY KEY,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    number_of_guests INTEGER,
    status_id INTEGER REFERENCES reservation_status(status_id),
    customer_id INTEGER REFERENCES customer(customer_id),
    room_id INTEGER REFERENCES room(room_id)
);
```

## ERD (3NF)

<img width="1365" height="597" alt="image" src="https://github.com/user-attachments/assets/bbdecf91-bae4-4ba7-ae0c-62ad14f91c46" />

