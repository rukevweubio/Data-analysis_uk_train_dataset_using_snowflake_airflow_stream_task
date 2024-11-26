CREATE OR REPLACE PROCEDURE consumption_merge_table()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    -- Merge data from stream into the curated table
    MERGE INTO demo_uk.consumption_schema.consumption_table AS CURATED
    USING (
        SELECT 
            ID,
            date_of_purchase,
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
        FROM demo_uk.curated_schema.curated_stream
    ) AS STREAM
    ON CURATED.ID = STREAM.ID
    WHEN MATCHED THEN
        UPDATE SET
            date_of_purchase = STREAM.date_of_purchase,
            time_of_purchase = STREAM.time_of_purchase,
            purchase_type = STREAM.purchase_type,
            payment_method = STREAM.payment_method,
            railcard = STREAM.railcard,
            ticket_class = STREAM.ticket_class,
            ticket_type = STREAM.ticket_type,
            price = STREAM.price,
            departure_station = STREAM.departure_station,
            arrival_destination = STREAM.arrival_destination,
            date_of_journey = STREAM.date_of_journey,
            departure_time = STREAM.departure_time,
            arrival_time = STREAM.arrival_time,
            actual_arrival_time = STREAM.actual_arrival_time,
            journey_status = STREAM.journey_status,
            reason_for_delay = STREAM.reason_for_delay,
            refund_request = STREAM.refund_request
    WHEN NOT MATCHED THEN
        INSERT (
            ID,
            date_of_purchase,
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
        VALUES (
            STREAM.ID,
            STREAM.date_of_purchase,
            STREAM.time_of_purchase,
            STREAM.purchase_type,
            STREAM.payment_method,
            STREAM.railcard,
            STREAM.ticket_class,
            STREAM.ticket_type,
            STREAM.price,
            STREAM.departure_station,
            STREAM.arrival_destination,
            STREAM.date_of_journey,
            STREAM.departure_time,
            STREAM.arrival_time,
            STREAM.actual_arrival_time,
            STREAM.journey_status,
            STREAM.reason_for_delay,
            STREAM.refund_request
        );

    RETURN 'Stream values merged into curated table successfully.';
END;
$$;

// create task to update the table 
create or replace schema consumption_schema

// CREATE THE CONSUMPTION TBALE 
CREATE OR REPLACE TABLE demo_uk.consumption_schema.consumption_table
CLONE demo_uk.curated_schema.curated_table;


// create store procedure to update the aggregation_table

// create the agggregate_fact _table
CREATE OR REPLACE TABLE demo_uk.consumption_schema.aggregated_fact_table (
    months_of_purchase STRING,
    day_of_purchase STRING,
    purchase_type STRING,
    payment_method STRING,
    railcard STRING,
    ticket_class STRING,
    ticket_type STRING,
    departure_station STRING,
    arrival_destination STRING,
    order_counts INT,
    average_price DECIMAL(10, 2),
    total_price DECIMAL(10, 2),
    max_departure_time TIME,
    min_departure_time TIME,
    months_of_journey STRING,
    day_of_journey STRING
);

CREATE OR REPLACE PROCEDURE aggregate_table_cal()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    -- Insert aggregated results into an aggregated table
    INSERT INTO demo_uk.consumption_schema.aggregated_fact_table(
        months_of_purchase,
        day_of_purchase,
        purchase_type,
        payment_method,
        railcard,
        ticket_class,
        ticket_type,
        departure_station,
        arrival_destination,
        order_counts,
        average_price,
        total_price,
        max_departure_time,
        min_departure_time,
        months_of_journey,
        day_of_journey
    )
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
        COUNT(*) AS order_counts, -- Count of orders
        AVG(price) AS average_price, -- Average price per group
        SUM(price) AS total_price, -- Total price per group
        MAX(departure_time) AS max_departure_time, -- Latest departure time per group
        MIN(departure_time) AS min_departure_time, -- Earliest departure time per group
        MONTHNAME(date_of_journey) AS months_of_journey,
        DAYNAME(date_of_journey) AS day_of_journey
    FROM 
        demo_uk.consumption_schema.consumption_table
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
        DAYNAME(date_of_journey);

    -- Return success message
    RETURN 'Aggregation successfully completed and stored in aggregated_table';
END;
$$;
call aggregate_table_cal()



create or replace task consumption_task
warehouse =compute_wh
schedule ='4 minute'
when 
    SYSTEM$STREAM_HAS_DATA('demo_uk.curated_schema.curated_stream')
AS 
BEGIN
    CALL consumption_merge_table();
END ;



create or replace task consumption_AGGREGATE_TASK
warehouse =compute_wh
schedule ='5 minute'
AS 
BEGIN
    CALL aggregate_table_cal();
END ;
SHOW TASKS


 ALTER TASK  CONSUMPTION_TASK RESUME ;
 ALTER TASK  CONSUMPTION_AGGREGATE_TASK RESUME;



 ALTER TASK  CONSUMPTION_TASK SUSPEND ;
 ALTER TASK  CONSUMPTION_AGGREGATE_TASK SUSPEND;



 SELECT COUNT(*) FROM demo_uk.consumption_schema.consumption_table --31656

 SELECT * FROM aggregated_fact_table --
 SELECT COUNT(*) FROM aggregated_fact_table --35752