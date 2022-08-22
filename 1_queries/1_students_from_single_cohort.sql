-- Get list of students from single cohort arranged alphabetically
SELECT id, name
FROM Students
WHERE cohort_id = 14
ORDER BY name;


-- Get list of students in cohorts 1-3
SELECT id, name
FROM Students
WHERE cohort_id IN (1,2,3);

-- Get all of the students that don't have an email or phone number
SELECT id, name, cohort_id
FROM Students
WHERE email IS NULL
OR phone IS NULL;

-- Get all of the students without gmail or phone number
SELECT id, name, email, cohort_id
FROM Students
WHERE email NOT LIKE '%@gmail.com'
AND phone IS NULL;

-- Get all students currently enrolled
SELECT id, name, cohort_id
FROM Students
WHERE end_date IS NULL
ORDER BY cohort_id;

-- Get all graduates without a linked Github account
SELECT name, email, phone
FROM Students
WHERE github IS NULL
AND end_date IS NOT NULL;