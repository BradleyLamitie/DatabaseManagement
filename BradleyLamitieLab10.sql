--------------------------------------------------------------------------------------
--Bradley Lamitie                                                                   --
--Lab 10: Stored Procedure                                                          --
--Assigned on 11/24/2016                                                            --
--Due on 12/01/2016                                                                 --
--Database Management ~ Labouseur                                                   --
--------------------------------------------------------------------------------------


-- 1. function PreReqsFor(courseNum) - 
-- Returns the immediate prerequisites for the passed-in course number.
create or replace function PreReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   course int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   Prerequisites p INNER JOIN Courses c ON p.preReqNum = c.num
       where  p.courseNum = course;
   return resultset;
end;
$$ 
language plpgsql;

select PreReqsFor(499, 'results');
Fetch all from results;


-- 2. function IsPreReqFor(courseNum) -
-- Returns the courses for which the passed-in course number is an immediate pre-requisite.

create or replace function IsPreReqFor(int, REFCURSOR) returns refcursor as 
$$
declare
   course int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   Prerequisites p INNER JOIN Courses c ON p.courseNum = c.num
       where  p.preReqNum = course;
   return resultset;
end;
$$ 
language plpgsql;

select IsPreReqFor(120, 'resultset');
Fetch all from resultset;






