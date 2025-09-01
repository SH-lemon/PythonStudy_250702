# Netflix Data 분석 마케터
# 특정 데이터 존재 = 사용자별 하루 시청 시간
# A 사용자가 10일 5시간 30분 시청
# B 사용자가 15일 3시간 시청
# ...

# STP => Segment => Target => Positioning => Persona

CREATE DATABASE Netflix_time;
USE Netflix_time;
# 테이블: id(primary), name, date, time, age, sex

CREATE TABLE mytable(
	id INT,
    name VARCHAR(40),
    sex VARCHAR(10),
    age INT,
    date VARCHAR(50),
    time VARCHAR(50),
    PRIMARY KEY(id)
);
show tables;
desc mytable;


drop table if exists mytable;
CREATE TABLE mytable(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(40),
    sex VARCHAR(10),
    age INT,
    date VARCHAR(50),
    time VARCHAR(50),
    PRIMARY KEY(id)
);

desc mytable;
INSERT INTO mytable (name, sex, age, date, time) VALUES ("Sienna","F","21","2025-08-04","3hr");
SELECT * FROM mytable;

SELECT name, time FROM mytable ORDER BY time DESC;

CREATE TABLE users_Davelee (
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50)
);

desc users_Davelee;
INSERT INTO users_Davelee (user_name) 
VALUES ("Alice"), ("David"), ("Cathy");

select * from users_Davelee;

CREATE TABLE watch_history (
	watch_id INT PRIMARY KEY,
    user_id INT,
    date_time DATE,
    hours_watched DECIMAL(4,1),
    FOREIGN KEY(user_id) REFERENCES users_Davelee(user_id)
);

desc watch_history;
INSERT INTO watch_history (watch_id, user_id, date_time, hours_watched)
VALUES (101, 1, "2025-07-11", "5.5"), (102, 1, "2025-07-15", "3.0"), (103, 2, "2025-07-20", "7.0"), (104, 3, "2025-06-30", "2.5"), (105, 2, "2025-07-05", "4.0"),
(106, 3, "2025-07-12", "6.5"), (107, 1, "2025-06-25", "1.0"), (108, 2, "2025-07-30", "2.0");

select * from watch_history;

# 특정 사용자의 영상 시청시간 기준, 내림차순

SELECT u.user_id, u.user_name, SUM(w.hours_watched) AS total_hours
FROM users_Davelee AS u
JOIN watch_history AS w ON u.user_id = w.user_id
WHERE w.date_time >= CURDATE() - INTERVAL 1 MONTH
GROUP BY u.user_id, u.user_name
ORDER BY total_hours DESC
LIMIT 10;