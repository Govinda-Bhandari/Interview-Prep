-- Step 1: Create Table 
CREATE TABLE customer_logins (
    Customer_id INT,
    Login_date DATE
);
-- Step 2: Insert Data into Table
INSERT INTO customer_logins (Customer_id, Login_date) VALUES
(101, '2024-03-05'),
(102, '2024-03-10'),
(103, '2024-03-15'),
(104, '2024-03-20'),
(105, '2024-03-25'),
(106, '2024-02-05'),
(107, '2024-02-10'),
(108, '2024-02-15'),
(109, '2024-02-20'),
(110, '2024-01-25'),
(111, '2024-03-30');

-- Step 3: Run the query
select  
    format(Login_date, 'yyyy-MM') as login_month,
    count(distinct current_month.Customer_id) as reactivated_users 
from 
    customer_logins as  current_month
where
 NOT EXISTS (
  select 1
  from customer_logins as  last_month
  where last_month.Customer_id = current_month.Customer_id
   AND last_month.Login_date >= dateadd(month, -1, datefromparts(year(current_month.Login_date), month(current_month.Login_date), 1))
   AND last_month.Login_date < datefromparts(year(current_month.Login_date), month(current_month.Login_date), 1)
    )
group by format(Login_date, 'yyyy-MM')
order by login_month desc;

