-- use test_data1;
-- CREATE TABLE program (
-- short_name VARCHAR(8) PRIMARY KEY,
-- full_name VARCHAR(100) NOT NULL,
-- students_count INT
-- -- CONSTRAINT pk_program PRIMARY KEY(short_name)
-- );

-- INSERT INTO program VALUES
-- ('CSE', 'Computer Engineerin', 450),
-- ('EEE', 'Electrical', 300),
-- ('BBA', 'Business', 250),
-- ('ENG', 'English', 180); 

-- UPDATE program SET students_count = 180 WHERE short_name='ENG';

-- CREATE TABLE course (
-- course_code CHAR(5) PRIMARY KEY,
-- course_name VARCHAR(30) NOT NULL,
-- course_credit INT NOT NULL
-- -- CONSTRAINT pk_course PRIMARY KEY(course_code)
-- );

-- INSERT INTO course VALUES
-- ('CSE11', 'Database system', 3),
-- ('CSE12', 'Object Oriented Programming', 3),
-- ('CSE13', 'Data Structured', 3),
-- ('MAT01', 'Calculus 1', 3),
-- ('ENG01', 'Academic English', 2),
-- ('BBA01', 'Principle of management 2', 2);


-- CREATE TABLE student (
--     student_id INT,
--     student_name VARCHAR(50) NOT NULL,
--     student_dob DATE DEFAULT '1996-01-01',
--     program_name VARCHAR(8),
--     student_email VARCHAR(50),
--     CONSTRAINT pk_student PRIMARY KEY(student_id),
--     CONSTRAINT fk_program FOREIGN KEY (program_name)
--         REFERENCES program(short_name) ON DELETE CASCADE
-- );


-- INSERT INTO student (student_id, student_name, student_dob, program_name, student_email) VALUES
-- (101, 'Afsana Akter', '2000-01-10', 'CSE', 'afsana@gmail.com'),
-- (102, 'Rafiul Hasan', '1999-05-14', 'EEE', 'rafiul@gmail.com'),
-- (103, 'Samira Khan', '2001-07-22', 'CSE', 'samira@gmail.com'),
-- (104, 'Tanvir Ahmed', '1998-10-30', 'BBA', 'tanvir@gmail.com'),
-- (105, 'Nafisa Rahman', '2000-03-11', 'ENG', 'nafisa@gmail.com'),
-- (106, 'Sadia Islam', '2001-12-01', 'CSE', 'sadia@gmail.com');

-- CREATE TABLE course_student (
--     course_code CHAR(5),
--     student_id INT,
--     CONSTRAINT pk_courseStudent PRIMARY KEY (course_code, student_id),
--     CONSTRAINT fk_course FOREIGN KEY(course_code) REFERENCES course(course_code),
--     CONSTRAINT fk_student FOREIGN KEY(student_id) REFERENCES student(student_id)
-- );

-- INSERT INTO course_student VALUES
-- ('CSE11', 101),
-- ('CSE12', 101),
-- ('CSE13', 101),
-- ('CSE11', 103),
-- ('CSE12', 103),
-- ('MAT01', 102),
-- ('ENG01', 105),
-- ('CSE11', 106),
-- ('CSE13', 106),
-- ('BBA01', 104);

-- 1. Show all the students from the student table

SELECT * FROM student;

-- 2. Show all who enrolled in CSE

SELECT * FROM student WHERE program_name='CSE';

-- 3. List all students whose dob is before 2000

SELECT * FROM student WHERE student_dob < '2000-01-01';

-- 4. List all program that have fewer than 300 student

SELECT * FROM program WHERE students_count < 300;

-- 5. Display all course codes starting with  CSE

SELECT * FROM course WHERE course_code LIKE 'CSE%';

-- 6. List all program that have fewer than 300 student

SELECT * FROM program WHERE students_count < 300;

-- 7. Display all distinct course codes taken by student with ID 101

SELECT DISTINCT course_code FROM course_student WHERE student_id=101;

-- 8. Display all whose course_code does not start with CSE

SELECT * FROM course_student WHERE course_code NOT LIKE 'CSE%';

-- 9. Student ID between 102 and 105

SELECT * FROM student WHERE student_id BETWEEN 102 AND 105;

-- 10. Show first 3 students by student name in desc order

SELECT * FROM student
ORDER BY student_name DESC
LIMIT 3;