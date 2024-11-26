// creat table curated zone 
CREATE OR REPLACE PROCEDURE CREATE_TABLE_CURATED_ZONE()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    //Create the table in the curated schema
    CREATE OR REPLACE TABLE demo_uk.curated_schema.curated_table (
        id INT,
        date_of_purchase DATE,
        time_of_purchase TIME,
        purchase_type STRING,
        payment_method STRING,
        railcard STRING,
        ticket_class STRING,
        ticket_type STRING,
        price DECIMAL(10, 2),
        departure_station STRING,
        arrival_destination STRING,
        date_of_journey DATE,
        departure_time TIME,
        arrival_time TIME,
        actual_arrival_time TIME,
        journey_status STRING,
        reason_for_delay STRING,
        refund_request BOOLEAN
    );

    //Return a success message
    RETURN 'TABLE IS CREATED SUCCESSFULLY';
END;
$$;