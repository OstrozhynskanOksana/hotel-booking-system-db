# Hotel Booking System Database Project - lab №1


## 1. Requirements Summary

 **Stakeholder Needs:**
* **Customers:** Search for available rooms, create/manage reservations, and provide feedback through reviews.
* **Administrators:** Manage hotel inventory (rooms), monitor reservation statuses, and oversee hotel-specific operations.


 **Data to be Stored:** Customer profiles, hotel details, room specifications, pricing, booking dates, and service ratings.
 
 **Business Rules:**
* A reservation cannot exist without a valid customer and a specific room
* Reviews can only be submitted for completed reservations
* One administrator is assigned to manage exactly one hotel



## 2. Entity-Relationship Diagram (ERD)

<img width="697" height="447" alt="hotel_management_erd (1)" src="https://github.com/user-attachments/assets/7a92db2e-79b2-46fb-8791-fdb0218a0aa0" />



## 3. Entities and Attributes

* **Hotel**: Represents the lodging establishment. Includes `hotelId` (PK), `name`, `address`, `city`, and `starRating`.
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
