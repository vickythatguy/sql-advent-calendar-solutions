-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

with cte as (
  select subject, row_number() over(partition by subject order by quiz_date asc) as rnk1, score as sc1
  from daily_quiz_scores
),
cte1 as (
  select subject, row_number() over(partition by subject order by quiz_date desc) as rnk2, score as sc2
  from daily_quiz_scores
)
select cte1.subject, sc1, sc2
from cte join cte1 on cte.subject = cte1.subject
where rnk1 =1 and rnk2=1
