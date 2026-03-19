# Hotel Booking System Database Project - lab №4

This report contains SQL queries created for analyzing a hotel reservation database. The queries demonstrate the use of aggregate functions, JOIN operations, and subqueries.
Additionally, the queries help to analyze pricing strategies, customer activity, and relationships between different entities in the database.

## 1. Aggregate Queries

### Query 1: Average room price per hotel

This query calculates the average price per night for rooms in each hotel.
It helps compare pricing levels between hotels and gives an understanding of which hotels are more expensive or more affordable on average.

SQL:

```sql
SELECT h.name AS hotel_name, AVG(r.price_per_night) AS average_price
FROM hotel h
JOIN room r ON r.hotel_id = h.hotel_id
GROUP BY h.hotel_id;
```

Result:

<img width="865" height="735" alt="image" src="https://github.com/user-attachments/assets/ae6daee7-7d0b-4837-832d-1d892803bc6c" />



### Query 2: Number of reservations per customer

This query counts how many reservations each customer has made.
It allows identifying the most active users and analyzing how frequently customers interact with the booking system.

SQL:

```sql
SELECT c.full_name, COUNT(r.reservation_id) AS reservations
FROM customer c
JOIN reservation r ON r.customer_id = c.customer_id
GROUP BY c.customer_id;
```


Result:

<img width="799" height="758" alt="image" src="https://github.com/user-attachments/assets/b40a696a-c242-4023-b581-c1031086e7d8" />


### Query 3: Minimum and maximum room price per hotel

This query finds the minimum and maximum room prices for each hotel.
It shows the full price range within each hotel and helps understand how diverse the pricing of rooms is.

SQL:

```sql
SELECT h.name AS hotel_name, 
       MAX(r.price_per_night) AS max_price, 
       MIN(r.price_per_night) AS min_price
FROM hotel h
JOIN room r ON r.hotel_id = h.hotel_id
GROUP BY h.hotel_id;
```


Result:

<img width="1141" height="739" alt="image" src="https://github.com/user-attachments/assets/3b7eb74c-960d-4f84-bcef-5f2c63908fdf" />


### Query 4: Total price of rooms per hotel

This query calculates the total sum of room prices in each hotel.
It can be used to estimate the overall value of all rooms in a hotel and compare hotels based on their pricing scale.

SQL:

```sql
SELECT h.name AS hotel_name, SUM(r.price_per_night) AS sum_of_prices
FROM hotel h
JOIN room r ON r.hotel_id = h.hotel_id
GROUP BY h.hotel_id;
```



Result:

<img width="880" height="740" alt="image" src="https://github.com/user-attachments/assets/d4fb2044-c37b-4147-b203-3595ce57b7ea" />


---

## 2. JOIN Queries

### Query 5: Rooms with hotel names (INNER JOIN)

This query retrieves room details along with the corresponding hotel name.
It demonstrates the relationship between rooms and hotels and shows only matching records where a room belongs to a hotel.

SQL:

```sql
SELECT r.room_number, r.room_type, r.price_per_night, h.name AS hotel_name
FROM room r
JOIN hotel h ON h.hotel_id = r.hotel_id;
```


Result:

<img width="829" height="836" alt="image" src="https://github.com/user-attachments/assets/71edfd3b-3452-4234-a909-14c90b1b45b1" />


### Query 6: Customers and their reservations (LEFT JOIN)

This query shows all customers and their reservations, including customers without reservations.
It is useful for identifying inactive customers and understanding customer engagement.

SQL:

```sql
SELECT c.full_name, r.reservation_status, r.check_in_date, r.check_out_date, r.number_of_guests
FROM customer c
LEFT JOIN reservation r ON r.customer_id = c.customer_id;
```


Result:

<img width="1044" height="862" alt="image" src="https://github.com/user-attachments/assets/b56ef61e-d5ee-4c08-a725-68cd91c87c33" />



### Query 7: All rooms and hotels (FULL JOIN)

This query returns all rooms and all hotels, even if there is no match between them.
It demonstrates how FULL JOIN includes all records from both tables and helps detect missing or unmatched data.

SQL:

```sql
SELECT r.room_number, h.name AS hotel_name
FROM room r
FULL JOIN hotel h ON h.hotel_id = r.hotel_id
ORDER BY h.name;
```

Result:

<img width="540" height="638" alt="image" src="https://github.com/user-attachments/assets/e2782e3a-de5d-48b9-b5cf-34c3260acc92" />

---

## 3. Subqueries

### Query 8: Rooms with price above average

This query selects rooms with a price higher than the average room price.
It helps identify premium rooms and analyze how prices are distributed in the database.

SQL:

```sql
SELECT room_number, price_per_night
FROM room
WHERE price_per_night > (
    SELECT AVG(price_per_night)
    FROM room
);
```


Result:

<img width="729" height="512" alt="image" src="https://github.com/user-attachments/assets/a87bec52-29d5-4c7e-b402-e1cf0873a30b" />


### Query 9: Customer with the most reservations

This query finds the customer with the highest number of reservations.
It uses a subquery to determine the maximum number of bookings and compares it with each customer.
 
SQL:

```sql
SELECT c.full_name, COUNT(r.customer_id) AS reservations
FROM customer c
JOIN reservation r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(r.customer_id) = (
    SELECT MAX(res_count)
    FROM (
        SELECT COUNT(customer_id) AS res_count
        FROM reservation
        GROUP BY customer_id
    ) 
);
```

Result:

<img width="670" height="594" alt="image" src="https://github.com/user-attachments/assets/1cebd2c4-cf8d-46fb-aa9b-6cde8fe1ec06" />


### Query 10: Hotels with above-average room prices

This query selects hotels where the average room price is higher than the overall average.
It helps identify relatively expensive hotels compared to the general price level.

SQL:

```sql
SELECT h.name AS hotel_name, AVG(r.price_per_night) AS price
FROM hotel h
JOIN room r ON r.hotel_id = h.hotel_id
GROUP BY h.hotel_id, r.hotel_id
HAVING AVG(r.price_per_night) > (
    SELECT AVG(price_per_night)
    FROM room
);
```


Result:

<img width="811" height="608" alt="image" src="https://github.com/user-attachments/assets/699d499a-b952-4b8c-ab53-c17b3926d193" />


