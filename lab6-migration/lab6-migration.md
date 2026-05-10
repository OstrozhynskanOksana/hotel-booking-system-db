# Hotel Booking System Database Project - lab №6

The goal of this stage was to implement a database migration system using **Prisma ORM** to handle schema changes for the **Hotel Booking System**. This lab demonstrates the transition from a basic structure to a more complex database capable of handling payments and extended customer data.

### Migration Highlights
| Migration Name | Key Change | Impact |
| :--- | :--- | :--- |
| `0_init` | Base Tables | Established the core Hotel/Room/Customer logic. |
| `add-created-at-to-customer` | Timestamping | Allows tracking when bookings were made for analytics. |
| `add-payment-table` | Financial Layer | Enabled the system to process and store payment methods and amounts. |
| `add-phone-to-customer` | Profile Update | Improved communication capabilities with customers. |

## Summary of Results
By the end of this work, the system transitioned from a static data storage to a dynamic relational database capable of:
1.  **Tracking financial flow** through the new payment module.
2.  **Maintaining high data quality** through automated Prisma migrations.
3.  **Providing audit trails** for reservations via automatic timestamps.

