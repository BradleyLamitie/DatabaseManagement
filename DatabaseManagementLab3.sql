----------------------------------------------
--Bradley Lamitie                           --
--Lab 3:	Getting	Started	with SQL Queries--
--Assigned on 9/15/2016                     --
--Due on 9/22/2016                          --
--Database Management ~ Labouseur           --
----------------------------------------------


--List the order	number and total dollars of	all	orders.	--

SELECT    ordnum, totalusd
FROM      orders;

--List the name and city of agents named Smith--

SELECT    name, city
FROM      agents
WHERE     name='Smith';

--List the id, name, and priceUSD of products with quantity more than 201,000--

SELECT     pid, name, priceusd
FROM       products
WHERE      quantity > 201000;

--List the names and cities of customers in Duluth--

SELECT     name, city
FROM       customers
WHERE      city = 'Duluth';

--List the names of agents not in New York and not in Duluth--

SELECT     name
FROM       agents
WHERE      city!= 'Duluth' 
                AND
           city!= 'New York';

--List all data for products in neither Dallas nor Duluth that cost US $1 or more--

SELECT     *
FROM       products
WHERE      city!= 'Dallas'
               AND
           city!= 'Duluth'
               AND 
           priceusd >= 1;

--List all data for orders in February or March--

SELECT     *
FROM       orders
WHERE      mon='feb'
		      OR
           mon = 'mar';

--List all data for orders in February of US $600 or more--

SELECT     *
FROM       orders
WHERE      mon = 'feb'
              AND 
           totalusd >= 600;

--List all data from the customer whose cid is C005--

SELECT     *
FROM       orders
WHERE      cid= 'c005';


