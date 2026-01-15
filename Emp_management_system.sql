create database subquery;
use subquery;
CREATE TABLE location (
    location_id INT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100)
);

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    manager_id INT,
	salary int,
    address VARCHAR(255),
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (manager_id) REFERENCES employee(employee_id)
);


INSERT INTO location (location_id, city, state) VALUES
(1, 'Mumbai', 'Maharashtra'),
(2, 'Delhi', 'Delhi'),
(3, 'Bangalore', 'Karnataka'),
(4, 'Hyderabad', 'Telangana'),
(5, 'Chennai', 'Tamil Nadu'),
(6, 'Kolkata', 'West Bengal'),
(7, 'Pune', 'Maharashtra'),
(8, 'Jaipur', 'Rajasthan'),
(9, 'Ahmedabad', 'Gujarat'),
(10, 'Lucknow', 'Uttar Pradesh');

INSERT INTO department (department_id, department_name, location_id) VALUES
(101, 'Marketing', 1),
(102, 'Finance', 2),
(103, 'Human Resources', 3),
(104, 'Sales', 4),
(105, 'Engineering', 5),
(106, 'Customer Service', 6),
(107, 'IT', 7),
(108, 'Operations', 8),
(109, 'Research and Development', 9),
(110, 'Quality Assurance', 10),
(111, 'Administration', 1),
(112, 'Legal', 2),
(113, 'Purchasing', 3),
(114, 'Production', 4),
(115, 'Supply Chain', 5);


INSERT INTO employee (employee_id, employee_name, department_id, manager_id, address, salary) VALUES
(1001, 'Rajesh Sharma', 101, NULL, '123 Main St, Mumbai, Maharashtra', 60000),
(1002, 'Priya Singh', 102, 1001, '456 Elm St, Delhi, Delhi', 75000),
(1003, 'Amit Patel', 103, 1001, '789 Oak St, Bangalore, Karnataka', 65000),
(1004, 'Sneha Reddy', 104, 1002, '101 Pine St, Hyderabad, Telangana', 70000),
(1005, 'Ravi Kumar', 105, 1002, '202 Maple St, Chennai, Tamil Nadu', 80000),
(1006, 'Ananya Banerjee', 106, 1003, '303 Cedar St, Kolkata, West Bengal', 62000),
(1007, 'Vikram Mukherjee', 107, 1003, '404 Walnut St, Pune, Maharashtra', 67000),
(1008, 'Neha Jain', 108, 1004, '505 Birch St, Jaipur, Rajasthan', 72000),
(1009, 'Kunal Mehta', 109, 1004, '606 Spruce St, Ahmedabad, Gujarat', 78000),
(1010, 'Pooja Srivastava', 110, 1005, '707 Oak St, Lucknow, Uttar Pradesh', 85000),
(1011, 'Alok Verma', 111, 1005, '808 Maple St, Mumbai, Maharashtra', 63000),
(1012, 'Deepika Gupta', 112, 1006, '909 Pine St, Delhi, Delhi', 74000),
(1013, 'Rahul Singhania', 113, 1006, '1010 Elm St, Bangalore, Karnataka', 66000),
(1014, 'Divya Agarwal', 114, 1007, '1111 Oak St, Hyderabad, Telangana', 71000),
(1015, 'Sanjay Joshi', 115, 1007, '1212 Maple St, Chennai, Tamil Nadu', 79000),
(1016, 'Anjali Desai', 101, 1008, '1313 Cedar St, Kolkata, West Bengal', 64000),
(1017, 'Vivek Chatterjee', 102, 1001, '1414 Walnut St, Pune, Maharashtra', 69000),
(1018, 'Nisha Singh', 103, 1001, '1515 Birch St, Jaipur, Rajasthan', 73000),
(1019, 'Rohan Shah', 104, 1002, '1616 Spruce St, Ahmedabad, Gujarat', 77000),
(1020, 'Preeti Yadav', 105, 1002, '1717 Oak St, Lucknow, Uttar Pradesh', 86000),
(1021, 'Gaurav Mishra', 106, 1003, '1818 Maple St, Mumbai, Maharashtra', 65000),
(1022, 'Neha Kapoor', 107, 1003, '1919 Pine St, Delhi, Delhi', 75000),
(1023, 'Rajat Khanna', 108, 1004, '2020 Elm St, Bangalore, Karnataka', 67000),
(1024, 'Shweta Sharma', 109, 1004, '2121 Oak St, Hyderabad, Telangana', 72000),
(1025, 'Ankit Singh', 110, 1005, '2222 Maple St, Chennai, Tamil Nadu', 80000),
(1026, 'Pallavi Joshi', 111, 1005, '2323 Cedar St, Kolkata, West Bengal', 64000),
(1027, 'Avinash Gupta', 112, 1006, '2424 Walnut St, Pune, Maharashtra', 69000),
(1028, 'Manisha Patel', 113, 1006, '2525 Birch St, Jaipur, Rajasthan', 73000),
(1029, 'Amit Kumar', 114, 1007, '2626 Spruce St, Ahmedabad, Gujarat', 77000),
(1030, 'Anjali Singhania', 115, 1007, '2727 Oak St, Lucknow, Uttar Pradesh', 86000);
select * from employee;
select * from location;
select * from department;

select * from employee where department_id=(select department_id from department where department_name like 'marketing');
select * from employee where department_id in(select department_id from department where department_name in ('Marketing','Finance'));
select * from employee where salary=(select max(salary) from employee where salary<(select max(salary) from employee));
select * from employee,(select avg(salary)as avgg from employee )as sub where salary>avgg;
select e.employee_id,e.department_id  from employee e where e.salary>( select avg(salary) from employee where department_id=e.department_id );

select e.department_id,count(e.employee_id) as c from employee e group by e.department_id;
select d.department_name,sub.c from department d,(select e.department_id,count(e.employee_id) as c from employee e group by e.department_id) sub where d.department_id=sub.department_id;
select sub.manager, count(sub.employee) from (select a.employee_name as employee,b.employee_name as manager from employee a,employee b where a.manager_id=b.employee_id) as sub group by sub.manager;
