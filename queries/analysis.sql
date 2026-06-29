-- What is the total revenue?
select sum(total_amount) AS total_revenue
FROM retail_sales;

-- How many unique customers are there?
select count(distinct customer_id) as Unique_customer from retail_sales;

-- Which product category is the most expensive?
select product_category , max(price_per_unit) AS max_price from retail_sales
group by product_category order by max_price desc limit 1;

-- How many total orders are there?
select count(*) as total_order from retail_sales;

-- What is the average order value of each product?
select product_category, avg(total_amount)
as avg_order_value from retail_sales group by
product_category order by avg_order_value desc;

-- Total sales per category?
select product_category , sum(total_amount) as total_sales from
retail_sales group by product_category;

-- Male vs Female — who places more orders?
select gender , sum(total_amount) as total_purchase 
from retail_sales group by gender
order by total_purchase desc;


-- Top 5 highest spending customers?
select customer_id , sum(total_amount) as Total_purchase
from retail_sales group by customer_id order by Total_purchase desc limit 5;

-- Which month generated the most revenue?
select to_char(date,'yyyy-mm') as months , sum(total_amount) as total_sales
from retail_sales
group by months 
order by total_sales
desc;

-- Which category sold the most by quantity?
select product_category, sum(quantity) as total_qty from
retail_sales group by product_category order by total_qty desc limit 1;

-- Revenue breakdown by age group?
select
	case
		when age < 25 then 'Under 25'
		when age between 25 and 34 then '25-34'
		when age between 35 and 44 then '35-44'
    	when age between 45 and 54 then '45-54'
		else '55+'
	end as age_group
,sum(total_amount) as revenue 
from retail_sales group by age_group order by revenue desc;


-- Revenue for each month and comparison with the previous month?
WITH monthly_data AS (
    SELECT 
        TO_CHAR(date, 'YYYY-MM') AS month,
        SUM(total_amount) AS revenue
    FROM retail_sales
    GROUP BY TO_CHAR(date, 'YYYY-MM')
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS difference
FROM monthly_data
ORDER BY month;


-- Cross-analysis of gender and category?
select gender,product_category ,sum(total_amount) as total_purchase 
from retail_sales group by gender,product_category
order by gender , total_purchase desc;

-- Best day of the week for sales?
select to_char(date,'day') as day_name,
sum(total_amount) as total_sales from retail_sales group by day_name
order by total_sales desc;

-- Which customers made a purchase only once?
select customer_id , count(*) as order_count 
from retail_sales group by customer_id having count(*) = 1 order by customer_id;

