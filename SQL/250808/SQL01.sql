use bestproducts;
# 메인카테고리와 서브카테고리별 평균 할인가격과 평균 할인률을 출력해주세요.

SELECT main_category, sub_category, AVG(dis_price), AVG(discount_percent)
FROM items
JOIN ranking ON items.item_code = ranking.item_code
GROUP BY main_category, sub_category
ORDER BY main_category ASC;

# 판매자별 베스트상품 개수, 평균할인가격, 평균할인률을 내림차순으로 출력하세요
# (상품개수 내림차순)
SELECT provider, COUNT(*), AVG(dis_price), AVG(discount_percent) FROM items
GROUP BY provider
ORDER BY COUNT(*) DESC;

# 메인카테고리별 베스트 상품 개수가 20개 이상인 판매자별 평균 할인 가격, 평균 할인률, 베스트 상품 개수 출력
SELECT provider, main_category, COUNT(*), AVG(dis_price), AVG(discount_percent)
FROM items
JOIN ranking ON items.item_code = ranking.item_code
WHERE provider IS NOT NULL AND provider != ""
GROUP BY provider, main_category
HAVING COUNT(main_category) >= 20
ORDER BY provider;

# items 테이블에서 dis_price가 5만원 이상인 상품들 중, main_category별 평균 할인가/할인률 출력
SELECT main_category, AVG(dis_price), AVG(discount_percent)
FROM items
JOIN ranking ON items.item_code = ranking.item_code
WHERE dis_price >=50000
GROUP BY main_category;

select dis_price from items
where dis_price >= 50000;