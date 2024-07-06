Use  Company ;

--drop TABLE Employee
CREATE TABLE EMPLOYEE (
FNAME VARCHAR (50) NOT NULL,
LNAME VARCHAR(50) NOT NULL ,
SSN CHAR(14) PRIMARY KEY ,
BDATE DATE,
DNO INT NOT NULL,
ADDRESS VARCHAR(100) ,
SALARY DECIMAL(10,2) DEFAULT 3000,
SUPERSSN CHAR(14) NOT NULL,
FOREIGN KEY (SUPERSSN) REFERENCES Employee(SSN),
);


-----------------------------------------------

ALTER TABLE EMPLOYEE 
ADD DNO INT NOT NULL;

EXEC sp_helpconstraint 'EMPLOYEE';

ALTER TABLE EMPLOYEE
DROP CONSTRAINT DF__EMPLOYEE__SALARY__3B75D760;

ALTER TABLE EMPLOYEE 
ADD FOREIGN KEY (SUPERSSN) REFERENCES Employee(SSN);




CREATE TABLE DEPARTMENT(
  DNAME VARCHAR(50) NOT NULL,
  DNUMBER INT PRIMARY KEY,
  MGRSSN CHAR(14), 
  FOREIGN KEY (MGRSSN) REFERENCES Employee(SSN) 

);

CREATE TABLE DEPT_LOCATIONS(
DNUMBER INT ,
DLOCATION VARCHAR(50),
PRIMARY KEY(DNUMBER,DLOCATION),
FOREIGN KEY (DNUMBER) REFERENCES DEPARTMENT(DNUMBER),

);

CREATE TABLE PROJECT (
  PNAME VARCHAR(50) NOT NULL,
  PNUMBER INT PRIMARY KEY,
  PLOCATION VARCHAR(50),
  DNUM INT NOT NULL, 
  FOREIGN KEY (DNUM) REFERENCES DEPARTMENT(DNUMBER) 
);


CREATE TABLE WORKS_ON (
  ESSN CHAR(14),
  PNO INT,
  HOURS TIME NOT NULL,
  PRIMARY KEY (ESSN, PNO), 
  FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(SSN), 
  FOREIGN KEY (PNO) REFERENCES PROJECT(PNUMBER) 
);

CREATE TABLE DEPENDENT (
  ESSN CHAR(14),
  DEPENDENT_NAME VARCHAR(50) NOT NULL,
  SEX CHAR(1), 
  BDATE DATE NOT NULL,
  RELATIONSHIP VARCHAR(100) NOT NULL,
  PRIMARY KEY (ESSN, DEPENDENT_NAME),  
  FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(SSN) 
);


--INSERT IN TABLE 
--1)
INSERT INTO EMPLOYEE (FNAME,LNAME,SSN,BDATE,ADDRESS,SALARY,SUPERSSN,DNO)
VALUES

      ('Ahmed', 'Youssef', '34798531987432', '1970-05-21', '789 Birch St', 90000.00, '34798531987432', 1),
    ('Mohammed', 'Khaled', '12309445026789', '1980-07-15', '456 Elm St', 85000.00, '12309445026789', 2),
    ('Yasmin', 'Salah', '12395345986789', '1975-03-20', '123 Pine St', 88000.00, '12395345986789', 3),
	('Omar', 'Nasser', '9875650084321', '1985-02-10', '654 Oak St', 80000.00, '9875650084321', 4),
    ('YAHYA', 'YASSER', '14785236996325', '1985-02-1', 'CAIRO', NULL, '14785236996325', 4),
	('TARK', 'NDER', '25896314798745', '1980-08-25', '456 Elm St', 85000.00, '25896314798745', 2),
	('hassan', 'NDER', '12365498732165', '1988-07-25', '456 Elm St', 88000.00, '12365498732165', 1),
	('galal', 'joussef', '25885236996314', '1980-12-21', 'CAIRO', 90000.00, '25885236996314', 1),
		('AYMAN', 'joNE', '14774125885236', '2000-11-1', 'CAIRO', 90000.00, '14774125885236', 2),
		('mazen', 'mazen', '88889999666633', '1999-11-1', 'CAIRO', 55000.00, '88889999666633', 2),
		('HUSSIEN', 'joussef', '98778965445632', '2003-12-21', 'CAIRO', 90000.00, '98778965445632', 1);


DELETE FROM EMPLOYEE;

select*
from EMPLOYEE


--------------------------------------------------------------------------------------------------------

--2) DEPARTMENT
INSERT INTO DEPARTMENT(DNUMBER, DNAME, MGRSSN)
VALUES
    (1, 'HR', '34798531987432'),
    (3, 'Marketing', '12395345986789'),
    (2, 'Engineering', '12309445026789'),
    (4, 'Sales', '9875650084321');
  
  --3)DEPT_LOCATION
  INSERT INTO DEPT_LOCATIONS(DNUMBER,DLOCATION)
  VALUES
       (1,'CAIRO'),
	   (2,'ALEX'),
	   (3,'SUEZ'),
	   (4,'ASSUAN');


--4)PROJECT
INSERT INTO PROJECT(PNAME,PNUMBER,PLOCATION,DNUM)
VALUES

    
      ('ANATOMI',11,'FAYOUM',1),
	  ('NABD',12,'OCTOPER',2),
      ('ROEYA',13,'ASSUT',3),
      ('FACK DETECT',14,'SUEZ',4),
	   ('BRIDGE',15,'ALEX',1),
	  ('BARAKA',16,'LUXOR',2);
	 
--5)WORKS_ON
INSERT INTO WORKS_ON(ESSN,PNO,HOURS)
VALUES
     ('34798531987432',11,'2:00:00'),
	 ('12309445026789',12,'8:00:00'),
	 ('12395345986789',13,'9:00:00'),
	 ('9875650084321',14,'12:00:00');

--DEPENDENT
INSERT INTO DEPENDENT(ESSN,DEPENDENT_NAME,SEX,BDATE,RELATIONSHIP)
VALUES
      ( '34798531987432', 'TAHA', 'M','1998-5-8', 'SON'),
	  ( '12309445026789', 'MOHAMMED', 'M','1997-7-15','SON'),
	  ( '12395345986789', 'RANA', 'F','2001-12-25','Daughter'),
	  ( '9875650084321', 'MENA', 'F','2002-5-9','Daughter');


---------------------------
SELECT*
FROM PROJECT

-------------------------------------------------------------------------------------------
--1)
SELECT 
    d.DEPENDENT_NAME AS DependentName,
    d.SEX AS DependentSex,
    d.BDATE AS Dependent_Birthdate,
    d.RELATIONSHIP AS Relationship,
    e.FNAME + ' ' + e.LNAME AS EmployeeName,
    e.SSN AS EmployeeSSN,
    e.BDATE AS EmployeeBirthdate,
    e.ADDRESS AS EmployeeAddress
FROM 
    DEPENDENT d
JOIN 
    EMPLOYEE e ON d.ESSN = e.SSN;
-------------------
--2)
SELECT 
    e.FNAME + ' ' + e.LNAME AS EmployeeName,
    p.PNAME AS Project_Name
FROM 
    EMPLOYEE e
JOIN 
    WORKS_ON w ON e.SSN = w.ESSN
JOIN 
    PROJECT p ON w.PNO = p.PNUMBER
ORDER BY 
    p.PNAME;

-------------------------
--3)
SELECT TOP 2
    FNAME + ' ' + LNAME AS EmployeeName,
    SALARY
FROM 
    EMPLOYEE
ORDER BY 
    SALARY DESC;
--------------------------------
--4)

SELECT 
    FNAME + ' ' + LNAME AS EmployeeName,
    COALESCE(CAST(SALARY AS VARCHAR(10)), '3000') AS Salary
FROM 
    EMPLOYEE;
------------------------
--5)
SELECT 
    e.FNAME AS EmployeeFirstName,
    s.FNAME AS SupervisorFirstName,
    s.LNAME AS SupervisorLastName,
    s.SSN AS SupervisorSSN,
    s.BDATE AS SupervisorBirthdate,
    s.ADDRESS AS SupervisorAddress,
    s.SALARY AS SupervisorSalary
FROM 
    EMPLOYEE e
JOIN 
    EMPLOYEE s ON e.SUPERSSN = s.SSN;

----------------------------
--6) --Common Table Expression (tempoorary
WITH RankEmployee AS (
    SELECT*,
        ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS SalaryR
    FROM 
        EMPLOYEE
)
SELECT  FNAME,LNAME,SSN,BDATE,DNO,ADDRESS,SALARY,SUPERSSN
FROM 
    RankEmployee
WHERE 
    SalaryR = 2;
--------------------------
--7)
SELECT*
FROM 
    PROJECT
WHERE 
    PNAME LIKE 'B%';
----------------------------
--8)
CREATE RULE CHECKSALARY
AS
    @Salary < 6000;
-----------------------------
--9)
-- FROM 1.1



INSERT INTO EMPLOYEE (FNAME,LNAME,SSN,BDATE,ADDRESS,SALARY,SUPERSSN,DNO)
VALUES

      ('Ahmed', 'Youssef', '34798531987432', '1970-05-21', '789 Birch St', 90000.00, '34798531987432', 1),
    ('Mohammed', 'Khaled', '12309445026789', '1980-07-15', '456 Elm St', 85000.00, '12309445026789', 2),
    ('Yasmin', 'Salah', '12395345986789', '1975-03-20', '123 Pine St', 88000.00, '12395345986789', 3),
	('Omar', 'Nasser', '9875650084321', '1985-02-10', '654 Oak St', 80000.00, '9875650084321', 4),
    ('YAHYA', 'YASSER', '14785236996325', '1985-02-1', 'CAIRO', NULL, '14785236996325', 4),
	('TARK', 'NDER', '25896314798745', '1980-08-25', '456 Elm St', 85000.00, '25896314798745', 2),
	('hassan', 'NDER', '12365498732165', '1988-07-25', '456 Elm St', 88000.00, '12365498732165', 1),
	('galal', 'joussef', '25885236996314', '1980-12-21', 'CAIRO', 90000.00, '25885236996314', 1),
		('AYMAN', 'joNE', '14774125885236', '2000-11-1', 'CAIRO', 90000.00, '14774125885236', 2),
		('mazen', 'mazen', '88889999666633', '1999-11-1', 'CAIRO', 55000.00, '88889999666633', 2),
		('HUSSIEN', 'joussef', '98778965445632', '2003-12-21', 'CAIRO', 90000.00, '98778965445632', 1);




--UPDATE EMPLOYEE
--SET ADDRESS = 'alex'
--WHERE FNAME = 'Ahmed' AND LNAME = 'Youssef' AND SSN = '34798531987432' AND BDATE = '1970-05-21' AND SALARY = 90000.00 AND SUPERSSN = '34798531987432' AND DNO = 1;

UPDATE EMPLOYEE
SET ADDRESS = 'cairo'
WHERE SSN = '88889999666633';

SELECT* FROM EMPLOYEE





ALTER TABLE EMPLOYEE
ADD CONSTRAINT CK_Address_Check 
CHECK (ADDRESS IN ('alex', 'mansoura', 'cairo'));

EXEC sp_helpconstraint 'EMPLOYEE';

-----------------------
--10)
CREATE FUNCTION CheckName (@SSN CHAR(14))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Message VARCHAR(100);

    SELECT @Message = 
        CASE 
            WHEN FNAME IS NULL AND LNAME IS NULL THEN 'First name & last name are null'
            WHEN FNAME IS NULL THEN 'First name is null'
            WHEN LNAME IS NULL THEN 'Last name is null'
            ELSE 'First name & last name are not null'
        END
    FROM EMPLOYEE
    WHERE SSN = @SSN;

    RETURN @Message;
END;

--Database Owner dbo
SELECT dbo.CheckName('34798531987432') AS NameCheck;
--------------------------------
--11)
CREATE FUNCTION EMPLOYEEENAME (@Type VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        CASE 
            WHEN @Type = 'first name' THEN ISNULL(FNAME, '')
            WHEN @Type = 'last name' THEN ISNULL(LNAME, '')
            WHEN @Type = 'full name' THEN ISNULL(FNAME, '') + ' ' + ISNULL(LNAME, '')
        END AS EmployeeDetail
    FROM EMPLOYEE
);

SELECT * FROM dbo.EMPLOYEEENAME('first name');
SELECT * FROM dbo.EMPLOYEEENAME('last name');
SELECT * FROM dbo.EMPLOYEEENAME('full name');
---------------------------------------------
--12)
CREATE VIEW WorkerInProject
AS
SELECT P.PNAME AS ProjectName, COUNT(W.ESSN) AS NumOfEmployeeInProject
FROM PROJECT P
LEFT JOIN WORKS_ON W ON P.PNUMBER = W.PNO
GROUP BY P.PNAME;

SELECT * FROM WorkerInProject;
------------------------------------------
--13)
CREATE VIEW EmpolyeeDepartment AS
SELECT SSN AS NumOfEmployee, LNAME AS EmployeeLastName
FROM EMPLOYEE
WHERE DNO = 2;

SELECT EmployeeLastName
FROM EmpolyeeDepartment
WHERE EmployeeLastName LIKE '%J%';
-------------------------------------------------
--14)
DROP PROCEDURE UpdateEmployee
CREATE PROCEDURE UpdateEmployee
    @OldEmpNumber CHAR(14),
    @NewEmpNumber CHAR(14),
    @ProjectNumber INT
AS
BEGIN
    UPDATE WORKS_ON
    SET ESSN = @NewEmpNumber
    WHERE ESSN = @OldEmpNumber
    AND PNO = @ProjectNumber;

    PRINT 'Employee updated successfully.';
END;

EXECUTE UpdateEmployee '25896314798745 ', '9875650084321 ', 13;



SELECT *
FROM WORKS_ON


SELECT *
FROM PROJECT
WHERE PNUMBER = 12;
---------------------------------------------------
--15)

DROP TABLE EmployeeAudit

CREATE TABLE EmployeeAudit (
    Name VARCHAR(100),
    Date DATETIME,
    Note VARCHAR(MAX)
);


DROP TRIGGER TriggerEmployee;

CREATE TRIGGER TriggerEmployee
ON Employee
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @UserName VARCHAR(100);
    SET @UserName = SUSER_SNAME();
    DECLARE @Date DATETIME;
    SET @Date = GETDATE();

    INSERT INTO EmployeeAudit (Name, Date, Note)
    SELECT @UserName, @Date, 'try to delete Row with Key of row = ' + CONVERT(VARCHAR(50), DELETED.SSN)
    FROM DELETED;

END;



DELETE FROM Employee WHERE SSN = '9875650084321';

SELECT* FROM EmployeeAudit


