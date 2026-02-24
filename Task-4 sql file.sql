-- TASK-4: Warehouse Performance
-- TASK-4.1: Top 3 Warehouses with Highest Average Delay
select * from shipments;
select warehouse_id,
round(avg(delay_hours),2) as avg_delay_hours
from shipments
group by warehouse_id
order by avg_delay_hours desc
limit 3; 

-- TASK-4.2: Total Shipments vs Delayed Shipments per Warehouse
select * from shipments;
select warehouse_id,
count(*) as total_shipments,
sum(delay_hours>0) as delayed_shipments
from shipments 
group by warehouse_id
order by warehouse_id;

-- TASK-4.3: Identify Warehouses with Avg Delay > Global Avg Delay
-- Using CTE
-- 1.calculate global avg delay
-- 2.calculate avg delay per warehouse
-- 3 . comparing both 
-- 4. show only warehouse above global avg delay

select * from shipments;
select * from warehouses;

with Global_Average as (
select round(avg(delay_hours),3) as global_avg_delay
from shipments),
Warehouse_Average as (
select warehouse_id,
round(avg(delay_hours),3) as warehouse_avg_delay
from shipments
group by warehouse_id
)
select w.warehouse_id,w.warehouse_avg_delay,
g.global_avg_delay
from Warehouse_Average w
join Global_Average g
on w.warehouse_avg_delay > g.global_avg_delay
order by w.warehouse_id;

-- Task 4.4:Rank Warehouses by On-Time Delivery Percentage
-- On-time delivery means delay_hours=0

select * from shipments;
select warehouse_id,
round((sum(delay_hours=0)/count(*)) * 100,2) as onTime_delivery_percentage,
rank() over (order by (sum(delay_hours=0)/count(*)) desc)
as warehouse_rank
from shipments
group by warehouse_id;







