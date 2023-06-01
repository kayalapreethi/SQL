-- create a table 
CREATE TABLE tbl_a ( 
  col_a INTEGER 
); 
-- insert some values 
INSERT INTO tbl_a VALUES (1); 
INSERT INTO tbl_a VALUES (1); 
INSERT INTO tbl_a VALUES (2); 
INSERT INTO tbl_a VALUES (2); 
INSERT INTO tbl_a VALUES (null); 
-- create a table 
CREATE TABLE tbl_b ( 
  col_b INTEGER 
); 
-- insert some values 
INSERT INTO tbl_b VALUES (1); 
INSERT INTO tbl_b VALUES (2); 
INSERT INTO tbl_b VALUES (2); 
INSERT INTO tbl_b VALUES (3); 
INSERT INTO tbl_b VALUES (null); 
INSERT INTO tbl_b VALUES (null); 
-- select count(*) from tbl_a join tbl_b on col_a = col_b how many rows the query will be return : 6
SELECT * FROM tbl_a 
JOIN tbl_b ON col_a = col_b;
-- select * from tbl_a left join tbl_b on col_a = col_b how many rows the query will be return : 7
SELECT * FROM tbl_a 
LEFT JOIN tbl_b ON col_a = col_b;
-- select * from tbl_a right join tbl_b on col_a = col_b how many rows the query will be return : 9
SELECT * FROM tbl_a 
RIGHT JOIN tbl_b ON col_a = col_b;
-- select * from tbl_a full outer join tbl_b on col_a = col_b how many rows the query will be return : 6
SELECT * FROM tbl_a 
FULL JOIN tbl_b ON col_a = col_b;