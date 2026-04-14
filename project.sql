---Testing one at a time

-- Student Table
CREATE TABLE IF NOT EXISTS Student (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

INSERT OR IGNORE INTO Student (first_name, last_name, email)
VALUES 
  ("Jillian", "Alexander", "jillian.alexander@bison.howard.edu"),
  ("Madison", "Simmons", "madison.simmons@bison.howard.edu"),
  ("Jessica", "Neal", "jessica.neal@bison.howard.edu"),
  ("Broward", "James","broward.james@bison.howard.edu"),
  ("Quentin", "Leo", "quentin.leo@bison.howard.edu"),
  ("Prince", "Question", "prince.question@bison.howard.edu"),
  ("Precious", "James", "precious.james@bison.howard.edu"),
  ("Joshua", "Alexander", "joshua.alexander@bison.howard.edu");

--Department Table
CREATE TABLE IF NOT EXISTS Department(
  	department_id INTEGER PRIMARY KEY AUTOINCREMENT,
  	department_name VARCHAR(100) NOT NULL
);

INSERT OR IGNORE INTO Department(department_name)
VALUES
	("Math");

-- Course Table
CREATE TABLE IF NOT EXISTS Course (
    course_id INTEGER PRIMARY KEY AUTOINCREMENT,
    department_id INT,
    course_num INT,
    course_name VARCHAR(100),
    semester VARCHAR(20),
  	year INT,
	FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

INSERT OR IGNORE INTO Course (department_id, course_num, course_name, semester, year)
VALUES 
  (1, 117, "Calculus I", "Spring", 2026);
  
-- Enrollment Table
CREATE TABLE IF NOT EXISTS Enrollment (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

INSERT OR IGNORE INTO Enrollment (student_id, course_id)
VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1);

-- Assignment Category Table
CREATE TABLE IF NOT EXISTS Assignment_Category (
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INT,
    category_type VARCHAR(50),
    weight_percentage DECIMAL(5,2),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

INSERT OR IGNORE INTO Assignment_Category (course_id, category_type, weight_percentage)
VALUES
(1, "Homework", 20),
(1, "Project", 15),
(1, "Quiz", 15),
(1, "Final Exam", 30),
(1, "Test", 20);

-- Assignment Table
CREATE TABLE IF NOT EXISTS Assignment (
    assignment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INT,
    assignment_name VARCHAR(50),
    max_score DECIMAL(5,2),
    FOREIGN KEY (category_id) REFERENCES Assignment_Category(category_id)
);

INSERT OR IGNORE INTO Assignment (category_id, assignment_name, max_score)
VALUES
(1, "HW1", 100),
(1, "HW2", 100),
(1, "HW3", 100),
(1, "HW4", 100),
(2, "Project", 100),
(3, "Q1", 100),
(3, "Q2", 100),
(3, "Q3", 100),
(4, "Final", 100),
(5, "T1", 100),
(5, "T2", 100);

-- Grade Table
CREATE TABLE IF NOT EXISTS Grade (
    grade_id INTEGER PRIMARY KEY AUTOINCREMENT,
    assignment_id INT,
    enrollment_id INT,
    score DECIMAL(5,2),
    FOREIGN KEY (assignment_id) REFERENCES Assignment(assignment_id),
    FOREIGN KEY (enrollment_id) REFERENCES Enrollment(enrollment_id)
);

INSERT INTO Grade (assignment_id, enrollment_id, score)
VALUES
-- Jillian (enrollment_id = 1)
(1, 1, 95), (2, 1, 88), (3, 1, 92), (4,1, 90),
(5, 1,93), (6,1, 85), (7, 1,87), (8,1, 90),
(9, 1,91), (10,1, 89), (11, 1,94),

-- Madison (enrollment_id = 2)
(1, 2, 80), (2, 2, 82), (3, 2,78), (4, 2,85),
(5,2, 88), (6, 2,75), (7,2,80), (8, 2,79),
(9,2, 84), (10, 2,77), (11, 2,81),

-- Jessica (enrollment_id = 3)
(1, 3, 92), (2, 3, 90), (3,3, 93), (4, 3,95),
(5, 3,91), (6, 3,88), (7,3, 89), (8, 3,90),
(9, 3,94), (10, 3,92), (11,3, 90),

-- Broward (enrollment_id = 4)
(1, 4, 70), (2, 4, 75), (3, 4, 72), (4, 4, 74),
(5, 4, 78), (6,4,  68), (7,4,  70), (8, 4, 73),
(9, 4, 76), (10, 4, 71), (11, 4, 69),

-- Quentin (enrollment_id = 5)
(1, 5, 88), (2, 5, 86), (3, 5, 85), (4,5,  87),
(5,5,  90), (6, 5, 82), (7,5,  84), (8,5,  83),
(9,5,  88), (10, 5, 85), (11, 5, 86),

-- Prince (enrollment_id = 6)
(1, 6, 60), (2, 6, 65), (3, 6,62), (4,6, 68),
(5, 6,70), (6, 6,55), (7, 6,58), (8, 6,60),
(9, 6,66), (10,6, 59), (11,6, 61),

-- Precious (enrollment_id = 7)
(1, 7, 98), (2, 7, 96), (3, 7,97), (4,7, 99),
(5,7, 95), (6,7, 94), (7, 7,96), (8, 7,97),
(9, 7,98), (10, 7,95), (11, 7,99),

-- Joshua (enrollment_id = 8)
(1, 8, 85), (2, 8, 80), (3, 8,83), (4,8, 82),
(5, 8,86), (6,8, 78), (7, 8,81), (8,8, 84),
(9, 8,87), (10, 8,79), (11, 8,85);

--Task 4
--Compute the average/highest/lowest score of an assignment;
-- Task 4: Stats for all assignments in the course
SELECT 
    g.assignment_id,				--
    AVG(g.score) AS Average_Score,	--
    MAX(g.score) AS Highest_Score,	-- This is one big SELECT statement, that's why there are commas
    MIN(g.score) AS Lowest_Score	--
    FROM Grade g
--Get the scores of the assignment with an id 6
WHERE g.assignment_id = 6;

--Task 5
--List all the students in a given course
SELECT s.first_name,
	   s.last_name
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id -- The FK connecting two tables
JOIN Course c ON e.course_id = c.course_id
WHERE c.course_name = 'Calculus I';

--Task 5 Check: 
--assignment_id = 6
--score = {85, 75, 88, 68, 82, 55 (before task 10), 94, 78}
--AVG-expected result: 78.125

--Task 6
--List all of the students in a course and all of their scores on every assignment;
SELECT s.first_name,
	   s.last_name,
       a.assignment_name,
	   g.score
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id 
JOIN Grade g ON e.enrollment_id = g.enrollment_id
JOIN Assignment a ON g.assignment_id = a.assignment_id
ORDER BY s.last_name;

--Task 7: Add an assignment to a course

INSERT INTO Assignment (category_id, assignment_name, max_score)
SELECT category_id, 'HW5', 100
FROM Assignment_Category
WHERE course_id = 1
AND category_type = 'Homework';

--Test Case: Run this code before and after. Before, the last assignment should be HW4. After, you should see HW5 | 100 | Homework | 1 added to the table.

SELECT a.assignment_id, a.assignment_name, a.max_score, ac.category_type, ac.course_id
FROM Assignment a
JOIN Assignment_Category ac
  ON a.category_id = ac.category_id
WHERE ac.course_id = 1
ORDER BY a.assignment_id;

--Task 8: Change the percentages of the categories for a course;

UPDATE Assignment_Category
SET weight_percentage = 25
WHERE course_id = 1 AND category_type = 'Homework';

UPDATE Assignment_Category
SET weight_percentage = 20
WHERE course_id = 1 AND category_type = 'Project';

UPDATE Assignment_Category
SET weight_percentage = 10
WHERE course_id = 1 AND category_type = 'Quiz';

UPDATE Assignment_Category
SET weight_percentage = 25
WHERE course_id = 1 AND category_type = 'Final Exam';

UPDATE Assignment_Category
SET weight_percentage = 20
WHERE course_id = 1 AND category_type = 'Test';

--Test Case: Shows the updated categories and their weights.

--1 | Homework  | 25
--1 | Project   | 20
--1 | Quiz      | 10
--1 | Final Exam| 25
--1 | Test      | 20

SELECT course_id, category_type, weight_percentage
FROM Assignment_Category
WHERE course_id = 1
ORDER BY category_id;

--Task 9: Add 2 points to the score of each student on an assignment

UPDATE Grade
SET score = CASE
    WHEN score + 2 > 100 THEN 100
    ELSE score + 2
END
WHERE assignment_id = 1;

--Test Case: Run this query before and after.

--Expected result:
--1 -> 97
--2 -> 82
--3 -> 94
--4 -> 72
--5 -> 90
--6 -> 62
--7 -> 100
--8 -> 87

SELECT g.grade_id, g.assignment_id, g.enrollment_id, g.score
FROM Grade g
WHERE g.assignment_id = 1
ORDER BY g.enrollment_id;



--task 10
--adding 2 points to students with Q in last name
UPDATE Grade
SET score = MIN(score + 2,
    (
        SELECT a.max_score
        FROM Assignment a
        WHERE a.assignment_id = Grade.assignment_id
    ))
WHERE enrollment_id IN (
    SELECT e.enrollment_id
    FROM Enrollment e
    JOIN Student s ON e.student_id = s.student_id
    WHERE s.last_name LIKE '%Q%'
);

--TC_01: Validate student with q in last name
--Description: Ensure that we only change scores for the students with 'Q' in last name
--Expected: Table with grades from student(s) with 'Q' in last name 
SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    a.assignment_name,
    g.score,
    a.max_score
FROM Grade g
JOIN Enrollment e 
    ON g.enrollment_id = e.enrollment_id
JOIN Student s 
    ON e.student_id = s.student_id
JOIN Course c 
    ON e.course_id = c.course_id
JOIN Assignment a 
    ON g.assignment_id = a.assignment_id
WHERE c.course_id = 1
	AND s.last_name LIKE '%q%'
ORDER BY s.last_name, s.first_name, a.assignment_name;
--Actual: Table with grades from student(s) with 'Q' in last name
--Pass/Fail: Pass
    
--TC_02: Validate adding two points and min
--Description: Ensure grades don't exceed the max_score
--Expected: one table pulling the student's scores and comparing to max_score, another table showing changed scores and max_score
SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    a.assignment_name,
    g.score,
    a.max_score
FROM Grade g
JOIN Enrollment e 
    ON g.enrollment_id = e.enrollment_id
JOIN Student s 
    ON e.student_id = s.student_id
JOIN Course c 
    ON e.course_id = c.course_id
JOIN Assignment a 
    ON g.assignment_id = a.assignment_id
WHERE c.course_id = 1
	AND s.last_name LIKE '%q%'
ORDER BY s.last_name, s.first_name, a.assignment_name;
    
UPDATE Grade
SET score = MIN(score + 2,
    (
        SELECT a.max_score
        FROM Assignment a
        WHERE a.assignment_id = Grade.assignment_id
    ))
WHERE enrollment_id IN (
    SELECT e.enrollment_id
    FROM Enrollment e
    JOIN Student s ON e.student_id = s.student_id
    WHERE s.last_name LIKE '%Q%'
);   
    
SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    a.assignment_name,
    g.score,
    a.max_score
FROM Grade g
JOIN Enrollment e 
    ON g.enrollment_id = e.enrollment_id
JOIN Student s 
    ON e.student_id = s.student_id
JOIN Course c 
    ON e.course_id = c.course_id
JOIN Assignment a 
    ON g.assignment_id = a.assignment_id
WHERE c.course_id = 1
	AND s.last_name LIKE '%q%'
ORDER BY s.last_name, s.first_name, a.assignment_name;
--Actual: two tables showing original and changed scores
--Pass/Fail: Pass


--trigger for ensuring grades don't exceed max_score or aren't negative
CREATE TRIGGER validate_grade_update
BEFORE UPDATE ON Grade
FOR EACH ROW
BEGIN
    SELECT
    CASE
        WHEN NEW.score < 0 THEN
            RAISE(ABORT, 'Score cannot be negative')
        WHEN NEW.score > (
            SELECT max_score
            FROM Assignment
            WHERE assignment_id = NEW.assignment_id
        ) THEN
            RAISE(ABORT, 'Score exceeds max_score')
    END;
END;


--Task 11
--calculate final grade
WITH assignment_counts AS (
    SELECT 
        category_id,
        COUNT(*) AS category_size
    FROM Assignment
    GROUP BY category_id
)

SELECT
    s.first_name,
    s.last_name,
    c.course_name,

    SUM(
        (g.score * 1.0 / a.max_score)
        *
        (ac.weight_percentage * 1.0 / acount.category_size)
    ) AS final_grade

FROM Grade g
JOIN Enrollment e 
    ON g.enrollment_id = e.enrollment_id
JOIN Student s 
    ON e.student_id = s.student_id
JOIN Assignment a 
    ON g.assignment_id = a.assignment_id
JOIN Assignment_Category ac 
    ON a.category_id = ac.category_id
JOIN Course c 
    ON e.course_id = c.course_id
JOIN assignment_counts acount
	ON acount.category_id = ac.category_id
GROUP BY e.enrollment_id;


--TC_03: Final grade with NULL scores
--Description: Change score value to NULL; Ensure final grade is calculated with missing assignment scores
--Expected: table with final grades for each student with no NULL values
UPDATE Grade
SET score = NULL
WHERE grade_id = 5;

WITH assignment_counts AS (
    SELECT 
        category_id,
        COUNT(*) AS category_size
    FROM Assignment
    GROUP BY category_id
)

SELECT
    s.first_name,
    s.last_name,
    c.course_name,

    SUM(
        (g.score * 1.0 / a.max_score)
        *
        (ac.weight_percentage * 1.0 / acount.category_size)
    ) AS final_grade

FROM Grade g
JOIN Enrollment e 
    ON g.enrollment_id = e.enrollment_id
JOIN Student s 
    ON e.student_id = s.student_id
JOIN Assignment a 
    ON g.assignment_id = a.assignment_id
JOIN Assignment_Category ac 
    ON a.category_id = ac.category_id
JOIN Course c 
    ON e.course_id = c.course_id
JOIN assignment_counts acount
	ON acount.category_id = ac.category_id
GROUP BY e.enrollment_id;
--Actual: table with no NULL values
--Pass/Fail: Pass

--TC_04: Final grade with different max_score per assignment
--Description: Change max_score for assignment with corresponding score; Ensure final grade is calculated with new assignment scores
--Expected: table with final grades for each student
UPDATE Assignment
SET max_score = 50
WHERE assignment_id = 2;

UPDATE Grade
SET score = score - 50
WHERE assignment_id = 2;

WITH assignment_counts AS (
    SELECT 
        category_id,
        COUNT(*) AS category_size
    FROM Assignment
    GROUP BY category_id
)

SELECT
    s.first_name,
    s.last_name,
    c.course_name,

    SUM(
        (g.score * 1.0 / a.max_score)
        *
        (ac.weight_percentage * 1.0 / acount.category_size)
    ) AS final_grade

FROM Grade g
JOIN Enrollment e 
    ON g.enrollment_id = e.enrollment_id
JOIN Student s 
    ON e.student_id = s.student_id
JOIN Assignment a 
    ON g.assignment_id = a.assignment_id
JOIN Assignment_Category ac 
    ON a.category_id = ac.category_id
JOIN Course c 
    ON e.course_id = c.course_id
JOIN assignment_counts acount
	ON acount.category_id = ac.category_id
GROUP BY e.enrollment_id;
--Actual: table with final grades
--Pass/Fail: Pass

--task 12
WITH normalized AS (
    SELECT
        e.enrollment_id,
        s.first_name,
        s.last_name,
        c.course_name,
        ac.category_id,
        ac.weight_percentage,
        (g.score * 1.0 / a.max_score) AS score_pct
    FROM Grade g
    JOIN Enrollment e ON g.enrollment_id = e.enrollment_id
    JOIN Student s ON e.student_id = s.student_id
    JOIN Course c ON e.course_id = c.course_id
  	JOIN Assignment a ON g.assignment_id = a.assignment_id
	JOIN Assignment_Category ac ON a.category_id = ac.category_id
	WHERE e.enrollment_id = 1
),

ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY enrollment_id, category_id
               ORDER BY score_pct ASC
           ) AS rn,
           COUNT(*) OVER (
               PARTITION BY enrollment_id, category_id
           ) AS cnt
    FROM normalized
),

filtered AS (
    SELECT *
    FROM ranked
    WHERE 
        cnt = 1        -- keep single-assignment categories
        OR rn > 1      -- drop lowest otherwise
),

category_scores AS (
    SELECT
        enrollment_id,
        first_name,
        last_name,
        course_name,
        category_id,
        weight_percentage,
        AVG(score_pct) AS category_avg
    FROM filtered
    GROUP BY enrollment_id, category_id
)

SELECT
    first_name,
    last_name,
    course_name,
    SUM(category_avg * weight_percentage) AS final_grade
FROM category_scores
GROUP BY enrollment_id;

--TC_05:One grade per assignment
--Description: Ensuring no grade is dropped when only one grade per assignment
--Expected: table of final grades
DELETE FROM Grade
WHERE assignment_id IN (2,3,4,7,8,11);

DELETE FROM Assignment
WHERE assignment_id IN (2,3,4,7,8,11);

WITH normalized AS (
    SELECT
        e.enrollment_id,
        s.first_name,
        s.last_name,
        c.course_name,
        ac.category_id,
        ac.weight_percentage,
        (g.score * 1.0 / a.max_score) AS score_pct
    FROM Grade g
    JOIN Enrollment e ON g.enrollment_id = e.enrollment_id
    JOIN Student s ON e.student_id = s.student_id
    JOIN Course c ON e.course_id = c.course_id
  	JOIN Assignment a ON g.assignment_id = a.assignment_id
	JOIN Assignment_Category ac ON a.category_id = ac.category_id
),

ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY enrollment_id, category_id
               ORDER BY score_pct ASC
           ) AS rn,
           COUNT(*) OVER (
               PARTITION BY enrollment_id, category_id
           ) AS cnt
    FROM normalized
),

filtered AS (
    SELECT *
    FROM ranked
    WHERE 
        cnt = 1        -- keep single-assignment categories
        OR rn > 1      -- drop lowest otherwise
),

category_scores AS (
    SELECT
        enrollment_id,
        first_name,
        last_name,
        course_name,
        category_id,
        weight_percentage,
        AVG(score_pct) AS category_avg
    FROM filtered
    GROUP BY enrollment_id, category_id
)

SELECT
    first_name,
    last_name,
    course_name,
    SUM(category_avg * weight_percentage) AS final_grade
FROM category_scores
GROUP BY enrollment_id;
--Actual: table of final grades
--Pass/Fail: Pass

--TC_06: Multiple Lowest Scores
--Description: Change score of one assignment to match lowest in assignment category; ensure only one score dropped
--Expected: table of final grades
UPDATE Grade
SET score = 70
WHERE grade_id = 35;

WITH normalized AS (
    SELECT
        e.enrollment_id,
        s.first_name,
        s.last_name,
        c.course_name,
        ac.category_id,
        ac.weight_percentage,
        (g.score * 1.0 / a.max_score) AS score_pct
    FROM Grade g
    JOIN Enrollment e ON g.enrollment_id = e.enrollment_id
    JOIN Student s ON e.student_id = s.student_id
    JOIN Course c ON e.course_id = c.course_id
  	JOIN Assignment a ON g.assignment_id = a.assignment_id
	JOIN Assignment_Category ac ON a.category_id = ac.category_id
),

ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY enrollment_id, category_id
               ORDER BY score_pct ASC
           ) AS rn,
           COUNT(*) OVER (
               PARTITION BY enrollment_id, category_id
           ) AS cnt
    FROM normalized
),

filtered AS (
    SELECT *
    FROM ranked
    WHERE 
        cnt = 1        -- keep single-assignment categories
        OR rn > 1      -- drop lowest otherwise
),

category_scores AS (
    SELECT
        enrollment_id,
        first_name,
        last_name,
        course_name,
        category_id,
        weight_percentage,
        AVG(score_pct) AS category_avg
    FROM filtered
    GROUP BY enrollment_id, category_id
)

SELECT
    first_name,
    last_name,
    course_name,
    SUM(category_avg * weight_percentage) AS final_grade
FROM category_scores
GROUP BY enrollment_id;
--Actual: table of final grades
--Pass/Fail: Pass

--TC_07: Perfect Scores
--Description: Ensure final grade is 100 when all student grades are 100
--Expected: table of final grades with 100 for enrollment_id = 1
UPDATE Grade
SET score = 100
WHERE enrollment_id = 1;

WITH normalized AS (
    SELECT
        e.enrollment_id,
        s.first_name,
        s.last_name,
        c.course_name,
        ac.category_id,
        ac.weight_percentage,
        (g.score * 1.0 / a.max_score) AS score_pct
    FROM Grade g
    JOIN Enrollment e ON g.enrollment_id = e.enrollment_id
    JOIN Student s ON e.student_id = s.student_id
    JOIN Course c ON e.course_id = c.course_id
  	JOIN Assignment a ON g.assignment_id = a.assignment_id
	JOIN Assignment_Category ac ON a.category_id = ac.category_id
),

ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY enrollment_id, category_id
               ORDER BY score_pct ASC
           ) AS rn,
           COUNT(*) OVER (
               PARTITION BY enrollment_id, category_id
           ) AS cnt
    FROM normalized
),

filtered AS (
    SELECT *
    FROM ranked
    WHERE 
        cnt = 1        -- keep single-assignment categories
        OR rn > 1      -- drop lowest otherwise
),

category_scores AS (
    SELECT
        enrollment_id,
        first_name,
        last_name,
        course_name,
        category_id,
        weight_percentage,
        AVG(score_pct) AS category_avg
    FROM filtered
    GROUP BY enrollment_id, category_id
)

SELECT
    first_name,
    last_name,
    course_name,
    SUM(category_avg * weight_percentage) AS final_grade
FROM category_scores
GROUP BY enrollment_id;
--Actual: 100 for enrollment_id = 1
--Pass/Fail: Pass