-- USE interparkmkt;
-- create database interparkmkt;-- 
-- use interparkmkt;
CREATE TABLE IF NOT EXISTS performances (
	id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    date_range VARCHAR(100),
    place VARCHAR(100)
);
desc performances;
select * from performances;
# 1. 크롤링한 전체 데이터 개수
SELECT COUNT(*) AS Total_performances FROM performances;
# 2. 크롤링한 데이터 가운데 어떤 지역, 장소에서 가장 많이 공연을 하고 있는지 확인
SELECT place, COUNT(*) AS Total_places 
FROM performances 
GROUP BY place
ORDER BY COUNT(*) DESC;

# 3. 특정 장소 공연 조회
SELECT * FROM performances
WHERE place LIKE "%전국 각 지역%";

# 4. 공연 일정이 가까운 순 정렬 (*시작일 기준)
SELECT title, place, SUBSTRING_INDEX(date_range, '-', 1) AS start_date FROM performances
ORDER BY start_date ASC;
