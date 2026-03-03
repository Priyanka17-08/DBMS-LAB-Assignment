CREATE DATABASE LAB3;

USE LAB3;

CREATE TABLE TEACHER (
    Name VARCHAR(50),
    DeptNo INT,
    Date_of_Joining DATE,
    DeptName VARCHAR(50),
    Location VARCHAR(50),
    Salary DECIMAL(10,2)
);

CREATE TABLE SALES (
    Sales_No INT PRIMARY KEY,
    Salesname VARCHAR(50),
    Branch VARCHAR(50),
    Salesamount DECIMAL(10,2),
    DOB DATE
);

CREATE TABLE DEPARTMENTS (
    dept_no INT PRIMARY KEY,
    dept_name VARCHAR(50),
    dept_location VARCHAR(50)
);

CREATE TABLE EMPLOYEES (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    emp_salary DECIMAL(10,2),
    dept_no INT,
    FOREIGN KEY (dept_no) REFERENCES DEPARTMENTS(dept_no)
);

INSERT INTO TEACHER VALUES
('Anita', 1, '2015-06-12', 'Mathematics', 'Delhi', 50000),
('Rajesh', 2, '2017-03-20', 'Commerce', 'Mumbai', 45000),
('Sneha', 1, '2018-07-15', 'Mathematics', 'Delhi', 52000),
('Amit', 3, '2016-01-10', 'Science', 'Chennai', 48000),
('Priya', 2, '2019-09-05', 'Commerce', 'Mumbai', 47000);
SET SQL_SAFE_UPDATES = 0;
UPDATE TEACHER
SET Salary = Salary + (Salary * 0.25)
WHERE DeptName = 'Mathematics';

UPDATE TEACHER
SET Salary = Salary + (Salary * 0.15)
WHERE DeptName = 'Commerce';

INSERT INTO SALES VALUES
(101, 'Rohan', 'Delhi', 20000, '1995-12-21'),
(102, 'Meena', 'Mumbai', 35000, '1993-05-15'),
(103, 'Aakash', 'Delhi', 15000, '1992-12-09'),
(104, 'Pooja', 'Chennai', 40000, '1994-08-18'),
(105, 'Karan', 'Mumbai', 30000, '1991-12-11');

SELECT Branch, AVG(Salesamount) AS Average_Sales
FROM SALES
GROUP BY Branch;

SELECT Branch, AVG(Salesamount) AS Average_Sales
FROM SALES
GROUP BY Branch;

SELECT Salesname,
DATE_FORMAT(DOB, '%d-%b-%y') AS Formatted_DOB
FROM SALES
WHERE MONTH(DOB) = 12;

SELECT Salesname, DOB
FROM SALES
ORDER BY MONTHNAME(DOB);

SELECT *
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.dept_no = D.dept_no;

INSERT INTO DEPARTMENTS VALUES
(1, 'Mathematics', 'Delhi'),
(2, 'Commerce', 'Mumbai'),
(3, 'Science', 'Chennai');

INSERT INTO EMPLOYEES VALUES
(201, 'Arjun', 60000, 1),
(202, 'Neha', 55000, 2),
(203, 'Vikas', 45000, 3),
(204, 'Simran', 50000, 1);

SELECT E.emp_name, D.dept_name
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.dept_no = D.dept_no;

SELECT E.emp_name, D.dept_name
FROM EMPLOYEES E
RIGHT JOIN DEPARTMENTS D
ON E.dept_no = D.dept_no;

SELECT *
FROM EMPLOYEES
WHERE emp_salary > (SELECT AVG(emp_salary) FROM EMPLOYEES);

ROLLBACK;
COMMIT;
SAVEPOINT sp1;

UPDATE TEACHER
SET Salary = Salary + 5000
WHERE DeptName = 'Science';

ROLLBACK TO sp1;

GRANT ALL PRIVILEGES
ON EMPLOYEES
TO DEPARTMENTS;

GRANT SELECT, INSERT
ON EMPLOYEES
TO DEPARTMENTS;

REVOKE ALL PRIVILEGES
ON EMPLOYEES
FROM DEPARTMENTS;

REVOKE SELECT, INSERT
ON EMPLOYEES
FROM DEPARTMENTS;