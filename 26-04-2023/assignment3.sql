CREATE TABLE table3(
    cust_id VARCHAR(3),
    due_date DATE,
    payment_date DATE);
INSERT INTO table3 (cust_id,due_date,payment_date)
VALUES ('C1','2019-01-05','2018-01-02'),('C1','2019-02-05','2019-02-04'),('C1','2019-03-05','2019-03-07'),('C2','2019-01-05','2019-01-06'),('C2','2019-02-05','2019-02-02'),('C2','2019-03-05','2019-03-07'); 
-- Find the customer who missed atleast two dues ? 
SELECT DISTINCT * FROM (
SELECT cust_id,COUNT(cust_id) OVER(PARTITION BY cust_id) AS count_id FROM table3
WHERE payment_date - due_date > 0 ) AS diff1
HAVING count_id > 1;