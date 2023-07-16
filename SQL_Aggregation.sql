use classicmodels;

/*what is the average order made by customers?*/
SELECT 
    FLOOR(AVG(quantityOrdered))
FROM 
    orderdetails;

/*what is the average credit limit offered?*/
SELECT 
    FLOOR(AVG(creditLimit)) AS avgCreditLimit
FROM
    customers; 


/*group the employee by their job title*/    
SELECT 
    jobTitle, COUNT(jobTitle) AS total
FROM
    employees
GROUP BY jobTitle;    
 
 
 /*list top 5 countries where the customers are from ?*/
SELECT 
    country, COUNT(country) AS totalCustomers
FROM
    customers
GROUP BY (country)
ORDER BY (totalCustomers) DESC
LIMIT 5;


 /* in what day was the largest single order amount made and from which customer ?*/
SELECT 
    customerName, (quantityOrdered*priceEach) as amount, orderDate
FROM 
    customers c
JOIN orders o 
    ON c.customerNumber=o.customerNumber
JOIN orderdetails od
    ON o.orderNumber=od.orderNumber
ORDER BY amount DESC
LIMIT 1;


/* what is the status of all order made in 2003 ?*/
SELECT 
    status,count(status) as totalOrder
FROM
    orders
WHERE YEAR(orderDate)=2003
GROUP BY status;


/* what is the status of all order made since the start ?*/
SELECT 
    status,count(status) as totalOrder
FROM
    orders
GROUP BY status;


/* list customers with disputed orders,year of dispute and the reason for dispute ?*/
SELECT
    customerName,YEAR(orderDate), status, comments as reasonForDispute
FROM customers c
JOIN orders o
    ON o.customerNumber=c.customerNumber
WHERE status ="disputed";    


/* list customers with disputed orders,total order quantity, price each, amount, and the reason for dispute ?*/
SELECT
    customerName, status,quantityOrdered,orderDate, priceEach, (quantityOrdered*priceEach) as amount, comments as reasonForDispute
FROM customers c
JOIN orders o
    USING (customerNumber)
JOIN orderdetails od 
    USING (orderNumber)
WHERE status ="disputed"; 


/* group the customers based on silver(order<10k),gold(order between 10k and 100k), 
and platinum(order>100k) the table should contain the customer name amount ordered and the customerGroup?*/
select customerName, ROUND(SUM(quantityOrdered*priceEach)) as amount,
    (case
        WHEN sum(quantityOrdered*priceEach)<10000 THEN "silver"
        WHEN sum(quantityOrdered*priceEach) BETWEEN 10000 AND 100000 THEN "gold"
        WHEN sum(quantityOrdered*priceEach)>100000 THEN "platinium" 
        END) as customerGroup
from orderdetails
JOIN orders
    USING (orderNumber)
JOIN customers
    USING (customerNumber)
GROUP BY orderNumber;


/* who are the top 5 platinum customers(customers having orderAmount > 100k) and their order amount?*/
select customerName, ROUND(SUM(quantityOrdered*priceEach)) as amount,     (case
        WHEN sum(quantityOrdered*priceEach)<10000 THEN "silver"
        WHEN sum(quantityOrdered*priceEach) BETWEEN 10000 AND 100000 THEN "gold"
        WHEN sum(quantityOrdered*priceEach)>100000 THEN "platinium" 
        END) as customerGroup
from orderdetails
JOIN orders
    USING (orderNumber)
JOIN customers
    USING (customerNumber)
GROUP BY customerName
HAVING ROUND(SUM(quantityOrdered*priceEach)) > 100000
ORDER BY amount DESC
LIMIT 5;


/* who are the top 5 gold customers(customers having orderAmount between 10k and 100k) and their order amount?*/
select customerName, ROUND(SUM(quantityOrdered*priceEach)) as amount,     (case
        WHEN sum(quantityOrdered*priceEach)<10000 THEN "silver"
        WHEN sum(quantityOrdered*priceEach) BETWEEN 10000 AND 100000 THEN "gold"
        WHEN sum(quantityOrdered*priceEach)>100000 THEN "platinium" 
        END) as customerGroup
from orderdetails
JOIN orders
    USING (orderNumber)
JOIN customers
    USING (customerNumber)
GROUP BY customerName
HAVING ROUND(SUM(quantityOrdered*priceEach)) > 100000
ORDER BY amount DESC
LIMIT 5;


/* does the customers total purchase give them higher credit limit*/
SELECT customerName,ROUND(SUM(quantityOrdered*priceEach)) as amount ,creditLimit
FROM customers
JOIN orders
    USING(customerNumber)
JOIN orderdetails
    USING (orderNumber) 
GROUP BY 1,3
ORDER BY amount DESC;


/* what is the number of products available for each productline? */
SELECT productLine, COUNT(productLine) as numberOfProduct
FROM products p
GROUP BY productLine
ORDER BY numberOfProduct DESC
;

/* what is the total sales made by each productline? */
SELECT productLine, COUNT(productLine) as totalOrder, ROUND(SUM(quantityOrdered*priceEach)) as totalSales
FROM products
JOIN orderdetails
    USING (productCode)
GROUP BY productLine
ORDER BY totalSales DESC
;

/* what is the total sales and order made by each product in the ships productLine? */
SELECT productName, COUNT(productName) as totalOrder, ROUND(SUM(quantityOrdered*priceEach)) as totalSales
FROM products
JOIN orderdetails
    USING (productCode)
WHERE productLine = "Ships"
GROUP BY productName
ORDER BY totalSales DESC
;

/* based on sales what are the top 5 product? */
SELECT productName, productLine, COUNT(productName) as totalOrder, ROUND(SUM(quantityOrdered*priceEach)) as totalSales
FROM products
JOIN orderdetails
    USING (productCode)
GROUP BY productName,productLine
ORDER BY totalSales DESC
LIMIT 5;

/* who are the least 5 vendors and their total sales? */
SELECT productVendor, COUNT(productVendor) as totalOrder, ROUND(SUM(quantityOrdered*priceEach)) as totalSales
FROM products
JOIN orderdetails
    USING (productCode)
GROUP BY productVendor
ORDER BY totalSales ASC
LIMIT 5
;

