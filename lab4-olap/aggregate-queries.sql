select h.name as hotel_name, avg(r.price_per_night ) as average_price from hotel h
join room r on r.hotel_id = h.hotel_id
group by h.hotel_id;

select c.full_name, count(r.reservation_id) as reservations from customer c
join reservation r  on r.customer_id  = c.customer_id 
group by c.customer_id;

select h.name as hotel_name, max(r.price_per_night ) as max_price, min(r.price_per_night ) as min_price from hotel h
join room r on r.hotel_id = h.hotel_id
group by h.hotel_id;

select h.name as hotel_name, sum(r.price_per_night) as sum_of_prices from hotel h
join room r on r.hotel_id = h.hotel_id
group by h.hotel_id;

