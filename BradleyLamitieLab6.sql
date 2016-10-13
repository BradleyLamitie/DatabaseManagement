-- ---------------------------------------------------------------------------------------------------------- --
-- Bradley Lamitie                                                                                            --
-- Lab 6: Interesting and Painful Queries                                                                     --
-- Assigned on 10/06/2016                                                                                     --
-- Due on 10/13/2016                                                                                          --
-- Database Management ~ Labouseur                                                                            --
-- -------------------------------------------------------------------------------------------------------------



-- #1
-- Display the name and city of customers who live in any city that makes the most different kinds of products. 
-- (There are two cities that make the most different products. Return the name and city of customers from       
-- either one of those.)                                                                                         
-- Ordered by customer name Ascendingly                                                                          


SELECT name, city
FROM   customers 
WHERE  city = ( SELECT city
                FROM products 
                GROUP BY city
                ORDER BY COUNT(city)
                LIMIT 1
               )
ORDER BY name ASC;



-- Just for thoroughness, this is the query for if I wanted all products sold in both cities that have the most  
-- Select name, city                                               
-- From customers 
-- where city IN ( SELECT city
--                FROM products 
--                GROUP BY city
--                ORDER BY COUNT(city)
--               )
-- ORDER BY name ASC;



-- #2
-- Display the names of products whose priceUSD is strictly below the average priceUSD, 
-- in reverse-alphabetical order
SELECT name
FROM   products 
WHERE  priceUSD< (SELECT AVG(p.priceUSD)
                  FROM   products p
                  )
ORDER BY name DESC;


-- #3
-- Display the customer name, pid ordered, and the total for all orders, sorted by total from low to high.


SELECT   c.name, o.pid, o.totalUSD
FROM     orders o INNER JOIN customers c ON o.cid = c.cid
ORDER BY o.totalUSD ASC;


-- #4
-- Display all customer names (in alphabetical order) and their total ordered, and nothing more. 
-- Use coalesce to avoid showing NULLs.
-- Ordered by orders' totalUSD Ascendingly


SELECT   c.name, COALESCE(o.pid, 'none') AS "pid", COALESCE(o.totalUSD, 0) AS "total_USD"
FROM     orders o RIGHT OUTER JOIN customers c ON o.cid = c.cid
ORDER BY o.totalUSD ASC;



-- #5
-- Display the names of all customers who bought products from agents based in New York along
-- with the names of the products they ordered, and the names of the agents who sold it to them.
-- Ordered by customer name ascendingly


SELECT c.name, a.name, p.name
FROM   orders o INNER JOIN customers c ON o.cid = c.cid
                INNER JOIN agents    a ON o.aid = a.aid
                INNER JOIN products  p ON o.pid = p.pid
WHERE  a.city IN ('New York')
ORDER BY c.name ASC;



-- #6
-- Write a query to check the accuracy of the dollars column in the Orders table. This means
-- calculating Orders.totalUSD from data in other tables and comparing those values to the 
-- values in Orders.totalUSD. Display all rows in Orders where Orders.totalUSD is incorrect, if any.
-- Ordered by order number Ascendingly

SELECT * 
FROM orders o INNER JOIN products  p ON o.pid = p.pid
              INNER JOIN customers c ON o.cid = c.cid
WHERE o.totalusd != ((p.priceusd * o.qty)-((p.priceusd * o.qty * c.discount)/100))
ORDER BY ordnum ASC;      


-- #7
-- What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? Give example queries 
-- in SQL to demonstrate. (Feel free to use the CAP database to make your points here.)


-- The difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN is that a LEFT OUTER JOIN
-- takes whatever table is on the left of the LEFT OUTER JOIN clause and matches up values
-- from the table on the right side of the clause using the data you specify. 
-- For Example: 
-- SELECT *
-- FROM orders o LEFT OUTER JOIN customers c ON o.cid = c.cid;
-- This LEFT OUTER JOIN connects all the information for each order to a customer on cid. 
-- Since every order has a customer there are no NULLs. and every row on the left matches 
-- with a row in the right table.
-- However, If you were to use a RIGHT OUTER JOIN it would match up the table on the right 
-- with values from the table on the left. So every row on the right table matches up with 
-- one on the left table.
-- SELECT *
-- FROM orders o RIGHT OUTER JOIN customers c ON o.cid = c.cid;
-- This RIGHT OUTER JOIN connects all information for each customer to an order on cid. 
-- Since not every customer has had an order Weyland can only match up with nulls, 
-- because they do not have an order that exists in the orders table. 