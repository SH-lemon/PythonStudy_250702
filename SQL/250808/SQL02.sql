use sqlDB_v1;

desc userTbl;
# 클러스터형 인덱스 : userID

desc buyTbl;
# 클러스터형 인덱스 : num

show index from buyTbl;
show index from userTbl;

ALTER TABLE userTbl ADD CONSTRAINT TESTDate UNIQUE(mDate);
CREATE INDEX idx_birth ON userTbl(birthYear);
ALTER TABLE userTbl ADD INDEX idx_addr(addr);

ALTER TABLE userTbl DROP INDEX idx_addr;
