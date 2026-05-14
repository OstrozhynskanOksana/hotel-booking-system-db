# Hotel Booking System Database Project - lab №6

To implement a database migration system using **Prisma ORM** for the incremental expansion of a Hotel Booking System schema. To demonstrate the transition from a basic structure to a fully-featured database with payment support and extended customer data.

---

## 1. Base Database Schema (migration `0_init`)

The initial migration creates the system core - all primary tables and relationships between them.

### Tables and Their Purpose

| Table | Purpose |
| :--- | :--- |
| `administrator` | Hotel administrators, linked to a specific hotel via `hotel_id` |
| `customer` | Basic customer profile: name, unique email, and password |
| `hotel` | Hotel information: name, address, city, country, phone, star rating |
| `room` / `room_type` | Rooms with price per night and a room type reference table |
| `reservation` | Central booking table: dates, guests, links to customer and room |
| `reservation_status` | Booking status reference table |
| `review` | Customer reviews: rating, comment, date |

### Running the Migration

```bash
npx prisma migrate deploy
```



## 2. Additional Migrations

After the base initialization, three migrations were applied sequentially, each extending the schema without data loss.

| Migration Name | Change | Impact |
| :--- | :--- | :--- |
| `0_init` | Base tables | Core created: hotel, room, customer, reservation, review |
| `add-created-at-to-customer` | Timestamp | Enables tracking of when a reservation was created |
| `add-payment-table` | Payment module | System can store payment method and amount |
| `add-phone-to-customer` | Customer profile | Customer contact data extended with a phone number |

---

### 2.1 `add-created-at-to-customer`

Adds a `created_at` column to the `reservation` table with an automatic default value of the current time.

**Migration SQL:**
```sql
ALTER TABLE "reservation"
ADD COLUMN "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;
```


<img width="508" height="154" alt="image" src="https://github.com/user-attachments/assets/8edc5144-a3a1-45b3-bd9e-aab061c4ce1f" />


---

### 2.2 `add-payment-table`

Creates a new `payment` table for storing reservation payment information.

**Migration SQL:**
```sql
CREATE TABLE "payment" (
    "payment_id"     SERIAL NOT NULL,
    "amount"         DOUBLE PRECISION NOT NULL,
    "payment_date"   TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "method"         TEXT NOT NULL,
    "reservation_id" INTEGER NOT NULL,
    CONSTRAINT "payment_pkey" PRIMARY KEY ("payment_id")
);

ALTER TABLE "payment"
ADD CONSTRAINT "payment_reservation_id_fkey"
    FOREIGN KEY ("reservation_id")
    REFERENCES "reservation"("reservation_id")
    ON DELETE RESTRICT ON UPDATE CASCADE;
```


Each payment is linked to a specific reservation via `reservation_id`. `ON DELETE RESTRICT` prevents deletion of a reservation if payment records exist for it - this protects financial data from accidental deletion. The `method` field stores the payment method as text (`'card'`, `'cash'`, `'online'`).




<img width="509" height="185" alt="image" src="https://github.com/user-attachments/assets/a6bb594b-8a02-4ad5-a386-b5493b0fad73" />



---

### 2.3 `add-phone-to-customer`

Adds an optional `phone` column to the `customer` table.

**Migration SQL:**
```sql
ALTER TABLE "customer"
ADD COLUMN "phone" VARCHAR(20);
```


The column is declared as nullable (no `NOT NULL`) - this allows the migration to be applied without breaking existing customer records that don't yet have a phone number. The `VARCHAR(20)` type is sufficient for storing international numbers in the format `+380XXXXXXXXX`.



<img width="513" height="215" alt="image" src="https://github.com/user-attachments/assets/f2c98af3-72f0-453d-b15d-0fe9a70fd155" />

---

## 3. Final Database Schema

After all migrations are applied, the schema contains the following key relationships:

- `hotel` → `room` — one-to-many, cascading room deletion
- `customer` → `reservation` — one-to-many
- `reservation` → `payment` — one-to-many, with deletion restriction (`RESTRICT`)
- `room` → `review`, `reservation` — one-to-many




