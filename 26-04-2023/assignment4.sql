CREATE TABLE sale_data(
	sale_date DATE,
    cust_id INT,
    sale_region VARCHAR(3),
    product VARCHAR(10),
    p_category VARCHAR(15),
    price INT,
    FOREIGN KEY (sale_region) REFERENCES regions(region));
INSERT INTO sale_data (sale_date,cust_id,sale_region,product,p_category,price)  
VALUES ('2019-11-05',111,'NY','Pen','Stationery',120),('2019-11-05',111,'NY','Pencil','Stationery',34),('2019-11-05',222,'SF','Eraser','Stationery',10),
		('2019-11-05',333,'NY','Scale','Stationery',20),('2019-11-05',444,'SF','Pen','Stationery',100),('2019-11-06',555,'NJ','Bag','Stationery',500),
		('2019-11-06',111,'NJ','Pen','Stationery',120);

CREATE TABLE regions(
    region VARCHAR(3) PRIMARY KEY,
    region_name VARCHAR(15),
    bus_unit INT,
    FOREIGN KEY (bus_unit) REFERENCES business_units(business_unit));
INSERT INTO regions(region,region_name,bus_unit)
VALUES ('NY','New York',1),('SF','San Fransisco',2),('NJ','New Jersey',3); 

CREATE TABLE business_units(
	business_unit INT PRIMARY KEY,
    business_unit_name VARCHAR(5));
INSERT INTO business_units(business_unit,business_unit_name)
VALUES (1,'CAP'),(2,'OLA'),(3,'COPS');
-- Write a sql query to produce below output: Here Sumsales means sum or price column from sales_data table
SELECT DISTINCT region_name,business_unit_name,SUM(price) OVER(PARTITION BY sale_region ORDER BY sale_region) AS SumSales FROM regions
JOIN business_units ON business_units.business_unit = regions.bus_unit
JOIN sale_data ON sale_data.sale_region = regions.region
ORDER BY business_unit_name;