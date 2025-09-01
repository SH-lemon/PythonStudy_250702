# rental과 inventory 테이블을 join하고 , film 테이블에 있는 replacement_cost가 $20 이상인 영화를 대여한 고객의 이름을 찾아주세요.
# 고객의 이름은 소문자로 출력해주세요.
SELECT CONCAT(LOWER(C.first_name), " ",LOWER(C.last_name)) AS Customer_name
FROM customer C
JOIN rental R ON R.customer_id = C.customer_id
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON F.film_id = I.film_id
WHERE F.replacement_cost >= 20;

# film 테이블에서 rating이 "PG-13" 등급인 영화들 중에서,
# 그들의 평균 description 길이보다
# description이 긴 영화의 제목을 찾아주세요.
SELECT title, rating
FROM film
WHERE rating = "PG-13" AND
length(description) > (
	SELECT AVG(length(description)) 
    FROM film
    WHERE rating = "PG-13"
);

# customer와 rental, inventory, film 테이블을 join하여 2005년 8월에 대여된
# 모든 "R" 등급 영화의 제목과 해당 영화를 대여한 고객의 이메일을 찾아주세요.
select * from film limit 1;
SELECT F.title, C.email FROM film F
JOIN inventory I ON F.film_id = I.film_id
JOIN rental R ON R.inventory_id = I.inventory_id
JOIN customer C ON C.customer_id = R.customer_id
WHERE F.rating = "R" AND YEAR(rental_date) = 2005 AND MONTH(rental_date) = 08;

SELECT F.title, C.email FROM film F
JOIN inventory I USING(film_id)
JOIN rental R USING(inventory_id)
JOIN customer C USING(customer_id)
WHERE F.rating = "R" AND YEAR(rental_date) = 2005 AND MONTH(rental_date) = 08;

# payment 테이블에서 가장 마지막에 결제된 일시에서 30일 이전까지의 모든 결제 내역을 찾고
# 해당 결제 내역에 대해서 각 고객별 총 결제 금액과 평균 결제 금액을 소수점 둘째 자리에서 반올림하여 출력하세요
select * from payment limit 1;
SELECT CONCAT(C.first_name, " ", C.last_name) AS customerName,
	SUM(P.amount), ROUND(AVG(P.amount), 2)
FROM payment P
JOIN customer C USING(customer_id)
WHERE P.payment_date >= DATE_SUB((select max(payment_date) from payment), interval 30 day)
GROUP BY C.customer_id, C.first_name, C.last_name;

# actor와 film_actor 테이블을 JOIN 하고 "Sci-Fi" 카테고리에 속한 영화에
# 출연한 배우의 이름을 찾으세요. 그리고 해당 배우의 이름은 성과 이름을 연결하여
# 대문자로 출력하세요.
select * from film_actor ; # actor_id, film_id
select * from actor; # actor_id
select * from film; # film_id
select * from category; # category_id, film_id

SELECT UPPER(CONCAT(A.first_name, " ",A.last_name)) AS actorName, F.title, CA.name genre
FROM actor A
JOIN film_actor FA USING(actor_id)
JOIN film F USING(film_id)
JOIN film_category FC USING(film_id)
JOIN category CA USING(category_id)
WHERE CA.category_id = 14;