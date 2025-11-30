/*
USE new_db;
CREATE TABLE program (
short_name VARCHAR(8),
full_name VARCHAR(100) NOT NULL,
students_count INT,
CONSTRAINT pk_program PRIMARY KEY(short_name)
);
*/
/*
CREATE TABLE course (
course_code CHAR(5),
course_name VARCHAR(30) NOT NULL,
course_credit INT NOT NULL,
CONSTRAINT pk_course PRIMARY KEY(course_code)
);
*/

/*
INSERT INTO program VALUES
('CSE', 'Computer Engineerin', 450),
('EEE', 'Electrical', 550),
('BBA', 'Business', 400),
('ENG', 'English', 200); 

SELECT * FROM program;

INSERT INTO course VALUES
('CSE11', 'Database system', 3),
('CSE12', 'Database system lab', 1),
('CSE13', 'Structured program', 3),
('MATH1', 'Calculus 1', 3),
('MATH2', 'Calculus 2', 3),
('ENG01', 'English 1', 3),
('ENG02', 'English 2', 3);

SELECT * FROM course;


CREATE TABLE student (
    student_id INT,
    student_name VARCHAR(50) NOT NULL,
    student_dob DATE DEFAULT '1996-01-01',
    program_name VARCHAR(8),
    student_email VARCHAR(50),
    CONSTRAINT pk_student PRIMARY KEY(student_id),
    CONSTRAINT fk_program FOREIGN KEY (program_name)
        REFERENCES program(short_name) ON DELETE CASCADE
);

INSERT INTO student (student_id, student_name, student_dob, program_name, student_email) VALUES
(101, 'Afsana Akter', '2000-01-10', 'CSE', 'afsana@gmail.com'),
(102, 'Rafiul Hasan', '1999-05-14', 'EEE', 'rafiul@gmail.com'),
(103, 'Samira Khan', '2001-07-22', 'CSE', 'samira@gmail.com'),
(104, 'Tanvir Ahmed', '1998-10-30', 'BBA', 'tanvir@gmail.com'),
(105, 'Nafisa Rahman', '2000-03-11', 'ENG', 'nafisa@gmail.com'),
(106, 'Sadia Islam', '2001-12-01', 'CSE', 'sadia@gmail.com');



CREATE TABLE course_student (
    course_code CHAR(5),
    student_id INT,
    CONSTRAINT pk_courseStudent PRIMARY KEY (course_code, student_id),
    CONSTRAINT fk_course FOREIGN KEY(course_code) REFERENCES course(course_code),
    CONSTRAINT fk_student FOREIGN KEY(student_id) REFERENCES student(student_id)
);

INSERT INTO course_student VALUES
('CSE11', 101),
('CSE12', 101),
('CSE13', 101),
('CSE11', 103),
('CSE12', 103),
('MATH1', 102),
('ENG01', 105),
('CSE11', 106),
('CSE13', 106),
('MATH2', 104);


SELECT student_name, student_dob FROM student WHERE student_dob LIKE '2000%';
SELECT course_code, course_name FROM course WHERE course_credit>2;

SELECT course_name FROM course WHERE course_credit BETWEEN 2 AND 3;
*/
-- SELECT * FROM student WHERE program_name IN ('CSE', 'EEE');

--  SELECT * FROM student ORDER BY student_name DESC;



