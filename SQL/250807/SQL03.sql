USE Sakila;
select * from address limit 1;
select * from customer limit 1;

SELECT * FROM customer
RIGHT OUTER JOIN address
ON customer.address_id = address.address_id
WHERE customer_id IS NULL;

# 서브 카테고리가 "여성신발"인 상품 타이틀만 가져오기
USE bestproducts;

SELECT title FROM items
JOIN ranking
ON items.item_code = ranking.item_code
WHERE ranking.sub_category = "여성신발";

# 서브쿼리 구문을 활용해서 서로 다른 두 개의 테이블을 연결해서 값을 찾아온다면?

SELECT item_code FROM items
limit 3;

SELECT title FROM items
WHERE
	item_code = "102425348" OR
    item_code = "104914497" OR
    item_code = "106332300";
    
SELECT title FROM items
WHERE item_code IN
	("102425348", "104914497", "106332300");
    
SELECT title FROM items
WHERE item_code IN
	(SELECT item_code FROM ranking
    WHERE sub_category = "여성신발");
    
USE sakila;

select * from category;

SELECT category_id, COUNT(*)
FROM film_category
WHERE film_category.category_id > 
	(SELECT category.category_id FROM category
    WHERE category.name = "Comedy")
GROUP BY film_category.category_id;

# bestproducts > 메인 카테고리별로 할인 가격이 10만원 이상인 상품이 몇 개 있는지 출력(JOIN 사용)
 USE bestproducts;
 
 SELECT main_category, COUNT(*) AS Total
 FROM ranking
 JOIN items
 ON ranking.item_code = items.item_code
 WHERE items.dis_price >= 100000
 GROUP BY main_category
 ORDER BY COUNT(*) DESC;
 
 # 방금 작성한 코드를 서브쿼리로 구현하기
 
 SELECT main_category, COUNT(*) AS Total
 FROM ranking
 WHERE item_code IN
	(SELECT item_code FROM items
    WHERE dis_price >= 100000)
GROUP BY main_category
ORDER BY COUNT(*) DESC;

# dis_price가 20만원 이상인 아이템들의 서브 카테고리별 상품 개수 출력

SELECT sub_category, COUNT(*) AS Total_prods FROM ranking
JOIN items
ON ranking.item_code = items.item_code
WHERE items.dis_price >= 200000
GROUP BY sub_category
ORDER BY COUNT(*) DESC;

SELECT sub_category, COUNT(*) AS Total_prods FROM ranking
WHERE item_code IN
	(SELECT item_code FROM items
    WHERE dis_price >= 200000)
GROUP BY sub_category
ORDER BY COUNT(*) DESC;