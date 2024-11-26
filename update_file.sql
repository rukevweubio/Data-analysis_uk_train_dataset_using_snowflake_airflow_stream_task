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
) VALUES (
    101,
    '2024-11-19',
    '14:30:00',
    'Online',
    'Credit Card',
    'Yes',
    'First Class',
    'Return',
    125.50,
    'London',
    'Manchester',
    '2024-11-25',
    '08:00:00',
    '10:30:00',
    '10:40:00',
    'Delayed',
    'Signal failure',
    true
);

UPDATE demo_uk.curated_schema.curated_table
SET 
    price = 135.75,
    journey_status = 'On Time',
    reason_for_delay = NULL,
    refund_request = false
WHERE 
    id = 101;

DELETE FROM demo_uk.curated_schema.curated_table
WHERE 
    id = 101;

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
) VALUES (
    102,
    '2024-11-18',
    '16:45:00',
    'In-Person',
    'Cash',
    'No',
    'Standard',
    'One Way',
    78.25,
    'Birmingham',
    'Leeds',
    '2024-11-20',
    '12:15:00',
    '14:45:00',
    '14:40:00',
    'On Time',
    NULL,
    false
);

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
) VALUES (
    103,
    '2024-11-19',
    '09:30:00',
    'Online',
    'Credit Card',
    'Yes',
    'First Class',
    'Return',
    150.50,
    'London',
    'Manchester',
    '2024-11-25',
    '08:00:00',
    '10:30:00',
    '10:45:00',
    'Delayed',
    'Signal failure',
    true
);
