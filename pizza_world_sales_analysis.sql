create database pizza_world;

use pizza_world;


-- Q1  Retrieve the total numbers of orders placed.

select count(order_id)
from orders;


-- Q2  Retrieve the total numbers of orders placed.

select count(order_id)
from orders;


-- Q3  find the category-wise distribution of pizzas

select category, count(name)
from pizza_types
group by category;


-- Q4  Identify the highest-priced pizza.

select price, name 
from pizzas
join pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id
order by price desc limit 1;


-- Q5  Identify the most common pizza size ordered. 

select size, count(order_details_id) as a
from pizzas
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by size order by a desc limit 1;


-- Q6  list the mot common pizza types along with their quatities. 

select name, sum(quantity) as b
from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by name order by b desc limit 5;


-- Q7  join the necessary tables to find the total quantity of each pizza ordered.

select category , count(quantity) as a
from pizza_types
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by category order by a desc;


-- Q8  determine the distribution of orders by hour of the day.

select hour(order_time) , count(order_id) as a
from orders
group by hour(order_time)  order by a desc;


-- Q9  group the orders by date and calculate the avg number of pizzas ordered per day.

select avg(q)
from 
(select order_date , sum(quantity) as q
from orders
join order_details
on orders.order_id = order_details.order_id
group by order_date) as quantity;


-- Q10  Determine the top 3 most ordered pizza types based on revenue.

select name , sum(quantity*price) as revenue
from order_details
join pizzas
on pizzas.pizza_id = order_details.pizza_id
join pizza_types
on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by name order by revenue desc limit 3;


-- Q11  calculate the percentage contribution of each pizza type to total revenue. 

select category, sum(quantity*price) / (select sum(order_details.quantity*pizzas.price)
from pizzas
join order_details
on pizzas.pizza_id=order_details.pizza_id) -- total revenue query
 *100 as percentage
from order_details
join pizzas
on pizzas.pizza_id = order_details.pizza_id
join pizza_types
on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by category;


-- Q12  analyze the total revenue generated over time.

select order_date ,sum(revenue) over(order by order_date)
from
(select order_date , sum(quantity*price) as revenue
from order_details
join pizzas
on pizzas.pizza_id = order_details.pizza_id
join orders
on orders.order_id = order_details.order_id
group by order_date) as sales;



