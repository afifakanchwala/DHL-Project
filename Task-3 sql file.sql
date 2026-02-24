-- TASK-3: Route Optimization Insights
-- Task3.1: Average Transit Time per Route
-- For each route, to calculate average transit time (in hours) across all shipments
-- Transit time = delivery date - pickup date

select * from shipments;
select route_id,
round(avg(timestampdiff(hour,pickup_date,delivery_date)),2) as avg_transit_time
from shipments
group by route_id
order by route_id;

-- Task 3.2: Average Delay per Route
-- Calculate average delay (in hours) per route
select * from shipments;
select route_id,
round(avg(delay_hours),2) as avg_delay_hours
from shipments 
group by route_id
order by route_id;

-- TASK-3.3: Distance-to-Time Efficiency Ratio
-- Distance-to-Time Efficiency Ratio = Distance_KM / Avg_Transit_Time_Hours
-- route date from route table and transit time from shipment table

select * from routes;
select * from shipments;

select r.route_id,r.distance_km,
round(avg(timestampdiff(hour,s.pickup_date,s.delivery_date)),2) as avg_transit_time,
round ((r.distance_km/avg(timestampdiff(hour,s.pickup_date,s.delivery_date))),2)as efficiency_ratio
from routes r 
join shipments s
on r.route_id= s.route_id
group by r.route_id,r.distance_km 
order by r.route_id; 

-- TASK-3.4: 3 Routes with Worst Efficiency Ratio
-- To identify 3 routes with lowest efficiency
select * from routes;
select * from shipments;

select r.route_id,r.distance_km,
round(avg(timestampdiff(hour,s.pickup_date,s.delivery_date)),2) as avg_transit_time,
round ((r.distance_km/avg(timestampdiff(hour,s.pickup_date,s.delivery_date))),2)as efficiency_ratio
from routes r 
join shipments s
on r.route_id= s.route_id
group by r.route_id,r.distance_km 
order by efficiency_ratio
limit 3;

-- TASK-3.5: Routes with >20% Shipments Delayed Beyond Expected Transit Time
--  To find routes where more than 20% of shipments have
-- Transit Time > Expected Avg Transit Time
-- Transit time= Delivery_date - pickup_date
-- Expected Transit Time= routes.Avg_transit_time

select * from shipments;
select * from routes;
select s.route_id,
count(*) as Total_shipments,
    sum(
        timestampdiff(hour, s.Pickup_Date, s.Delivery_Date) > r.avg_transit_time_hours
    ) as Delayed_shipments,

(sum(
        timestampdiff(hour, s.Pickup_Date, s.Delivery_Date) > r.avg_transit_time_hours
    ) / count(*)) * 100 as Delay_Percentage
from shipments s
join routes r
on s.route_id = r.route_id 
group by s.route_id
having delay_percentage > 20
order by r.route_id;

-- TASK-3.6: Recommend potential routes or hub pairs for optimization.
-- 1. Routes with low distance-to-time efficiency 
-- ratios indicate inefficient utilization of transit time and require operational review.

-- 2. Routes showing high delay percentages (above 20%) 
-- should be prioritized for optimization due to frequent delivery overruns.

-- 3. Better shipment scheduling and load planning may reduce waiting times during peak hours.

-- 4. Improved coordination between hubs and warehouses can help minimize handling and transfer delays.

-- 5. Routes with repeated delays should be monitored regularly to 
--    identify systemic bottlenecks and implement corrective actions.
