WITH cases_by_country AS (  
SELECT    
country_name AS country,    
sum(cumulative_confirmed) AS cases,   
sum(cumulative_recovered) AS recovered_cases  
FROM    bigquery_public_data.covid19_open_data.covid19_open_data  WHERE    
date = '2020-03-25'  
GROUP BY    
country_name ), recovered_rate AS 
(SELECT  country, cases, recovered_cases,  (recovered_cases * 100)/cases AS recovery_rate
FROM cases_by_country)SELECT 
country, 
cases AS confirmed_cases, 
recovered_cases, 
recovery_rate
FROM 
recovered_rate
WHERE cases > 50000
ORDER BY recovery_rate desc
LIMIT 10
