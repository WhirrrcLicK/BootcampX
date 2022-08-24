-- Total number of assistance_requests for teacher

SELECT teachers.name as name, COUNT(assistance_requests.*) AS total_assistances
FROM assistance_requests
JOIN teachers ON teachers.id = teacher_id
WHERE teachers.name = "Waylon Boehm"
GROUP BY teachers.name;

-- How many assistance requests any student has requested

SELECT students.name, COUNT(assistance_requests.*) AS total_assistances
FROM assistance_requests
JOIN students ON students.id = student_id
WHERE students.name = "Elliot Dickinson"
GROUP BY students.name;

-- See all important data from assistance request

SELECT teachers.name, students.name, assignments.name, (completed_at-started_at) AS duration
FROM assistance_requests
JOIN teachers ON teachers.name = teacher_id
JOIN students ON students.name = student_id
JOIN assignments ON assignments.name = assignment_id
ORDER BY duration;

-- See current avaerage time it takes to complete an assistance

SELECT avg(completed_at - started_at) AS average_assistance_request_duration
FROM assistance_requests;

-- See average duration of single assistance request for each cohort

SELECT avg(completed_at - started_at) AS average_assistance_time, cohorts.name
FROM assistance_requests
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time;

-- Cohort with the longest average duration of assistance requests

SELECT avg(completed_at - started_at) AS average_assistance_time, cohorts.name
FROM assistance_requests
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time DESC
LIMIT 1;

-- Average amount of time that students are waiting for assistance

SELECT avg(started_at - created_at) AS average_wait_time
FROM assistance_requests;

-- Total duration of all assistance requests for each cohort

SELECT sum(started_at-completed_at) AS total_duration, cohorts.name AS cohort
FROM assistance_requests
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY total_duration;

-- Average total amount of time being spent on assistance requests for each cohort

SELECT avg(total_duration) AS average_total_duration
FROM (
  SELECT sum(started_at-completed_at) AS total_duration, cohorts.name AS cohort
FROM assistance_requests
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY total_duration;
) as total_durations;

-- List each assignment with total number of assistance requests

SELECT assignments.id, name, day, chapter, COUNT(assistance_requests) AS total_requests
FROM assignments
JOIN assistance_requests ON assignments.id = assignment_id
GROUP BY assignment.id
ORDER BY total_requests DESC;

-- Each day with total number of assignments and total duration of assignments

SELECT day, COUNT(*) AS number_of_assignments, sum(duration) AS duration
FROM assignments
GROUP BY day
ORDER BY day;

-- Get names of teachers that performed an assistance request during a cohort

SELECT DISTINCT teachers.name, cohorts.name
FROM teachers
JOIN assistance_requests ON teachers_id = teacher.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohort.name = 'JUL02'
ORDER BY teachers.name;

-- Include number of assistances

SELECT teachers.name AS teacher, cohorts.name AS cohort, COUNT(assistance_requests) AS total_assistances
FROM teachers
JOIN assistance_requests ON teachers_id = teacher.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohort.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY teachers.name;
