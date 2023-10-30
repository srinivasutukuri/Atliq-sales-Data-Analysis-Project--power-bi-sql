/*transactions*/

/* seeing all recoreds in transactions table  */
SELECT * FROM transactions;

/* CHEKING THE RECORDS LESSTHAN AND EQUVAL TO 0 */
SELECT * FROM transactions WHERE sales_amount <=0;

/*DELETING RECORDS <=0*/
DELETE FROM transactions WHERE sales_amount <=0;

/* COUNTS OF RECORDS */
SELECT 'RECORDS <= 0', COUNT(*) FROM transactions WHERE sales_amount <=0
UNION
SELECT 'TOTAL RECORDS',COUNT(*)FROM transactions;

/* unique values in currency*/
SELECT DISTINCT TRIM(currency) FROM transactions;
/* INR, USD, INR , USD ,*/

/* count of unique values */
SELECT  currency , count(currency) FROM transactions
GROUP BY currency
HAVING COUNT(currency)>1;

select t.* , year from transactions t join date d on d.date = t.order_date;

/* CONVERTIG THE ALL CURRENCY IN INR*/
ALTER TABLE transactions
ADD sales_amount_inr DECIMAL(10, 2);

UPDATE  transactions
SET sales_amount_inr = CASE
    WHEN TRIM(currency) LIKE '%USD%' THEN sales_amount * 75
    ELSE sales_amount
END;

SELECT * FROM transactions WHERE currency LIKE '%USD%';

SELECT * FROM transactions WHERE market_code = 'Mark097' OR market_code = 'Mark999';
/* NO RECORDS ARE THERE ACCODING TO Mark097 AND Mark999;


/* PRODUCT */
select count(distinct product_code) from transactions;

SELECT COUNT(distinct t.product_code) FROM transactions t
LEFT JOIN products P ON  P.product_code = t.product_code
WHERE P.product_code IS NULL ;
 /* 59 PRODUCTS ARE NOT DEFINED IN PRODUCTS TABLE */
 
 /*customer_code*/
 select count(distinct customer_code) from transactions;
 /*sales_qty*/
 SELECT sales_qty FROM transactions WHERE sales_qty < 0; 
 
 /* market
SELECT * FROM sales.markets;
/* Mark097, Mark999 THIS MARKETS ARE NOT CONTRIBUTUNG ANY REVENUE SO WEREMOVING THIS*/
DELETE FROM markets WHERE markets_name = 'New York' OR markets_name = 'Paris';
 
 /*cheking duplicate numbers*/
SELECT product_code,customer_code,market_code,order_date,sales_qty,sales_amount,currency, COUNT(*)  AS duplicates
FROM transactions
GROUP BY product_code,customer_code,market_code,order_date,sales_qty,sales_amount,currency
HAVING duplicates>1;

SELECT product_code, COUNT(*)AS duplicates FROM products
GROUP BY product_code HAVING duplicates>1;

/* ALMOST DATA IS CLEAEN */
 
 
