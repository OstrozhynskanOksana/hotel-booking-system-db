select 
r.room_number, 
r.room_type,
r.price_per_night,
h.name as hotel_name from room r
join hotel h on h.hotel_id = r.hotel_id;

select 
c.full_name, 
r.reservation_status,
r.check_in_date,
r.check_out_date,
r.number_of_guests
from customer c
left join reservation r on r.customer_id = c.customer_id;

select r.room_number,
h.name as hotel_name 
from room r
full join hotel h on h.hotel_id = r.hotel_id
order by h.name;