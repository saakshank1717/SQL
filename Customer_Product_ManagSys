create database amazon;
use amazon;
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    DOB DATE,
    City VARCHAR(50),
    Email VARCHAR(100)
);
INSERT INTO Customer VALUES
(1, 'John Doe', '1985-05-15', 'New York', 'john.doe@example.com'),
(2, 'Alice Smith', '1990-07-20', 'Los Angeles', 'alice.smith@example.com'),
(3, 'Robert Johnson', '1978-09-22', 'Chicago', 'robert.johnson@example.com'),
(4, 'Emily Brown', '1982-03-10', 'Houston', 'emily.brown@example.com'),
(5, 'Daniel Wilson', '1995-11-18', 'Miami', 'daniel.wilson@example.com'),
(6, 'Sophia Miller', '1988-02-25', 'Dallas', 'sophia.miller@example.com'),
(7, 'Michael Taylor', '1980-12-15', 'San Francisco', 'michael.taylor@example.com'),
(8, 'Emma Martinez', '1992-06-05', 'Seattle', 'emma.martinez@example.com'),
(9, 'William Anderson', '1987-08-30', 'Boston', 'william.anderson@example.com'),
(10, 'Olivia Garcia', '1993-04-12', 'Philadelphia', 'olivia.garcia@example.com'),
(11, 'Noah Hernandez', '1984-10-03', 'Phoenix', 'noah.hernandez@example.com'),
(12, 'Ava Lopez', '1991-09-08', 'Denver', 'ava.lopez@example.com'),
(13, 'Logan Gonzalez', '1976-07-25', 'Detroit', 'logan.gonzalez@example.com'),
(14, 'Isabella Perez', '1989-01-20', 'Austin', 'isabella.perez@example.com'),
(15, 'Ethan Campbell', '1983-06-17', 'Portland', 'ethan.campbell@example.com');

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

INSERT INTO Product VALUES
(101, 'Laptop', 'Electronics', 1200.00),
(102, 'Smartphone', 'Electronics', 800.00),
(103, 'T-shirt', 'Clothing', 20.00),
(104, 'Coffee Maker', 'Appliances', 50.00),
(105, 'Running Shoes', 'Footwear', 70.00),
(106, 'Headphones', 'Electronics', 100.00),
(107, 'Bookshelf', 'Furniture', 150.00),
(108, 'Dress Shoes', 'Footwear', 80.00),
(109, 'Sunglasses', 'Accessories', 30.00),
(110, 'Backpack', 'Accessories', 40.00);

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ProductID INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO Supplier VALUES
(201, 'SupplierA', 101),
(202, 'SupplierB', 102),
(203, 'SupplierC', 103),
(204, 'SupplierD', 104),
(205, 'SupplierE', 105),
(206, 'SupplierF', 106),
(207, 'SupplierG', 107),
(208, 'SupplierH', 108),
(209, 'SupplierI', 109),
(210, 'SupplierJ', 110);

CREATE TABLE OrderTable (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    ModeOfPayment VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO OrderTable VALUES
(1, '2024-01-01', 1, 101, 2, 'CASH'),
(2, '2024-01-02', 2, 102, 1, 'UPI'),
(3, '2024-01-03', 3, 103, 3, 'CARDS'),
(4, '2024-01-04', 4, 104, 1, 'CARDS'),
(5, '2024-01-05', 5, 105, 2, 'CASH'),
(6, '2024-01-06', 6, 106, 1, 'CASH'),
(7, '2024-01-07', 7, 107, 1, 'UPI'),
(8, '2024-01-08', 8, 108, 2, 'CARDS'),
(9, '2024-01-09', 9, 109, 1, 'CARDS'),
(10, '2024-01-10', 10, 110, 3, 'CASH'),

(11, '2024-01-11', 11, 101, 1, 'CASH'),
(12, '2024-01-12', 12, 102, 2, 'UPI'),
(13, '2024-01-13', 13, 103, 1, 'CARDS'),
(14, '2024-01-14', 14, 104, 4, 'CARDS'),
(15, '2024-01-15', 15, 105, 2, 'CASH'),
(16, '2024-01-16', 1, 107, 3, 'CASH'),
(17, '2024-01-17', 2, 107, 1, 'UPI'),
(18, '2024-01-18', 3, 108, 2, 'CARDS'),
(19, '2024-01-19', 4, 108, 1, 'CARDS'),
(20, '2024-01-20', 5, 107, 3, 'CASH'),
(21, '2024-01-21', 6, 101, 2, 'CASH'),
(22, '2024-01-22', 7, 102, 1, 'UPI'),
(23, '2024-01-23', 8, 103, 3, 'CARDS'),
(24, '2024-01-24', 9, 104, 1, 'CARDS'),
(25, '2024-01-25', 10, 105, 2, 'CASH'),
(26, '2024-01-26', 11, 106, 1, 'CASH'),
(27, '2024-01-27', 12, 107, 1, 'UPI'),
(28, '2024-01-28', 13, 108, 2, 'CARDS'),
(29, '2024-01-29', 1, 107, 1, 'CARDS'),
(30, '2024-01-30', 12, 108, 3, 'CASH');

select * from customer;
select * from product;
select * from supplier;
select * from ordertable;


select p.ProductName,sum(o.Quantity) from Product p,OrderTable o where p.ProductID=o.ProductID group by p.ProductName;
select distinct c.*,o.* from Customer c,OrderTable o where c.CustomerID=o.CustomerID and o.ModeOfPayment='CASH';
select c.CustomerName from Customer c,OrderTable o,Product p where c.CustomerID=o.CustomerID and o.ProductID=p.ProductID group by c.CustomerName having count(distinct p.Category)>1;
select * from OrderTable where OrderDate='2024-01-01';
select * from Product where Price=(select max(price) from Product);
select c.customerID,c.CustomerName ,max(o.Quantity*p.Price) from Customer c,Product p,OrderTable o where c.CustomerId=o.CustomerID
and o.ProductID=p.ProductID group by c.customerID,c.CustomerName order by max(o.Quantity*p.Price) desc limit 1 ;

select c.CustomerName from  Customer c,Product p,OrderTable o where c.CustomerId=o.CustomerID
and o.ProductID=p.ProductID group by  c.CustomerName  having sum(o.Quantity*p.Price)>=any(select sum(o.Quantity*p.Price)from
 OrderTable o2,Product p2 where o2.ProductID=p2.ProductID group by o2.CustomerID);
 
 SELECT c.CustomerName
FROM Customer c
JOIN OrderTable o ON c.CustomerID = o.CustomerID
JOIN Product p ON o.ProductID = p.ProductID
GROUP BY c.CustomerName
HAVING SUM(o.Quantity * p.Price) >= ALL (
    SELECT SUM(o2.Quantity * p2.Price)
    FROM OrderTable o2
    JOIN Product p2 ON o2.ProductID = p2.ProductID
    GROUP BY o2.CustomerID
);


