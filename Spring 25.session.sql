-- use spring25;
-- -- ============================
-- -- CREATE TABLES
-- -- ============================

-- CREATE TABLE JobSeeker (
--     seeker_id INT PRIMARY KEY,
--     name VARCHAR(100),
--     email VARCHAR(100),
--     skill VARCHAR(100),
--     experience_years INT,
--     location VARCHAR(100)
-- );

-- CREATE TABLE Recruiter (
--     recruiter_id INT PRIMARY KEY,
--     name VARCHAR(100),
--     company VARCHAR(100),
--     email VARCHAR(100),
--     industry VARCHAR(100),
--     location VARCHAR(100)
-- );

-- CREATE TABLE JobPost (
--     job_id INT PRIMARY KEY,
--     recruiter_id INT,
--     title VARCHAR(100),
--     description TEXT,
--     salary INT,
--     location VARCHAR(100),
--     posted_date DATE,
--     application_deadline DATE,
--     FOREIGN KEY (recruiter_id) REFERENCES Recruiter(recruiter_id)
-- );

-- CREATE TABLE Application (
--     app_id INT PRIMARY KEY,
--     seeker_id INT,
--     job_id INT,
--     status VARCHAR(50),
--     applied_date DATE,
--     FOREIGN KEY (seeker_id) REFERENCES JobSeeker(seeker_id),
--     FOREIGN KEY (job_id) REFERENCES JobPost(job_id)
-- );

-- CREATE TABLE Interview (
--     interview_id INT PRIMARY KEY,
--     app_id INT,
--     date DATE,
--     time VARCHAR(20),
--     status VARCHAR(50),
--     feedback TEXT,
--     FOREIGN KEY (app_id) REFERENCES Application(app_id)
-- );

-- CREATE TABLE Company (
--     company_id INT PRIMARY KEY,
--     name VARCHAR(100),
--     industry VARCHAR(100),
--     headquarters VARCHAR(100),
--     employee_count INT
-- );

-- -- ============================
-- -- INSERT DUMMY DATA
-- -- ============================

-- -- JobSeekers
-- INSERT INTO JobSeeker VALUES
-- (1, 'Alice Johnson', 'alice@mail.com', 'Java Developer', 3, 'New York'),
-- (2, 'Bob Smith', 'bob@mail.com', 'Data Analyst', 5, 'Chicago'),
-- (3, 'Charlie Brown', 'charlie@mail.com', 'UI/UX Designer', 2, 'San Francisco');

-- -- Recruiters
-- INSERT INTO Recruiter VALUES
-- (1, 'Emma Davis', 'TechNova', 'emma@technova.com', 'Technology', 'San Francisco'),
-- (2, 'Michael Green', 'HealthCore', 'michael@healthcore.com', 'Healthcare', 'Boston');

-- -- Job Posts
-- INSERT INTO JobPost VALUES
-- (1, 1, 'Backend Developer', 'Develop REST APIs using Java and Spring Boot.', 95000, 'San Francisco', '2025-01-05', '2025-01-30'),
-- (2, 2, 'Data Analyst', 'Analyze healthcare datasets and build dashboards.', 85000, 'Boston', '2025-01-10', '2025-02-05'),
-- (3, 1, 'UI/UX Designer', 'Design modern UI components and user flows.', 78000, 'Remote', '2025-01-15', '2025-02-10');

-- -- Applications
-- INSERT INTO Application VALUES
-- (1, 1, 1, 'Pending', '2025-01-10'),
-- (2, 2, 2, 'Reviewed', '2025-01-12'),
-- (3, 3, 3, 'Shortlisted', '2025-01-18');

-- -- Interviews
-- INSERT INTO Interview VALUES
-- (1, 3, '2025-01-25', '10:00 AM', 'Scheduled', 'Portfolio looks promising'),
-- (2, 2, '2025-01-20', '02:00 PM', 'Completed', 'Strong analytical skills'),
-- (3, 1, '2025-01-22', '11:00 AM', 'Cancelled', 'Candidate rescheduled');

-- -- Companies
-- INSERT INTO Company VALUES
-- (1, 'TechNova', 'Technology', 'San Francisco', 500),
-- (2, 'HealthCore', 'Healthcare', 'Boston', 1200),
-- (3, 'DesignHub', 'Design', 'New York', 200);

-- ALTER TABLE JobPost
-- Modify title VARCHAR(100) NOT NULL;
-- ALTER TABLE JobPost
-- Modify description VARCHAR(100) NOT NULL;
-- ALTER TABLE JobPost
-- Modify location VARCHAR(100) NOT NULL;

-- ALTER TABLE Recruiter
-- -- Add column company_id INT;
-- ADD CONSTRAINT fk_company_id
-- FOREIGN KEY(company_id) REFERENCES Company(company_id);

-- SELECT name, email FROM JobSeeker
-- WHERE experience_years>5 and skill='Python';

-- SELECT c.name, c.company_id as company_name, Count(j.job_id) as total_job
-- From Company c
-- Join Recruiter r ON c.company_id = r.company_id
-- Join JobPost j ON r.recruiter_id = j.recruiter_id
-- GROUP BY c.company_id, c.name
-- Having Count(j.job_id)>10;

-- SELECT j.title, j.job_id, COUNT(a.app_id) as num_of_app
-- FROM Application a
-- LEFT JOIN JobPost j ON a.job_id=j.job_id
-- JOIN JobSeeker js ON a.seeker_id=js.seeker_id
-- GROUP BY j.title, j.job_id
-- ORDER BY Count(a.app_id) DESC;