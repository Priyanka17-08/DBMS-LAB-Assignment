CREATE DATABASE LAB1;
USE LAB1;
DROP DATABASE LAB1;
CREATE TABLE STUDENT (
    USN VARCHAR(20) PRIMARY KEY,
    SName VARCHAR(50),
    Address VARCHAR(100),
    Phone VARCHAR(15),
    Gender VARCHAR(10)
);
CREATE TABLE SEMSEC (
    SSID INT PRIMARY KEY,
    Sem INT,
    Sec VARCHAR(5)
);

CREATE TABLE CLASS (
    USN VARCHAR(20),
    SSID INT,
    PRIMARY KEY (USN, SSID),
    FOREIGN KEY (USN) REFERENCES STUDENT(USN),
    FOREIGN KEY (SSID) REFERENCES SEMSEC(SSID)
);
CREATE TABLE SUBJECT (
    Subcode VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(50),
    Sem INT,
    Credits INT
);
CREATE TABLE IAMARKS (
    USN VARCHAR(20),
    Subcode VARCHAR(10),
    SSID INT,
    Test1 INT,
    Test2 INT,
    Test3 INT,
    FinalIA INT,
    PRIMARY KEY (USN, Subcode, SSID),
    FOREIGN KEY (USN) REFERENCES STUDENT(USN),
    FOREIGN KEY (Subcode) REFERENCES SUBJECT(Subcode),
    FOREIGN KEY (SSID) REFERENCES SEMSEC(SSID)
);

CREATE TABLE DEPARTMENT (
    DNo INT PRIMARY KEY,
    DName VARCHAR(50),
    MgrSSN VARCHAR(20),
    MgrStartDate DATE
);
CREATE TABLE EMPLOYEE (
    SSN VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(100),
    Sex VARCHAR(10),
    Salary DECIMAL(10,2),
    SuperSSN VARCHAR(20),
    DNo INT,
    FOREIGN KEY (SuperSSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);
CREATE TABLE DLOCATION (
    DNo INT,
    DLoc VARCHAR(50),
    PRIMARY KEY (DNo, DLoc),
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);
CREATE TABLE PROJECT (
    PNo INT PRIMARY KEY,
    PName VARCHAR(50),
    PLocation VARCHAR(50),
    DNo INT,
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);
CREATE TABLE WORKS_ON (
    SSN VARCHAR(20),
    PNo INT,
    Hours DECIMAL(5,2),
    PRIMARY KEY (SSN, PNo),
    FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY (PNo) REFERENCES PROJECT(PNo)
);

ALTER TABLE STUDENT
ADD Email VARCHAR(50);

ALTER TABLE EMPLOYEE
MODIFY Salary DECIMAL(10,2) NOT NULL;
ALTER TABLE Item
MODIFY price INT NOT NULL;

ALTER TABLE STUDENT
RENAME COLUMN SName TO StudentName;
DROP TABLE DLOCATION;


CREATE TABLE Customer (
    Cust_id INT PRIMARY KEY,
    Cust_name VARCHAR(50)
);
INSERT INTO Customer VALUES
(1,'Priya'),
(2,'Rahul'),
(3,'Amit'),
(4,'Neha'),
(5,'Karan'),
(6,'Simran'),
(7,'Arjun'),
(8,'Riya'),
(9,'Vikas'),
(10,'Meena');
CREATE TABLE Item (
     item_id INT PRIMARY KEY,
     item_name VARCHAR(50),
     price INT NOT NULL
);
INSERT INTO Item VALUES
(101,'Laptop',50000),
(102,'Mouse',500),
(103,'Keyboard',800),
(104,'Headphones',1500),
(105,'Pen',20),
(106,'Notebook',100),
(107,'Bag',1200),
(108,'Phone',20000),
(109,'Charger',700),
(110,'Tablet',25000);


CREATE TABLE Sale (
    bill_no INT PRIMARY KEY,
    bill_date DATE,
    cust_id INT,
    item_id INT,
    qty_sold INT,
    FOREIGN KEY (cust_id) REFERENCES Customer(Cust_id),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);
INSERT INTO Sale VALUES
(1,CURDATE(),1,101,1),
(2,CURDATE(),2,102,2),
(3,CURDATE(),3,104,1),
(4,'2026-02-15',5,108,1),
(5,'2026-02-14',4,105,10),
(6,'2026-02-13',5,110,1),
(7,'2026-02-12',6,103,3),
(8,'2026-02-11',7,107,1),
(9,'2026-02-10',8,109,2),
(10,CURDATE(),5,102,5);

SELECT s.Bill_no, s.Bill_date, c.Cust_name, i.Item_name
FROM Sale s
JOIN Customer c ON s.Cust_id = c.Cust_id
JOIN Item i ON s.Item_id = i.Item_id
WHERE s.Bill_date = CURDATE();

DESC Sale;
SELECT s.bill_no, c.Cust_name, i.Item_name,
       s.qty_sold, i.Price,
       (s.qty_sold * i.Price) AS Total_Amount
FROM Sale s
JOIN Customer c ON s.cust_id = c.Cust_id
JOIN Item i ON s.item_id = i.item_id;

SELECT DISTINCT c.Cust_name
FROM Sale s
JOIN Customer c ON s.Cust_id = c.Cust_id
JOIN Item i ON s.Item_id = i.Item_id
WHERE i.Price > 200;

SELECT c.Cust_name, COUNT(s.Item_id) AS Total_Products
FROM Sale s
JOIN Customer c ON s.Cust_id = c.Cust_id
GROUP BY c.Cust_name;

SELECT i.Item_name, s.qty_sold
FROM Sale s
JOIN Item i ON s.Item_id = i.Item_id
WHERE s.Cust_id = 5;

CREATE VIEW Bill_Details AS
SELECT s.Bill_no,
       s.Bill_date,
       s.Cust_id,
       s.Item_id,
       i.Price,
       s.qty_sold,
       (i.Price * s.qty_sold) AS Amount
FROM Sale s
JOIN Item i ON s.Item_id = i.Item_id;

SELECT * FROM Bill_Details;

CREATE VIEW Weekly_Sales AS
SELECT Bill_date,
       SUM(i.Price * s.qty_sold) AS Daily_Total
FROM Sale s
JOIN Item i ON s.Item_id = i.Item_id
WHERE Bill_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY Bill_date;
SELECT * FROM Weekly_Sales;