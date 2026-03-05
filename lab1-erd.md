# Hotel Booking System Database Project - lab №1


## 1. Requirements Summary

### Stakeholder Needs
* **Customers:** Search for available rooms, create and manage reservations with a specified number of guests, and provide feedback through reviews.
* **Administrators:** Manage hotel inventory (rooms), monitor reservation statuses, and oversee hotel-specific operations.

### Data to be Stored
* **Customer profiles:** Full name, email, and security credentials.
* **Hotel details:** Name, address, city, country, phone contact, and star rating.
* **Room specifications:** Number, type, and pricing.
* **Booking details:** Check-in/out dates, number of guests, and current status.
* **Service ratings:** Numerical scores and text comments.

### Business Rules
* **Mandatory Links:** A reservation cannot exist without a valid customer and a specific room.
* **Review Ownership:** Reviews are linked to both the customer and the specific room.
* **Staff Management:** Each hotel can have one or more administrators assigned to oversee its operations (1:N relationship as shown in ERD).
* **Data Integrity:** All primary keys (PK) are unique, and foreign keys (FK) maintain referential integrity.

## 2. Entity-Relationship Diagram (ERD)

<img width="697" height="447" alt="hotel_management_erd (1)" src="https://github.com/user-attachments/assets/7a92db2e-79b2-46fb-8791-fdb0218a0aa0" />



## 3. Entities and Attributes

* **Hotel**: Includes `hotelId` (PK), `name`, `address`, `city`, `country`, `phoneNumber`, and `starRating`.
* **Room**: Defines specific units within a hotel. Includes `roomId` (PK) and `hotelId` (FK). One hotel has many rooms (1:M).
* **Customer**: Stores user account information like `fullName`, `email`, `password` and `customerId` (PK).
* **Reservation**: The core transactional entity tracking `checkInDate`, `checkOutDate`, and `reservationStatus`. It links a `Customer` to a `Room` (M:1).
* **Review**: Contains `rating` and `comment`. Also contains `reviewId` (PK), `customerId` (FK) and `roomId` (FK).
* **Administrator**: Staff members assigned to a hotel via `hotelId` (FK).

## 4. Assumptions and Constraints

* **Double Booking Prevention**: A single room cannot have overlapping reservation dates for different customers.
* **One Review Per Stay**: Each reservation allows for only one review entry.
* **Static Pricing**: For this model, `pricePerNight` is considered constant for the room, regardless of seasonal changes or guest count.
* **Admin Isolation**: An administrator can only access and manage data for the hotel they are assigned to.


