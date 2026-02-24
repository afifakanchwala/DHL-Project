-- TASK-7: Advanced KPI Reporting
-- TASK-7.1: Average Delivery Delay per Source_Country
-- source_country --> from routes
-- delay_hours -->from shipemnts

select * from shipments;
select * from routes;

select r.source_country,
round(avg(s.delay_hours),2) as avg_delay_hours
from shipments s
join routes r 
on s.route_id = r.route_id 
group by source_country;

-- TASK-7.2: On-Time Delivery Percentage
-- on time delivery % = (total on-time deliveries / total deliveries ) *100
-- on-time delivery => delay hours=0

select * from shipments;
select round(
(sum(
case when delay_hours=0 then 1
else 0
end ) / count(*)) * 100 ,2) as on_time_delivery_percent
from shipments;

-- TASK-7.3: Average Delay (in hours) per Route_ID
select * from shipments;
select route_id,
round(avg(delay_hours),2) as avg_delay_hours
from shipments
group by route_id
order by route_id; 

-- TASK-7.4: Warehouse Utilization Percentage
-- warehouse utilization % = (shipments handled / capacity_per_day) * 100
-- shipments handled = count of shipments per warehouse 
-- capacity_per_day--> from warehouse

select * from shipments;
select * from warehouses;

select w.warehouse_id, w.capacity_per_day,
count(s.shipment_id) as shipments_handled,
round((count(s.shipment_id)/w.capacity_per_day) * 100,2) as warehouse_utilization_percent
from warehouses w
left join shipments s
on w.warehouse_id = s.warehouse_id
group by w.warehouse_id, w.Capacity_per_day;

