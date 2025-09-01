create database musinsa_db_v4;
use musinsa_db_v4;
desc reviews;

SELECT * FROM reviews LIMIT 1;

# 크롤링한 데이터를 바탕으로 어뷰징 등을 판단 가능
SELECT 
	상품명,
	AVG(CHAR_LENGTH(리뷰)) 평균_리뷰_길이
FROM reviews
GROUP BY 상품명
ORDER BY 평균_리뷰_길이 DESC;

SELECT *
FROM reviews
WHERE 리뷰 LIKE '%별로%' OR 리뷰 LIKE '%불편%';