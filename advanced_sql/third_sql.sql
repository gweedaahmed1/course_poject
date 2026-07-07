SELECT
    CASE
        WHEN salary_year_avg < 90000 THEN 'LOW'
        WHEN salary_year_avg BETWEEN 90000 AND 110000 THEN 'MID'
        ELSE'HIGH'
    END AS salary_rank,
COUNT(job_id) AS count_of_jobs
FROM job_postings_fact

WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst'

GROUP BY salary_rank

ORDER BY 
    count_of_jobs
DESC

-- case and ctes




SELECT
    skills_dim.skills AS skill_name,
    skill_job.skill_count,
    skills_dim.skill_id
FROM skills_dim 
RIGHT JOIN ( SELECT skill_id, COUNT(job_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER by skill_count DESC
    LIMIT 5) AS skill_job
    ON skill_job.skill_id = skills_dim.skill_id 

-------- AI

WITH company_posts AS (
    SELECT
        company_id,
        COUNT(company_id) AS count_of_post,
        CASE
            WHEN COUNT(job_id) < 10 THEN 'small'
            WHEN COUNT(job_id) BETWEEN 10 AND 50 THEN 'medium'
            ELSE   'large'
             
        END AS company_cat
    FROM job_postings_fact

    GROUP BY company_id
  )

SELECT 
    company_dim.name,
    company_posts.company_cat
FROM company_posts
LEFT JOIN company_dim ON company_posts.company_id = company_dim.company_id




-- OR


SELECT 
    company_dim.name,
    CASE
            WHEN count_of_post < 10 THEN 'small'
            WHEN count_of_post BETWEEN 10 AND 50 THEN 'medium'
            ELSE   'large'
             
        END AS company_cat
FROM company_dim
INNER JOIN (
    SELECT
        company_id,
        COUNT(job_id) AS count_of_post
    FROM job_postings_fact

    GROUP BY company_id
  ) AS company_posts
    ON company_posts.company_id = company_dim.company_id






WITH top_10 as(SELECT
        job_postings_fact.job_id,
        job_postings_fact.job_title_short,
        job_postings_fact.salary_year_avg,
        company.name
FROM job_postings_fact
LEFT JOIN company_dim AS company ON company.company_id = job_postings_fact.company_id 

WHERE
    job_location = 'Anywhere' AND
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
)

SELECT 
    skills.skills AS skill,
    top_10.name,
    top_10.salary_year_avg

FROM top_10
INNER JOIN skills_job_dim AS skills_job ON top_10.job_id = skills_job.job_id
INNER JOIN skills_dim AS skills On skills_job.skill_id = skills.skill_id
        




-- practice problem 7

SELECT 
skills_dim.skill_id AS skills_id,
skills_dim.skills AS skill_name,
COUNT(jobs.job_id) AS skill_count

FROM job_postings_fact AS jobs
INNER JOIN skills_job_dim as job_skills ON job_skills.job_id = jobs.job_id
INNER JOIN skills_dim  ON job_skills.skill_id = skills_dim.skill_id
WHERE
    jobs.job_work_from_home = True AND
    jobs.job_title_short = 'Data Analyst'
GROUP BY skills_id

ORDER BY skill_count DESC

LIMIT 5

-- or 

WITH remote_job_skills  AS (SELECT 
job_skills.skill_id AS skill_id,
COUNT(jobs.job_id) AS skill_count
FROM job_postings_fact AS jobs
INNER JOIN skills_job_dim as job_skills ON job_skills.job_id = jobs.job_id
WHERE
    jobs.job_work_from_home = True AND
       jobs.job_title_short = 'Data Analyst'
GROUP BY skill_id
ORDER BY skill_count DESC
LIMIT 5)

SELECT
    skills.skill_id,
    skills.skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim as skills ON skills.skill_id = remote_job_skills.skill_id

--problem 8
WITH quarter_one AS (
SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    job_posted_date
FROM january_jobs

UNION ALL

SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    job_posted_date
FROM january_jobs

UNION ALL

SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    job_posted_date
FROM january_jobs
)

SELECT
    quarter_one.job_id,
    quarter_one.job_title_short,
    quarter_one.salary_year_avg,
    quarter_one.job_posted_date,
    skills_dim.skills,
    skills_dim.type
FROM  quarter_one
LEFT JOIN  skills_job_dim AS skill_to_job ON skill_to_job.job_id = quarter_one.job_id
LEFT JOIN  skills_dim  ON skill_to_job.skill_id = skills_dim.skill_id

WHERE 
    salary_year_avg > 70000 
