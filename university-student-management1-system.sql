SET DEFINE OFF;

-- ---------- CLEAN UP (first run: ORA-00942 is normal) ----------
DROP TABLE Result CASCADE CONSTRAINTS;
DROP TABLE Enrollment CASCADE CONSTRAINTS;
DROP TABLE Course CASCADE CONSTRAINTS;
DROP TABLE Student CASCADE CONSTRAINTS;
DROP TABLE Teacher CASCADE CONSTRAINTS;
DROP TABLE Department CASCADE CONSTRAINTS;

-- ---------- SECTION 1 : DDL - CREATE TABLE ----------
CREATE TABLE Department (
  Dept_ID NUMBER(4) PRIMARY KEY,
  Dept_Name VARCHAR2(50) NOT NULL UNIQUE,
  Head_Name VARCHAR2(60),
  Established_Year NUMBER(4) CHECK (Established_Year > 1900)
);

CREATE TABLE Teacher (
  Teacher_ID NUMBER(4) PRIMARY KEY,
  Teacher_Name VARCHAR2(60) NOT NULL,
  Designation VARCHAR2(30) CHECK (Designation IN ('Professor','Associate Professor','Assistant Professor','Lecturer')),
  Dept_ID NUMBER(4) REFERENCES Department(Dept_ID),
  Email VARCHAR2(60) UNIQUE,
  Salary NUMBER(8,2) CHECK (Salary > 0)
);

CREATE TABLE Student (
  Student_ID NUMBER(5) PRIMARY KEY,
  Student_Name VARCHAR2(60) NOT NULL,
  Gender CHAR(1) CHECK (Gender IN ('M','F')),
  Date_Of_Birth DATE,
  Phone VARCHAR2(15) NOT NULL,
  Dept_ID NUMBER(4) REFERENCES Department(Dept_ID),
  Admission_Year NUMBER(4) CHECK (Admission_Year BETWEEN 2000 AND 2030)
);

CREATE TABLE Course (
  Course_ID VARCHAR2(10) PRIMARY KEY,
  Course_Name VARCHAR2(60) NOT NULL,
  Credits NUMBER(2) CHECK (Credits BETWEEN 1 AND 4),
  Dept_ID NUMBER(4) REFERENCES Department(Dept_ID),
  Teacher_ID NUMBER(4) REFERENCES Teacher(Teacher_ID)
);

CREATE TABLE Enrollment (
  Student_ID NUMBER(5) REFERENCES Student(Student_ID),
  Course_ID VARCHAR2(10) REFERENCES Course(Course_ID),
  Semester VARCHAR2(20) NOT NULL,
  Enrollment_Date DATE,
  PRIMARY KEY (Student_ID, Course_ID)
);

CREATE TABLE Result (
  Student_ID NUMBER(5) REFERENCES Student(Student_ID),
  Course_ID VARCHAR2(10) REFERENCES Course(Course_ID),
  Marks NUMBER(3) CHECK (Marks BETWEEN 0 AND 100),
  Grade VARCHAR2(2),
  Exam_Date DATE,
  PRIMARY KEY (Student_ID, Course_ID)
);

-- DESCRIBE
DESCRIBE Department;
DESCRIBE Teacher;
DESCRIBE Student;
DESCRIBE Course;
DESCRIBE Enrollment;
DESCRIBE Result;

-- ALTER TABLE examples (DDL)
ALTER TABLE Student ADD Email VARCHAR2(60);
ALTER TABLE Teacher MODIFY Salary NUMBER(10,2);
ALTER TABLE Course RENAME COLUMN Credits TO Credit_Hours;
ALTER TABLE Course RENAME COLUMN Credit_Hours TO Credits;
ALTER TABLE Student DROP COLUMN Email;
-- TRUNCATE / DROP demo is on a throwaway table, so real tables stay safe
CREATE TABLE Temp_Test (ID NUMBER PRIMARY KEY, Name VARCHAR2(30));
TRUNCATE TABLE Temp_Test;
DROP TABLE Temp_Test;

-- ---------- SECTION 2 : DML - INSERT / UPDATE / DELETE ----------
INSERT INTO Department VALUES (101, 'Computer Science and Engineering', 'Dr. Anwar Hossain', 1995);
INSERT INTO Department VALUES (102, 'Electrical and Electronic Engineering', 'Dr. Rahim Uddin', 1998);
INSERT INTO Department VALUES (103, 'Business Administration', 'Dr. Nasrin Akter', 2000);
INSERT INTO Department VALUES (104, 'English', 'Dr. Kamal Ahmed', 2002);

INSERT INTO Teacher VALUES (1, 'Mobarak Hossain Al-Mamon', 'Lecturer', 101, 'mobarak@diu.edu.bd', 55000);
INSERT INTO Teacher VALUES (2, 'Dr. Anwar Hossain', 'Professor', 101, 'anwar@diu.edu.bd', 120000);
INSERT INTO Teacher VALUES (3, 'Dr. Rahim Uddin', 'Associate Professor', 102, 'rahim@diu.edu.bd', 95000);
INSERT INTO Teacher VALUES (4, 'Farhana Islam', 'Assistant Professor', 103, 'farhana@diu.edu.bd', 75000);
INSERT INTO Teacher VALUES (5, 'Tanvir Ahmed', 'Lecturer', 101, 'tanvir@diu.edu.bd', 50000);

INSERT INTO Student VALUES (21, 'Md Sanjid Islam', 'M', TO_DATE('15-03-2004','DD-MM-YYYY'), '01745532902', 101, 2024);
INSERT INTO Student VALUES (22, 'Rafi Hasan', 'M', TO_DATE('10-01-2004','DD-MM-YYYY'), '01711112222', 101, 2024);
INSERT INTO Student VALUES (23, 'Maria Hasan', 'F', TO_DATE('20-05-2004','DD-MM-YYYY'), '01722223333', 101, 2024);
INSERT INTO Student VALUES (24, 'Tahzib Rahman', 'M', TO_DATE('05-07-2003','DD-MM-YYYY'), '01733334444', 102, 2023);
INSERT INTO Student VALUES (25, 'Nusrat Jahan', 'F', TO_DATE('12-09-2004','DD-MM-YYYY'), '01744445555', 103, 2024);
INSERT INTO Student VALUES (26, 'Arif Hossain', 'M', TO_DATE('25-11-2003','DD-MM-YYYY'), '01755556666', 101, 2023);
INSERT INTO Student VALUES (27, 'Sadia Akter', 'F', TO_DATE('08-02-2005','DD-MM-YYYY'), '01766667777', 104, 2024);
INSERT INTO Student VALUES (28, 'Mehedi Hasan', 'M', TO_DATE('30-06-2004','DD-MM-YYYY'), '01777778888', 102, 2024);

INSERT INTO Course VALUES ('CSE-301', 'Database Management System', 3, 101, 1);
INSERT INTO Course VALUES ('CSE-302', 'Data Communication', 3, 101, 5);
INSERT INTO Course VALUES ('CSE-303', 'Operating System', 3, 101, 2);
INSERT INTO Course VALUES ('EEE-201', 'Electrical Circuits', 3, 102, 3);
INSERT INTO Course VALUES ('BBA-101', 'Principles of Management', 3, 103, 4);
INSERT INTO Course VALUES ('ENG-101', 'English Language', 2, 104, 5);

INSERT INTO Enrollment VALUES (21, 'CSE-301', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (21, 'CSE-302', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (21, 'CSE-303', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (22, 'CSE-301', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (22, 'CSE-302', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (23, 'CSE-301', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (23, 'CSE-303', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (24, 'EEE-201', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (25, 'BBA-101', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (26, 'CSE-301', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (27, 'ENG-101', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));
INSERT INTO Enrollment VALUES (28, 'EEE-201', 'Fall 2026', TO_DATE('01-07-2026','DD-MM-YYYY'));

INSERT INTO Result VALUES (21, 'CSE-301', 85, 'A', TO_DATE('08-11-2026','DD-MM-YYYY'));
INSERT INTO Result VALUES (21, 'CSE-302', 78, 'B+', TO_DATE('09-11-2026','DD-MM-YYYY'));
INSERT INTO Result VALUES (21, 'CSE-303', 82, 'A-', TO_DATE('10-11-2026','DD-MM-YYYY'));
INSERT INTO Result VALUES (22, 'CSE-301', 72, 'B', TO_DATE('08-11-2026','DD-MM-YYYY'));
INSERT INTO Result VALUES (22, 'CSE-302', 68, 'B-', TO_DATE('09-11-2026','DD-MM-YYYY'));
INSERT INTO Result VALUES (23, 'CSE-301', 90, 'A+', TO_DATE('08-11-2026','DD-MM-YYYY'));
INSERT INTO Result VALUES (23, 'CSE-303', 88, 'A', TO_DATE('10-11-2026','DD-MM-YYYY'));
INSERT INTO Result VALUES (24, 'EEE-201', 75, 'B+', TO_DATE('08-11-2026','DD-MM-YYYY'));
INSERT INTO Result VALUES (25, 'BBA-101', 80, 'A-', TO_DATE('08-11-2026','DD-MM-YYYY'));
INSERT INTO Result VALUES (26, 'CSE-301', 65, 'B-', TO_DATE('08-11-2026','DD-MM-YYYY'));
COMMIT;

-- UPDATE and DELETE (DML)
UPDATE Teacher SET Salary = 60000 WHERE Teacher_ID = 1;
UPDATE Result SET Grade = 'A' WHERE Student_ID = 21 AND Course_ID = 'CSE-302';
DELETE FROM Enrollment WHERE Student_ID = 28 AND Course_ID = 'EEE-201';
COMMIT;

-- ---------- SECTION 3 : SELECT AND FILTERING ----------
-- Q1: All students
SELECT * FROM Student;
-- Q2: Specific columns, Alias (AS)
SELECT Student_Name AS Name, Phone AS Contact FROM Student;
-- Q3: DISTINCT departments of students
SELECT DISTINCT Dept_ID FROM Student;
-- Q4: Calculated field - total marks out of 300 for roll 21
SELECT Student_ID, (85 + 78 + 82) AS Total_Marks FROM Result WHERE Student_ID = 21;
-- Q5: WHERE with AND / OR
SELECT * FROM Student WHERE Dept_ID = 101 AND Gender = 'M';
SELECT * FROM Student WHERE Dept_ID = 102 OR Dept_ID = 103;
-- Q6: BETWEEN / NOT BETWEEN
SELECT * FROM Result WHERE Marks BETWEEN 70 AND 90;
SELECT * FROM Result WHERE Marks NOT BETWEEN 70 AND 90;
-- Q7: IN / NOT IN
SELECT * FROM Student WHERE Dept_ID IN (101, 102);
SELECT * FROM Course WHERE Course_ID NOT IN ('CSE-301', 'CSE-302');
-- Q8: LIKE
SELECT * FROM Student WHERE Student_Name LIKE 'M%';
SELECT * FROM Course WHERE Course_Name LIKE '%System%';
-- Q9: IS NULL / IS NOT NULL
SELECT * FROM Teacher WHERE Email IS NOT NULL;
SELECT * FROM Student WHERE Date_Of_Birth IS NULL;

-- ---------- SECTION 4 : SORTING AND AGGREGATE ----------
-- Q10: ORDER BY ASC / DESC, multi-column
SELECT * FROM Result ORDER BY Marks DESC;
SELECT * FROM Student ORDER BY Dept_ID ASC, Student_Name ASC;
-- Q11: COUNT, SUM, AVG, MIN, MAX
SELECT COUNT(*) AS Total_Students FROM Student;
SELECT SUM(Marks) AS Total_Marks, AVG(Marks) AS Avg_Marks, MIN(Marks) AS Min_Marks, MAX(Marks) AS Max_Marks FROM Result;
-- Q12: NVL - show 0 where marks is NULL
SELECT Student_ID, Course_ID, NVL(Marks, 0) AS Marks FROM Result;

-- ---------- SECTION 5 : ADVANCED QUERIES ----------
-- Q13: GROUP BY - students per department
SELECT Dept_ID, COUNT(*) AS No_Of_Students FROM Student GROUP BY Dept_ID;
-- Q14: GROUP BY + HAVING - departments with more than 2 students
SELECT Dept_ID, COUNT(*) AS No_Of_Students FROM Student GROUP BY Dept_ID HAVING COUNT(*) > 2;
-- Q15: GROUP BY + HAVING - average marks per course above 75
SELECT Course_ID, AVG(Marks) AS Avg_Marks FROM Result GROUP BY Course_ID HAVING AVG(Marks) > 75;
-- Q16: Subquery - students of CSE department
SELECT * FROM Student WHERE Dept_ID IN (SELECT Dept_ID FROM Department WHERE Dept_Name LIKE '%Computer%');
-- Q17: Aggregate subquery - students who scored above average
SELECT * FROM Result WHERE Marks > (SELECT AVG(Marks) FROM Result);
-- Q18: Correlated subquery - students who scored highest in their course
SELECT * FROM Result R WHERE Marks = (SELECT MAX(Marks) FROM Result WHERE Course_ID = R.Course_ID);
-- Q19: Join - student name with course name and marks
SELECT S.Student_Name, C.Course_Name, R.Marks, R.Grade FROM Student S, Course C, Result R WHERE S.Student_ID = R.Student_ID AND C.Course_ID = R.Course_ID ORDER BY R.Marks DESC;
-- Q20: Teachers with their department name
SELECT T.Teacher_Name, T.Designation, D.Dept_Name FROM Teacher T, Department D WHERE T.Dept_ID = D.Dept_ID;


COMMIT;
