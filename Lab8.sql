--------------------------------------------------------------------------------------------
--Bradley Lamitie                                                                         --
--Lab 8: Normalization One                                                                --
--Assigned on 11/3/2016                                                                   --
--Due on 11/10/2016                                                                       --
--Database Management ~ Labouseur                                                         --
--------------------------------------------------------------------------------------------

DROP TABLE IF  EXISTS Directs;
DROP TABLE IF  EXISTS ActsIn;
DROP TABLE IF  EXISTS Directors;
DROP TABLE IF  EXISTS Movies;
DROP TABLE IF  EXISTS Actors;
DROP TABLE IF  EXISTS People;



-- Create Movies Table --
CREATE TABLE Movies (
  MID INT  NOT NULL ,
  movieName TEXT,
  yearReleased INT, 
  MPAAnumber INT,
  domesticBoxSalesUSD INT,
  foreignBoxSalesUSD INT,
  DiscSales INT,
  
PRIMARY KEY(MID));


-- Create People Table --
CREATE TABLE People (
 PID INT NOT NULL, 
 name TEXT,
 address TEXT,
 spouseName TEXT,
  PRIMARY KEY (PID)
);

-- Create Actors Table --
CREATE TABLE Actors (
  AID INT NOT NULL REFERENCES people(pid),
  birthDate DATE,
  hairColor TEXT,
  eyeColor TEXT,
  heightInInches INT,
  weightInPounds INT,
  favoriteColor TEXT,
  sagAnniversaryDate DATE,
PRIMARY KEY(aID)
);

-- Create Directors Table --
CREATE TABLE Directors (
  DID INT NOT NULL REFERENCES people(pid),
  filmSchoolAttended TEXT,
  directorsGuildAnniversaryDate  DATE,
  favoriteLensMaker TEXT,
PRIMARY KEY(dID)
);

-- Create ActsIn Table --
CREATE TABLE ActsIn (
  AID INT NOT NULL REFERENCES Actors(aid),
  MID INT NOT NULL REFERENCES Movies(mid),
PRIMARY KEY(aID,MID));


-- Create Directs Table --
CREATE TABLE Directs (
  DID INT NOT NULL REFERENCES Directors(did),
  MID INT NOT NULL REFERENCES Movies(mid),
PRIMARY KEY(dID,MID)
);


-- Populates the People Table with somewhat incorrect data -- 

INSERT INTO People(pid, name, address, spouseName)
  VALUES(1, 'Sean Connery','007 Goldfinger Lane','Micheline');
INSERT INTO People(pid, name, address, spouseName)
  VALUES(2,'Pierce Brosnan','007 GoldenEye Drive','Keely');
INSERT INTO People(pid, name, address, spouseName)
  VALUES(3,'Roger Moore', '007 Moonraker Court' , 'Kristina');
INSERT INTO People(pid, name, address, spouseName)
  VALUES(4,'Guy Hamilton', '105 Fantastic Avenue' , 'Naomi');
INSERT INTO People(pid, name, address, spouseName)
  VALUES(5,'Lewis Gilbert', '10 Great Avenue' , 'Hylda');
INSERT INTO People(pid, name, address, spouseName)
  VALUES(6,'Martin Campbell', '1 Good Avenue' , 'Sol');
 
-- Populates the Actors Table with somewhat incorrect data -- 

INSERT INTO Actors(aid, birthDate, hairColor, eyeColor, heightInInches, weightInPounds, favoriteColor, sagAnniversaryDate)
  VALUES(1,'1942-12-01', 'Grey' ,'blue',79,203, 'Gold', '2014-12-01');
INSERT INTO Actors(aid, birthDate, hairColor, eyeColor, heightInInches, weightInPounds, favoriteColor, sagAnniversaryDate)
  VALUES(2,'1983-11-10', 'Black','green' ,68,149, 'Gold', '2013-11-05');
INSERT INTO Actors(aid, birthDate, hairColor, eyeColor, heightInInches, weightInPounds, favoriteColor, sagAnniversaryDate)
  VALUES(3,'1927-10-14', 'brown', 'hazel' ,59,120, 'Grey', '1986-10-07');

  
-- Populates the Directors Table with somewhat incorrect data -- 

INSERT INTO Directors(did,filmSchoolAttended, directorsGuildAnniversaryDate, favoriteLensMaker)
  VALUES(4,'Marist', '2014-12-01', 'Zeiss');
  INSERT INTO Directors(did,filmSchoolAttended, directorsGuildAnniversaryDate, favoriteLensMaker)
  VALUES(5,'RCC', '2014-12-01', 'Olympus');
  INSERT INTO Directors(did,filmSchoolAttended, directorsGuildAnniversaryDate, favoriteLensMaker)
  VALUES(6,'PAR', '2014-12-01', 'Leica');

-- Populates the Movies Table with somewhat incorrect data -- 
  
INSERT INTO Movies(mid, movieName, yearReleased, mpaaNumber, domesticBoxSalesUSD, foreignBoxSalesUSD, DiscSales)
  VALUES(1,'Goldfinger',1964,12058 ,120000,107053,123456);
INSERT INTO Movies(mid, movieName, yearReleased,mpaaNumber, domesticBoxSalesUSD, foreignBoxSalesUSD, DiscSales)
  VALUES(2, 'GoldenEye',1995,12068,123378,983465,123465);
INSERT INTO Movies(mid,movieName, yearReleased, mpaaNumber, domesticBoxSalesUSD, foreignBoxSalesUSD, DiscSales)
  VALUES(3, 'MoonRaker',1979,87965, 120000,983465,123456);

  
-- Populates the Directs Table with somewhat incorrect data -- 

INSERT INTO Directs(did,mid)
  VALUES(4,1);
INSERT INTO Directs(did,mid)
  VALUES(5,2);
INSERT INTO Directs(did,mid)
  VALUES(6,3);
  
-- Populates the ActsIn Table with somewhat incorrect data --  
  
INSERT INTO ActsIn(aid,mid)
  VALUES(1,1);
INSERT INTO ActsIn(aid,mid)
  VALUES(2,2);
INSERT INTO ActsIn(aid,mid)
  VALUES(3,3);
  
-- SELECT * FROM movies;
-- SELECT * FROM actors;
-- SELECT * FROM directors;
-- SELECT * FROM directs;
-- SELECT * FROM people;
-- SELECT * FROM actsIn;

-- Answer to number 4
/*
CREATE OR REPLACE VIEW DirectorInfo AS 
Select * FROM people p INNER JOIN directors d ON p.pid = d.did;


select di.name
from actsin a INNER JOIN directs d ON a.mid = d.mid
              INNER JOIN actors ac ON a.aid = ac.aid
              INNER JOIN DirectorInfo di ON di.did = d.did
              INNER JOIN people p ON p.pid = a.aid 
WHERE p.name = 'Sean Connery';
*/