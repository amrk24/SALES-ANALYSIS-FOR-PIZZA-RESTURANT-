select * 
from pizza_sales..pizza_types p 

select * 
from 
pizza_sales..order_details 

select * 
from pizza_sales..orders

select * 
from pizza_sales..pizzas


--Total Revenue 
select round ( sum(price * quantity) , 0) as Total_revenue
from 
pizza_sales..order_details o
left join 
pizza_sales..pizzas p
on o.pizza_id = p.pizza_id

--Avg order Value
select round ( sum(price * quantity)/ COUNT(Distinct(order_id)) , 0) as Avg_value
from 
pizza_sales..order_details o
left join 
pizza_sales..pizzas p
on o.pizza_id = p.pizza_id


--Total Pizzas Sold
select sum(quantity) as Pizzas_sold
from 
pizza_sales..order_details

--Total orders 
select count(distinct(order_id)) as Pizzas_sold
from 
pizza_sales..order_details

--Avg Pizza sold ber order
select sum(quantity) / count(distinct(order_id)) as Avg_Pizza_ber_order
from 
pizza_sales..order_details

--Daily Trends For Total Orders 
select 
FORMAT(date,'dddd') as Days, 
COUNT(distinct(order_id)) as Total_orders
from pizza_sales.. orders
group by FORMAT(date,'dddd')
order by COUNT(distinct(order_id)) desc

--Hourly Trends For Total Orders 
select 
FORMAT(time,'hh') as Hours, --or Datepart(Hours,time)
COUNT(distinct(order_id)) as Total_orders
from pizza_sales.. orders
group by FORMAT(time,'hh')
order by FORMAT(time,'hh')


--percentage of sales by category
select 
round(sum(quantity * price) , 0 )as Sales_by_category 
,
round(
sum(quantity * price) * 100 / 
(
select sum(quantity * price) 
from 
pizza_sales..order_details o
left join
pizza_sales..pizzas p
on p.pizza_id = o.pizza_id) , 2) as percentage
, 
category
from
pizza_sales..order_details o
left join
pizza_sales..pizzas p
on p.pizza_id = o.pizza_id
left join 
pizza_sales..pizza_types pt
on pt.pizza_type_id = p.pizza_type_id
group By category


--percentage of sales by pizza size 
select 
round(sum(quantity * price) , 0 )as Sales_by_size 
,
round(
sum(quantity * price) * 100 / 
(
select sum(quantity * price) 
from 
pizza_sales..order_details o
left join
pizza_sales..pizzas p
on p.pizza_id = o.pizza_id) , 2) as percentage
, 
size
from
pizza_sales..order_details o
left join
pizza_sales..pizzas p
on p.pizza_id = o.pizza_id
left join 
pizza_sales..pizza_types pt
on pt.pizza_type_id = p.pizza_type_id
group By size


--Total Pizza sold by category
select 
round(sum(quantity) , 0 )as Sales_by_category 
, 
category
from
pizza_sales..order_details o
left join
pizza_sales..pizzas p
on p.pizza_id = o.pizza_id
left join 
pizza_sales..pizza_types pt
on pt.pizza_type_id = p.pizza_type_id
group By category


--Top 5 pizza
select top 5
sum(quantity) as Total_quantity 
, 
name
from
pizza_sales..order_details o
left join
pizza_sales..pizzas p
on p.pizza_id = o.pizza_id
left join 
pizza_sales..pizza_types pt
on pt.pizza_type_id = p.pizza_type_id
group By name
order by Total_quantity desc

--Worst 5 pizza
select top 5
sum(quantity) as Total_quantity 
, 
name
from
pizza_sales..order_details o
left join
pizza_sales..pizzas p
on p.pizza_id = o.pizza_id
left join 
pizza_sales..pizza_types pt
on pt.pizza_type_id = p.pizza_type_id
group By name
order by Total_quantity 