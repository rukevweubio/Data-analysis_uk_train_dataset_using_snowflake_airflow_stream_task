// TOTAL VALUME OF TICKET SOLD BY PURCHASE TYPE 

SELECT 
    PURCHASE_TYPE,
    COUNT(*) AS number_of_tickets_bought_by_customer
FROM 
    DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
GROUP BY
    PURCHASE_TYPE;
	
// Ticket prices variation by hour of purchase (early vs. last-minute)
SELECT 
    HOUR(TIME_OF_PURCHASE) AS hour_of_purchase,
    AVG(PRICE) AS average_price
FROM 
    DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
GROUP BY 
    HOUR(TIME_OF_PURCHASE)
ORDER BY 
    average_price DESC;
	
//Average ticket price by payment method
SELECT 
    PAYMENT_METHOD,
    AVG(PRICE) AS average_price
FROM 
    DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
GROUP BY 
    PAYMENT_METHOD
ORDER BY 
    average_price DESC;

//Ticket sales volume by route and sales channel
SELECT 
   DEPARTURE_STATION,
    PURCHASE_TYPE,
    COUNT(*) AS number_of_tickets_sold
FROM 
    DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
GROUP BY 
    DEPARTURE_STATION,
    PURCHASE_TYP
ORDER BY 
    number_of_tickets_sold DESC;
// SALES VALUME BY ROUTE OR DETINATURE 
SELECT 
   DEPARTURE_STATION,
    COUNT(*) AS number_of_tickets_sold
FROM 
    DEMO_UK.CONSUMPTION_SCHEMA.CONSUMPTION_TABLE
GROUP BY 
    DEPARTURE_STATION,
   
ORDER BY 
    number_of_tickets_sold DESC;


