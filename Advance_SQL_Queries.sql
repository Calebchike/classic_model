
/* This query groups the total sales by the region*/
WITH regionSales AS 
            (SELECT country, 
            (CASE 
                WHEN country IN ("Hong Kong","Japan","Philippines","Singapore") THEN  "Asia"
                WHEN country IN ("USA","Canada") THEN "North America"
                WHEN country IN ("Italy","France","Denmark","Spain","Belgium","Ireland",
                "Switzerland","Sweden","Austria","Germany","Norway","Finland","UK") THEN "Europe"
                WHEN country IN ("Australia","New Zealand") THEN "Oceania"
                WHEN country IN ("South Africa") THEN "Africa"
                ELSE  "Others"
                END) AS region ,
            ROUND(SUM(quantityOrdered*priceEach)) totalSales
            FROM customers
            JOIN orders
                USING (customerNumber)
            JOIN orderdetails
                USING (orderNumber)
            GROUP BY country,region
            ORDER BY totalSales DESC)
SELECT IF(GROUPING(region),"Total",region) region, 
COUNT(region) totalCountries,FLOOR(SUM(totalSales)) totalRegionSales
FROM regionSales
GROUP BY region WITH ROLLUP
ORDER BY totalRegionSales DESC;

/* list of countries, their top sales rep and the total number of sales by sales rep */
SELECT DISTINCT country co, 
    (SELECT  count(employeeNumber) numberOfSales
    FROM employees  e
    JOIN customers c
        ON e.employeeNumber=c.salesRepEmployeeNumber
    JOIN orders
        USING (customerNumber)
    JOIN orderdetails
        USING (orderNumber)
    WHERE country = co
    GROUP BY firstName,country
    ORDER BY numberOfSales DESC
    LIMIT 1) numberOfSales, 

    (SELECT CONCAT(firstName, " ", lastName)
    FROM employees  e
    JOIN customers c
        ON e.employeeNumber=c.salesRepEmployeeNumber
    JOIN orders
        USING (customerNumber)
    JOIN orderdetails
        USING (orderNumber)
    WHERE country = co AND numberOfSales = numberOfSales
    LIMIT 1
    ) salesRep

FROM employees  e
JOIN customers c
    ON e.employeeNumber=c.salesRepEmployeeNumber
JOIN orders
    USING (customerNumber)
JOIN orderdetails
    USING (orderNumber)
ORDER BY numberOfSales DESC;


