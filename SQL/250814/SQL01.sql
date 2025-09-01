use sakila;

show tables;

SELECT
	first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
    WHERE amount > 3
)
LIMIT 5;

SELECT
	first_name,
	last_name
FROM customer C
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
    GROUP BY customer_id 
    HAVING COUNT(*) > (
		SELECT
			AVG(payment_count)
		FROM (
			SELECT COUNT(*) AS payment_count
            FROM payment
            GROUP BY customer_id
		) AS payment_count
	)
);

SELECT
	first_name,
    last_name
FROM customer
WHERE customer_id = (
	SELECT customer_id
    FROM (
		SELECT customer_id, COUNT(*) AS payment_count
        FROM payment
        GROUP BY customer_id
    ) AS payment_counts
	ORDER BY payment_count DESC
    LIMIT 1
);

# film 테이블에서 평균 영화길이(length)보다 긴 영화들의 제목을 찾아주세요!

SELECT * FROM film;
SELECT title
FROM film
WHERE length > (
	SELECT AVG(length)
    FROM film
)
GROUP BY title;

# rental 테이블에서 고객별 평균 대여 횟수보다 많은 대여를 한 고객들의 이름 (first, last)을 찾아주세요.
select * from rental limit 1;
select * from customer limit 1;
SELECT
	first_name,
    last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT AVG(rental_count)
        FROM (
			SELECT customer_id, COUNT(*) AS rental_count
            FROM rental
            GROUP BY customer_id
        ) AS rental_counts
    )
);

# 가장 많은 영화를 대여한 고객의 이름(first, last)을 찾아주세요!
SELECT
	first_name,
    last_name
FROM customer
WHERE customer_id = (
	SELECT customer_id
    FROM (
		SELECT customer_id, COUNT(*) AS rental_count
		FROM rental
		GROUP BY customer_id
	) AS rental_counts
    ORDER BY rental_count DESC
    LIMIT 1
);

# 각 고객에 대해 자신이 대여한 평균 영화 길이보다 긴 영화들의 제목을 출력하세요.
SELECT * from customer limit 1; # customer_id
select * from film limit 1; # film_id
select * from rental limit 1; # inventory_id, customer_id
select * from inventory; # inventory_id, film_id

# 고객별 평균 길이
# rental -> inventory_id -> film_id(film) -> length
# rental의 inventory_id가 inventory의 것과 같음
# inventory의 film_id가 film의 것과 같음
# film의 평균 length를 rental의 customer_id별로 묶음

SELECT
	C.first_name, C.last_name, F.title
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON F.film_id = I.film_id
WHERE F.length > (
	SELECT AVG(FIL.length)
    FROM film FIL
    JOIN inventory INV ON REN.inventory_id = INV.inventory_id
    JOIN rental REN ON C.customer_id = REN.customer_id
    JOIN film F ON FIL.film_id = INV.film_id
    WHERE REN.customer_id = C.customer_id
)
