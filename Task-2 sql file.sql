-- Task 2: Delivery Delay Analysis
-- TASK-2.1 (CORRECTED): Calculate Transit Time (in hours)
-- Formula given : transit time= delivery date- pickup date
-- NOT delay hours (because Delay_Hours already exists in the table)
-- transit time : tota time taken from pickup to delivery

select * from shipments;
select shipment_id,pickup_date,delivery_date,
timestampdiff(hour,pickup_date,delivery_date) as
transit_time_hour
from shipments;

-- Task 2.2: Top 10 Delayed Routes
select route_id, 
round(avg(delay_hours),2) as avg_delay_hours
from shipments
group by route_id 
order by avg_delay_hours desc 
limit 10;

-- Task 2.3 : Rank Shipments by Delay within Warehouse
select * from shipments;

SELECT warehouse_id, COUNT(*) AS shipment_count
FROM shipments
GROUP BY warehouse_id
order by warehouse_id;

select shipment_id, warehouse_id,delay_hours,
rank() over (partition by warehouse_id order by delay_hours desc) as delay_rank
from shipments;

-- Task 2.4 : Avg Delay by Delivery Type
select * from shipments;
select o.delivery_type,
round(avg(s.delay_hours),2) as avg_delay_hours
from shipments s
join orders o 
on s.order_id= o.order_id
group by o.delivery_type;






