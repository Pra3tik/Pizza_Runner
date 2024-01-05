/* Q1. How many runners signed up for each 1 week period? 
(i.e. week starts 2021-01-01) */

SELECT
	DATE_TRUNC('WEEK', registration_date) AS week_start,
    COUNT(*) AS number_of_runners
FROM runners
WHERE registration_date >= '2021-01-01'
GROUP BY week_start
ORDER BY week_start

----------------------------------------------------------------------------------------
/* Q2. What was the average time in minutes it took for each runner
to arrive at the Pizza Runner HQ to pickup the order? */

SELECT 
     R.RUNNER_ID, 
     AVG(R.PICKUP_TIME-C.ORDER_TIME) AS AVGERAGE_TIME 
FROM RUNNER_ORDERS AS R
INNER JOIN CUSTOMER_ORDERS AS C
ON C.ORDER_ID = R.ORDER_ID	
GROUP BY R.RUNNER_ID

-----------------------------------------------------------------------------------------
/* Q3. Is there any relationship between the number of pizzas
and how long the order takes to prepare? */

SELECT 
C.ORDER_ID,
COUNT(C.PIZZA_ID) AS NO_OF_PIZZAS,
AVG(R.PICKUP_TIME-C.ORDER_TIME) AS NOD
FROM CUSTOMER_ORDERS AS C
INNER JOIN RUNNER_ORDERS AS R
ON R.ORDER_ID= C.ORDER_ID
WHERE R.PICKUP_TIME IS NOT NULL
GROUP BY C.ORDER_ID

-----------------------------------------------------------------------------------------
/* Q4. What was the average distance travelled for each customer? */

SELECT 
C.CUSTOMER_ID,
round(AVG(R.DISTANCE),1)
FROM CUSTOMER_ORDERS AS C
INNER JOIN RUNNER_ORDERS AS R
ON R.ORDER_ID=C.ORDER_ID
WHERE R.DISTANCE is not null
GROUP BY C.CUSTOMER_ID

-----------------------------------------------------------------------------------------
/* Q5. What was the difference between the longest and shortest
delivery times for all orders? */

select 
max(duration) as longest_delivery_time,
min (duration) as shortest_delivery_time
from runner_orders

-----------------------------------------------------------------------------------------
/* Q6. What was the average speed for each runner for each delivery 
and do you notice any trend for these values? */

SELECT 
RUNNER_ID,
ROUND(AVG(DURATION),1) AS Average_speed
FROM RUNNER_ORDERS
GROUP BY RUNNER_ID
ORDER BY RUNNER_ID ASC

-----------------------------------------------------------------------------------------
/* Q7. What is the Successful delivery percentage for each runner? */

SELECT R.RUNNER_ID, ((COUNT(CASE WHEN R.PICKUP_TIME IS NOT NULL THEN R.PICKUP_TIME END)*100)/COUNT(C.ORDER_TIME)) AS DELIVERY_PERCENTAGE FROM RUNNER_ORDERS AS R
RIGHT JOIN CUSTOMER_ORDERS AS C
ON R.ORDER_ID = C.ORDER_ID
GROUP BY R.RUNNER_ID


