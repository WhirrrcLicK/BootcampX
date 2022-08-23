-- Get total number of assignments for each day

SELECT day, COUNT(*) as total_assignments
FROM assignments
GROUP BY day
ORDER BY day;

-- Only return rows where total assignments is <= 10

SELECT day, COUNT(*) as total_assignments
FROM assignments
GROUP BY day
HAVING COUNT(*) >= 10
ORDER BY day;

-- Get all cohorts with 18 or mopre students

SELECT cohort.name as cohort_name, COUNT(students.*) AS student_count
FROM cohorts
JOIN students ON cohorts.id = cohorts_id
HAVING COUNT(students.*) >= 18
ORDER BY student_count;

-- Get total number of assignment submissions for each cohort

SELECT cohort.name as cohort, COUNT(assignment_submissions.*) AS total_submissions
FROM assignment_submissions
JOIN students ON student.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY total_submissions DESC;

-- Get currently enrolled students' average assignment completion time

SELECT student.name as student, avg(assignment_submissions.duration) as average_assignment_duration
FROM students
JOIN assignment_submissions ON student_id = student.id
WHERE end_date IS NULL
GROUP BY student
ORDER BY average_assignment_duration DESC;

-- Get the students who's average time it takes to complete an assignment is less than half of the average

SELECT student.name as student, avg(assignment_submissions.duration) as average_assignment_duration, avg(assignments.duration) as average_estimated duration
FROM students
JOIN assignment_submissions ON student_id = student.id
JOIN assignments ON assignment.id = assignment_id
WHERE end_date IS NULL
GROUP BY student
HAVING avg(assignment_submissions.duration) < avg(assignments.duration)
ORDER BY average_assignment_duration;

