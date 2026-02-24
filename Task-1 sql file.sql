use dhl_project;
select * from delivery_agents;
select * from orders;
select * from shipments;
select * from routes;
select * from warehouses;

-- Task 1: Data Cleaning & Preparation
-- TASK-1.1: Identify & Delete Duplicate Records
-- finding duplicate order_ids in order
select * from orders;
select order_id, count(*) as order_count
from orders
group by order_id
having order_count >1;

-- no duplicates found in orders

-- finding duplicate shipment_id in shipments
select * from shipments;
select shipment_id, count(*) as count_shipment
from shipments
group by shipment_id
having count_shipment >1;

-- no duplicates found in shipments

-- TASK-1.2: Handle NULL Delay_Hours
-- Replace null Delay_Hours with the average delay for that Route_ID
-- check null values
select * from shipments;
select * from shipments
where delay_hours is null;

-- no null values found so no replacement needed

 -- TASK-1.3: Convert Date Columns to Proper Format
 -- Convert all date columns to YYYY-MM-DD HH:MM:SS
-- convert order_date
select * from orders;
update orders
set order_date = str_to_date(order_date, '%Y-%m-%d %H:%i:%s');

-- convert pickup and delivery date
select * from shipments;
update shipments
set pickup_date = str_to_date(pickup_date, '%Y-%m-%d %H:%i:%s'),
delivery_date = str_to_date(delivery_date, '%Y-%m-%d %H:%i:%s');

-- TASK-1.4: Ensure Delivery_Date is NOT before Pickup_Date
-- Flag records where Delivery_Date < Pickup_Date
-- to find invalid records
select * from shipments;
select * from shipments
where delivery_date < pickup_date;

-- no such records found

-- TASK-1.5: Validate Referential Integrity
-- Ensure links between Orders, Routes, Warehouses, Shipments are valid
-- every foreign key should exist in parent table.
 
 -- 1. shipments --> orders
 select * from shipments;
 select * from orders;
 select s.* from shipments s
 left join orders o
 on s.order_id = o.order_id
 where o.order_id is null;
 
 -- 2. Shipments -->Routes
 select * from shipments;
 select * from routes;
 select s.* from shipments s 
 left join routes r
 on s.route_id= r.route_id
 where r.route_id is null;
 
 -- 3. shipments --> warehouses
 select * from shipments;
 select * from warehouses;
 select s.*
from shipments s
left join warehouses w
on s.warehouse_id = w.warehouse_id
where w.warehouse_id is null;

-- 4. shipments --> Deliver agents
select * from shipments;
select * from delivery_agents;
select s.* from shipments s 
left join delivery_agents d 
on s.agent_id = d.agent_id
where d.agent_id is null;

-- Data is now clean, reliable, and ready for analysis.













