# Hotel Booking System Database Project - lab №2

## 1. Implementation (SQL Script)
This section includes the DDL (Data Definition Language) to create the schema and DML (Data Manipulation Language) to populate the tables with at least 3-5 rows of data each.

```sql
CREATE TABLE hotel (
    hotel_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    city VARCHAR(100),
    country VARCHAR(100),
    phone_number VARCHAR(20),
    star_rating INT CHECK (star_rating BETWEEN 1 AND 5)
);

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE room (
    room_id SERIAL PRIMARY KEY,
    room_number INTEGER NOT NULL CHECK (room_number > 0),
    room_type TEXT,
    price_per_night NUMERIC(10, 2) NOT NULL CHECK (price_per_night > 0),
    hotel_id INTEGER REFERENCES hotel(hotel_id) ON DELETE CASCADE
);
CREATE TABLE administrator (
    administrator_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    hotel_id INTEGER REFERENCES hotel(hotel_id)
);

CREATE TABLE reservation (
    reservation_id SERIAL PRIMARY KEY,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    number_of_guests INTEGER CHECK (number_of_guests > 0),
    reservation_status VARCHAR(50),
    customer_id INTEGER REFERENCES customer(customer_id),
    room_id INTEGER REFERENCES room(room_id)
);

CREATE TABLE review (
    review_id SERIAL PRIMARY KEY,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment VARCHAR(400),
    review_date DATE NOT NULL,
    customer_id INTEGER REFERENCES customer(customer_id),
    room_id INTEGER REFERENCES room(room_id)
);


-- DATA INSERTION

INSERT INTO hotel (name, address, city, country, phone_number, star_rating) VALUES  
('Grand Kyiv', 'Khreshchatyk 1', 'Kyiv', 'Ukraine', '+380441234567', 5),
('Lviv Central', 'Ploshcha Rynok 5', 'Lviv', 'Ukraine', '+380327654321', 4),
('Odesa Sea', 'Primorsky Blvd 10', 'Odesa', 'Ukraine', '+380481112233', 5);

INSERT INTO customer (full_name, email, password) VALUES  
('Oksana Ostrozhynska', 'oksana@mail.com', 'pass123'),
('Oleg Petrenko', 'oleg@mail.com', 'qwerty'),
('Ivan Ivanov', 'ivan@mail.com', 'ivan2026');

INSERT INTO room (room_number, room_type, price_per_night, hotel_id) VALUES  
(101, 'Standard', 1500.00, 1),
(202, 'Deluxe', 3500.00, 1),
(12, 'Suite', 5000.00, 2),
(5, 'Single', 1200.00, 3);

INSERT INTO administrator (full_name, email, hotel_id) VALUES  
('Admin Anna', 'anna_admin@hotel.com', 1),
('Admin Petro', 'petro_admin@hotel.com', 2),
('Admin Olena', 'olena_admin@hotel.com', 3);

INSERT INTO review (rating, comment, review_date, customer_id, room_id) VALUES  
(5, 'Excellent service and location!', '2026-03-16', 1, 1),
(4, 'Great view, but a bit expensive.', '2026-04-06', 2, 3),
(3, 'Standard room, nothing special.', '2026-02-15', 3, 2);
```
## 2. Tables and Keys
| Table | Description | Primary Key (PK) | Foreign Keys (FK) |
| :--- | :--- | :--- | :--- |
| **hotel** | Stores general hotel information | `hotel_id` | — |
| **customer** | Registered users who can book rooms | `customer_id` | — |
| **room** | Details of individual rooms in hotels | `room_id` | `hotel_id` (refers to hotel) |
| **administrator** | Staff members assigned to hotels | `administrator_id` | `hotel_id` (refers to hotel) |
| **reservation** | Records of room bookings | `reservation_id` | `customer_id`, `room_id` |
| **review** | Customer feedback and ratings | `review_id` | `customer_id`, `room_id` |

## 3. Important Constraints & Assumptions
* **Cascading Deletes:** The `room` table uses `ON DELETE CASCADE` for `hotel_id`. If a hotel is removed, all its associated rooms are automatically deleted to maintain integrity.
* **Data Validation:** `CHECK` constraints are applied to ensure:
    * Ratings (`star_rating`, `rating`) are between 1 and 5.
    * Prices (`price_per_night`), number of guests and room number are always positive.
* **Uniqueness:** Email addresses in both `customer` and `administrator` tables are `UNIQUE` to prevent duplicate accounts.

## 4. Results of data integration into tables in DBeaver

<img width="840" height="404" alt="image" src="https://github.com/user-attachments/assets/71d8d0ad-32d3-4c50-ad9c-9e0cef61a511" />


<img width="792" height="410" alt="image" src="https://github.com/user-attachments/assets/3671a514-6267-48fb-9c99-73f484e29281" />


<img width="797" height="414" alt="image" src="https://github.com/user-attachments/assets/d58ee7e1-97c7-43d5-afe1-11563fc28ca1" />


<img width="805" height="446" alt="image" src="https://github.com/user-attachments/assets/906bb4a3-2eb7-4cb9-86bc-e9706b5d1763" />


<img width="1202" height="453" alt="image" src="https://github.com/user-attachments/assets/2690929b-2caf-40bc-9b00-fce1b954e67a" />


<img width="1136" height="412" alt="image" src="https://github.com/user-attachments/assets/d82dedc0-4a55-4174-bd76-7a4fac02fb33" />



