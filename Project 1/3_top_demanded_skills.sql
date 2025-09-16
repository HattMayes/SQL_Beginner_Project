-- What are the most in-demand skills for data analysts?
/*
- Identify the top 5 in-demand skills for a data analyst (similar to results in 2_top_paying_jobs)
- Focusing on all job postings
*/

-- 1. Using the same INNER JOIN code from 2_top_paying_jobs_skills, but renaming the joining table
-- 2. Limiting to 5 results
-- 3. Using COUNT to aggregate the total count of each skill, grouped by skills
-- 4. ORDER BY the COUNT (demand_count) in descending order to get the top 5 skills
-- Use WHERE to filter to only data analyst job titles

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5

-- Results -
/*
[
  {
    "skills": "sql",
    "demand_count": "92628"
  },
  {
    "skills": "excel",
    "demand_count": "67031"
  },
  {
    "skills": "python",
    "demand_count": "57326"
  },
  {
    "skills": "tableau",
    "demand_count": "46554"
  },
  {
    "skills": "power bi",
    "demand_count": "39468"
  }
]
*/