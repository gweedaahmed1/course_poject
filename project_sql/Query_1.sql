/*
Question: what the top-paying job in analyst jobs?
- identify the top-10 highest-paying data analyst job that are available remotely.
- Focuses on job postings with spacified salary (remove null)
- Why? highlight the top-paying oppertunities for Data Analyst, offering insighits into employment
*/

SELECT
    jobs.job_id,
    jobs.job_title,
    company.name AS company_name,
    jobs.job_location,
    jobs.job_schedule_type,
    jobs.salary_year_avg,
    jobs.job_posted_date
FROM job_postings_fact AS jobs
LEFT JOIN company_dim AS company ON jobs.company_id = company.company_id

WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True

ORDER BY salary_year_avg DESC

LIMIT 10 ;