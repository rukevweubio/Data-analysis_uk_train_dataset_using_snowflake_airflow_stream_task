use database demo_uk;
use schema demo_schema ;




// show table 
select * from DEMO_UK.CONSUMPTION_SCHEMA.AGGREGATED_FACT_TABLE

select * from DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE


// check table column  and data type
SELECT COLUMN_NAME, data_type
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'CONSUMPTION_SCHEMA'
AND TABLE_NAME = 'AGGREGATED_FACT_TABLE';

 ///What is the average ticket price across different routes or destinations?
   select  
    DEPARTURE_STATION,
    avg(price) as average_price
from
    DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
group by 
    DEPARTURE_STATION
order by 
    average_price desc  limit 10
    
    
// count the number of trip made by the train made  from the arrival to destination 
select 
     DEPARTURE_STATION,
     arrival_destination,
    count(*) as number_of_trip
from 
    DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
group by 
    DEPARTURE_STATION,
     arrival_destination
  order by count(*)
  desc  limit 10
// price of ticket by data of purchase 

WITH day_of_week AS (
    SELECT 
        DAYOFWEEK(DATE_OF_PURCHASE) AS day,
        AVG(price) AS average_price
    FROM DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
    GROUP BY day
    ORDER BY average_price DESC
)
SELECT 
    CASE 
        WHEN day_of_week.day = 1 THEN 'Sunday'
        WHEN day_of_week.day = 2 THEN 'Monday'
        WHEN day_of_week.day = 3 THEN 'Tuesday'
        WHEN day_of_week.day = 4 THEN 'Wednesday'
        WHEN day_of_week.day = 5 THEN 'Thursday'
        WHEN day_of_week.day = 6 THEN 'Friday'
        WHEN day_of_week.day = 0 THEN 'Saturday'
        ELSE 'Unknown'
    END AS day_of_week_name,
   
    day_of_week.average_price
FROM day_of_week;

 // time or purchase  with price of the ticket with the higest price       
WITH day_of_week AS (
    SELECT 
        DAYOFWEEK(DATE_OF_PURCHASE) AS day,
        HOUR(TIME_OF_PURCHASE) AS hour_of_purchase, 
        AVG(price) AS average_price
    FROM DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
    GROUP BY day, hour_of_purchase
    ORDER BY average_price DESC
),
time_of_purchase AS (
    SELECT 
        CASE 
            WHEN day_of_week.day = 1 THEN 'Sunday'
            WHEN day_of_week.day = 2 THEN 'Monday'
            WHEN day_of_week.day = 3 THEN 'Tuesday'
            WHEN day_of_week.day = 4 THEN 'Wednesday'
            WHEN day_of_week.day = 5 THEN 'Thursday'
            WHEN day_of_week.day = 6 THEN 'Friday'
            WHEN day_of_week.day = 7 THEN 'Saturday'
            ELSE 'Unknown'
        END AS day_of_week_name,
        day_of_week.hour_of_purchase,
        day_of_week.average_price
    FROM day_of_week
    LIMIT 10
)
SELECT 
    time_of_purchase.day_of_week_name,
    time_of_purchase.average_price,
    CASE
        WHEN time_of_purchase.hour_of_purchase IN (6, 7, 8, 9, 10) THEN 'Morning'
        WHEN time_of_purchase.hour_of_purchase IN (11, 12, 13, 14, 15, 16) THEN 'Afternoon'
        WHEN time_of_purchase.hour_of_purchase IN (17, 18, 19, 20, 21, 22, 23) THEN 'Evening'
        ELSE 'Unknown'
    END AS time_of_purchase_period
FROM 
    time_of_purchase;

       
// time or purchase  with price of the ticket with the higest price       
  WITH day_of_week AS (
    SELECT 
        DAYOFWEEK(DATE_OF_PURCHASE) AS day,
        hour(TIME_OF_PURCHASE) as hour, 
        AVG(price) AS average_price
    FROM DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
    GROUP BY day,hour
    ORDER BY average_price DESC
)
SELECT 
    CASE 
        WHEN day_of_week.day = 1 THEN 'Sunday'
        WHEN day_of_week.day = 2 THEN 'Monday'
        WHEN day_of_week.day = 3 THEN 'Tuesday'
        WHEN day_of_week.day = 4 THEN 'Wednesday'
        WHEN day_of_week.day = 5 THEN 'Thursday'
        WHEN day_of_week.day = 6 THEN 'Friday'
        WHEN day_of_week.day = 0 THEN 'Saturday'
        ELSE 'Unknown'
    END AS day_of_week_name,
    day_of_week.hour as hour_of_purchase,
    day_of_week.average_price 
FROM day_of_week
order by 
    day_of_week.average_price 
    asc ;  
    
 // departure time with price 
WITH day_of_week AS (
    SELECT 
        DAYOFWEEK(DATE_OF_JOURNEY) AS day,
        HOUR(DEPARTURE_TIME) AS hour_of_departure, 
        AVG(price) AS average_price
    FROM DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
    GROUP BY day, hour_of_departure
    ORDER BY average_price DESC
),
time_of_purchase AS (
    SELECT 
        CASE 
            WHEN day_of_week.day = 1 THEN 'Sunday'
            WHEN day_of_week.day = 2 THEN 'Monday'
            WHEN day_of_week.day = 3 THEN 'Tuesday'
            WHEN day_of_week.day = 4 THEN 'Wednesday'
            WHEN day_of_week.day = 5 THEN 'Thursday'
            WHEN day_of_week.day = 6 THEN 'Friday'
            WHEN day_of_week.day = 7 THEN 'Saturday'
            ELSE 'Unknown'
        END AS day_of_week_name,
        day_of_week.hour_of_departure,
        day_of_week.average_price
    FROM day_of_week
    LIMIT 10
)
SELECT 
    time_of_purchase.day_of_week_name,
    time_of_purchase.average_price,
    CASE
        WHEN time_of_purchase.hour_of_departure IN (6, 7, 8, 9, 10) THEN 'Morning'
        WHEN time_of_purchase.hour_of_departure IN (11, 12, 13, 14, 15, 16) THEN 'Afternoon'
        WHEN time_of_purchase.hour_of_departure IN (17, 18, 19, 20, 21, 22, 23) THEN 'Evening'
        ELSE 'Unknown'
    END AS time_of_purchase_period
FROM 
    time_of_purchase
	
//purchase type with price 
select 
    PURCHASE_TYPE,
    AVG(PRICE) AS AVEARGE_PRICE
FROM 
    DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
GROUP BY 
     PURCHASE_TYPE
ORDER BY AVEARGE_PRICE DESC 

// TICKET TYPE WITH PRICE
select 
    TICKET_TYPE,
    AVG(PRICE) AS AVEARGE_PRICE, COUNT(*) AS COUNT
FROM 
    DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
GROUP BY 
    TICKET_TYPE
ORDER BY AVEARGE_PRICE DESC,COUNT(*) DESC

// DAY OF THE WEEK WHERE THIS TICKER ARE BOUGHT
WITH DAY_OF_WEEK AS (
    SELECT 
        TICKET_TYPE,
        DAYOFWEEK(DATE_OF_PURCHASE) AS day,
        AVG(PRICE) AS AVERAGE_PRICE,
        COUNT(*) AS COUNT
    FROM 
        DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
    GROUP BY 
        TICKET_TYPE, DAYOFWEEK(DATE_OF_PURCHASE)
    ORDER BY 
        AVG(PRICE) DESC, COUNT DESC
)
SELECT 
    DAY_OF_WEEK.COUNT AS TICKET_COUNT,
    DAY_OF_WEEK.AVERAGE_PRICE,
    DAY_OF_WEEK.TICKET_TYPE,
    CASE 
        WHEN DAY_OF_WEEK.day = 1 THEN 'Sunday'
        WHEN DAY_OF_WEEK.day = 2 THEN 'Monday'
        WHEN DAY_OF_WEEK.day = 3 THEN 'Tuesday'
        WHEN DAY_OF_WEEK.day = 4 THEN 'Wednesday'
        WHEN DAY_OF_WEEK.day = 5 THEN 'Thursday'
        WHEN DAY_OF_WEEK.day = 6 THEN 'Friday'
        WHEN DAY_OF_WEEK.day = 7 THEN 'Saturday'
        ELSE 'Unknown'
    END AS DAY_OF_WEEK_NAME
FROM 
    DAY_OF_WEEK
    
    order by TICKET_COUNT desc ;

// total  revenue by payment type 
select 
    payment_method,count(*) as total_counts,
    avg(price) as average_price
from 
    DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
group by 
     payment_method
order by 
     total_counts desc ,average_price desc 

//What is the impact of travel class (e.g., standard vs. first class) on ticket prices?
SELECT 
    ticket_class,
    avg(price) as average_price
from 
     DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
 group by 
    ticket_class
order by 
    average_price
    desc 
      ;


 SELECT 
    DATEDIFF('minute', DEPARTURE_TIME, ARRIVAL_TIME) / 60.0 AS travel_time_hours,
    AVG(PRICE) AS AVERAGE_PRICE
FROM DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
GROUP BY
    travel_time_hours
ORDER BY 
    AVERAGE_PRICE DESC  ;



    
    