# Hotel Booking System Database Project - Lab №3

## 1. Overview

Laboratory work 3 demonstrates OLTP (Online Transaction Processing) operations in the Hotel Booking System database.  
The report includes transactional scenarios that simulate real business processes in a hotel booking system.

The following transaction scenarios are implemented:
- **Transaction 1:** Reservation cancellation, room return, and review deletion
- **Transaction 2:** Reservation completion, review creation, and room price update


## 2. Transaction 1 — Reservation Cancellation, Room Return, and Review Deletion

### Scenario  
This transaction simulates the situation when a customer cancels an existing reservation. In such a case, the reservation status must be updated in the system. Additionally, if the customer had already left a review related to that reservation or room, the review can be removed as no longer relevant. The room also becomes available again for future booking, which in this database model is represented by updating room-related data.

### SQL Query

```sql
BEGIN;

UPDATE reservation 
SET reservation_status = 'Available'
WHERE customer_id = 4;

DELETE FROM review r
WHERE customer_id = 4;

UPDATE room 
SET price_per_night = 950
WHERE room_id = 4;

COMMIT;
```

### Verification Query

```sql
SELECT 
    c.customer_id, 
    c.full_name, 
    rv.comment AS review, 
    r.reservation_status AS status_of_last_reservation, 
    rm.price_per_night AS price_of_room 
FROM customer c 
LEFT JOIN reservation r ON r.customer_id = c.customer_id 
LEFT JOIN review rv ON rv.customer_id = r.customer_id 
LEFT JOIN room rm ON rm.room_id = r.room_id
WHERE r.customer_id = 4 
  AND rm.room_id = 4;
```

### Result

<img width="977" height="67" alt="image" src="https://github.com/user-attachments/assets/04cf878e-cd28-483e-b55a-1e864f38b9e4" />



## 3. Transaction 2 — Reservation Completion, Review Creation, and Room Price Update

### Scenario

This transaction simulates the completion of a hotel stay. After the customer finishes their stay, the reservation status is updated to reflect completion. Then, a new review is added to the database to store the customer’s feedback about the room or service. Finally, room-related information such as the price per night can be updated, for example to reflect pricing changes after a completed booking cycle.


### SQL Query

```sql
BEGIN;

UPDATE reservation r 
SET reservation_status = 'Completed'
WHERE r.customer_id = 1;


INSERT INTO review (
    review_id, 
    rating, 
    comment, 
    review_date, 
    customer_id, 
    room_id
) 
VALUES (
    7, 
    3, 
    'Everything is good but too expensive', 
    '2026-03-18', 
    1, 
    1
);


UPDATE room 
SET price_per_night = price_per_night * 1.10
WHERE room_id = 1;

COMMIT;
```

### Verification Query

```sql
SELECT 
    c.customer_id, 
    c.full_name,
    rv.comment,
    rv.rating AS review_rating,
    rv.review_date,
    rm.room_number,
    rm.price_per_night AS price_of_room
FROM customer c
LEFT JOIN review rv ON rv.customer_id = c.customer_id 
LEFT JOIN room rm ON rm.room_id = rv.room_id 
WHERE c.customer_id = 1 
  AND rv.review_date = '2026-03-18';
```

### Result

<img width="1369" height="76" alt="image" src="https://github.com/user-attachments/assets/55a31af3-5526-4f8a-81a8-1258047e23cb" />


