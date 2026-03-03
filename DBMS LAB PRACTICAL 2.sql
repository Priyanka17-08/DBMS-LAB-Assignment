CREATE DATABASE LAB2;
USE LAB2;
DROP DATABASE LAB2;

CREATE TABLE CLASS (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);
INSERT INTO CLASS VALUES (1, 'Bravo');
INSERT INTO CLASS VALUES (2, 'Alex');
INSERT INTO CLASS VALUES (4, 'Cheng');
COMMIT;

CREATE TABLE EMPLOYEES (
    Employee_Id INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Email VARCHAR(100),
    Phone_Number VARCHAR(20),
    Hire_Date DATE,
    Job_Id VARCHAR(20),
    Salary DECIMAL(10,2),
    Commission_Pct DECIMAL(5,2),
    Manager_Id INT,
    Department_Id INT
);
DROP TABLE Client_master;
CREATE TABLE Client_master (
    ClientNO VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50),
    Address1 VARCHAR(100),
    City VARCHAR(50),
    Pincode INT,
    State VARCHAR(50),
    Bal_due DECIMAL(10,2)
);

ALTER TABLE Client_master
RENAME TO Client12;

SELECT Bal_due AS "BALANCE"
FROM Client12;

INSERT INTO CLASS VALUES (5,'Rahul');

UPDATE CLASS SET name='Abhijeet' WHERE id=5;
SAVEPOINT A;
INSERT INTO CLASS VALUES (6,'Chris');
SAVEPOINT B;
INSERT INTO CLASS VALUES (7,'Bravo');
SAVEPOINT C;
SELECT * FROM CLASS;
ROLLBACK TO B;
SELECT * FROM CLASS;
ROLLBACK TO A;
SELECT * FROM class;


INSERT INTO EMPLOYEES VALUES
(101, 'Priya', 'bisht', 'priya@gmail.com', '1234567890', '2003-06-17', 'AD_PRES', 24000, NULL, NULL, 90),
(102, 'Neena', 'khankriyal', 'neena@gmail.com', '1234567891', '2005-09-21', 'AD_VP', 17000, NULL, 101, 90),
(103, 'Khushi', 'jindal', 'khushi@gmail.com', '1234567892', '2001-01-13', 'AD_VP', 17000, NULL, 101, 90),
(104, 'Amit', 'kumar', 'amit@gmail.com', '1234567893', '2006-01-03', 'IT_PROG', 9000, NULL, 103, 60),
(105, 'Bruce', 'den', 'bruce@gmail.com', '1234567894', '2007-05-21', 'IT_PROG', 6000, NULL, 103, 60),
(106, 'David', 'chawla', 'David@gmail.com', '1234567895', '2005-06-25', 'IT_PROG', 4800, NULL, 103, 60),
(107, 'Neha', 'null', 'neha@gmail.com', '1234567896', '2006-02-05', 'IT_PROG', 4800, NULL, 103, 70),
(108, 'Diya', 'bisht', 'Diya', '1234567897', '2007-02-07', 'IT_PROG', 4200, NULL, 103, 80);
SELECT Employee_Id, First_Name, Last_Name, Salary
FROM EMPLOYEES;

SELECT *
FROM EMPLOYEES
WHERE Manager_Id = 101;
SELECT First_Name, Last_Name
FROM EMPLOYEES
WHERE Salary >= 4800;
SELECT *
FROM EMPLOYEES
WHERE Last_Name = 'chawla';
SELECT First_Name, Last_Name
FROM EMPLOYEES
WHERE Department_Id IN (60, 70, 80);
SELECT DISTINCT Manager_Id
FROM EMPLOYEES;

INSERT INTO Client12 VALUES
('C201','Rohan','Street 1','Delhi',110001,'Delhi',6000),
('C202','Meena','Street 2','Mumbai',400001,'Maharashtra',3000),
('C203','Amit','Street 3','Chennai',600001,'Tamil Nadu',8000),
('C204','Sneha','Street 4','Delhi',110002,'Delhi',2000),
('C205','Vikas','Street 5','Mumbai',400002,'Maharashtra',7000);
SELECT Name, Bal_due
FROM Client12
WHERE Bal_due > 5000;

UPDATE Client12
SET Bal_due = 5100
WHERE ClientNO = 'C203';
SELECT * FROM Client12
WHERE ClientNO = 'C203';