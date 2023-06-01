CREATE TABLE table2(
	eid INT AUTO_INCREMENT PRIMARY KEY,
    loc VARCHAR(5),
    dept VARCHAR(5),
    sal INT);
 INSERT INTO table2 (loc,dept,sal)
 VALUES ('hyd','Adm',10000),('hyd','It',12000),('hyd','Adm',20000),('hyd','It',10000),('ban','Adm',30000),('ban','It',12000),('ban','Adm',20000),('ban','It',10000);
 -- Find the highest salary of employee in each dept ? (write in both group by and windows approach) 
 -- GROUP BY APPROACH
 SELECT dept,MAX(sal) FROM table2
 GROUP BY(dept);
 -- WINDOWS APPROACH
 SELECT * FROM (
 SELECT dept,sal,DENSE_RANK() OVER(PARTITION BY dept ORDER BY sal DESC) AS sal_rank FROM table2 ) AS highest
 WHERE sal_rank = 1
 LIMIT 2;
 -- Find the highest salary of employee in each location and department wise ? 
-- GROUP BY APPROACH
SELECT loc,dept,MAX(sal) FROM table2
GROUP BY loc,dept;
-- WINDOWS APPROACH
SELECT * FROM (
 SELECT loc,dept,sal,DENSE_RANK() OVER(PARTITION BY loc,dept ORDER BY sal DESC) AS sal_rank FROM table2 ) AS highest
 WHERE sal_rank = 1;
-- Find the 3rd highest salary of employee 
SELECT * FROM(
	SELECT *,RANK() OVER(ORDER BY sal DESC) AS sal_rank 
    FROM table2 )
    AS table_rank
WHERE sal_rank >2
LIMIT 1;
-- Find the 2nd salary of emplyee in each department
SELECT * FROM(
	SELECT *,DENSE_RANK() OVER(PARTITION BY dept ORDER BY sal DESC) AS dept_rank 
    FROM table2 )
    AS table_rank
WHERE dept_rank = 2;
