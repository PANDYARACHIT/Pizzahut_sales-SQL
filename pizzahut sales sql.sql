## Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select name,revenue from 
(Select category,name,revenue,
rank() over (partition by category order by revenue desc) as rn
from
(SELECT pizza_types_dummy.category, pizza_types_dummy.name,
sum((order_details.quantity)*pizzas.price) as revenue
from pizza_types_dummy join pizzas
on pizza_types_dummy.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types_dummy.category, pizza_types_dummy.name) as a) as b
where rn <=3;



