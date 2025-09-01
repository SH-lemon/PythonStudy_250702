# CREATE DATABASE dbname;
# SHOW DATABASES;
# USE dbname;

# CREATE TABLE mytable(
	# id INT, name VARCHAR(50), PRIMARY
# );

# DROP DATABASE IF EXISTS dbname;

# CREATE DATABASE david;
# USE david;

-- CREATE TABLE mytable(
-- 	id TINYINT UNSIGNED,
--     name VARCHAR(50),
--     PRIMARY KEY(id)
-- );

-- CREATE TABLE mytable(
-- 	id FLOAT,
--     name VARCHAR(50),
--     PRIMARY KEY(id)
-- );

-- CREATE TABLE mytable(
-- 	id INT UNSIGNED,
--     name VARCHAR(50),
--     PRIMARY KEY(id)
-- );

-- CREATE TABLE mytable(
-- 	id INT NOT NULL AUTO_INCREMENT,
--     name VARCHAR(50),
--     PRIMARY KEY(id)
-- );

-- CREATE TABLE mytable(
-- 	id INT NOT NULL AUTO_INCREMENT,
--     name CHAR(50), # 50개의 문자열이 들어올 수 있는 공간을 항상 준비해둔다.
--     city VARCHAR(50), # 최대 50개까지 입력 -> 5개
--     PRIMARY KEY(id, name) # 하나의 레코드 안에 프라이머리 키 복수 가능
-- );

CREATE TABLE mytable(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    modelnumber VARCHAR(15) NOT NULL,
    series VARCHAR(30) NOT NULL,
    PRIMARY KEY(id)
);