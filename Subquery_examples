-- Create Department Table
CREATE TABLE department (
    did INT PRIMARY KEY,
    dname VARCHAR(20)
);

-- Create Employee Table with salary
CREATE TABLE employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(20),
    did INT,
    salary INT,
    FOREIGN KEY (did) REFERENCES department(did)
);


INSERT INTO department VALUES (100, 'HR');
INSERT INTO department VALUES (101, 'RD');
INSERT INTO department VALUES (102, 'Comp');
insert into department values(103,'maths');

INSERT INTO employee VALUES (1, 'A', 100, 40000);
INSERT INTO employee VALUES (2, 'B', 100, 45000);
INSERT INTO employee VALUES (3, 'C', 101, 50000);
INSERT INTO employee VALUES (4, 'D', 102, 60000);
INSERT INTO employee VALUES (5, 'E', 102, 70000);


SELECT * FROM department;
SELECT * FROM employee;



-- Find employees who work in the HR department
SELECT * FROM employee WHERE did = (SELECT did FROM department WHERE dname = 'HR');

-- Find the department name of employee C
SELECT dname FROM department WHERE did = (SELECT did FROM employee WHERE ename = 'C');

-- Find the employee with the second highest salary
SELECT * FROM employee WHERE salary = (SELECT MAX(salary) FROM employee WHERE salary < (SELECT MAX(salary) FROM employee));

-- Find all employees who work in the same department as employee B
SELECT * FROM employee WHERE did = (SELECT did FROM employee WHERE ename = 'B');

-- Find the minimum salary in department 102
SELECT MIN(salary) FROM employee WHERE did = 102;

-- Find departments that have no employees
SELECT did, dname FROM department d WHERE NOT EXISTS (SELECT 1 FROM employee e WHERE e.did = d.did);

-- Find employees whose salary is greater than all employees in the HR department
SELECT * FROM employee WHERE salary > ALL (SELECT salary FROM employee WHERE did = (SELECT did FROM department WHERE dname = 'HR'));

-- Find the highest-paid employee in each department
SELECT ename, did FROM employee e WHERE salary = (SELECT MAX(salary) FROM employee WHERE did = e.did);

-- Find the department(s) having the maximum number of employees
SELECT did FROM employee GROUP BY did HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM employee GROUP BY did);

-- Find the department whose total salary is maximum
SELECT did, dname FROM department WHERE did = (SELECT did FROM employee WHERE did = (SELECT did FROM employee WHERE salary IN (SELECT SUM(salary) FROM employee GROUP BY did)));


