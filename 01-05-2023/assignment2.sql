DROP TABLE main,delta;
CREATE TABLE main(
	eid INT PRIMARY KEY,
    ename VARCHAR(15),
    esalary VARCHAR(3),
    ecity VARCHAR(3),
    update_ts TIMESTAMP);
    
INSERT INTO main(eid,ename,esalary,ecity,update_ts)
VALUES (100,'Anubeig','50k','Hyd','2022-08-22 10:00:00'),
(101,'Suresh','60k','Hyd','2022-08-22 10:00:00'),
(102,'Rajesh','50k','Ban','2022-08-22 10:00:00');

CREATE TABLE delta(
	eid INT PRIMARY KEY,
    ename VARCHAR(15),
    esalary VARCHAR(3),
    ecity VARCHAR(3),
    update_ts TIMESTAMP);
    
INSERT INTO delta(eid,ename,esalary,ecity,update_ts)
VALUES (100,'Anubeig','70k','Hyd','2022-08-23 10:00:00'),
(103,'Ashok','90k','Hyd','2022-08-23 10:00:00'),
(104,'Alok','50k','Ban','2022-08-23 10:00:00');
-- Write upsert or merge into query Update record directly, there is no record of historical values, only current state.
INSERT INTO main(eid,ename,esalary,ecity,update_ts)
SELECT * FROM delta
ON DUPLICATE KEY UPDATE main.eid = delta.eid,
						main.ename = delta.ename,
                        main.esalary = delta.esalary,
                        main.ecity = delta.ecity,
                        main.update_ts = delta.update_ts;
SELECT * FROM main;