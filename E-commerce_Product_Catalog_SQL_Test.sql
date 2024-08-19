CREATE DATABASE Ecommerce;
use Ecommerce;

create table IF NOT EXISTS products(
product_id Int AUTO_INCREMENT primary key,
product_name varchar(50),
category_id int,
price decimal(10,2),
stock_quantity int,
created_at date,
updated_at date
);


insert into products ( product_id, product_name,category_id,price, stock_quantity, created_at,updated_at)values 
( 1, 'laptop', 1, 50000.00, 50, '2024-08-01', '2024-08-19'),
( 2, 'headphone', 1, 500.00, 100, '2024-07-07', '2024-07-12'),
( 3, 'smartphone', 2, 20000.00, 150, '2024-06-03', '2024-06-13'),
( 4, 'keyboard', 2, 700.00, 30, '2024-05-08', '2024-05-17'),
( 5, 'monitor', 2, 30000.00, 40, '2024-04-01', '2024-04-08'),
( 6, 'mouse', 1, 350.00, 80, '2024-03-09', '2024-03-11'),
( 7, 'charger', 3, 750.00, 20, '2024-02-11', '2024-02-10'),
( 8, 'smartwatch', 1, 5000.00, 10, '2024-01-13', '2024-01-12'),
( 9, 'camera', 4, 70000.00, 90, '2024-06-01', '2024-08-10'),
( 10, 'tablet', 1, 90000.00, 120, '2024-08-01', '2024-08-12')
;

 select * from products limit 10; 
 
 
 CREATE table IF NOT EXISTS categories(
 category_id int NOT NULL UNIQUE,
 category_name varchar(30),
 foreign key (category_id) references products(category_id)
 );
 
 insert into categories ( category_id, category_name ) values
 (1, 'electronics'),
 (2, 'accessories'),
 (3, 'chargers'),
 (4, 'Cameras'),
 (5, 'wearables');
 
select * from categories limit 5;



SET @AUTO_INCREMENT_INCREMENT=1;
CREATE TABLE IF NOT EXISTS orders (
order_id int AUTO_INCREMENT PRIMARY KEY,
customer_id int NOT NULL,
order_date date,
total_amount decimal(10,2),
orders_status varchar(20)
)AUTO_INCREMENT = 1;

insert into orders (order_id, customer_id, order_date, total_amount, orders_status) VALUES 
( 1, 1, '2024-08-26', 2000.00, 'completed'),
( 2, 2, '2024-07-29', 800.00, 'completed'), 
( 3, 3, '2024-06-21', 450.00, 'completed'), 
( 4, 4, '2024-05-19', 600.00, 'completed'), 
( 5, 5, '2024-04-01', 1300.00, 'pending'), 
( 6, 6, '2024-03-14', 500.00, 'completed'), 
( 7, 7, '2024-02-11', 750.00, 'pending'), 
( 8, 8, '2024-01-08', 1200.00, 'completed'),
( 9, 9, '2024-08-06', 900.00, 'completed'),
( 10, 10, '2024-07-03', 1400.00, 'pending');

select * from orders limit 10;

CREATE TABLE IF NOT EXISTS order_items(
order_item_id int NOT NULL UNIQUE,
order_id int NOT NULL,
product_id int,
quantity int,
price decimal(10,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES 
( 1, 1, 1, 1, 1200.00),
( 2, 1, 10, 2, 600.00),
( 3, 1, 8, 1, 800.00),
( 4, 2, 9, 1, 250.00),
( 5, 3, 6, 4, 1000.00),
( 6, 4, 2, 7, 1250.00),
( 7, 5, 3, 11, 1300.00),
( 8, 6, 5, 19, 500.00),
( 9, 7, 7, 16, 700.00),
( 10, 7, 4, 10, 650.00);

select * from order_items limit 10;

CREATE TABLE IF NOT EXISTS customers (
customer_id int NOT NULL,
first_name varchar(30) UNIQUE,
last_name varchar(30) UNIQUE,
email varchar(40) UNIQUE,
phone varchar(10),
address TEXT,
FOREIGN KEY (customer_id) REFERENCES orders(customer_id)
);

INSERT INTO customers (customer_id, first_name, last_name, email, phone, address) VALUES 
( 1, 'Navateja' , 'Gogula' , 'gogula@gmail.com ', '967-677', ' 123 hanuman colony, kamareddy'),
( 2, 'Nirup' , 'Gupta' , 'gupta@gmail.com', '960-000', ' 1 victory colony, siddipet'), 
( 3, 'Praneeth' , 'Goud' , 'goud@gmail.com', '967-000', ' 13 new jersey colony, medak'), 
( 4, 'srikar' , 'Reddy' , 'reddy@gmail.com', '967-111', ' 1230 masjid colony, kachapur'), 
( 5, 'Lucas' , 'Garcia' , 'garcia@gmail.com', '967-111', ' 3 hyper Towers, hyderabad'), 
( 6, 'Edison' , 'Thomas' , 'thomas@gmail.com', '967-711', ' 1234 colony, domakonda'), 
( 7, 'kiran' , 'Maisagon' , 'maisagon@gmail.com', '967-772', ' 1235 hanuman colony, jangampally'), 
( 8, 'rikthesh' , 'Kamindla' , 'kamindla@gmail.com', '967-733', ' 1236 colony, bhiknoor'),
( 9, 'chandan' , 'Radarapu' , 'radarapu@gmail.com', '967-883', ' 1237  city colony, Bibipet'), 
( 10, 'gowtham' , 'chintamadaka' , 'chintamadaka@gmail.com', '967-766', ' 1789 colony, Nizamabad');
 
 
 select * from customers limit 10;



-- QUESTIONS

-- 1. Write a query to find the top 3 most expensive products in each category. Use a CTE to achieve this.

WITH cte1 AS (
    SELECT
        product_id,
        product_name,
        category_id,
        price,
        ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY price DESC) AS rn
    FROM
        products
)
SELECT
    product_id,
    product_name,
    category_id,
    price
FROM
    cte1
WHERE
    rn <= 3
ORDER BY
    category_id, 
    rn;



-- 2. Create a trigger that automatically updates the stock_quantity in the products table 
-- whenever a new item is added to an order in the order_items table.

delimiter //
CREATE TRIGGER updatestock_quantitys
AFTER INSERT ON order_items
FOR Each ROW
BEGIN 
UPDATE Products
set stock_quantity = stock_quantity - NEW.quantity
where product_id = NEW.Product_id;
END //
delimiter ; 

-- SET SQL_SAFE_UPDATES = 0; WHEN WE ENCOUNTER AN ERROR LIKE (WE are using safe update mode means by default it is set 1 and trying  to update a table without using a WHERE clause which uses a PRIMARY KEY.) . So to overcome this error we use that statement.
SET
SQL_SAFE_UPDATES = 0;

INSERT INTO order_items(order_item_id, order_id, product_id, quantity, price)
VALUES
(11,12, 1, 2, 50000.00);

INSERT INTO order_items(order_item_id, order_id, product_id, quantity, price)
VALUES
(21,12, 5, 20, 5000.00);

INSERT INTO order_items(order_item_id, order_id, product_id, quantity, price)
VALUES
(18,1, 3, 20, 50000.00);

update products
set stock_quantity=100
where product_id=2;

select * from order_items;
SELECT * FROM Products;



-- 3. Retrieve the most recent order for each customer. 
-- Get the total amount spent + order_id, order_date. 

WITH RecentOrders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM
        orders
)
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM
    RecentOrders
WHERE
    rn = 1; 




-- 4 Write a query to find the top 3 most expensive products in each category. 
-- Use a CTE to achieve this.

WITH cte1 AS (
    SELECT
        product_id,
        product_name,
        category_id,
        price,
        ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY price DESC) AS rn
    FROM
        products
)
SELECT
    product_id,
    product_name,
    category_id,
    price
FROM
    cte1
WHERE
    rn <= 3
ORDER BY
    category_id, 
    rn;





-- 5. Write a query to find the top 5 products with the highest sales revenue in the last 30 days. 
-- You should include the product name, category name, and the total revenue for each product. 
-- Use a CTE to achieve this.

WITH ProductRevenue AS (
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM
        order_items oi
    JOIN
        orders o ON oi.order_id = o.order_id
    JOIN
        products p ON oi.product_id = p.product_id
    JOIN
        categories c ON p.category_id = c.category_id
    WHERE
        o.order_date >= CURDATE() - INTERVAL 30 DAY
    GROUP BY
        p.product_id, p.product_name, c.category_name
),
cte1 AS (
    SELECT
        product_name,
        category_name,
        total_revenue,
        ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS rn
    FROM
        ProductRevenue
)
SELECT
    product_name,
    category_name,
    total_revenue
FROM
   cte1
WHERE
    rn <= 5;



-- 6. Write a query to find customers who have spent more than the average amount spent by all customers.
-- The query should include the customer’s ID, name, and total amount spent.

WITH CustomerSpending AS (
    SELECT
        o.customer_id,
        first_name AS customer_name,
        SUM(o.total_amount) AS total_spent
    FROM
        orders o
    JOIN
        customers c ON o.customer_id = c.customer_id
    GROUP BY
        o.customer_id, c.first_name, c.last_name
),
AverageSpending AS (
    SELECT
        AVG(total_spent) AS avg_spent
    FROM
        CustomerSpending
)
SELECT
    cs.customer_id,
    cs.customer_name,
    cs.total_spent
FROM
    CustomerSpending cs
JOIN
    AverageSpending avgS ON cs.total_spent > avgS.avg_spent;



-- 7. Write a query to find the top 5 customers who have purchased the highest number of distinct 
-- products, along with their total number of distinct products purchased.

WITH CustomerProductCounts AS (
    SELECT
        o.customer_id,
        first_name AS customer_name,
        COUNT(DISTINCT oi.product_id) AS distinct_products_count
    FROM
        order_items oi
    JOIN
        orders o ON oi.order_id = o.order_id
    JOIN
        customers c ON o.customer_id = c.customer_id
    GROUP BY
        o.customer_id, c.first_name, c.last_name
),
RankedCustomers AS (
    SELECT
        customer_id,
        customer_name,
        distinct_products_count,
        ROW_NUMBER() OVER (ORDER BY distinct_products_count DESC) AS rn
    FROM
        CustomerProductCounts
)
SELECT
    customer_id,
    customer_name,
    distinct_products_count
FROM
    RankedCustomers
WHERE
    rn <= 5;



-- 8. Write a query to find all pairs of products that have been purchased together in the same order. 
-- For each pair, display the product names and the order_id where they were both purchased together. 
-- Ensure that you don't list the same pair twice in different orders. 
-- Make sure you add relevant data wrt to this question.

SELECT DISTINCT
    p1.product_name AS product1,
    p2.product_name AS product2,
    oi1.order_id
FROM
    order_items oi1
JOIN
    order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id
JOIN
    products p1
    ON oi1.product_id = p1.product_id
JOIN
    products p2
    ON oi2.product_id = p2.product_id
ORDER BY
    oi1.order_id, p1.product_name, p2.product_name;
