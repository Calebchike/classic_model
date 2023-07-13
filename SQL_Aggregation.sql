use classicmodels;

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