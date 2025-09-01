SELECT rating FROM film GROUP BY rating;
SELECT rating, COUNT(*) AS total FROM film GROUP BY rating;

SELECT rating, COUNT(*) AS total FROM film 
WHERE rating = "PG" OR rating = "G"
GROUP BY rating;

# 필름 테이블에서 영화등급이 G 등급인 영화제목을 모두 출력해주세요
SELECT * FROM film limit 5;

SELECT rating, title FROM film
WHERE rating = "G" OR rating = "PG"
ORDER BY rating DESC;

# 필름 테이블에서 영화개봉년도가 2006년 또는 2007년이고, 영화등급이 PG 또는 G인 영화의 제목만 출력해주세요.
SELECT title FROM film
WHERE (release_year = "2006" or release_year = "2007") and (rating = "PG" or rating = "G");

# 필름 테이블에서 rating으로 그룹을 묶어서, 각 등급별 영화 개수와 등급, 각 그룹별 평균 rental_rate를 출력해주세요.
SELECT * FROM FILM LIMIT 3;
SELECT rating, COUNT(*) as total_movies, AVG(rental_rate) as avg_rental_rate FROM film
GROUP BY rating;

# GROUP BY -> 집계함수를 사용해서 들어오면, 해당 컬럼값이 실제 그룹핑과 관계가 없더라도 출력값으로 허용해줌 (*예외조항)
# 필름 테이블에서 rating으로 그룹을 묶어서 각 등급별 영화 개수와 각 등급별 평균 렌탈비용을 출력하는데, 평균 렌탈비용이 높은 순으로 출력해주세요!

SELECT rating, COUNT(*) as total_movies, AVG(rental_rate) as avg_rental_rate FROM film
GROUP BY rating
ORDER BY avg_rental_rate DESC;

# 각 등급별 영화 길이가 130분 이상인 영화의 개수와 등급을 출력해보세요!
select * from film;
SELECT rating, count(*) AS films FROM film
WHERE length >= "130"
GROUP BY rating
ORDER BY films DESC;