/* Q1. How many pizzas were ordered? */

select COUNT((pizza_id)) as Total_pizza
from customer_orders
-----------------------------------------------
/* Q2. How many unique customer orders were made? */

SELECT COUNT(DISTINCT(CUSTOMER_ID) ) AS TOTAL_CUSTOMER_ORDERS
FROM CUSTOMER_ORDERS
-----------------------------------------------
/* Q3. How many successful orders were delivered by each runner? */

SELECT count(ORDER_ID) AS SUCCESSFUL_ORDERS
FROM RUNNER_ORDERS
WHERE CANCELLATION IS NULL OR CANCELLATION = 'null'
-----------------------------------------------
/* Q4. How many of each type of pizza was delivered? */

SELECT C.PIZZA_ID, COUNT(C.ORDER_ID)
FROM RUNNER_ORDERS AS R
INNER JOIN CUSTOMER_ORDERS AS C
ON R.ORDER_ID = C.ORDER_ID
WHERE CANCELLATION IS NULL OR CANCELLATION = 'null'
GROUP BY C.PIZZA_ID
-----------------------------------------------
/* Q5. How many Vegetarian and Meatlovers were ordered by each customer? */

select pn.pizza_name, count(c.order_id) from customer_orders as c
inner join pizza_names as pn
on c.pizza_id=pn.pizza_id
group by pn.pizza_name
-----------------------------------------------
/* Q6. What was the maximum number of pizzas delivered in a single order? */

select count(pizza_id) as Max_num_pizza  from customer_orders
group by order_id order by count desc
limit 1
-----------------------------------------------
/* Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes? */

with cust1 as(select c.customer_id, c.pizza_id,c.exclusions, c.extras from customer_orders as c
inner join runner_orders as rn
on rn.order_id = c.order_id
where rn.cancellation= 'null' or rn.cancellation is null)
select customer_id, 
count(case when exclusions ='null' and extras='null' then pizza_id end) as pizzas_no_change,
count(case when exclusions ='null' or extras='null' then pizza_id end)
as pizzas_1_change from cust1
group by customer_id
-----------------------------------------------
/* Q8. How many pizzas were delivered that had both exclusions and extras? */

select count(c.pizza_id)as exclusions_extras from customer_orders as c
inner join runner_orders as rn
on rn.order_id = c.order_id 
where c.exclusions <> 'null' and c.extras<>'null'
-----------------------------------------------
/* Q9. What was the total volume of pizzas ordered for each hour of the day? */

select extract(hour from order_time) as hour_of_day, count(pizza_id) as total_pizza from customer_orders
where order_time is not null
group by hour_of_day
-----------------------------------------------
/* Q10.What was the volume of orders for each day of the week? */

select extract(dow  from order_time) as day_of_week, count(pizza_id) as total_pizza from customer_orders
where order_time is not null
group by day_of_week






	
	









