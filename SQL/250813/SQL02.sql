USE sakila;
SHOW TABLES;
SELECT * FROM actor LIMIT 10;
SELECT title, LENGTH(title) FROM film LIMIT 10;
SELECT title, LOWER(title) FROM film LIMIT 10;

select
	title, length(title) title_length
from film limit 10;

SELECT 
	CONCAT(first_name, " ", last_name)
FROM actor LIMIT 10;

SELECT 
	description, SUBSTRING(description, 1, 10) AS Short_Description
FROM film LIMIT 10;

# film 테이블에 가서 영화제목이 15자인 영화를 출력해주세요!

SELECT title FROM film
WHERE LENGTH(title) = 15;

# actor 테이블에서 첫번째 이름이 소문자로 john인 배우들의 전체 이름을 대문자로 변환 및 출력
select UPPER(CONCAT(first_name, " ", last_name)) John_fullName from actor
where first_name = "john";

# flim 테이블에서 description의 3번째 글자부터 6글자가 "action"인 영화의 제목을 찾아서 출력해주세요
select description from film
where substring(description,3,6) = "action";

select curtime();

# 일 단위의 값을 추가
select
	rental_date,
    date_add(rental_date, interval 7 day)
from rental
limit 10;

# 월 단위의 값을 추가
select
	rental_date,
    date_sub(rental_date, interval 1 year)
from rental
limit 10;

SELECT
	payment_date,
    EXTRACT(YEAR FROM payment_date)
FROM payment;
# 구체적으로 특정 년도에 해당하는 데이터값만 추출하여 찾아오는 데 매우 유용함

# 렌탈되고 있는 각 월마다의 빌려가는 횟수 등을 확인
SELECT * FROM payment LIMIT 10;

SELECT
	EXTRACT(MONTH FROM payment_date) AS payment_month, COUNT(*)
FROM payment
GROUP BY payment_month;

select
	year(payment_date) as payment_year,
    month(payment_date) as payment_month,
    day(payment_date) as payment_day
from payment;

select
	dayofweek(payment_date)
from payment
group by dayofweek(payment_date);

select
	date_format(payment_date, '%a') AS payment_dayname,
    count(*) AS total_count
from payment
group by payment_dayname;

select
	CASE dayofweek(payment_date)
		WHEN 1 THEN '일요일'
        WHEN 2 THEN '월요일'
        WHEN 3 THEN '화요일'
        WHEN 4 THEN '수요일'
        WHEN 5 THEN '목요일'
        WHEN 6 THEN '금요일'
        WHEN 7 THEN '토요일'
	END AS payment_dayname,
    count(*)
from payment
group by payment_dayname;

show tables;

select rental_date, return_date,
	TIMESTAMPDIFF(week, rental_date, return_date) as rental_days
from rental
limit 5;

select
	rental_id,
    rental_date,
    DATE_FORMAT(rental_date, '%Y-%m-%D') as formatted_rental_date
from rental
limit 5;

# rental 테이블에서 대여 시작날짜가 2006년 1월 1일 이후인 모든 대여에 대해
# 예상반납 날짜를 대여 날짜로부터 5일 뒤로 설정하여, 출력해주세요!

select 
	date_format(rental_date, '%Y-%m-%d') as rental_date,
    date_format(date_add(rental_date, interval 5 day),'%Y-%m-%d') as return_date
from rental
where rental_date > '2006-01-01';

select rental_date from rental
where year(rental_date) = 2006
group by rental_date;

select 
	-amount,
    ABS(-amount) AS Absolute_amount,
    CEIL(amount) as ceiling_amount,
    FLOOR(amount) as floor_amount,
    round(amount,1)
from payment
limit 10;

select sqrt(4);

# payment 테이블에서 결제금액(amount)이 5 이하인 모든 결제에 대해 절대값을 계산하여 출력해주세요!
select abs(amount), round(amount) from payment
where amount <= 5;

# film 테이블에서 영화길이가 120분 이상인 모든 영화에 대해 영화 길이의 제곱근을 계산해주세요
select * from film limit 1;
select title, length, sqrt(length), round(sqrt(length),1) from film
where length >= 120;

# payment 테이블에서 결제금액을 소수점 첫번째 자리에서 반올림해 출력해주세요.
select * from payment limit 1;
select round(amount, 1) rounded_amount from payment;
select round(sum(amount), 1) from payment;