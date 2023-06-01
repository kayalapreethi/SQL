DROP TABLE main_table,delta_table,total;
CREATE TABLE main_table(
	eid INT,
    ename VARCHAR(15),
    esalary VARCHAR(3),
    ecity VARCHAR(3),
    update_ts TIMESTAMP);
    
INSERT INTO main_table(eid,ename,esalary,ecity,update_ts)
VALUES (100,'Anubeig','50k','Hyd','2022-08-22 10:00:00'),
(101,'Suresh','60k','Hyd','2022-08-22 10:00:00'),
(102,'Rajesh','50k','Ban','2022-08-22 10:00:00');

CREATE TABLE delta_table(
	eid INT,
    ename VARCHAR(15),
    esalary VARCHAR(3),
    ecity VARCHAR(3),
    update_ts TIMESTAMP);
    
INSERT INTO delta_table(eid,ename,esalary,ecity,update_ts)
VALUES (100,'Anubeig','70k','Hyd','2022-08-23 10:00:00'),
(102,'Rajesh','80k','Ban','2022-08-23 10:00:00'),
(103,'Ashok','90k','Hyd','2022-08-23 10:00:00'),
(104,'Alok','50k','Ban','2022-08-23 10:00:00');
-- Write SCD Type 2 query to maintain both history and current status
INSERT INTO main_table(eid,ename,esalary,ecity,update_ts)
SELECT eid,ename,esalary,ecity,update_ts FROM delta_table;

SELECT * FROM main_table
ORDER BY eid;
-- after that write query to give always the latest record
SELECT eid,ename,esalary,ecity,update_ts FROM (
	SELECT eid,ename,esalary,ecity,update_ts,LEAD(update_ts) OVER(PARTITION BY eid ORDER BY eid) AS future_ts FROM main_table
    ) AS new_main_table
WHERE future_ts - update_ts IS NULL;
-- simple way using dense rank function.
SELECT eid,ename,esalary,ecity,update_ts FROM(
	SELECT eid,ename,esalary,ecity,update_ts,DENSE_RANK() OVER(PARTITION BY eid ORDER BY update_ts DESC) AS update_ts_rank FROM main_table
    ) AS new1
WHERE update_ts_rank = 1;
-- another way of writing query
with temp as(
SELECT eid,ename,esalary,ecity, dense_rank() over(PARTITION BY eid order by update_ts desc) as latest_rec
from main_table
)select * from temp where latest_rec = 1
