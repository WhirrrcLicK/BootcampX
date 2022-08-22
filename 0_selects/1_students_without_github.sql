SELECT id, name, email, cohort_id
FROM Students
WHERE github IS NULL
ORDER BY cohort_id;