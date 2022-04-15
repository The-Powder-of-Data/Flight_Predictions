SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND 
    schemaname != 'information_schema';


SELECT * FROM flights_test limit 5;
SELECT *, EXTRACT(month FROM fl_date) as month, EXTRACT(dow FROM fl_date) as day FROM flights_test limit 5;
SELECT *, EXTRACT(month FROM fl_date) as month, EXTRACT(dow FROM fl_date) as day FROM flights_test;

SELECT *, (EXTRACT(day FROM fl_date)) as day, EXTRACT(month FROM fl_date) as month, EXTRACT(year FROM fl_date) as year, (EXTRACT(dow FROM fl_date)) as day_ow FROM flights_test 
WHERE (EXTRACT(day FROM fl_date)) < 9
;

SELECT EXTRACT(MONTH FROM TO_DATE(fl_date)) AS month FROM flights_test;


/* 5802 for all of jan, or 5584 for the first week*/ 
SELECT COUNT(DISTINCT(tail_num)) FROM flights_test
WHERE (EXTRACT(day FROM fl_date)) < 9
;

/* 363 origin airport id*/
SELECT COUNT(DISTINCT(origin_airport_id)) FROM flights_test
WHERE (EXTRACT(day FROM fl_date)) < 9
;

/* 25 Op carriers*/
SELECT COUNT(DISTINCT(op_unique_carrier)) FROM flights_test
WHERE (EXTRACT(day FROM fl_date)) < 9
;

/* 363 dest airports*/
SELECT COUNT(DISTINCT(dest_airport_id)) FROM flights_test
WHERE (EXTRACT(day FROM fl_date)) < 9
;


SELECT * FROM flights
WHERE tail_num IN (SELECT DISTINCT(tail_num) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND
      origin_airport_id IN (SELECT DISTINCT(origin_airport_id) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND 
      op_unique_carrier IN (SELECT DISTINCT(op_unique_carrier) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND
      dest_airport_id IN (SELECT DISTINCT(dest_airport_id) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    
      
LIMIT 5;

SELECT COUNT(*) FROM flights
WHERE tail_num IN (SELECT DISTINCT(tail_num) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND
      origin_airport_id IN (SELECT DISTINCT(origin_airport_id) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND 
      op_unique_carrier IN (SELECT DISTINCT(op_unique_carrier) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND
      dest_airport_id IN (SELECT DISTINCT(dest_airport_id) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
      
;


SELECT tail_num, origin_airport_id, origin, dest_airport_id, dest, op_unique_carrier FROM flights_test
WHERE (EXTRACT(day FROM fl_date)) < 8


SELECT * FROM SELECT((SELECT * FROM flights
WHERE tail_num IN (SELECT DISTINCT(tail_num) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND
      origin_airport_id IN (SELECT DISTINCT(origin_airport_id) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND 
      op_unique_carrier IN (SELECT DISTINCT(op_unique_carrier) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND
      dest_airport_id IN (SELECT DISTINCT(dest_airport_id) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
      
) )
TABLESAMPLE BERNOULLI(0.4);



SELECT * FROM flights
WHERE tail_num IN (SELECT DISTINCT(tail_num) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND
      origin_airport_id IN (SELECT DISTINCT(origin_airport_id) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND 
      op_unique_carrier IN (SELECT DISTINCT(op_unique_carrier) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
    AND
      dest_airport_id IN (SELECT DISTINCT(dest_airport_id) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 9)
      
;

SELECT fl_date, op_unique_carrier, tail_num, origin_airport_id, dest_airport_id, crs_dep_time, dep_time, dep_delay, taxi_out, taxi_in, crs_arr_time, arr_time, arr_delay, crs_elapsed_time, actual_elapsed_time 
 FROM flights TABLESAMPLE bernoulli(4)
 WHERE tail_num IN (SELECT DISTINCT(tail_num) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 8)
    AND
      origin_airport_id IN (SELECT DISTINCT(origin_airport_id) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 8)
    AND 
      op_unique_carrier IN (SELECT DISTINCT(op_unique_carrier) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 8)
    AND
      dest_airport_id IN (SELECT DISTINCT(dest_airport_id) FROM flights_test WHERE (EXTRACT(day FROM fl_date)) < 8);



SELECT * FROM flights_test limit 5;

SELECT fl_date, mkt_carrier, mkt_carrier_fl_num, origin, dest, op_unique_carrier, tail_num, origin_airport_id, dest_airport_id, 
       crs_dep_time, crs_arr_time, crs_elapsed_time, (EXTRACT(day FROM fl_date)) as day_om, ((EXTRACT(dow FROM fl_date)) -1) as day, EXTRACT(month FROM fl_date) as month
FROM flights_test
WHERE EXTRACT(day FROM fl_date) < 8

;








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