-- Task 5: Delivery Agent Performance
-- TASK-5.1: Rank Delivery Agents (per Route) by On-Time Delivery %

select * from shipments;
select s.route_id,
s.agent_id,
round((sum(s.delay_hours = 0)/count(*)) *100,2)as onTime_delivery_percentage,
rank() over(partition  by s.route_id order by (sum(s.delay_hours = 0)/count(*)) desc)
as agent_rank
from shipments s 
group by s.route_id, s.agent_id;

-- TASK-5.2: Find Agents with On-Time % Below 85%
select * from shipments;
select agent_id,
round((sum(delay_hours =0)/count(*)) * 100,2) as onTime_delivery_percentage
from shipments
group by agent_id
having onTime_delivery_percentage < 85 
order by agent_id ;

-- TASK-5.3: Compare Top 5 vs Bottom 5 Agents (Rating & Experience)
-- Top 5 agents : best-on-time %
-- Bottom 5 agents: worst-on-time %

select * from shipments;
select * from delivery_agents;

select category,round(avg(avg_rating),2) as average_rating,
round(avg(experience_years),2) as avg_experience_years
from (
-- top 5 agents
select 'Top 5 agents' as category,
d.avg_rating,d.experience_years
from (
select agent_id,
(sum(delay_hours=0)/count(*)) * 100 as onTime_percentage
from shipments 
group by agent_id 
order by onTime_percentage desc
limit 5
) ta
join delivery_agents d 
on ta.agent_id= d.agent_id

union all 
-- bottom 5 agents
select 'Bottom 5 agents' as category,
d.avg_rating,d.experience_years
from (
select agent_id,
(sum(delay_hours=0)/count(*)) *100 as onTime_percentage
from shipments 
group by agent_id
order by onTime_percentage 
limit 5) ba
join delivery_agents d
on ba.agent_id=d.agent_id
) comparison 
group by category;

-- TASK-5.4: Suggestions for Low-Performing Agents

-- 1. Agents with on-time delivery below 85% should be prioritized for 
-- performance improvement initiatives.

-- 2.Targeted training programs can help improve route familiarity and delivery efficiency.

-- 3. Workload balancing should be implemented to avoid over-assignment of shipments 
-- to underperforming agents.

-- 4.Pairing less experienced agents with senior agents can improve on-ground execution.

-- 5. Continuous monitoring of agent performance metrics can help 
-- identify issues early and reduce delivery delays.









