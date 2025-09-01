CREATE DATABASE IF NOT EXISTS index_demo_v1;
USE index_demo_v1;

SHOW VARIABLES LIKE 'default_storage_engine';

CREATE TABLE customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    age INT,
    city VARCHAR (100)
) ENGINE = InnoDB;

# 클러스터형 인덱스와 보조형 인덱스가 다른 필드값에 있는 요소들을 사용할 때보다 연산 처리 속도가 빠르다는 것을 확인 
# 우선, 여러분들의 MySQL 안에 설정 및 설치되어있는 스토리지 엔진(storage engine)
# ENGINE = InnoDB
# MySQL 8.0 이상 버전부터는 기본값으로 InnoDB가 디폴트로 되어 있으나, 아닌 경우가 종종 있음
# MyISAM 엔진을 쓰는 분들이 있다...!! 

INSERT INTO customers (name, email, age, city) VALUES ();

INSERT INTO customers (name, email, age, city) 
SELECT 
	CONCAT('User', LPAD(FLOOR(RAND() * 10000), 5, '0')),
    CONCAT('user', LPAD(FLOOR(RAND() * 10000), 5, '0'), '@test.com'),
    FLOOR(18 + (RAND() * 50)),
    ELT(FLOOR(1 + (RAND()*5)),'Seoul','Busan','Incheon','Daegu','Daejeon')
FROM information_schema.tables LIMIT 1000;

select * from customers;
# information_schema.tables
# 현재 내가 사용하고 있는 MySQL Workbench 안에 있는 전체 테이블 정보 값을 가지고 있는 시스템 테이블 = 메타테이블

SHOW INDEX FROM customers;
CREATE INDEX idx_email ON customers(email);
CREATE INDEX idx_age ON customers(age);

EXPLAIN SELECT * FROM customers; # ALL 387
EXPLAIN SELECT * FROM customers WHERE id = 300;

EXPLAIN SELECT * FROM customers WHERE email = 'user95976@test.com';
EXPLAIN SELECT * FROM customers WHERE city = 'Busan';