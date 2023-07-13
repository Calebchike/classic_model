use classicmodels;

/*what is the average order made by customers?*/
SELECT 
    FLOOR(AVG(quantityOrdered))
FROM 
    orderdetails;

/*what is the average credit limit offered?*/
SELECT 
    FLOOR(AVG(creditLimit)) AS avgLimit
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
SELECT status,count(status) as totalOrder
FROM
orders
WHERE YEAR(orderDate)=2003
GROUP BY status
;