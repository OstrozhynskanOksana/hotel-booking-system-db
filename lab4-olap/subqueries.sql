select room_number,
price_per_night  
from room 
where price_per_night > (select avg(price_per_night) from room);

select c.full_name, count(r.customer_id) as reservations
from customer c
join reservation r on r.customer_id = c.customer_id
group by c.customer_id, c.full_name
having count(r.customer_id) = (
    select max(res_count)
    from (
        select count(customer_id) as res_count
        from reservation
        group by customer_id 
    )
);

select h.name as hotel_name, avg(r.price_per_night) as price from hotel h
join room r on r.hotel_id = h.hotel_id
group by h.hotel_id, r.hotel_id 
having avg(r.price_per_night) > (select avg(price_per_night) from room);