create table Customers(
CustomerID SERIAL PRIMARY KEY,
CustomerName varchar(100),
City varchar(100),
sta_te varchar(100),
JoinDate DATE
);

create table Cars(
CarID SERIAL PRIMARY KEY,
Model varchar(100),
Brand varchar(100),
Year INTEGER,
Price BIGINT,
Color varchar(100),
InventoryCount INTEGER
);


create table Sales(
SaleID SERIAL PRIMARY KEY,
CustomerID integer,
CarID integer,
saleDate DATE,
SalePrice float,
SalespersonID integer
);

create table Salespersons(
SalespersonID SERIAL PRIMARY KEY,
Name varchar(100),
Department varchar(200),
HireDate DATE
);

create table ServiceRecords(
RecordID SERIAL PRIMARY KEY,
CarID integer,
ServiceDate DATE,
ServiceType varchar(200),
Cost FLOAT,
technicianID integer
);

INSERT INTO Customers (CustomerName, City, Sta_te, JoinDate) VALUES
('Alice Smith', 'New York', 'NY', '2023-01-15'),
('Bob Johnson', 'Los Angeles', 'CA', '2023-02-20'),
('Charlie Lee', 'Chicago', 'IL', '2023-03-10'),
('Diana Evans', 'Houston', 'TX', '2023-05-05'),
('Ethan Wright', 'Phoenix', 'AZ', '2023-06-25');


INSERT INTO Cars (Model, Brand, Year, Price, Color, InventoryCount) VALUES
('Accord', 'Honda', 2022, 25000, 'Black', 5),
('Civic', 'Honda', 2021, 20000, 'White', 8),
('Camry', 'Toyota', 2023, 27000, 'Gray', 3),
('Corolla', 'Toyota', 2021, 22000, 'Blue', 6),
('Model S', 'Tesla', 2023, 80000, 'Red', 2),
('Model 3', 'Tesla', 2022, 50000, 'White', 4),
('Mustang', 'Ford', 2023, 55000, 'Yellow', 3);



INSERT INTO Salespersons (Name, Department, HireDate) VALUES
('John Carter', 'New Cars', '2021-01-10'),
('Emily Davis', 'Used Cars', '2020-05-20'),
('Michael Scott', 'New Cars', '2019-09-15'),
('Sophia Brown', 'Luxury Cars', '2022-02-01');



INSERT INTO Sales (CustomerID, CarID, SaleDate, SalePrice, SalespersonID) VALUES
(1, 1, '2023-02-01', 24000, 1),
(2, 3, '2023-03-15', 26000, 2),
(3, 5, '2023-04-20', 78000, 3),
(4, 6, '2023-06-10', 49000, 1),
(5, 4, '2023-07-01', 21000, 2),
(1, 7, '2023-07-15', 53000, 4),
(3, 2, '2023-08-05', 19500, 3);





INSERT INTO ServiceRecords (CarID, ServiceDate, ServiceType, Cost, TechnicianID) VALUES
(1, '2023-05-01', 'Oil Change', 150, 401),
(3, '2023-05-15', 'Tire Rotation', 80, 402),
(5, '2023-06-20', 'Engine Repair', 1200, 403),
(4, '2023-07-10', 'Brake Replacement', 600, 401),
(7, '2023-08-01', 'Oil Change', 180, 402);


-- Find the total number of customers in the database

SELECT COUNT(*) AS total_customers
FROM Customers;


-- Calculate the average sale price of all car sales.

SELECT avg(SalePrice) as average_sale_price FROM Sales

-- Find the most expensive car ever sold.

SELECT MAX(SalePrice) FROM Sales

-- Determine the total inventory count of all cars in the showroom.

SELECT sum(InventoryCount) as total_inventory_count FROM Cars

--  Find the earliest and most recent sale dates.

SELECT MIN(SaleDate) as earliest_Sale from Sales;
SELECT MAX(SaleDate) as latest_Sale from Sales;

-- Group cars by brand and count how many models each brand has

select count(Model) from cars 
group by Brand

-- Calculate the total sales amount for each salesperson

select SalesPersonID,
	sum(SalePrice) as total_Sales
from Sales
group by SalesPersonID
order by total_Sales DESC

-- Find the average sale price for each car model.

select Model,
	avg(SalePrice) as average_sale_price
from Sales
JOIN cars on Sales.CarID = Cars.CarID
group by Model;

-- For each service type, find the average service cost.

select ServiceType,
	avg(Cost) as Average_Service_Cost
from ServiceRecords
group by ServiceType

-- Find the count of cars by brand and color combination from the cars table.

SELECT Brand,
	Color,
	count(*) as car_Count
FROM Cars
GROUP BY Brand,Color




-- Identify brands that offer more than five different car models


SELECT Brand from Cars
group by Brand
having count(Model) > 5


-- List car models that have been sold more than 10 times.

SELECT Cars.Model, COUNT(*) AS total_sold
FROM Sales, Cars
GROUP BY Model
HAVING COUNT(*) > 10;



-- Find salespersons whose average sale price is greater than 50,000.


select SalesPersonID
from Sales
group by SalesPersonID
having avg(SalePrice) > 50000

-- Identify months that had more than 20 sales.

SELECT EXTRACT(MONTH FROM SaleDate) AS sale_month,
       COUNT(*) AS total_sales
FROM Sales
GROUP BY EXTRACT(MONTH FROM SaleDate)
HAVING COUNT(*) > 20;

-- Find service types where the average cost is greater than 500.

select ServiceType from ServiceRecords
group by ServiceType
having avg(Cost) > 500


