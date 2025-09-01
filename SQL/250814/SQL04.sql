SET SQL_SAFE_UPDATES = 0;
START TRANSACTION;

UPDATE customer
SET first_name = "DAVID";

SELECT * FROM customer LIMIT 10;

ROLLBACK;
# commit; 해버리면 롤백 안됨