SELECT * FROM transactions;

/* total revenue */
SELECT SUM(sales_amount_inr) FROM transactions;

/* REVENU PER YERA */
SELECT year, SUM(sales_amount_inr) AS TOTAL_REVENUE  FROM transactions t 
JOIN date d ON d.date = t.order_date GROUP BY year ORDER BY  TOTAL_REVENUE ;

/* AVARAGE REVENU */
SELECT year, SUM(sales_amount_inr)/SUM(sales_qty) AS AVGR FROM transactions t 
JOIN date d ON d.date = t.order_date GROUP BY year ORDER BY AVGR;

/* TOP FIVE BIG MARKETS and least market*/
SELECT t.market_code,markets_name,SUM(sales_amount_inr) AS TOTAL_SALES FROM transactions t 
JOIN markets m ON m.markets_code = t.market_code  WHERE sales_amount_inr > 0
 GROUP BY   t.market_code
ORDER BY TOTAL_SALES   LIMIT 5;

/* TOP  and least FIVE PROFITABLE PRODUCTS  */
SELECT product_code , SUM(sales_amount_inr) AS REVENU FROM transactions GROUP BY product_code ORDER BY REVENU  LIMIT 5;

select year,count(distinct product_code) as uniq, sum(sales_qty),count(distinct customer_code) from transactions t left join date d on  t.order_date = d.date
where market_code = 'Mark004' 
group by year;

select distinct sales_qty from transactions order by sales_qty;

/*Categorization of the sales quantity*/
SELECT 'RETAIL',COUNT(sales_qty)AS NO_SALES, SUM(sales_amount_inr)AS TOTAL_AMOUNT, SUM(sales_amount_inr)/ SUM(sales_qty) AS AVG_REVENUE FROM transactions WHERE sales_qty <= 100
UNION 
SELECT 'WHOLESALE',COUNT(sales_qty), SUM(sales_amount_inr),  SUM(sales_amount_inr)/ SUM(sales_qty) FROM transactions WHERE sales_qty >= 101 AND sales_qty <1000
UNION 
SELECT 'BLUCK',COUNT(sales_qty), SUM(sales_amount_inr),  SUM(sales_amount_inr)/ SUM(sales_qty) FROM transactions WHERE sales_qty >=  1000 ;

/*'RETAIL'*/
SELECT year, count(distinct customer_code), count(distinct market_code),count(distinct product_code), COUNT(sales_qty),SUM(sales_qty),SUM(sales_amount_inr) 
FROM  transactions t LEFT JOIN date d ON d.date  = t.order_date 
WHERE  sales_qty <=100 GROUP BY year;

/*'WHOLESALE'*/
 SELECT year, count(distinct customer_code), count(distinct market_code),count(distinct product_code), COUNT(sales_qty),SUM(sales_qty),SUM(sales_amount_inr) FROM  transactions t LEFT JOIN date d ON d.date  = t.order_date 
WHERE  sales_qty >= 101 AND sales_qty <1000 GROUP BY year;

/*BLUCK*/
 SELECT year, count(distinct customer_code), count(distinct market_code),count(distinct product_code), COUNT(sales_qty),SUM(sales_qty),SUM(sales_amount_inr) FROM  transactions t LEFT JOIN date d ON d.date  = t.order_date 
WHERE sales_qty >=  1000 GROUP BY year;

/* NEW PRODUCTS INTRDUCED IN 2018*/
SELECT  year,COUNT(distinct product_code), sum(sales_amount_inr),count(sales_qty), sum(sales_qty) FROM transactions t LEFT JOIN date d ON d.date = t.order_date 
WHERE sales_qty <=100 AND year = 2018 AND market_code = 'Mark004'  AND product_code NOT IN (SELECT product_code FROM transactions t LEFT JOIN date d ON d.date = t.order_date 
WHERE sales_qty <=100 AND year = 2017 );
 
/*MARKET*/
SELECT  year,COUNT(distinct product_code), sum(sales_amount_inr),count(sales_qty), sum(sales_qty) FROM transactions t LEFT JOIN date d ON d.date = t.order_date 
WHERE market_code = 'Mark004' GROUP BY year;

/*customer*/
SELECT  COUNT(distinct C.customer_code) FROM customers C RIGHT JOIN transactions T ON T.customer_code = C.customer_code 
WHERE product_code = 'Prod318'

