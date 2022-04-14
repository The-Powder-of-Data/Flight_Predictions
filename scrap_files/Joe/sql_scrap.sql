SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND 
    schemaname != 'information_schema';


SELECT * FROM flights_test;
SELECT EXTRACT(MONTH FROM TO_DATE(fl_date)) AS month FROM flights_test;




SELECT * FROm flights LIMIT 10; 
SELECT * FROM passengers LIMIT 2;
SELECT * FROM fuel_comsumption LIMIT 2;

SELECT DISTINCT(mkt_carrier) FROM flights;
SELECT DISTINCT(origin_airport_id), origin, origin_city_name FROM flights;
SELECT COUNT(DISTINCT(origin_airport_id)) FROM flights;
SELECT COUNT(DISTINCT(dest_airport_id)) FROM flights;
SELECT * FROm flights WHERE diverted = 1 LIMIT 5; 

SELECT * FROM flights ORDER BY weather_delay DESC NULLS LAST LIMIT 500;



SELECT AVG(arr_delay), MEDIAN(arr_delay), MIN(arr_delay), MAX(arr_delay) FROM flights;

/* median = -6  */
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY arr_delay) FROM flights;

/* min date = 2018-01-01 */
SELECT MIN(fl_date) FROM flights;

/* max date = 2019-12-31 */
SELECT MAX(fl_date) FROM flights;

SELECT MIN(fl_date) from flights_test;

SELECT arr_delay from flights;

/* frame for month/ day/ year extraction */
SELECT random(), fl_date, EXTRACT(MONTH FROM TO_DATE(fl_date, 'YYYY-MM-DD')) AS month, EXTRACT(YEAR FROM TO_DATE(fl_date, 'YYYY-MM-DD')) AS year  FROM flights
WHERE EXTRACT(YEAR FROM TO_DATE(fl_date, 'YYYY-MM-DD')) < 2019 AND EXTRACT(MONTH FROM TO_DATE(fl_date, 'YYYY-MM-DD')) = 1 AND random() < .01
;


/* get random sample*/ 
SELECT fl_date, EXTRACT(MONTH FROM TO_DATE(fl_date, 'YYYY-MM-DD')) AS month, EXTRACT(YEAR FROM TO_DATE(fl_date, 'YYYY-MM-DD')) AS year  FROM flights
WHERE EXTRACT(YEAR FROM TO_DATE(fl_date, 'YYYY-MM-DD')) < 2019 AND EXTRACT(MONTH FROM TO_DATE(fl_date, 'YYYY-MM-DD')) = 1 AND random() < .05
;


/* get random sample*/ 
SELECT *, EXTRACT(MONTH FROM TO_DATE(fl_date, 'YYYY-MM-DD')) AS month, EXTRACT(YEAR FROM TO_DATE(fl_date, 'YYYY-MM-DD')) AS year  FROM flights
WHERE EXTRACT(YEAR FROM TO_DATE(fl_date, 'YYYY-MM-DD')) < 2019 AND random() < .03
ORDER BY random()
;

SELECT * FROM flights TABLESAMPLE BERNOULLI(20);