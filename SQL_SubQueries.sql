/* what is the total sales and total credit limit of each customer that is a corperative(Co.)*/
SELECT * 
FROM 
    (SELECT customerName,ROUND(SUM(quantityOrdered*priceEach)) as amount ,creditLimit
FROM customers
JOIN orders
    USING(customerNumber)
JOIN orderdetails
    USING (orderNumber) 
GROUP BY 1,3
ORDER BY amount DESC) as t1
WHERE customerName LIKE "%Co.%";

/* what is the total sales and total credit limit of all customers that are a corperative(Co.)*/
SELECT SUM(amount)as totalAmount, ROUND(SUM(creditLimit)) as TotalCredit
FROM (SELECT customerName,ROUND(SUM(quantityOrdered*priceEach)) as amount ,creditLimit
    FROM customers
    JOIN orders
        USING(customerNumber)
    JOIN orderdetails
        USING (orderNumber) 
    WHERE customerName LIKE "%Co.%"
    GROUP BY 1,3
    ORDER BY amount DESC) t1
;

/* what is the total purchase and total credit limit of all customers */
SELECT SUM(amount)as totalAmount, ROUND(SUM(creditLimit)) as TotalCredit
FROM (SELECT customerName,ROUND(SUM(quantityOrdered*priceEach)) as amount ,creditLimit
    FROM customers
    JOIN orders
        USING(customerNumber)
    JOIN orderdetails
        USING (orderNumber) 
    GROUP BY 1,3
    ORDER BY amount DESC) t2
;

/* what is the total purchase and total credit limit of all customers in the USA*/
SELECT country, SUM(amount)as totalAmount, ROUND(SUM(creditLimit)) as TotalCredit
FROM (SELECT customerName,country,ROUND(SUM(quantityOrdered*priceEach)) as amount ,creditLimit
    FROM customers
    JOIN orders
        USING(customerNumber)
    JOIN orderdetails
        USING (orderNumber) 
    WHERE country = "USA"
    GROUP BY 1,2,4
    ORDER BY amount DESC) t3
GROUP BY 1;

/* what is the total purchase and total credit limit of all customers by country*/
SELECT country, SUM(amount)as totalAmount, ROUND(SUM(creditLimit)) as TotalCredit
FROM (SELECT customerName,country,ROUND(SUM(quantityOrdered*priceEach)) as amount ,creditLimit
    FROM customers
    JOIN orders
        USING(customerNumber)
    JOIN orderdetails
        USING (orderNumber) 
    GROUP BY 1,2,4
    ORDER BY amount DESC) t3
GROUP BY 1
ORDER BY totalAmount DESC;

/* what countries have a creditLimit < their purchase*/
SELECT country, SUM(amount)as totalAmount, ROUND(SUM(creditLimit)) as totalCredit
FROM (SELECT customerName,country,ROUND(SUM(quantityOrdered*priceEach)) as amount ,creditLimit
    FROM customers
    JOIN orders
        USING(customerNumber)
    JOIN orderdetails
        USING (orderNumber) 
    GROUP BY 1,2,4
    ORDER BY amount DESC) t3
GROUP BY 1
HAVING totalCredit < totalAmount
ORDER BY totalAmount DESC;

SELECT * 
FROM 
    (SELECT customerName,ROUND(SUM(quantityOrdered*priceEach)) as amount ,creditLimit
FROM customers
JOIN orders
    USING(customerNumber)
JOIN orderdetails
    USING (orderNumber) 
GROUP BY 1,3
ORDER BY amount DESC) as t1
WHERE customerName LIKE "%Co.%";

/* how many total order do we have of each products in the classic cars productline and what is their total sales? */
SELECT productName, COUNT(productName) totalOrder, ROUND(SUM(priceEach*quantityOrdered)) as totalSales
FROM (SELECT *
    FROM products
    WHERE productLine ="Classic Cars") as classicCars
JOIN orderdetails
    USING (productCode)
GROUP BY productName
ORDER BY totalOrder DESC, totalSales DESC;

/* who are the customers that have at least one order? */
SELECT customerNumber, customerName
FROM customers c
WHERE EXISTS(SELECT *
            FROM orders o
            WHERE c.customerNumber=o.customerNumber
            )
;

/* list of all employee working at the paris office */
SELECT employeeNumber, lastName, firstName, extension
FROM employees e
WHERE EXISTS(SELECT *
            FROM offices o
            WHERE city="Paris" AND 
            e.officeCode=o.officeCode)
;

/* Alternatively, the query below could also be used to get the list of all employee working at the paris office 
same as the query above*/
SELECT employeeNumber, lastName, firstName, extension
FROM employees
JOIN offices
    USING (officeCode)
WHERE city="Paris";




/* This query uses CTE to obtain the total sales of all asian countries*/
WITH asianCountries AS 
            (SELECT *
            FROM customers
            WHERE country IN ("Japan","Hong Kong","Russia")), 
    asianOrders AS 
            (SELECT country, ROUND(SUM(quantityOrdered*priceEach)) totalSales
            FROM asianCountries
            JOIN orders
                USING (customerNumber)
            JOIN orderdetails
                USING(orderNumber)
            GROUP BY country 
            ORDER BY totalSales DESC)
    SELECT * 
    FROM asianOrders;

