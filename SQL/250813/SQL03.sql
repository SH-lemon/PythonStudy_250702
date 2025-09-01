show tables;

select * from customer limit 3;
select * from payment limit 3;

SELECT
	first_name,
    last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
    WHERE amount > (SELECT AVG(amount) FROM payment)
);

create database musinsa_top50;
use musinsa_top50;
show tables;
desc products;
select * from products;