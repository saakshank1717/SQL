create database library;
use library;

-- Member Table
CREATE TABLE member (
    mid INT PRIMARY KEY,
    mname VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone VARCHAR(15),
    memdate DATE
);

-- Book Table
CREATE TABLE book (
    isbn CHAR(13) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    publisher VARCHAR(100),
    yearofpublication INT
);

-- Author Table
CREATE TABLE author (
    aid INT PRIMARY KEY,
    aname VARCHAR(100) NOT NULL
);

-- BookAuthor Table (Many-to-Many: Book ↔ Author)
CREATE TABLE bookauthor (
    isbn CHAR(13),
    aid INT,
    PRIMARY KEY (isbn, aid),
    FOREIGN KEY (isbn) REFERENCES book(isbn),
    FOREIGN KEY (aid) REFERENCES author(aid)
);

-- Borrow Table
CREATE TABLE borrow (
    bid INT PRIMARY KEY,
    mid INT,
    isbn CHAR(13),
    borrowdate DATE,
    duedate DATE,
    libid INT,
    FOREIGN KEY (mid) REFERENCES member(mid),
    FOREIGN KEY (isbn) REFERENCES book(isbn)
);

INSERT INTO member (mid, mname, address, phone, memdate) VALUES
(1, 'Alice', 'Green St', '9876543210', '2023-01-10'),
(2, 'Bob', 'Lake View', NULL, '2023-02-15'),          -- phone NULL
(3, 'Carol', 'Hill Rd', '9988776655', '2023-03-20'),
(4, 'David', NULL, '9123456780', '2023-04-12'),       -- address NULL
(5, 'Emma', 'Sunset Blvd', '9112233445', NULL),       -- memdate NULL
(6, 'Frank', 'Main St', NULL, '2023-05-05');          -- phone NULL

INSERT INTO book (isbn, title, publisher, yearofpublication) VALUES
(10, 'C Programming', 'Prentice Hall', 1988),
(11, 'Head First Java', 'OReilly Media', 2005),
(12, 'Design Patterns', 'Addison Wesley', 1994),
(13, 'Database System Concepts', NULL, 2010),   -- publisher NULL
(14, 'Operating Systems', 'McGraw Hill', NULL), -- year NULL
(15, 'Networks Fundamentals', 'Pearson', 2015);

INSERT INTO author (aid, aname) VALUES
(101, 'Brian Kernighan'),
(102, 'Dennis Ritchie'),
(103, 'Kathy Sierra'),
(104, 'Bert Bates'),
(105, 'Erich Gamma'),
(106, 'Abraham Silberschatz');

INSERT INTO bookauthor (isbn, aid) VALUES
(10, 101),
(10, 102),   -- C Programming has 2 authors
(11, 103),
(11, 104),   -- Head First Java has 2 authors
(12, 105),
(13, 106);   -- Database book
insert into bookauthor values(13,101);

INSERT INTO borrow (bid, mid, isbn, borrowdate, duedate, libid) VALUES
(1, 1, 10, '2023-06-01', '2023-06-15', 501),
(2, 2, 11, '2023-06-05', '2023-06-20', 502),
(3, 3, 12, '2023-06-10', '2023-06-25', 503),
(4, 4, NULL, '2023-06-12', '2023-06-30', 504),   -- isbn NULL (borrow missing book ref)
(5, NULL, 13, '2023-06-15', '2023-07-01', 505),  -- mid NULL (borrow not linked to member)
(6, 6, 15, '2023-06-18', NULL, 506);    
insert into borrow values(7, 1, 12, '2023-06-12', '2023-06-30', 504);

-- Find members who have borrowed at least one book (using INNER JOIN)
SELECT DISTINCT m.mid, m.mname FROM member m INNER JOIN borrow b ON m.mid = b.mid;

-- Find members who have borrowed at least one book (using implicit join)
SELECT m.mid, m.mname FROM member m, borrow b WHERE m.mid = b.mid;

-- Find members whose borrow count is greater than the average borrow count
SELECT b.mid FROM borrow b GROUP BY b.mid HAVING COUNT(b.mid) > (SELECT AVG(bcount) FROM (SELECT mid, COUNT(*) AS bcount FROM borrow ba WHERE mid IS NOT NULL GROUP BY mid) AS sub);

-- Find members who have never borrowed any book (LEFT JOIN method)
SELECT m.mid, m.mname FROM member m LEFT JOIN borrow b ON m.mid = b.mid WHERE b.mid IS NULL;

-- Find members who have never borrowed any book (NOT IN – may fail with NULLs)
SELECT m.mid, m.mname FROM member m WHERE m.mid NOT IN (SELECT mid FROM borrow);

-- Find members who have never borrowed any book (NOT EXISTS – safest)
SELECT m.mid, m.mname FROM member m WHERE NOT EXISTS (SELECT 1 FROM borrow b WHERE b.mid = m.mid);

-- Find books that have never been borrowed (NOT IN)
SELECT b.title FROM book b WHERE b.isbn NOT IN (SELECT isbn FROM borrow);

-- Find books that have never been borrowed (NOT EXISTS)
SELECT b.isbn, b.title FROM book b WHERE NOT EXISTS (SELECT 1 FROM borrow bo WHERE bo.isbn = b.isbn);

-- Find authors who have written more than one book
SELECT a.aid, a.aname FROM author a, bookauthor ba WHERE a.aid = ba.aid GROUP BY a.aid, a.aname HAVING COUNT(ba.aid) > 1;

-- Count how many times each book is borrowed
SELECT b.isbn, COUNT(ba.isbn) FROM book b, borrow ba WHERE b.isbn = ba.isbn GROUP BY b.isbn;

-- Find members who borrowed books written by Dennis Ritchie
SELECT DISTINCT m.mid, m.mname FROM member m JOIN borrow br ON m.mid = br.mid JOIN bookauthor ba ON br.isbn = ba.isbn JOIN author a ON ba.aid = a.aid WHERE a.aname = 'Dennis Ritchie';

-- Display books along with their authors (including books without authors)
SELECT b.isbn, b.title, a.aname FROM book b LEFT JOIN bookauthor ba ON b.isbn = ba.isbn LEFT JOIN author a ON ba.aid = a.aid;

-- Find the latest borrow date for each member
SELECT b.mid, MAX(b.borrowdate) FROM borrow b WHERE b.mid IS NOT NULL GROUP BY b.mid;

-- Display book, member, and library details for all borrow records
SELECT b.isbn, b.title, m.mid, m.mname, bo.libid FROM book b, member m, borrow bo WHERE b.isbn = bo.isbn AND bo.mid = m.mid;

-- Find members who borrowed more than one book
SELECT bo.mid, COUNT(bo.mid) FROM borrow bo GROUP BY bo.mid HAVING COUNT(bo.mid) > 1;

-- Find members who borrowed books from more than one publisher
SELECT bo.mid, COUNT(DISTINCT b.publisher) FROM borrow bo, book b WHERE bo.isbn = b.isbn GROUP BY bo.mid HAVING COUNT(DISTINCT b.publisher) > 1;

-- Find top 3 most borrowed books
SELECT b.isbn, COUNT(b.isbn) AS borrowcount FROM borrow b WHERE b.isbn IS NOT NULL GROUP BY b.isbn ORDER BY borrowcount DESC LIMIT 3;

-- Find book title and author name for all books
SELECT b.title, a.aname FROM book b, author a, bookauthor ba WHERE b.isbn = ba.isbn AND ba.aid = a.aid;

-- Find the most recent borrow date of each member with name
SELECT m.mid, m.mname, MAX(b.borrowdate) FROM member m, borrow b WHERE m.mid = b.mid GROUP BY m.mid, m.mname;

-- Find books that have been borrowed at least once (EXISTS)
SELECT b.isbn FROM book b WHERE EXISTS (SELECT 1 FROM borrow bo WHERE bo.isbn = b.isbn);
