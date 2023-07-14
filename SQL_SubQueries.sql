/* what is the total purchase and total credit limit of customers that are a corperative(Co.)*/
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

