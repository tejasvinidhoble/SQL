# Write your MySQL query statement below
WITH DailyTotals AS (
    SELECT visited_on, SUM(amount) AS total_amount
    FROM Customer
    GROUP BY visited_on
),
MovingAverages AS (
    SELECT d1.visited_on, 
           SUM(d2.total_amount) AS amount,
           ROUND(AVG(d2.total_amount), 2) AS average_amount
    FROM DailyTotals d1
    JOIN DailyTotals d2 
    ON d2.visited_on BETWEEN DATE_SUB(d1.visited_on, INTERVAL 6 DAY) AND d1.visited_on
    GROUP BY d1.visited_on
    HAVING COUNT(d2.visited_on) = 7
)
SELECT visited_on, amount, average_amount
FROM MovingAverages
ORDER BY visited_on;
