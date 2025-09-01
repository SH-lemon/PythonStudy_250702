CREATE DATABASE IF NOT EXISTS bestproducts;
USE bestproducts;

DESC items;
SELECT * FROM items LIMIT 5;

SELECT provider FROM items
GROUP BY provider;

# 가설: 베스트 랭킹에 등록되어 있는 약 1만개 이상의 업체들 가운데 진짜 베스트 업체라면, 약 100개 정도의 자사 혹은 위탁 상품이 있을 것이다.

SELECT provider, COUNT(*) AS Total FROM items
WHERE COUNT(*) >= 100
GROUP BY provider
ORDER BY Total DESC;

# SUM, MAX, MIN, AVG, COUNT 등과 같은 집계함수들은 절대 GROUP BY 와 WHERE절로는 사용불가!
# 이때 HAVING절을 사용해야 함
# 결론: GROUP BY와 집계함수는 WHERE절 절대 사용 불가
# HAVING절의 위치는 반드시 GROUP BY 뒤

SELECT provider, AVG(ori_price) FROM items
GROUP BY provider HAVING COUNT(*) >= 100;

# GROUP BY 설정을 했다고 해서 아예 집계함수 사용 불가 x
# WHERE절 안에 집계함수를 사용하는 것만 불가

SELECT provider FROM items
WHERE
	provider != "스마일배송" AND
    provider != ""
GROUP BY provider
HAVING COUNT(*) >= 100
ORDER BY COUNT(*) DESC;

JOIN idol ID
ON ranking.item_code = items.item_code
WHERE main_category = "ALL";

SELECT title FROM items I
JOIN ranking R
ON R.item_CODE = I.item_code
WHERE main_category = "ALL";
# 메인카테고리 ALL에서 "판매자별 베스트상품 개수를 출력해주세요"

SELECT provider, COUNT(*) FROM items
JOIN ranking
ON ranking.item_code = items.item_code
WHERE main_category = "ALL"
GROUP BY provider
ORDER BY COUNT(*) DESC
LIMIT 10;

# 메인카테고리가 "패션의류"인, 패션의류 전체 베스트상품에서 판매자별 베스트상품 개수가 5 이상인 판매자와 해당 베스트상품 개수를 출력해주세요.

SELECT provider, COUNT(*) FROM items I
JOIN ranking R
ON R.item_code = I.item_code
WHERE main_category = "패션의류"
GROUP BY provider
HAVING COUNT(*) >= 5
ORDER BY COUNT(*) DESC;

select distinct main_category from ranking;

# 메인카테고리가 신발/잡화이고, 판매자별 상품개수가 10개 이상인 판매자명과 상품개수 출력

SELECT provider, COUNT(*) FROM items I
JOIN ranking R
ON R.item_code = I.item_code
WHERE main_category = "신발/잡화"
GROUP BY provider
HAVING COUNT(*) >= 10
ORDER BY COUNT(*) DESC;

# 메인카테고리가 화장품/헤어일 때, 평균/최대/최소 할인 가격을 출력해주세요!

SELECT 
	main_category, 
	AVG(dis_price), 
    MAX(dis_price), 
    MIN(dis_price) 
FROM items I
JOIN ranking R
ON R.item_code = I.item_code
WHERE main_category = "화장품/헤어";