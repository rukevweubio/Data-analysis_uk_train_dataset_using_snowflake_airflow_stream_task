// create store procedure to load data into data 
CREATE OR REPLACE PROCEDURE LOAD_DATA_PROCEDURE()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    -- Insert data into the curated table from the source if no duplicates exist
    INSERT INTO demo_uk.curated_schema.curated_table (
        id,
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
    SELECT
         id,
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
    FROM
        demo_uk.demo_schema.uk_onlin_train_sales
    WHERE
        date_of_journey IS NOT NULL
        AND NOT EXISTS (
            -- Ensure the record does not already exist in the curated table based on ID
            SELECT 1
            FROM demo_uk.curated_schema.curated_table
            WHERE demo_uk.curated_schema.curated_table.id =demo_uk.demo_schema.uk_onlin_train_sales.id 
        );

    RETURN 'Data successfully loaded into curated zone, with no duplicates';
END;
$$;