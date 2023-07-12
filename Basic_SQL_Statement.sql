
use classicmodels;

/*what is the total number of customers?*/
SELECT 
    COUNT(customerNumber) AS totalCustomers
FROM
    customers;

/*what is the total number of employees?*/
SELECT 
    COUNT(employeeNumber) AS totalEmployee
FROM
    employees;

/*in how many countries does the company have an office?*/
SELECT 
    COUNT(DISTINCT (country)) AS totalCountriesWithAnOffice
FROM
    offices;

/*list countries where the company has an office and the number of offices present in it?*/
SELECT 
    country, COUNT(country) AS offices
FROM
    offices
GROUP BY country
ORDER BY offices;

/*how many products does the company have?*/
SELECT 
    COUNT(DISTINCT (productName)) totalProduct
FROM
    products;

/*how many customers are a limited company*/
SELECT 
    COUNT(customerNumber) AS totalLtd
FROM
    customers
WHERE
    customerName LIKE '%Ltd%';


/*what is the maximum and minimum credit limit of the customer?*/
SELECT 
    MIN(creditLimit) AS minLimit, MAX(creditLimit) AS maxLimit
FROM
    customers;

/*how many customers are without a sales representative?*/
SELECT 
    COUNT(customerNumber)
FROM
    customers
WHERE
    salesRepEmployeeNumber IS NULL;

/*what is the average credit limit offered?*/
SELECT 
    FLOOR(AVG(creditLimit)) AS avgLimit
FROM
    customers;

