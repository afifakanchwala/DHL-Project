-- Task 6: Shipment Tracking Analytics
-- TASK-6.1: Latest Status of Each Shipment
-- Each shipment Id appear once
-- latest status = already stored in delivery_status

select * from shipments;
select shipment_id,delivery_status,delivery_date
from shipments;

-- TASK-6.2: Routes with Majority Shipments “In Transit” or “Returned”
-- To identify routes where most shipments are NOT delivered.
-- Majority = more than 50%

select * from shipments;
select route_id,
count(*) as total_shipments,
sum(delivery_status in ('In Transit','Returned')) as issue_shipments,
(sum(delivery_status in('In Transit', 'Returned'))/count(*)) *100 as issue_percentage
from shipments
group by route_id
having issue_percentage >50;

-- no such record found for routes majority shipments In transit or returned status.

-- For additional insight, routes found for more than 10% of delivery issues.
select route_id,
count(*) as total_shipments,
sum(delivery_status in ('In Transit','Returned')) as issue_shipments,
(sum(delivery_status in('In Transit', 'Returned'))/count(*)) *100 as issue_percentage
from shipments
group by route_id
having issue_percentage >10;

-- TASK-6.3: Most Frequent Delay Reasons
select * from shipments;
select delay_reason,
count(*) as occurence_count
from shipments
where delay_reason is not null
group by delay_reason
order by occurence_count desc;
-- most frequent delay reason is due to Traffic.

-- TASK-6.4: Orders with Exceptionally High Delay (>120 hours)
select * from shipments;
select shipment_id, order_id,route_id,delay_hours
from shipments
where delay_hours > 120
order by delay_hours desc;












