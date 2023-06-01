CREATE TABLE table1(
	col_1 INT,
    col_2 INT);
INSERT INTO table1 (col_1,col_2)
VALUES (2,3),(5,4),(6,3),(2,8),(5,7);
-- Give sum of each column
SELECT SUM(col_1),SUM(col_2) FROM table1 AS sum1,sum2;
-- Total sum of two columns 
SELECT SUM(col_1+col_2) FROM table1 AS total;
-- Max sum of each row sum 
SELECT MAX(col_1+col_2) FROM table1 AS col_sum;
