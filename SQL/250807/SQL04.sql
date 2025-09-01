CREATE DATABASE IF NOT EXISTS musinsa_db_v3;
USE musinsa_db_v3;

CREATE TABLE IF NOT EXISTS  customers (
	customer_id INT PRIMARY KEY,
    name VARCHAR(40),
    age INT,
    gender VARCHAR(10),
    address TEXT, # 2바이트 메모리 값을 고정값으로 가져가는 타입
    phone VARCHAR(20),
    email VARCHAR(50),
    grade VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS  products (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    stock INT,
    main_category VARCHAR(50),
    sub_category VARCHAR(50),
    price INT,
    discount_price INT,
    discount_rate INT
);
CREATE TABLE IF NOT EXISTS  orders (
	order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE IF NOT EXISTS  reviews (
	review_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT,
    review_text TEXT,
    review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

# 회원등급별 인원수 출력
SELECT grade, COUNT(*) AS Total FROM customers
GROUP BY grade
ORDER BY COUNT(*) DESC;

SELECT grade, COUNT(*) Total FROM orders
JOIN customers
ON customers.customer_id = orders.customer_id
GROUP BY grade
ORDER BY COUNT(*) DESC;

SELECT product_name, AVG(rating) FROM reviews
JOIN products
ON products.product_id = reviews.product_id
GROUP BY product_name
ORDER BY AVG(rating) DESC;

SELECT COUNT(*) Total_orders FROM orders
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;

# 상품별 최근 한 달간 주문건수
SELECT product_name, orders.product_id, COUNT(*) recent_order_count 
FROM orders
JOIN products
ON products.product_id = orders.product_id
WHERE order_date >= CURDATE() - INTERVAL 30 DAY
GROUP BY product_name, orders.product_id
ORDER BY COUNT(*) DESC;

select product_id, count(*) from orders
group by product_id;

# 고객별 건수와 구매 수량을 구하고 출력해주세요!

SELECT orders.customer_id, customers.name, COUNT(*) order_count, SUM(quantity) total_quantity FROM orders
JOIN customers
ON customers.customer_id = orders.customer_id
GROUP BY orders.customer_id, customers.name;

# 고객별 총 구매금액을 계산 후 출력해주세요
# 고객 이름-고객, 총량-오더, 할인가-프로덕트 // 곱하기
SELECT name, SUM(orders.quantity*products.discount_price) Total_purchase FROM orders
JOIN customers
ON customers.customer_id = orders.customer_id
JOIN products
ON products.product_id = orders.product_id
GROUP BY customers.name
ORDER BY name;

SELECT O.customer_id, C.name, SUM(P.discount_price * O.quantity) total_spent
FROM orders O
JOIN customers C on O.customer_id = C.customer_id
JOIN products P on O.product_id = P.product_id
GROUP BY O.customer_id
ORDER BY name;
select * from products;

# 지금까지 가장 많이 판매된 상품 top5를 출력해주세요!
SELECT P.product_name, SUM(quantity) FROM orders
JOIN products P on orders.product_id = P.product_id
GROUP BY P.product_name
ORDER BY SUM(quantity) DESC
LIMIT 5;

USE musinsa_db_v3;
# 평균 평점이 4.5 이상인 상품명과 평점 출력 (*인기상품)
SELECT product_name, AVG(rating) FROM reviews
JOIN products ON products.product_id = reviews.product_id
GROUP BY product_name
HAVING AVG(rating) >= 4.5000;

select product_name, count(*) from reviews
JOIN products ON products.product_id = reviews.product_id
group by product_name
order by count(*) desc;