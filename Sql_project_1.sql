create database  SQl_Project;
use sql_project;

create table Retail_sales
(
transactions_id	int primary key,
sale_date	date,
sale_time	time,
customer_id	int,
gender	varchar(15),
age	int,
category	varchar(25),
quantiy	int,
price_per_unit	float,
cogs	float,
total_sale float 

);

-- --checking null values and cleaning process
select * from retail_sales
where 
     transactions_id is null
     or
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
     age is null
     or
     quantiy is null
     or
     price_per_unit is null
     or
     cogs is null
     or
     total_sale is null
     
     
-- -- Data Exploration
-- --How many sales we have?
select count(*) as Total_sales from retail_sales

-- --How many unique customers we have
select count(distinct customer_id) as total_sales from retail_sales

-- -- How to check types of category in table.
select distinct category from retail_sales

-- --Data Analysis and Business Key Problems & Answers?

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from retail_sales
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from retail_sales
where category='clothing'
and quantiy>3
and sale_date between '2022-11-01' and '2022-11-30'


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category
select category, sum(total_sale) as Net_sale,
count(*) as Total_order
from retail_sales
group by 1


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2) as Average_Age
from retail_sales
where category='beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where Total_sale>1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
       category, 
	   gender, 
       count(*) as Total_transactions 
from retail_sales
group 
     by 
       category,
       gender
order by 1 

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select 
      year(sale_date),
      month(sale_date),
      round(avg(total_sale), 2) as avg_sales
from retail_sales
group by 1, 2
order by 1, 3 desc



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
select 
      customer_id,
      sum(total_sale) as Total_sales
from retail_sales
group by 1
order by 2 desc
limit 5



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
	   category,
       count(distinct customer_id) as unique_customer
from retail_sales
group by 1


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
With hourly_sale
as
(
select * ,
	case
        when Hour(sale_time) <12 then   'Morning'
        when Hour(sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
	End as Shift
from retail_sales
)
select 
      shift,
      count(*) as Total_orders
from hourly_sale
group by shift

-- End of Project
