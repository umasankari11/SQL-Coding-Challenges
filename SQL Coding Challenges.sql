/** SQL Question 1: CREATE Table
Scenario:
 You are a data analyst at City Hospital. Management wants to create a new table to store patient details.*/
 
 Create database City_Hospital_DB;
 
 use City_Hospital_DB;

CREATE TABLE Patients_details(
    PatientID INT ,
    PatientName VARCHAR(100),
    Age INT,
    Gender enum("Male","Female"),
    AdmissionDate DATE
);

/*SQL Question 2: ALTER – Add Column
Scenario:
 Later, the hospital decides to store the doctor assigned to each patient.*/
 
 ALTER TABLE Patients_Details
ADD DoctorAssigned VARCHAR(50);

select * from Patients_Details;


/* challenge: Constraints
SQL Question 1: PRIMARY KEY & FOREIGN KEY
Scenario:
 You are creating a database for an online bookstore.
Task:

-- Create Orders table with foreign key referencing Books */

-- Create Books table with primary key
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(50),
    ISBN VARCHAR(20)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    BookID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


-- SQL Question 2: UNIQUE Constraint

-- Scenario: Ensure that each book’s ISBN is unique.

-- Add UNIQUE constraint to ISBN column in Books

ALTER TABLE Books
ADD CONSTRAINT unique_isbn UNIQUE (ISBN);

-- SQL Question 3: DELETE vs TRUNCATE

-- Scenario: Remove test orders while understanding difference between DELETE and TRUNCATE.

-- DELETE: Remove only orders with OrderID less than 100
DELETE FROM Orders
WHERE OrderID < 100;

-- TRUNCATE: Quickly remove all rows from Orders table
TRUNCATE TABLE Orders;

select * from Books;
select * from Orders;

-- Students Table

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Email VARCHAR(50),
    CourseID INT,
    GPA DECIMAL(3,2)
);

-- Insert sample data
INSERT INTO Students (StudentID, Name, Department, Email, CourseID, GPA) VALUES
(1, 'Alice', 'Computer Science', 'alice@email.com', 101, 3.5),
(2, 'Bob', 'Mathematics', NULL, 102, 3.0),
(3, 'Charlie', 'Physics', 'charlie@email.com', 103, 2.8),
(4, 'David', 'Computer Science', NULL, 101, 3.9),
(5, 'Eva', 'Mathematics', 'eva@email.com', 104, 3.7),
(6, 'Frank', 'Biology', NULL, 105, 2.5);

-- 1. DISTINCT & WHERE
-- List unique departments
SELECT DISTINCT Department
FROM Students;

-- 2: IS NULL & NOT NULL
-- Students with no email
SELECT * FROM Students
WHERE Email IS NULL;

-- Students with email
SELECT * FROM Students
WHERE Email IS NOT NULL;

-- 3: IN, BETWEEN, NOT BETWEEN
-- Students enrolled in courses 101, 102, 103
SELECT * FROM Students
WHERE CourseID IN (101, 102, 103);

-- Students with GPA between 3.0 and 4.0
SELECT * FROM Students
WHERE GPA BETWEEN 3.0 AND 4.0;

-- Students with GPA NOT between 2.0 and 3.0
SELECT * FROM Students
WHERE GPA NOT BETWEEN 2.0 AND 3.0;

/* E-Commerce Database – Products Table */
-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(8,2)
);

-- Insert sample data
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1200.00),
(2, 'Smartphone', 800.00),
(3, 'Headphones', 150.00),
(4, 'Monitor', 300.00),
(5, 'Keyboard', 100.00);


-- Q1: ORDER BY & LIMIT
-- Top 3 highest-priced products
SELECT ProductName, Price
FROM Products
ORDER BY Price DESC
LIMIT 3;

/* Sales Database – Sales Table*/
-- Create Sales table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Amount DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO Sales (SaleID, ProductID, Amount) VALUES
(1, 1, 1200.00),
(2, 2, 800.00),
(3, 3, 150.00),
(4, 4, 300.00),
(5, 5, 100.00);

/* Challenge Queries – Aggregate Functions*/
-- Count of sales
SELECT COUNT(*) AS TotalSales FROM Sales;

-- Total revenue
SELECT SUM(Amount) AS TotalRevenue FROM Sales;

-- Average sale amount
SELECT AVG(Amount) AS AvgSale FROM Sales;

-- Maximum sale amount
SELECT MAX(Amount) AS MaxSale FROM Sales;

-- Minimum sale amount
SELECT MIN(Amount) AS MinSale FROM Sales;

/* SQL Question 3: GROUP BY & HAVING Scenario: Find departments with more than 10 employees.*/
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50)
);

-- Insert sample data
INSERT INTO Employees (EmployeeID, Name, Department) VALUES
(1, 'Alice', 'IT'),
(2, 'Bob', 'IT'),
(3, 'Charlie', 'HR'),
(4, 'David', 'IT'),
(5, 'Eva', 'Finance'),
(6, 'Frank', 'Finance'),
(7, 'Grace', 'IT'),
(8, 'Hannah', 'IT'),
(9, 'Ian', 'HR'),
(10, 'Jack', 'IT'),
(11, 'Kelly', 'IT'),
(12, 'Leo', 'IT');

-- Challenge Query – GROUP BY & HAVING
-- Departments with more than 10 employees
SELECT Department, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 10;

/* SQL Question 1: INNER JOIN Scenario: Show students with their enrolled course names.*/

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

INSERT INTO Courses (CourseID, CourseName) VALUES
(101, 'Mathematics'),
(102, 'Computer Science'),
(103, 'Physics');

UPDATE Students SET CourseID = 101 WHERE StudentID = 1;
UPDATE Students SET CourseID = 102 WHERE StudentID = 2;
UPDATE Students SET CourseID = 103 WHERE StudentID = 3;

SELECT 
    Students.StudentID,
    Students.Name,
    Courses.CourseName
FROM Students
INNER JOIN Courses
ON Students.CourseID = Courses.CourseID;

-- SQL Question 2: LEFT & RIGHT JOIN Scenario: List all students and their courses, including those without matches.

-- Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID) VALUES
(1, 1, 101),
(2, 2, 102),
(3, 3, 103);

-- Q2: LEFT & RIGHT JOIN

-- Scenario: List all students and their courses, including unmatched records.

-- LEFT JOIN: All students, NULL if no course
SELECT s.StudentID, s.Name, c.CourseName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Courses c ON e.CourseID = c.CourseID;

-- RIGHT JOIN: All courses, NULL if no student enrolled
SELECT s.StudentID, s.Name, c.CourseName
FROM Students s
RIGHT JOIN Enrollments e ON s.StudentID = e.StudentID
RIGHT JOIN Courses c ON e.CourseID = c.CourseID;

-- Q3: UNION vs UNION ALL
-- Employees Table (Current & Past)
CREATE TABLE CurrentEmployees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE PastEmployees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50)
);

INSERT INTO CurrentEmployees (EmpID, Name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO PastEmployees (EmpID, Name) VALUES
(3, 'Charlie'),
(4, 'David');

SELECT Name FROM CurrentEmployees
UNION
SELECT Name FROM PastEmployees;

-- UNION ALL: keeps all rows including duplicates
SELECT Name FROM CurrentEmployees
UNION ALL
SELECT Name FROM PastEmployees;

-- Convert first and last names to uppercase
SELECT EmployeeID, UPPER(Name) AS Name_Upper, UPPER(Name) AS Name_Upper
FROM Employees;

-- Convert first and last names to lowercase
SELECT EmployeeID, LOWER(FirstName) AS FirstName_Lower, LOWER(LastName) AS LastName_Lower
FROM Employees;

-- Extract first 3 letters of first name
SELECT EmployeeID, SUBSTRING(Name,1,3) AS Name_Short
FROM Employees;

-- Concatenate first and last names
SELECT EmployeeID, CONCAT(EmployeeID, '-', Name) AS FullName
FROM Employees;

/* Q.2. Date Functions

Scenario: Calculate employee tenure in years*/
-- alter
ALTER TABLE Employees
ADD COLUMN JoinDate DATE;
UPDATE Employees SET JoinDate = '2020-06-12' WHERE EmployeeID = 1;
UPDATE Employees SET JoinDate = '2019-03-20' WHERE EmployeeID = 2;
UPDATE Employees SET JoinDate = '2022-11-01' WHERE EmployeeID = 3;
UPDATE Employees SET JoinDate = '2021-01-15' WHERE EmployeeID = 4;
UPDATE Employees SET JoinDate = '2018-09-10' WHERE EmployeeID = 5;

-- Tenure using YEAR() difference
SELECT EmployeeID, Name,
       YEAR(NOW()) - YEAR(JoinDate) AS TenureYears
FROM Employees;

-- Tenure using DATEDIFF() and approximate conversion to years
SELECT EmployeeID, Name,
       ROUND(DATEDIFF(NOW(), JoinDate)/365,2) AS TenureYears
FROM Employees;

/*Question 3: User-defined Function */

DELIMITER $$

CREATE FUNCTION GetFullName(Name VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN Name;
END $$

DELIMITER ;

SELECT 
    StudentID,
    GetFullName(Name) AS FullName
FROM Students;

SHOW FUNCTION STATUS WHERE Db = 'city_hospital_db';

-- Q1: Stored Procedure

-- Scenario: Fetch employee details by ID.

-- Departments Table

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

INSERT INTO Departments (DeptID, DeptName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

-- Salaries Table

CREATE TABLE Salaries (
    EmployeeID INT PRIMARY KEY,
    Salary DECIMAL(10,2)
);

INSERT INTO Salaries (EmployeeID, Salary) VALUES
(1, 50000),
(2, 60000),
(3, 55000);

-- Employees Table
CREATE TABLE Employees1 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DeptID INT,
    JoinDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Employees1 (EmployeeID, FirstName, LastName, DeptID, JoinDate) VALUES
(1, 'Alice', 'Smith', 2, '2018-05-10'),
(2, 'Bob', 'Johnson', 2, '2020-03-15'),
(3, 'Charlie', 'Brown', 1, '2015-11-20');

SHOW FUNCTION STATUS WHERE Db = 'city_hospital_db';

use city_hospital_db;

DELIMITER //

CREATE PROCEDURE GetEmployeeDetails(IN emp_id INT)
BEGIN
    SELECT e.EmployeeID, e.Name, d.DeptName, e.JoinDate, s.Salary
    FROM Employees1 e
    LEFT JOIN Departments d ON e.DeptID = d.DeptID
    LEFT JOIN Salaries s ON e.EmployeeID = s.EmployeeID
    WHERE e.EmployeeID = emp_id;
END //

DELIMITER ;

-- Execute the procedure for EmployeeID = 2
CALL GetEmployeeDetails(2);

CREATE VIEW EmployeeSummary AS
SELECT 
    Name,
    Department
FROM Employees;

SELECT * FROM EmployeeSummary; 

/* Question 3: Complex View
Scenario:
 Create a view joining Employees, Departments, and Salaries.*/
 
 select * from Employees;
 select * from Employees1;
 
ALTER TABLE Employees1
ADD COLUMN DepartmentID INT;

UPDATE Employees1 SET DepartmentID = 1 WHERE EmployeeID = 1;
UPDATE Employees1 SET DepartmentID = 2 WHERE EmployeeID = 2;
UPDATE Employees1 SET DepartmentID = 2 WHERE EmployeeID = 3;
UPDATE Employees1 SET DepartmentID = 3 WHERE EmployeeID = 4;
UPDATE Employees1 SET DepartmentID = 4 WHERE EmployeeID = 5;



CREATE VIEW EmployeeFullInfo AS
SELECT 
    e.EmployeeID,
    e.FirstName,
    d.DeptName,
    s.Salary
FROM Employees1 e
INNER JOIN Departments d 
    ON e.DepartmentID = d.DeptID
INNER JOIN Salaries s
    ON e.EmployeeID = s.EmployeeID;
    
    SELECT * FROM EmployeeFullInfo;
    
    
    /*Triggers & Transactions
SQL Question 1: Trigger
Scenario:
 Log every deletion in the Orders table.*/
 
 CREATE TABLE Order_History (
    OrderID INT,
    BookID INT,
    OrderDate DATE,
    DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER LogOrderDeletion
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_History (OrderID, BookID, OrderDate)
    VALUES (OLD.OrderID, OLD.BookID, OLD.OrderDate);
END $$

DELIMITER ;

DELETE FROM Orders WHERE OrderID = 3;
SELECT * FROM Order_History;

/*SQL Question 2: DCL Commands
Scenario:
 Grant reporting access to junior analysts.*/
 
 GRANT SELECT ON city_hospital_db.* TO 'junior_analyst'@'localhost';
 
REVOKE SELECT ON city_hospital_db.* FROM 'junior_analyst'@'localhost';

FLUSH PRIVILEGES;

/*SQL Question 3: TCL Commands
Scenario:
 During a bank transfer, ensure atomicity.*/

CREATE TABLE Accounts (
    AccountNo VARCHAR(10) PRIMARY KEY,
    AccountHolder VARCHAR(100),
    Balance DECIMAL(10,2)
);

INSERT INTO Accounts (AccountNo, AccountHolder, Balance)
VALUES
('A001', 'Arun Kumar', 20000),
('B001', 'Priya Sharma', 15000);

 
 START TRANSACTION;

-- Step 1: Deduct money from Sender
UPDATE Accounts
SET Balance = Balance - 5000
WHERE AccountNo = 'A001';

-- Savepoint after deduction
SAVEPOINT AfterDeduction;

-- Step 2: Add money to Receiver
UPDATE Accounts
SET Balance = Balance + 5000
WHERE AccountNo = 'B001';

-- If everything is correct, commit the transaction
COMMIT;

/* SQL Question 4: Subquery
Scenario:
Find employees who earn more than the average salary.*/

SELECT
    e.EmployeeID,
    e.FirstName,
    s.Salary
FROM Employees1 e
JOIN Salaries s 
    ON e.EmployeeID = s.EmployeeID
WHERE s.Salary > (
    SELECT AVG(Salary)
    FROM Salaries
);


