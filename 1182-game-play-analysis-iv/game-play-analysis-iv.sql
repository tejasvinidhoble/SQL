# Write your MySQL query statement below
WITH FirstLogin AS (
    
    SELECT player_id, MIN(event_date) AS first_login_date
    FROM Activity
    GROUP BY player_id
)

SELECT ROUND(
    (COUNT(DISTINCT f.player_id) * 1.0 / (SELECT COUNT(DISTINCT player_id) FROM Activity)), 2
) AS fraction
FROM FirstLogin f
JOIN Activity a
ON f.player_id = a.player_id 
AND a.event_date = DATE_ADD(f.first_login_date, INTERVAL 1 DAY);
