use sss;


-- TABLE CREATION


CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB DATE,
    Gender CHAR(1),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(200),
    Program VARCHAR(100),
    YearOfStudy INT,
    DateOfAdmission DATE
);

CREATE TABLE Course (
    CourseCode VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT,
    Description TEXT,
    Semester INT,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE Professor (
    ProfessorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE CourseProfessor (
    CourseCode VARCHAR(10),
    ProfessorID INT,
    PRIMARY KEY (CourseCode, ProfessorID),
    FOREIGN KEY (CourseCode) REFERENCES Course(CourseCode),
    FOREIGN KEY (ProfessorID) REFERENCES Professor(ProfessorID)
);

CREATE TABLE Registration (
    StudentID INT,
    CourseCode VARCHAR(10),
    PRIMARY KEY (StudentID, CourseCode),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseCode) REFERENCES Course(CourseCode)
);

-- =========================
-- DATA INSERTION
-- =========================

INSERT INTO Department VALUES 
(1,'Computer Science'),
(2,'Information Technology'),
(3,'Business Analytics');

INSERT INTO Student VALUES
(101,'Alice','Johnson','2002-05-15','F','alice.johnson@example.com','9876543210','123 Main St','B.Sc IT',2,'2022-07-01'),
(102,'Bob','Smith','2001-09-20','M','bob.smith@example.com','9876543211','456 Park Ave','M.Sc BDA',1,'2023-07-15'),
(103,'Charlie','Davis','2000-12-10','M','charlie.davis@example.com','9876543212','789 Hill Rd','B.Sc IT',3,'2021-07-01'),
(104,'AAA','LLL','2008-01-10','M','aaa@gmail.com','1234567890','pune','BBA',4,'2021-07-01');

INSERT INTO Course VALUES
('CS101','Introduction to Programming',4,'Basic programming concepts',1,1),
('IT201','Database Systems',3,'Relational databases and SQL',2,2),
('BA301','Data Analytics',3,'Introduction to data analytics',3,3);

INSERT INTO Professor VALUES
(201,'Dr. Emily Clark','emily.clark@univ.edu','9876543213',1),
(202,'Prof. David Lee','david.lee@univ.edu','9876543214',2),
(203,'Dr. Sarah Patel','sarah.patel@univ.edu','9876543215',3);

INSERT INTO CourseProfessor VALUES
('CS101',201),
('IT201',202),
('BA301',203),
('IT201',201);

INSERT INTO Registration VALUES
(101,'CS101'),
(101,'IT201'),
(102,'BA301'),
(103,'CS101'),
(103,'IT201');

--Queries

-- Display all student records
select * from Student;

-- Display students whose program starts with 'B'
select * from student where program like 'B%';

-- Display students whose first name starts with 'A'
select * from student where FirstName like 'A%';

-- Display courses offered in semester 2
select * from course where Semester=2;

-- Display students admitted after 1 January 2023
select * from student where DateOfAdmission > '2023-01-01';

-- Display students enrolled in B.Sc IT or M.Sc BDA
select * from student where Program in ('B.Sc IT','M.Sc BDA');

-- Display students admitted between 2022 and 2023
select * from Student where DateOfAdmission between '2022-01-01' and '2023-12-31';

-- Display professors belonging to IT and Business Analytics departments
select * from professor where DepartmentID in (2,3);

-- Display full name of each student
select concat(FirstName,' ',LastName) as 'Full' from Student;

-- Display current year
select year(current_date());

-- Display total number of students
select count(*) from student;

-- Display average year of study for B.Sc IT students
select avg(YearOfStudy) from student where program='B.Sc IT';

-- Display number of students program-wise
select program,count(*) from student group by program;

-- Display maximum credits among all courses
select max(Credits) from course;

-- Display professor count department-wise
select d.DepartmentName,count(p.ProfessorID)
from professor p, department d
where d.DepartmentID=p.DepartmentID
group by d.DepartmentName;

-- Display earliest and latest student admission dates
select min(DateOfAdmission),max(DateOfAdmission) from student;

-- Display count of male students program-wise
select program,count(*) from Student where gender='M' group by program;

-- Display students and their enrolled courses
select s.FirstName,c.CourseName
from student s,course c,registration r
where s.StudentID=r.StudentID and c.CourseCode=r.CourseCode;

-- Display student, course and professor details
select s.FirstName,p.Name,c.CourseName
from Student s,Course c,Professor p,Registration r,CourseProfessor cp
where s.StudentID=r.StudentID
and r.CourseCode=c.CourseCode
and c.CourseCode=cp.CourseCode
and cp.ProfessorID=p.ProfessorID;

-- Display students along with their department names
select s.FirstName,c.CourseName,d.DepartmentName
from Student s,Course c,Department d,Registration r
where s.StudentId=r.StudentID
and r.CourseCode=c.CourseCode
and c.DepartmentID=d.DepartmentID
order by s.FirstName asc;

-- Display students taught by professors of Information Technology department
select distinct s.FirstName
from Student s,Course c,Registration r,Professor p,CourseProfessor cp
where s.StudentID=r.StudentID
and r.CourseCode=cp.CourseCode
and cp.ProfessorID=p.ProfessorID
and p.DepartmentID=
(select DepartmentID from Department where DepartmentName='Information Technology');

-- Display professors who teach more than one course
select p.Name
from Professor p
where p.ProfessorID in
(select cp.ProfessorID
 from CourseProfessor cp
 group by cp.ProfessorID
 having count(*)>1);

-- Display students who are not registered in any course
select s.FirstName
from Student s left join Registration r
on s.StudentID=r.StudentID
where r.StudentID is null;

-- Display number of students enrolled in each course
select c.CourseName,count(r.StudentID)
from Registration r,Course c
where c.CourseCode=r.CourseCode
group by r.CourseCode;
