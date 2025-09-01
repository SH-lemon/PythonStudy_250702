USE sakila;
# 1. 성(last_name)이 ‘%SON’ 으로 끝나는 배우의 actor_id, first_name, last_name 출력, 성 오름차순.
SELECT actor_id, first_name, last_name FROM actor
WHERE last_name LIKE "%SON";

# 2. 영화 rating='PG-13' 인 영화의 film_id, title, rating 10개만, title 오름차순
SELECT film_id, title, rating FROM film
WHERE rating = "PG-13"
ORDER BY title
LIMIT 10;

# 3. rental_rate 내림차순 상위 15편의 film_id, title, rental_rate 조회.
SELECT film_id, title, rental_rate
FROM film
ORDER BY rental_rate DESC 
LIMIT 15;

# 4. 카테고리 이름과(없으면 NULL) 영화 수를 구해 개수 내림차순 정렬.
SELECT CA.name Categories, COUNT(*) Total_film FROM film F
JOIN film_category FC USING(film_id)
JOIN category CA USING(category_id)
GROUP BY Categories
ORDER BY Total_film DESC;