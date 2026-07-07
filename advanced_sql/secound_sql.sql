SELECT 
    EXTRACT (MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_posted_count

FROM job_postings_fact

GROUP BY job_posted_month  

ORDER BY
    job_posted_month;
-- problems

-- problem 1
SELECT
    job_schedule_type AS job_type,
    AVG(salary_year_avg) AS AVG_yearly_salary,
    AVG(salary_hour_avg) AS AVG_hour_salary

FROM job_postings_fact

WHERE   
    job_posted_date > '2023-06-01'

GROUP BY job_schedule_type;

-- problem 2
SELECT 
    EXTRACT(Month FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York')) AS job_posted_month,
    COUNT(job_id) AS job_postings_count

FROM job_postings_fact
WHERE
    EXTRACT(YEAR FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York')) = '2023' 
GROUP BY job_posted_month

ORDER BY job_posted_month;

-- problem 3
 SELECT DISTINCT company.name
FROM job_postings_fact as job
LEFT JOIN company_dim AS company ON job.company_id = company.company_id

WHERE
    EXTRACT(MONTH FROM job.job_posted_date) BETWEEN 4 AND 6 AND
    EXTRACT(YEAR FROM job.job_posted_date) = '2023' AND
    job.job_health_insurance  = TRUE;

-- end of date functions

CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT *

FROM march_jobs
LIMIT 10
-- start of problem 6





