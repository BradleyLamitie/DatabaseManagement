--------------------------------------------------------------------------------------------
--Bradley Lamitie                                                                         --
--Lab 4: SQL Queries - The Subqueries Sequel                                              --
--Assigned on 9/22/2016                                                                   --
--Due on 9/29/2016                                                                        --
--Database Management ~ Labouseur                                                         --
--------------------------------------------------------------------------------------------

--#1                                                                                      --
--List the cities of agents booking an order for a customer whose cid is 'c006'           --
--Additionally I ordered the output by city name descendingly                             --

SELECT DISTINCT city
FROM            agents
WHERE           aid   IN (
                         SELECT aid
                         FROM   orders
                         WHERE  cid = 'c006'
                         )
ORDER BY city DESC;
         
--#2                                                                                      --
--List the ids of products ordered through any agent who takes at least one               --
--order from a customer in kyoto, ordered by pid descendingly                             --

SELECT DISTINCT pid
FROM            orders
WHERE           aid   IN (
                         SELECT aid
                         FROM   orders
                         WHERE  cid   IN (
                                          SELECT cid
                                          FROM   customers
                                          WHERE  city= 'Kyoto'    
                                         )
                         )
ORDER BY pid DESC;
         
 
--#3                                                                                      -- 
--List the ids and names of customers who did not place an order through agent a03        --
--ordered descendingly                                                                    --

SELECT DISTINCT cid, name
FROM            customers
WHERE           cid  NOT IN (
                             SELECT cid
                             FROM   orders
                             WHERE  aid = 'a03'    
                             )
ORDER BY cid DESC;

--#4                                                                                      --
--List the ids  of customers who ordered both product p01 and p07 descendingly            --


SELECT   cid
FROM     orders
WHERE    pid = 'p01'

     INTERSECT
     
SELECT           cid
FROM             orders
WHERE            pid = 'p07'
ORDER BY cid DESC;


--#5                                                                                      --
--List the pid of products not ordered by any customers who placed any order              -- 
--through agent a08 in pid order from highest to lowest. Ordered descendingly             --


SELECT pid 
FROM   products
    
        EXCEPT

SELECT DISTINCT pid
FROM            orders
WHERE           cid    IN (
                           SELECT cid
                           FROM   orders
                           WHERE  aid = 'a08'    
                          )
    
ORDER BY pid DESC;


--#6                                                                                      --
--List names, discounts, and cities of all customers who place orders through             --
--agents in Dallas or New York. Ordered Descendingly                                      --

SELECT          name, discount, city
FROM            customers
WHERE           cid   IN (
                         SELECT DISTINCT cid
                         FROM            orders
                         WHERE           aid   IN (
                                                   SELECT aid
                                                   FROM   agents
                                                   WHERE  city IN ('New York','Dallas')    
                                                  )
                         )
ORDER BY cid DESC;
         

--#7                                                                                      --
--List customers who have the same discount as customers in Dallas or London              --
--Ordered Descendingly                                                                    --

SELECT          *
FROM            customers
WHERE           discount   IN (
                           SELECT  discount
                           FROM    customers
                           WHERE   city IN ('Dallas','London')
                         )
ORDER BY cid DESC;


--#8                                                                                      --
--                                                                                        --
--	Check constraints are used to limit the value range that can be placed in a column.   --
-- Check constraints ensure that your data has integrity. The advantage is that the field --
-- will only take a certain range of values. This ensures that whenever data is entered   --
-- it follows the guidelines you need it to. A good use of a check constraint would be    --
-- for when a user enters their age. The age would definitely have to be greater than 0.  --
-- A bad use would be to use constraints to break up the data's integrity. For example,   --
-- for age, using check constraints to ensure that users can't enter anything over 85     --
-- wouldn't be good for the data. the difference is that good constraints make sure that  --
-- someone doesn't enter data that could later cause an error in the application, while   --
-- bad constraints will limit the valuable data that could have been entered.             --















                                                                                --