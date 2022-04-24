# sql-bigquery-examples
Insights made on bigquery public datasets through SQL queries

#### no:of bikes in New York and how this number has grown over years(2013-18):
```sql
SELECT 
 EXTRACT(YEAR from starttime) as year,  
  COUNT(DISTINCT(bikeid)) as num_bikes
FROM `bigquery-public-data.new_york.citibike_trips`
GROUP BY year
ORDER BY year
```

#### which were the most popular for starting a trip:
```sql
SELECT
      start_station_name,
      start_station_latitude,
      start_station_longitude, COUNT(*) as num_trips
FROM
      `bigquery-public-data.new_york.citibike_trips`
GROUP BY
      1,2,3
ORDER BY num_trips DESC
LIMIT 10
```

#### no:of trips does each generation take in a year:
```sql
SELECT
  EXTRACT(year
  FROM
    starttime) AS year,
  COUNT(CASE
      WHEN birth_year>= 1940 AND birth_year < 1959 THEN 1
  END
    ) AS Boomer,
  COUNT(CASE
      WHEN birth_year>= 1960 AND birth_year < 1979 THEN 1
  END
    ) AS Gen_X,
  COUNT(CASE
      WHEN birth_year>= 1980 AND birth_year < 1994 THEN 1
  END
    ) AS Gen_Y,
  COUNT(CASE
      WHEN birth_year>= 1995 AND birth_year < 2012 THEN 1
  END
    ) AS Gen_Z
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
GROUP BY
  year
HAVING 
  year is NOT NULL
ORDER BY
  year DESC
```

#### which gender rides more over the years:
```sql
SELECT
  EXTRACT(year
  FROM
    starttime) AS year,
  SUM(CASE
      WHEN gender='female' THEN tripduration
  END
    )/(60*60) AS female_ride_time,
  SUM(CASE
      WHEN gender='male' THEN tripduration
  END
    )/(60*60) AS male_ride_time
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
GROUP BY
  year
HAVING 
  year is NOT NULL
ORDER BY
  year DESC
```

#### popular routes:
```sql
SELECT
  start_station_id,
  end_station_id,
  COUNT(*) AS Trips_on_route
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  (start_station_id != end_station_id) or (start_station_id = end_station_id and tripduration > 300)
GROUP BY
  start_station_id,
  end_station_id
ORDER BY
  Trips_on_route DESC
LIMIT
  10
```