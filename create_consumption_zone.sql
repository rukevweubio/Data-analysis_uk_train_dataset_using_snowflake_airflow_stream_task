// create stream on the curated table 
create or replace stream curated_stream on table  demo_uk.curated_schema.curated_table
append_only =True


// select from the curated table for business need
create or replace table consumption_zone(
            ID,
           extract(month from  date_of_purchase) as months_of_purchase,
           extract(day from  date_of_purchase) as day_of_puchase,
            time_of_purchase,
            purchase_type,
            payment_method,
            railcard,
            ticket_class,
            ticket_type,
            price,
            departure_station,
            arrival_destination,
            date_of_journey,
            departure_time,
            arrival_time,
            actual_arrival_time,
            journey_status,
            reason_for_delay,
            refund_request
)
// show task 
show tasks


DROP TABLE demo_uk.curated_schema.curated_table;

SELECT 
    MONTHNAME(date_of_purchase) AS months_of_purchase,
    DAYNAME(date_of_purchase) AS day_of_purchase,
    purchase_type,
    payment_method,
    railcard,
    ticket_class,
    ticket_type,
    departure_station,
    arrival_destination,
    COUNT(*) AS order_counts, 
    AVG(price) AS average_price, 
    SUM(price) AS total_price,
    MAX(departure_time) AS max_departure_time,
    MIN(departure_time) AS min_departure_time,
    MONTHNAME(date_of_journey) AS months_of_journey,
    DAYNAME(date_of_journey) AS day_of_journey
FROM 
    demo_uk.curated_schema.curated_table
GROUP BY 
    MONTHNAME(date_of_purchase), 
    DAYNAME(date_of_purchase),
    purchase_type,
    payment_method,
    railcard,
    ticket_class,
    ticket_type,
    departure_station,
    arrival_destination,
    MONTHNAME(date_of_journey),
    DAYNAME(date_of_journey)
	
	
// alter the task 
alter task curated_zone_task resume ;
alter task curated_zone_task2 resume;
alter task curated_zone_task_stream resume ;

alter task curated_zone_task suspend; 
alter task curated_zone_task2 suspend;
alter task curated_zone_task_stream suspend ;
