SELECT COUNT(*) FROM film;
SELECT * FROM film
LIMIT 10;

SELECT DISTINCT staff_id FROM rental;

# film 테이블에 존재하는 영화 연도를 출력해주세요.

SELECT DISTINCT release_year FROM film;

SELECT * FROM rental limit 10;

# 렌탈 테이블에서 인벤토리 아이디값이 367인 값만 출력한다면?
select * from rental
where inventory_id=367;

# 고객 관련 데이터를 찾아보고 싶다!
SELECT COUNT(*) FROM customer;
SELECT * FROM customer LIMIT 5;

SELECT COUNT(*) FROM payment;
SELECT * FROM payment LIMIT 5;

SELECT SUM(amount), AVG(amount), MAX(amount), MIN(amount) FROM payment;

# rental 테이블에서 inventory_id가 367이면서 staff_id가 1인 값을 찾아주세요.
select * from rental
WHERE inventory_id = 367 and staff_id = 1;

select rating, count(*) from film group by rating;