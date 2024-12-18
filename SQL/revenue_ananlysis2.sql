// CUSTOMER PURCHASE TYPE  PATTERN
SELECT 
	PURCHASE_TYPE
	COUNT(*) AS NUMBER_OF_PURCHASE
FROM	
	 DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
 GROUP BY
	PURCHASE_TYPE
	
 // CUSTOMER PAYMENT PATTERN
 SELECT 
	PAYMENT_TYPE,
	COUNT(*) AS NUMBER_OF_PAYMENT
FROM	
	DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
GROUP BY
		PAYMENT_TYPE
	
	// PEAK BOOKING TIME 
WITH PEAK_HOUR_DAY_PEAK AS (
    SELECT 
        HOUR(TIME_OF_PURCHASE) AS PEAK_HOUR,
        DAYOFWEEK(DATE_OF_PURCHASE) AS PEAK_DAY
    FROM 
        DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
)
SELECT 
    PEAK_HOUR,
    CASE    
        WHEN PEAK_DAY = 1 THEN 'SUNDAY'
        WHEN PEAK_DAY = 2 THEN 'MONDAY'
        WHEN PEAK_DAY = 3 THEN 'TUESDAY'
        WHEN PEAK_DAY = 4 THEN 'WEDNESDAY'
        WHEN PEAK_DAY = 5 THEN 'THURSDAY'
        WHEN PEAK_DAY = 6 THEN 'FRIDAY'
        WHEN PEAK_DAY = 7 THEN 'SATURDAY'
        ELSE 'UNKNOWN'
    END AS PEAK_DAY_NAME
FROM 
    PEAK_HOUR_DAY_PEAK
ORDER BY 
    PEAK_HOUR DESC ;

//	// PEAK BOOKING TIME  AND DAYS OF BOOKING 
WITH PEAK_HOUR_DAY_PEAK AS (
    SELECT 
        HOUR(TIME_OF_PURCHASE) AS PEAK_HOUR,
        DAYOFWEEK(DATE_OF_PURCHASE) AS PEAK_DAY
    FROM 
        DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
)
SELECT 
    PEAK_HOUR,
    SUM(CASE WHEN PEAK_DAY = 1 THEN 1 ELSE 0 END) AS SUNDAY_COUNT,
    SUM(CASE WHEN PEAK_DAY = 2 THEN 1 ELSE 0 END) AS MONDAY_COUNT,
    SUM(CASE WHEN PEAK_DAY = 3 THEN 1 ELSE 0 END) AS TUESDAY_COUNT,
    SUM(CASE WHEN PEAK_DAY = 4 THEN 1 ELSE 0 END) AS WEDNESDAY_COUNT,
    SUM(CASE WHEN PEAK_DAY = 5 THEN 1 ELSE 0 END) AS THURSDAY_COUNT,
    SUM(CASE WHEN PEAK_DAY = 6 THEN 1 ELSE 0 END) AS FRIDAY_COUNT,
    SUM(CASE WHEN PEAK_DAY = 7 THEN 1 ELSE 0 END) AS SATURDAY_COUNT
FROM 
    PEAK_HOUR_DAY_PEAK
GROUP BY 
    PEAK_HOUR
ORDER BY 
    PEAK_HOUR DESC;
	

	
