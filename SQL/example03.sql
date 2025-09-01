#CREATE DATABASE IF NOT EXISTS school;
#USE school;

-- CREATE TABLE students (
-- 	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
--     PRIMARY KEY(id)
-- );

-- CREATE TABLE students (
-- 	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(50) NOT NULL,
--     age INT UNSIGNED,
--     grade VARCHAR(10)
-- );

-- INSERT INTO students VALUES(1,"강백호","15살","8학년");
INSERT INTO students (name, age, grade) VALUES ("서태웅",15,"8학년");
INSERT INTO students (name, age, grade) 
VALUES ("강백호",15,"8학년");

SELECT * FROM students;
SELECT name,age FROM students;
SELECT * FROM students WHERE age = 16; # 대입연산자
SELECT * FROM students WHERE age != 15; # 부정연산자 -1 -2(<>)