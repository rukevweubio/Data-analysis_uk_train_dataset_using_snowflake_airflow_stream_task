//Create the database and schema
CREATE OR REPLACE DATABASE demo_uk;
CREATE OR REPLACE SCHEMA demo_uk.demo_schema;

//Create the custom role for managing the schema
CREATE OR REPLACE ROLE demo_uk_role;


// Grant necessary system-level roles to the new role
GRANT ROLE SYSADMIN TO ROLE demo_uk_role;
GRANT ROLE SECURITYADMIN TO ROLE demo_uk_role;

// Grant access to the database and schema
GRANT USAGE ON DATABASE demo_uk TO ROLE demo_uk_role;
GRANT USAGE ON SCHEMA demo_uk.demo_schema TO ROLE demo_uk_role;

// Grant full privileges (SELECT, INSERT, UPDATE, DELETE) on all existing tables in the schema
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA demo_uk.demo_schema TO ROLE demo_uk_role;

//Grant future table privileges for automatic access to new tables
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA demo_uk.demo_schema TO ROLE demo_uk_role;

//Create a stage for external file storage
CREATE OR REPLACE STAGE MY_CSV_STAGE
  FILE_FORMAT = (FORMAT_NAME = MY_CSV_FILE);

//Create a file format for CSV files
CREATE OR REPLACE FILE FORMAT MY_CSV_FILE
  TYPE = 'CSV',
  FIELD_DELIMITER = ',',
  SKIP_HEADER = 2;

//Create a sequence for use as a primary key
CREATE OR REPLACE SEQUENCE UK_sqr
  START = 1
  INCREMENT = 1
  COMMENT = 'Sequence for primary key generation';
  
  
  // insert data into stage
  put file:/// railway @MY_CSV_STAGE autocompress=True


  // create table 
  CREATE OR REPLACE TABLE uk_onlin_train_sales(
    id int  DEFAULT uk_sqr.NEXTVAL,
    transaction_id string,
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
// read data from stage into table 
 insert into uk_onlin_train_sales
SELECT
   uk_sqr.NEXTVAL AS id,                   
    $1::string AS transaction_id,                    
    $2 AS date_of_purchase,                   
    $3 AS time_of_purchase,                  
    $4 AS purchase_type,                      
    $5 AS payment_method,                     
    $6 AS railcard,                         
    $7 AS ticket_class,                      
    $8 AS ticket_type,                       
    $9 AS price,                              
    $10 AS departure_station,                
    $11 AS arrival_destination,              
    $12 AS date_of_journey,                   
    $13 AS departure_time,                    
    $14 AS arrival_time,                     
    $15 AS actual_arrival_time,              
    $16 AS journey_status,                  
    $17 AS reason_for_delay,                 
    $18 AS refund_request                     
FROM
    @my_csv_stage



//select  from table

// check of the data is loaded in the internal stage 
select * from uk_onlin_train_sales;

 
 // truncate table to check if data is loaded
 truncate table  uk_onlin_train_sales;



// create stream on table uk_onlin_train_sales
create or replace stream  uk_stream on table uk_onlin_train_sales
append_only =True;


