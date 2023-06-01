-- creating tables and inserting data
create table dept(
dept_id 	integer	  primary key,
dept_name	character varying(30));

create table emp(
emp_id		integer   primary key,
emp_name 	character varying(30),
dept_id		integer,
designation	character varying(30),
salary		decimal(10,2),
doj			timestamp,
foreign key (dept_id)  references dept(dept_id)
);
insert into  dept 	   values (1,'HR');
insert into  dept 	   values (2,'IT');
insert into  dept 	   values (3,'Marketing');
insert into  dept 	   values (4,'Finance');
insert into  dept 	   values (5,'Engineering');

insert into emp values (1,'Odille',1,'Manager',541947,'2001-01-01 00:00:00');
insert into emp values (2,'Glen',2,'admin',277915,'2001-01-02 00:00:00');
insert into emp values (3,'Mike',3,'head',147406,'2001-01-03 00:00:00');
insert into emp values (4,'Elvina',4,'account manager',983731,'2001-01-04 00:00:00');
insert into emp values (5,'Rosalinda',5,'senior engineer',983731,'2001-01-05 00:00:00');
insert into emp values (6,'Alfredo',1,'senior manager',650318,'2001-01-06 00:00:00');
insert into emp values (7,'Raina',2,'engineer',99167,'2001-01-07 00:00:00');
insert into emp values (8,'Wilhelm',3,'senior engineer',801655,'2001-01-08 00:00:00');
insert into emp values (9,'Rollo',4,'staff engineer',615736,'2001-01-09 00:00:00');
insert into emp values (10,'Salomon',5,'engineer leader',615959,'2001-01-10 00:00:00');
insert into emp values (11,'Baxter',5,'engineer head',480536,'2001-01-11 00:00:00');
insert into emp values (12,'Georgetta',5,'Manager',665649,'2001-01-12 00:00:00');
insert into emp values (13,'Danielle',5,'admin',785291,'2001-01-13 00:00:00');
insert into emp values (14,'Clovis',3,'head',260600,'2001-01-14 00:00:00');
insert into emp values (15,'Crissy',2,'senior engineer',33206,'2001-01-15 00:00:00');
insert into emp values (16,'Angele',2,'senior manager',516534,'2001-01-16 00:00:00');
insert into emp values (17,'Idaline',1,'admin',329866,'2001-01-17 00:00:00');
insert into emp values (18,'Tiebold',3,'account manager',821068,'2001-01-18 00:00:00');
insert into emp values (19,'Franciska',4,'account manager',782610,'2001-01-19 00:00:00');
insert into emp values (20,'Christie',5,'architect',657581,'2001-01-20 00:00:00');
insert into emp values (21,'Brannon',3,'engineer',266742,'2001-01-21 00:00:00');
insert into emp values (22,'Cosetta',4,'account manager',824856,'2001-01-22 00:00:00');
insert into emp values (23,'Ina',5,'architect',378551,'2001-01-23 00:00:00');
insert into emp values (24,'Gaye',5,'senior engineer',172837,'2001-01-24 00:00:00');
insert into emp values (25,'Karlik',5,'engineer head',525237,'2001-01-25 00:00:00');
insert into emp values (26,'Ellynn',5,'engineer leader',283259,'2001-01-26 00:00:00');
insert into emp values (27,'Albertine',5,'senior engineer',749709,'2001-01-27 00:00:00');
insert into emp values (28,'Arin',2,'senior manager',590968,'2001-01-28 00:00:00');
insert into emp values (29,'Hale',3,'Manager',753701,'2001-01-29 00:00:00');
insert into emp values (30,'Hale',4,'Manager',393982,'2001-01-30 00:00:00');

select 		* 	
from 		dept;
select 		* 
from 		emp;

-- write a query/code using pandas dataframes to get the top 3 employees with highest salary.	
	-- more than 1 employee can have the same salary in that case take all of them
with rankcte as 
	(
		select 	*,dense_rank() over(order by salary desc) as _rank
		from 	emp
	)
select 			emp_id,emp_name,dept_id,designation,salary,doj 
from 			rankcte
where 			_rank <= 3;
	-- If more than 1 employee is having the same salary pick the one base on the prior doj from the latest date
with rankcte as 
	(
		select 	*,rank() over(partition by salary order by salary desc,doj) as _rank
		from 	emp
	)
select 			emp_id,emp_name,dept_id,designation,salary,doj 
from 			rankcte
where 			_rank = 1
limit 			3;
-- calculate the average salary spent department wise
select 			dept.dept_id,dept.dept_name,avg(salary) 
from 			emp
join 			dept
on 				dept.dept_id=emp.dept_id
group by 		dept.dept_id
order by  		dept.dept_id;
-- get the department with the highest expenditure
with sum_cte as 
	(
		select 			dept.dept_id,dept.dept_name,sum(salary) as sal_sum
		from 			emp
		join 			dept
		on 				dept.dept_id=emp.dept_id
		group by 		dept.dept_id
	),
	r_cte as
	(
		select 			*,rank() over(order by dept_id desc) as r_sum 
		from 			sum_cte
	)
select					dept_id,dept_name,sal_sum
from					r_cte
where					r_sum = 1;
-- views
CREATE	VIEW 	empview AS 
SELECT			emp_id,emp_name,emp.dept_id,dept_name,designation,salary,doj  
FROM 			emp
join 			dept
on				dept.dept_id = emp.dept_id
order by 		emp_id;
-- dept 1
CREATE VIEW 	dept1 AS 
SELECT 			emp_id,emp_name,emp.dept_id,dept_name,designation,salary,doj
FROM 			emp
join 			dept
on				dept.dept_id = emp.dept_id
where 			emp.dept_id = 1
order by 		emp_id; 
-- dept 2
CREATE VIEW 	dept2 AS 
SELECT 			emp_id,emp_name,emp.dept_id,dept_name,designation,salary,doj
FROM 			emp
join 			dept
on				dept.dept_id = emp.dept_id
where 			emp.dept_id = 2
order by 		emp_id; 
-- dept 3 
CREATE VIEW 	dept3 AS 
SELECT 			emp_id,emp_name,emp.dept_id,dept_name,designation,salary,doj
FROM 			emp
join 			dept
on				dept.dept_id = emp.dept_id
where 			emp.dept_id = 3
order by 		emp_id; 
-- dept 4 
CREATE VIEW 	dept4 AS 
SELECT 			emp_id,emp_name,emp.dept_id,dept_name,designation,salary,doj
FROM 			emp
join 			dept
on				dept.dept_id = emp.dept_id
where 			emp.dept_id = 4
order by 		emp_id; 
-- dept 5 
CREATE VIEW 	dept5 AS 
SELECT 			emp_id,emp_name,emp.dept_id,dept_name,designation,salary,doj
FROM 			emp
join 			dept
on				dept.dept_id = emp.dept_id
where 			emp.dept_id = 5
order by 		emp_id; 
-- simple upsert
insert into 	emp
values 			(1,'casendra',1,'Manager',1000,'2001-01-01 00:00:00')
on conflict 	(emp_id)
do update 
set 			emp_name = concat(EXCLUDED.emp_name,',',EXCLUDED.emp_name),
				salary = EXCLUDED.salary;
select * from emp;
