# CREATE DATABASE customer_db; 
# USE customer_db;

-- CREATE TABLE customer (
-- 	No INT NOT NULL AUTO_INCREMENT,
--     Name CHAR(20) NOT NULL,
--     Age TINYINT,
--     Phone VARCHAR(20),
--     Email VARCHAR(30) NOT NULL,
--     Address VARCHAR(50),
--     PRIMARY KEY(No)
-- );

# DROP TABLE IF EXISTS customer;

# SHOW TABLES; 현재 보고 있는 데이터베이스 안에 생성된 모든 테이블 확인하기
# DESC customer; 특정 테이블 안에 생성된 구조 확인하기

# ALTER TABLE customer ADD COLUMN Color VARCHAR(12); # 테이블 내 속성 추가
# ALTER TABLE customer MODIFY COLUMN Color VARCHAR(20) NOT NULL; # 테이블 내 속성 변경

# 테이블 내 속성명 변경
# ALTER TABLE customer CHANGE COLUMN Phone Mobile VARCHAR(20) NOT NULL;

# 특정 테이블 내 속성 삭제하기
# ALTER TABLE customer DROP COLUMN Color;

# CREATE DATABASE Dave;
# USE Dave;

-- CREATE TABLE DaveTable(
-- 	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
--     name VARCHAR(50) NOT NULL,
--     modelnumber VARCHAR(15) NOT NULL,
--     series VARCHAR(30) NOT NULL,
--     PRIMARY KEY(id)
-- );

# DESC DaveTable;

# ALTER TABLE DaveTable MODIFY COLUMN name VARCHAR(20) NOT NULL;
# ALTER TABLE DaveTable CHANGE COLUMN modelnumber model_number VARCHAR(10) NOT NULL;
# ALTER TABLE DaveTable CHANGE COLUMN series model_type VARCHAR(10) NOT NULL;
# desc DaveTable;

# DROP TABLE DaveTable;
-- CREATE TABLE model_info(
-- 	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
--     name VARCHAR(20) NOT NULL,
--     model_num VARCHAR(10) NOT NULL,
--     model_type VARCHAR(10) NOT NULL,
--     PRIMARY KEY(id)
-- );
desc model_info;