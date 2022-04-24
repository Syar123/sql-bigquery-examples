SELECT 
 EXTRACT(YEAR from starttime) as year,  
  COUNT(DISTINCT(bikeid)) as num_bikes
FROM `bigquery-public-data.new_york.citibike_trips`
GROUP BY year
ORDER BY year