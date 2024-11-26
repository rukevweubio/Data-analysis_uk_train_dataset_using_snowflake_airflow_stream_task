// create task in the curated zone 
CREATE OR REPLACE TASK curated_zone_task
SCHEDULE = '1 MINUTE' 
WAREHOUSE = compute_wh
AS
BEGIN
    
    CALL CREATE_TABLE_CURATED_ZONE();
    
END;



// create task for insert data into table
CREATE OR REPLACE TASK curated_zone_task2
SCHEDULE = '2 MINUTE' 
WAREHOUSE = compute_wh
AS
BEGIN
    
    CALL  LOAD_DATA_PROCEDURE();
    
END;


