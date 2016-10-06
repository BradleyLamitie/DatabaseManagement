--------------------------------------------------------------------------------------------
--Bradley Lamitie                                                                         --
--Lab 5: SQL Queries - The Joins Three-quel                                              --
--Assigned on 9/29/2016                                                                   --
--Due on 10/6/2016                                                                        --
--Database Management ~ Labouseur                                                         --
--------------------------------------------------------------------------------------------

-- #1                                                                                      --
-- Show	the	cities	of	agents	booking	an	order	for	a	customer	whose	id
-- is	'c006'.	Use	joins this	time;	no	subqueries
-- Ordered Ascendingly by agent's city

SELECT DISTINCT a.city
FROM orders o INNER JOIN customers c ON o.cid = c.cid
			  INNER JOIN agents    a ON o.aid = a.aid
WHERE c.cid = 'c006'
ORDER BY a.city ASC;


-- #2
-- Show	the	ids	of	products	ordered	through	any	agent	who	makes	at	least	one	order
-- for	a	customer	in	Kyoto,	sorted	by	pid	from	highest	to	lowest.	Use	joins;	no	subqueries.	
-- Ordered Descendingly by product id


SELECT DISTINCT o.pid 
FROM orders o INNER JOIN orders oo   ON oo.aid = o.aid
              INNER JOIN customers c ON c.cid = oo.cid AND c.city = 'Kyoto'
ORDER BY o.pid DESC;

-- #3
-- Show the names of customers who have never placed an order. use a subquery.
-- Ordered Ascendingly by customer name


SELECT c.name
FROM customers c
WHERE c.cid NOT IN (
    				SELECT o.cid
    				FROM   orders o
    				)
ORDER BY c.name ASC;


-- #4
-- Show the names of customers who have never placed an order. use a join
-- Ordered Ascendingly by customer name


SELECT c.name
FROM orders o RIGHT OUTER JOIN customers c ON o.cid=c.cid
WHERE o.ordnum IS NULL
ORDER BY c.name ASC;


-- #5
-- Show the names of customers who placed at least one order through an agent in their 
-- own city, along with those agent(s') names.
-- Ordered Ascendingly by customer name


SELECT DISTINCT c.name
FROM orders o INNER JOIN customers c ON o.cid=c.cid
		      INNER JOIN agents    a ON o.aid=a.aid
              WHERE c.city = a.city
ORDER BY c.name ASC;
              
           
-- #6
-- Show the names of customers and agents living in the same city, along with the name
-- of the shared city, regardless of whether or not the customer has ever placed an order 
-- with that agent.
-- Ordered Ascendingly by customer name


SELECT c.name, a.name
FROM agents a INNER JOIN customers c ON a.city = c.city
ORDER BY c.name ASC;


-- #7 
-- Show the name and city of customers who live in the city that makes the fewest 
-- different kind of products (HINT: use count and group by on the products table)
-- Ordered Ascendingly
-- I am unsure if i solved this incorrectly. I know the answer is right, but what if
-- there are two or more minimums?

SELECT name, city 
FROM customers 
WHERE city = (
                SELECT city
                FROM products 
                GROUP BY city
                ORDER BY COUNT(city)
                LIMIT 1
                )
ORDER BY name ASC;                

