-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

with cte as (
  select user_name, count(message_id) as total_messages, date(sent_at) as day1
  from npn_users join npn_messages on npn_messages.sender_id = npn_users.user_id
  group by user_name, day1
),
cte1 as (
  select *,dense_rank() over(partition by day1 order by total_messages desc) as rank1
  from cte
)
select user_name, total_messages, day1
from cte1
where rank1=1
