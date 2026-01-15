create database trig;
use trig;

create table emp(eid int primary key,fname varchar(10) not null,lname varchar(10) not null,email varchar(20));

create trigger t1 on emp  after insert as 
     BEGIN
     update emp e set e.email=CONCAT('fname','lname','.','gmail.com')
     END; 
     1. AFTER INSERT Trigger

Automatically fills in an email column after a new employee is inserted.

CREATE TRIGGER trg_after_insert_emp
ON emp
AFTER INSERT
AS
BEGIN
    UPDATE e
    SET e.email = CONCAT(i.fname, i.lname, '@gmail.com')
    FROM emp e
    INNER JOIN inserted i ON e.empid = i.empid;
END;

🔹 2. AFTER UPDATE Trigger

Keeps track of salary changes in an audit table.

CREATE TABLE Salary_Audit (
    audit_id INT IDENTITY PRIMARY KEY,
    empid INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_after_update_salary
ON emp
AFTER UPDATE
AS
BEGIN
    INSERT INTO Salary_Audit (empid, old_salary, new_salary)
    SELECT d.empid, d.salary, i.salary
    FROM deleted d
    INNER JOIN inserted i ON d.empid = i.empid
    WHERE d.salary <> i.salary;  -- only log when salary changes
END;

🔹 3. AFTER DELETE Trigger

Logs deleted employee info into an archive table.

CREATE TABLE Emp_Archive (
    empid INT,
    fname VARCHAR(50),
    lname VARCHAR(50),
    deleted_on DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_after_delete_emp
ON emp
AFTER DELETE
AS
BEGIN
    INSERT INTO Emp_Archive (empid, fname, lname)
    SELECT d.empid, d.fname, d.lname
    FROM deleted d;
END;

🔹 4. INSTEAD OF INSERT Trigger

Prevents direct inserts and applies custom logic.

CREATE TRIGGER trg_instead_of_insert_emp
ON emp
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO emp (empid, fname, lname, salary, email)
    SELECT i.empid, i.fname, i.lname, i.salary,
           CONCAT(i.fname, '.', i.lname, '@company.com')
    FROM inserted i;
END;

5. Preventive Trigger (Validation)

Blocks inserting employees with salary < 10000.

CREATE TRIGGER trg_prevent_low_salary
ON emp
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE salary < 10000)
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR ('Salary must be at least 10000.', 16, 1);
    END
END;
