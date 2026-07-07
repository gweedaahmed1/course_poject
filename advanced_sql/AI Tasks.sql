-- AI Tasks
-- 30-6-2026

-- First one 

SELECT
    company.name AS name,
    COUNT(company.company_id) AS count_of_company_posts

FROM company_dim AS company
LEFT JOIN job_postings_fact AS jobs ON company.company_id = jobs.company_id

WHERE
    EXTRACT(MONTH FROM jobs.job_posted_date) = 1
GROUP BY
    name
ORDER BY count_of_company_posts
    DESC

-- to make top 10
LIMIT 10


--SECOUND TASK

SELECT DISTINCT
    company.NAME AS company_not_require_degree


FROM company_dim AS company
LEFT JOIN job_postings_fact AS jobs ON company.company_id = jobs.company_id

WHERE
    jobs.job_no_degree_mention = TRUE


-- th3 task

SELECT 
skills.skills AS skills,
COUNT(jobs.job_id) AS count_of_the_skill

FROM job_postings_fact AS jobs
LEFT JOIN skills_job_dim AS skills_jobs ON jobs.job_id = skills_jobs.job_id
LEFT JOIN skills_dim AS skills ON skills_jobs.skill_id = skills.skill_id

WHERE
    jobs.job_title_short = 'Data Analyst'

GROUP BY skills
ORDER BY count_of_the_skill
    DESC

LIMIT 5;

-- 4th task

SELECT *

FROM job_postings_fact

WHERE
    EXTRACT(MONTH FROM job_posted_date) = 3 AND
    job_title LIKE '%Engineer%'

-- 5th task

SELECT
    *,
    (salary_year_avg /12)  AS salary_month_avg
FROM job_postings_fact

WHERE
    salary_year_avg IS NOT NULL

 ORDER BY salary_month_avg
    DESC

LIMIT 5;

-- NEW TASKS

-- task 1



CREATE TABLE favorite_jobs
    (job_id INT  PRIMARY KEY ,
     job_title VARCHAR(255),
     applied_date DATE)

--DROP TABLE favorite_jobs IF 

--TASK 2


SELECT 
    job_title  AS Target_Jobs
FROM job_postings_fact

WHERE job_title LIKE '%DATA%'

--TASK 3 

SELECT
    EXTRACT(YEAR FROM job_posted_date) AS year,
    COUNT(job_id) AS the_count
FROM job_postings_fact

GROUP BY year

--TASK 4
SELECT
    company.name AS company_name,
    job_title

FROM job_postings_fact AS jobs
LEFT JOIN company_dim AS company ON jobs.company_id = company.company_id
WHERE salary_year_avg IS  NULL
