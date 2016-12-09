-- ------------------------------------------------------------------------------------
-- Bradley Lamitie                                                                   --
-- Database Design Project                                                           --
-- Due on 12/08/2016                                                                 --
-- Database Management ~ Labouseur                                                   --
-- ------------------------------------------------------------------------------------
-- Restart all roles for supervisor. and regrant them privelages. 
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM supervisor;
DROP ROLE supervisor;
CREATE ROLE supervisor;
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public 
TO supervisor;

-- Grants Read only privelages to public
GRANT SELECT ON ALL TABLES IN SCHEMA public TO PUBLIC;

-- Drop all tables and start from scratch
DROP TABLE IF EXISTS EnemyLocations CASCADE;
DROP TABLE IF EXISTS NonPlayerCharacterLocations ;
DROP TABLE IF EXISTS Sells ;
DROP TABLE IF EXISTS Drops ;
DROP TABLE IF EXISTS ItemLocations CASCADE;
DROP TABLE IF EXISTS Inventory ;
DROP TABLE IF EXISTS PlayerCharacters ;
DROP TABLE IF EXISTS NonPlayerCharacters ;
DROP TABLE IF EXISTS Enemies;
DROP TABLE IF EXISTS Gamers ;
DROP TABLE IF EXISTS Areas ;
DROP TABLE IF EXISTS Items ;


-- Create the Gamers table and populate it with sample data
CREATE TABLE Gamers
(
	gamertag 	TEXT 		NOT NULL UNIQUE PRIMARY KEY,
	bio      	TEXT
);
INSERT INTO Gamers
	VALUES('Cosmic0blivion', 'I Like food'),
    	  ('WhiteKitten87', 'Meow'),
     	  ('Fallout878', 'Fallout Boy!'),
   		  ('AcexMerk', 'Hi, Im Eddie'),
  		  ('PapaChopz', 'MasterShake Yo');
   
   
-- Create the Areas table and populate it with sample data
   
CREATE TABLE Areas
(
	areaName 		TEXT 		NOT NULL UNIQUE PRIMARY KEY,
	connection   	TEXT 		NOT NULL,
	connection1  	TEXT 		DEFAULT(' '),
	connection2  	TEXT 		DEFAULT(' '),
	connection3  	TEXT 		DEFAULT(' '),
	connection4 	TEXT 		DEFAULT(' '),
	connection5  	TEXT 		DEFAULT(' '),
	notes  			TEXT
);

INSERT INTO Areas
	VALUES('Northern Undead Asylum','Firelink Shrine',' ',' ',' ',' ',' ','Tutorial Level'),
    	  ('Firelink Shrine','Undead Burg','The Catacombs','New Londo Ruins','Northern Undead Asylum','Undead Parish','Firelink Altar','First Hub. Anastacia of Astora in cage below the bonfire. Petrus of Thorolund of Way of White covenant. Kingseeker Frampt will appear in the collapsed chapel once both Bells of Awakening have been rung.'),
          ('Undead Burg','Firelink Shrine','Undead Parish','Darkroot Basin','Depths',' ',' ','NPC Solaire of Astora located on the bridge. Bonfire and Broken altar for Warrior of Sunlight under Hellkite Dragon'),
   		  ('Undead Parish','Undead Burg','Darkroot Garden','Firelink Shrine','Sens Fortress',' ',' ','Location of the first Bell of Awakening. Oswald of Carim is located at the entrance of the Bell Tower.'),
  		  ('The Depths','Blighttown','Undead Burg',' ',' ',' ',' ','None'),
   	      ('Blighttown','Valley of the Drakes','The Depths','The Great Hollow','Queelags Domain',' ',' ','Quelana of Izalith advanced pyromancy vendor. Shiva of the East Forest Keeper covenant vendor.'),
 		  ('Quelaags Domain','Blighttown','Ash Lake',' ',' ',' ',' ','Location of the second Bell of Awakening. Quelaags Sister and Eingyi for Chaos Servant covenant.'),
    	  ('The Great Hollow','Blighttown','Ash Lake',' ',' ',' ',' ','Hidden (and optional area) with no possibility to summon or getting summoned. Contains the most Crystal Lizards of any area in the game.'),
    	  ('Ash Lake','The Great Hollow',' ',' ',' ',' ',' ','Hidden (and optional area) with no possibility to summon or getting summoned. Is also a dead end, contains NPC for the Path of the Dragon covenant.'),
    	  ('Sens Fortress','Undead Parish','Anor Londo',' ',' ',' ',' ','None'),
    	  ('Anor Londo','Sens Fortress','The Dukes Archives','Painted World of Ariamis',' ',' ',' ','None'),
    	  ('Painted World of Ariamis','Anor Londo',' ',' ',' ',' ',' ','Optional, requires Peculiar Doll in order to enter the painting in Anor Londo'),
          ('Kiln of the First Flame','Firelink Altar',' ',' ',' ',' ',' ','Final area of the game.'),
		  ('The Dukes Archives','Anor Londo','Crystal Cave',' ',' ',' ',' ','None');


-- Create the PlayerCharacters table and populate it with sample data

CREATE TABLE PlayerCharacters
(
    gamertag 			TEXT 		NOT NULL references Gamers(gamertag),
	playerName 			TEXT 		NOT NULL UNIQUE,
	areaName 			TEXT 		NOT NULL references Areas(areaName),
    soulLevel 			INT 		NOT NULL, 
	souls      			INT			NOT NULL,
	gift      			TEXT 		NOT NULL,
	class      			TEXT 		NOT NULL,
	vitality      		INT 		NOT NULL,
	attunement      	INT 		NOT NULL,
	endurance       	INT 		NOT NULL,
	strength        	INT 		NOT NULL,
	dexterity       	INT 		NOT NULL,
	resistance      	INT 		NOT NULL,
	intelligence    	INT 		NOT NULL,
	faith      			INT 		NOT NULL,
	humanity      		INT 		NOT NULL,
    gender   			CHAR 		NOT NULL,
    playthrough 		INT 		NOT NULL,
    covenant 			TEXT,
    chaosServantRank 	INT 		NOT NULL,
    forestHunterRank 	INT 		NOT NULL,
    darkmoonRank 		INT 		NOT NULL,
    darkwraithRank 		INT 		NOT NULL,
    gravelordRank 		INT 		NOT NULL,
    dragonRank 			INT 		NOT NULL,
    princessRank 		INT 		NOT NULL,
    sunlightRank 		INT 		NOT NULL,
    whiteRank 			INT 		NOT NULL,
    PRIMARY KEY(gamertag, playerName)
);

INSERT INTO PlayerCharacters
	VALUES('Cosmic0blivion','The Wall','Ash Lake',42, 25825,'Binoculars','Deprived',12,15,18,16,24,85,56,8,6,'M',1,'Way of the White', 0,0,0,0,0,0,0,0,0),
    ('WhiteKitten87','Allen','Undead Parish',36,254856, 'Divine Blessing','Cleric',3,26,89,75,11,10,5,26,5,'M',2,'DarkWraith', 1,2,1,1,0,3,2,4,1),
    ('Cosmic0blivion','Steve','Northern Undead Asylum',23,12345,'Black Firebomb','Wanderer',13,29,17,24,24,24,24,3,1,'M',2,'Path of the Dragon', 1,1,1,1,1,2,1,1,0),
    ('PapaChopz','Destroyer','The Depths',1,0,'Master Key','Pyromancer',1,1,12,52,3,15,12,20,16,'M',1,'DarkMoon', 3,3,3,3,3,3,3,3,3),
    ('AcexMerk','Gretchen','Sens Fortress',356,1254,'Old Witchs Ring','Sorcerer',15,48,20,11,11,11,14,15,16,'M',3,'Princess Guard', 1,1,1,1,1,1,1,1,2);


-- Create the Enemies table and populate it with sample data

CREATE TABLE Enemies
(
    enemyName 			TEXT 		NOT NULL PRIMARY KEY,
	parryable 			BOOLEAN 	NOT NULL,
	damageType  		TEXT 		NOT NULL,
    enemyDescription  	TEXT 		NOT NULL
);

INSERT INTO Enemies
	VALUES('Hollow',true,'physical','Hollows are undead who have lost their sanity.'),
          ('Havel the Rock',true,'physical','Havel, the Rock was a bishop of the Way of White.'),
          ('Titanite Demon',false,'physical/lightning','The Prowling Demons, also known as the Titanite Demons, are demons born from the scattered legendary slabs after the unnamed blacksmith deity passed away.'),
          ('Armored Tusk',false,'physical','A large, heavily armored boar.'),
          ('Channeler',false,'physical/sorcery','The Channelers are powerful servants of Seath the Scaleless. '),
          ('Butcher',false,'physical','These cannibal butchers carry two weapons, a massive butcher blade and a sharpening steel that is used for a grab attack.'),
          ('Slime',false,'physical','Slimey creatures that often drop from the ceiling.'),
          ('Basilisk',false,'curse','These frog-like creatures jump around and spit gas that can result in a curse status ailment if you are exposed long enough.'),
          ('Crystal Golem',false,'physical','A golem created from Seaths experimentation with the Primordial Crystal.'),
          ('Hydra',false,'physical/sorcery','A giant aquatic serpent with many heads.'),
          ('CragSpider',false,'physical/fire','A Hollow transformed into a spider creature that is able to breathe fire.'),
          ('Asylum Demon',false,'physical','A lesser demon who guards the Undead Asylum, preventing the prisoners within from escaping. '),
          ('Dragon Slayer Ornstein',false,'physical/lightning','Ornstein is the captain of the Four Knights of Gwyn, and presumably, the leader of Gwyns knights.'),
          ('Executioner Smough',false,'physical','Smough is the royal executioner of Anor Londo. He longs to be ranked with the Four Knights, but his cruelty, including using his victims bone as his foods seasoning, forever denied him the position.'),
          ('Moonlight Butterfly',false,'Sorcery','Large magical butterfly created by Seath the Scaleless from magic.'),
          ('Gwyn, Lord of Cinder',true,'physical/Fire','Gwyn is one of the gods that defeated the Everlasting Dragons long ago.');



-- Create the NonPlayerCharacters table and populate it with sample data

CREATE TABLE NonPlayerCharacters
(
    npcName		  TEXT 		NOT NULL UNIQUE PRIMARY KEY,
	health  	  INT		NOT NULL,
	soulsYielded  INT 		NOT NULL,
	isMerchant    BOOLEAN 	NOT NULL,
   	uses 		  TEXT 		NOT NULL
);

INSERT INTO NonPlayerCharacters
	VALUES('Oscar, knight of Astora',793,1000,true,'gives you keys and an estus flask.'),
    ('Snuggly the Crow',0,0,false,'trades items for other items'),
   ('Crestfallen Warrior',793,1000,false,'gives some conversation'),
   ('Petrus of Thorolund',594,1000,true,'sells miracles'),
   ('The Crow',0,0,false,'transports the player back to Northern Undead Asylum'),
   ('Anastacia of Astora',0,0,false,'Levels up your Estus Flask'),
   ('Griggs of Vinheim',659,1000,true,'sells sorcery'),
   ('Laurentius',719,1000,true,'sells and levels up pyromancy'),
   ('Big Hat Logan',719,1000,true,'sells sorceries');
  
  

-- Create the NonPlayerCharacterLocations table and populate it with sample data

CREATE TABLE NonPlayerCharacterLocations
(
    npcName			TEXT		 NOT NULL references NonPlayerCharacters(npcName),
    areaName 		TEXT 		 NOT NULL references Areas(areaName),
    innerLocation 	TEXT		 NOT NULL,
    condition 		TEXT 		 NOT NULL,
    PRIMARY KEY (npcName, areaName, innerLocation)
);

INSERT INTO NonPlayerCharacterLocations
	VALUES('Oscar, knight of Astora','Northern Undead Asylum','behind the wall the cannonball destroys','none'),
    ('Snuggly the Crow','Northern Undead Asylum','after beating the first boss, further up the hill','none'),
    ('Crestfallen Warrior','Firelink Shrine','sits against a wall near the bonfire.','none'),
    ('Crestfallen Warrior','Anor Londo','attacks the player heading towards New Lond Ruins','Exhaust dialog and ring both bells'),
    ('Petrus of Thorolund','Firelink Shrine', 'can be found near the elevator to Undead Parish','none'),
    ('The Crow', 'Firelink Shrine','can be found after jumping off the elevator to Undead Parish','none'),
    ('Anastacia of Astora','Firelink Shrine','Down the staircase on the left','none'),       
    ('Griggs of Vinheim','Undead Burg','locked in a room','none'),       
    ('Griggs of Vinheim','Firelink Shrine','near the well','free him in Undead Burg'),  
    ('Griggs of Vinheim','Sens Fortress','Will attack the player in Sens fortress','buy all his spells and rings'),       
	('Laurentius','The Depths', 'located behind the second butcher, Inside a barrel','none'),
    ('Laurentius','Firelink Shrine','sits close to Frampt', 'Free him in The Depths'),
    ('Laurentius','Blighttown','in front of the blighttown bonfire','if the player has a unique pyromancy and talks to him'),
    ('Big Hat Logan','Sens Fortress', 'found behind a wall knocked down by a boulder','none'),
    ('Big Hat Logan','Firelink Shrine', 'found near the bonfire','Player has freed him and has at least 15 intelligence'),
    ('Big Hat Logan','The Dukes Archives','found in the prison tower cage', 'player has placed the lordvessel'),
    ('Big Hat Logan','The Dukes Archives','found in the book room behind the moving bookcase', 'player mustve freed him from the prison cell'),
    ('Big Hat Logan','The Dukes Archives','found in the room where you first encounter seath', 'must have bought all of his items and exhausted his dialog');


-- Create the Items table and populate it with sample data

CREATE TABLE Items
(
    itemName 	TEXT	NOT NULL UNIQUE PRIMARY KEY,
    itemType	TEXT 	NOT NULL,
	description TEXT 	NOT NULL
);

INSERT INTO Items
	VALUES('Binoculars', 'Key', 'Key Item used to view far away'),
    ('Heal', 'Miracle', 'Heals a small amount of health'),
    ('Great Heal Excerpt', 'Miracle', 'Heals a large amount of HP.'),
    ('Seek Guidance','Miracle','Show More online hints.'),
    ('Force','Miracle','This quickly-acting miracle inflicts no damage, but propels foes back and defends against arrows.'),
    ('Homeward','Miracle','Return to last used bonfire, similar to the Homeward Bone item.'),
    ('Talisman','Talisman','Used for casting miracles with MagAdjust of 118.'),
    ('Thorolund Talisman','Talisman','Used for casting miracles with fixed MagAdjust of 165.'),
    ('Soul Arrow','Sorcery','Shoots a fast projectile at target that does Magic damage'),
    ('Great Soul Arrow','Sorcery','Stronger Soul Arrow'),
    ('Heavy Soul Arrow','Sorcery','Slower Soul Arrow, but higher damage than Great'),
    ('Great Heavy Soul Arrow','Sorcery','Stronger Heavy Soul Arrow'),
    ('Magic Weapon','Sorcery','Must be used with catalyst in left hand, adds Magic damage to your right hand weapon'),
    ('Magic Shield','Sorcery','Must be used with catalyst in right hand, temporarily increases the stability of your shield'),
    ('Aural Decoy','Sorcery','Throws a decoy that lures enemies away by creating a sound'),
    ('Fall Control','Sorcery','Reduce damage and noise from fall'),
    ('Soul Spear','Sorcery','Fires large Soul Arrow that pierces its targets. Only after Big Hat Logan leaves Firelink Shrine.'),
    ('Homing Soulmass','Sorcery','Summons up to five soulmasses that fire automatically when an enemy is near. Only after Big Hat Logan leaves Firelink Shrine.'),
    ('Sorcerers Catalyst','Catalyst','Basic catalyst needed to cast sorceries. Starting equipment of Sorcerer class.'),
    ('Bellowing Dragoncrest Ring','Ring','Increases Sorcery and Pyromancy spell damage by 20%'),
    ('Lingering Dragoncrest Ring','Ring','Increases the duration of Sorcery and Pyromancy spell effects by 50%'),
    ('Fire Orb','Pyromancy','Hurls flaming orbs.'),
    ('Combustion','Pyromancy','Shoots a close range burst of fire from the hand.'),
    ('Iron Flesh','Pyromancy','Greatly increases defense at the expense of mobility. Only Laurentius sells this.'),
    ('Flash Sweat','Pyromancy','Covers the player in water for 1 minute. Only Laurentius sells this.'),
    ('Fireball','Pyromancy','Throws a ball of flames that explodes on impact.'),
    ('Homing Crystal Soulmass','Sorcery','Stronger Homing Soulmass. Only available when you meet him at The Dukes Archives.'),
    ('Crystal Magic Weapon','Sorcery','Strongest version of Magic Weapon. Only available when you meet him at The Dukes Archives.'),
    ('Crystal Soul Spear','Sorcery','Stronger Soul Spear. Only available when you meet him at The Dukes Archives.'),
    ('Havels Ring','Ring','Wearing the ring raises maximum equipment burden by 50%'),
    ('Titanite Catch Pole','Weapon','Weapon of the titanite demon, a faceless stone monster born from titanite slab.'),
	('Demon Titanite', 'Upgrade Material','Special titanite stolen from a faceless stone beast known as a Titanite Demon.'),
	('Fang Boar Helm','Armor','Severed head of the fully-armored Fang Boar taken by the one who killed it as proof of his victory, just as the Gods once did with the head of the ancient dragon.'),
	('Channelers Trident','Weapon','Trident of the Six-eyed Channelers, sorcerers who serve Seath the Scaleless in collecting human specimens.'),
	('Sack','Armor','Bloodstained patchwork sack by the Undead man-eating cook lurking in the Depths. '),
	('Green Titanite Shard','Upgrade Material','Titanite shard for weapon reinforcement.'),
	('Large Titanite Shard','Upgrade Material','Titanite shard for weapon reinforcement.'),
    ('Eye of Death','Consumable','Online play item. Lure phantoms from other worlds.'),
    ('Blue Titanite Chunk','Upgrade Material','Titanite chunk for weapon reinforcement.'),
    ('Dragon Scale', 'Upgrade Material', 'Dragon scale for reinforcing dragon weapons. Peeled from an ancient dragon.'),
    ('Dusk Crown Ring','Ring','The ringstone allows its wearer to cast additional sorceries, but at the cost of one-half of HP'),
    ('Demons Great Hammer', 'Weapon', 'Demon weapon built from the stone archtrees.'),
    ('Big Pilgrims Key','Key','Key to the inner door of the Undead Asylum main hall'),
    ('Humanity','Consumable','These consumables are not lost upon death and, when used, are converted to Humanity in "loose form" as an increase to the Humanity stat.'),
    ('Soul of Ornstein','Consumable','Can be consumed or used as an upgrade material'),
    ('Leo Ring','Ring','Further boosts Counter damage by 40%, for a total of ~67% additional damage'),
	('Soul of Smough','Consumable','Can be consumed or used as an upgrade material'),
	('Soul of the Moonlight Butterfly','Consumable','Can be consumed or used as an upgrade material'),
	('Soul of Gwyn, Lord of Cinder','Consumable','Can be consumed or used as an upgrade material'),
    ('Rusted Iron Ring', 'Ring', 'Allows the wearer to tread through water easier'),
    ('Soul of a Lost Undead','Consumable','Gives the user 200 souls'),
    ('Firebomb','Consumable','Can be thrown to inflict fire damage'),
    ('Homeward Bone','Consumable','Can be used to return to the last bonfire rested at.'),
    ('Large Soul of a Lost Undead','Consumable','Gives the user 400 souls'),
    ('Soul of a Nameless Soldier','Consumable','Gives the user 800 souls'),
	('Gold Pine Resin', 'Consumable','imbues the users weapon with lightning'),
    ('Throwing Knife','Consumable', 'Can be thrown from a distance to inflict damage.'),
    ('Black Firebomb','Consumable','Can be thrown to inflict lots of fire damage'),
	('Fire Keepers Soul', 'Upgrade Material','Can be used to upgrade an Estus Flask'),
    ('Large Ember','Upgrade Material','Can be used to upgrade Weapons and Armor'),
    ('Large Soul of a Nameless Soldier','Consumable','Gives the user 1000 souls'),
    ('Large Soul of a Proud Knight','Consumable','Gives the user 3000 souls'),
    ('Soul of a Proud Knight','Consumable','Gives the user 2000 souls'),
    ('Titanite Chunk','Upgrade Material','Can be used to upgrade Weapons and Armor'),
    ('White Titanite Chunk','Upgrade Material','Can be used to upgrade Weapons and Armor'),
    ('Red Titanite Chunk','Upgrade Material','Can be used to upgrade Weapons and Armor'),
    ('Large Soul of a Brave Warrior','Consumable','Gives the user 8000 souls'),
    ('Soul of a Brave Warrior','Consumable','Gives the user 5000 souls'),
    ('Soul of a Hero','Consumable','Gives the user 10000 souls'),
    ('Dark Ember','Upgrade Material','Can be used to upgrade Weapons and Armor'),
	('Twin Humanities','Consumable','When used, grants the user two humanity.');



-- Create the Sells table and populate it with sample data

CREATE TABLE Sells
(
    npcName 		 TEXT 		NOT NULL references NonPlayerCharacters(npcName),
    itemName 		 TEXT		NOT NULL references Items(itemName),
    costSouls		 INT 		NOT NULL,
    PRIMARY KEY (npcName, itemName)
);

INSERT INTO Sells
	VALUES('Petrus of Thorolund','Heal',4000),
    ('Petrus of Thorolund','Great Heal Excerpt',10000),
    ('Petrus of Thorolund','Seek Guidance',2000),
    ('Petrus of Thorolund','Force',4000),
    ('Petrus of Thorolund','Homeward',8000),
    ('Petrus of Thorolund','Talisman',1000),
    ('Petrus of Thorolund','Thorolund Talisman',5000),
	('Griggs of Vinheim','Soul Arrow',1000),
    ('Griggs of Vinheim','Great Soul Arrow',6000),
	('Griggs of Vinheim','Heavy Soul Arrow',2000),
	('Griggs of Vinheim','Great Heavy Soul Arrow',8000),
	('Griggs of Vinheim','Magic Weapon',3000),
	('Griggs of Vinheim','Magic Shield',3000),
	('Griggs of Vinheim','Aural Decoy',1000),
	('Griggs of Vinheim','Fall Control',1500),
	('Griggs of Vinheim','Soul Spear',40000),
	('Griggs of Vinheim','Homing Soulmass',20000),
	('Griggs of Vinheim','Sorcerers Catalyst',500),
	('Griggs of Vinheim','Bellowing Dragoncrest Ring',20000),
	('Griggs of Vinheim','Lingering Dragoncrest Ring',20000),
    ('Laurentius','Fire Orb',8000),
    ('Laurentius','Combustion',500),
    ('Laurentius','Iron Flesh',2000),
    ('Laurentius','Flash Sweat',2000),
    ('Laurentius','Fireball',800),
    ('Big Hat Logan','Great Soul Arrow', 6000),
    ('Big Hat Logan','Heavy Soul Arrow', 2000),
    ('Big Hat Logan','Great Heavy Soul Arrow', 8000),
    ('Big Hat Logan','Homing Soulmass', 20000),
    ('Big Hat Logan','Soul Spear', 40000),
    ('Big Hat Logan','Magic Weapon', 3000),
    ('Big Hat Logan','Magic Shield', 3000),
    ('Big Hat Logan','Soul Arrow', 1000),
    ('Big Hat Logan','Homing Crystal Soulmass', 30000),
    ('Big Hat Logan','Crystal Magic Weapon', 20000),
    ('Big Hat Logan','Crystal Soul Spear', 50000 );



-- Create the Inventory table and populate it with sample data

CREATE TABLE Inventory
(
    playerName 		TEXT	 NOT NULL references PlayerCharacters(playerName),
    gamertag		TEXT	 NOT NULL references Gamers(gamertag),
	itemName 		TEXT 	 NOT NULL references Items(itemName),
    quantity		INT 	 NOT NULL,
    PRIMARY KEY (gamertag, itemName, playerName)
);

INSERT INTO Inventory
	VALUES ('The Wall','Cosmic0blivion','Crystal Soul Spear',1),
('The Wall','Cosmic0blivion','Heal',10),
('The Wall','Cosmic0blivion','Iron Flesh',1),
('The Wall','Cosmic0blivion','Sorcerers Catalyst',1),
('The Wall','Cosmic0blivion','Fire Orb',7),
('The Wall','Cosmic0blivion','Great Heavy Soul Arrow',1),
('The Wall','Cosmic0blivion','Bellowing Dragoncrest Ring',4),
('The Wall','Cosmic0blivion','Lingering Dragoncrest Ring',1),
('The Wall','Cosmic0blivion','Homing Crystal Soulmass',1),
('The Wall','Cosmic0blivion','Talisman',3),
('The Wall','Cosmic0blivion','Crystal Magic Weapon',1),
('Steve','Cosmic0blivion','Great Heavy Soul Arrow',1),
('Steve','Cosmic0blivion','Fire Orb',1),
('Steve','Cosmic0blivion','Heal',1),
('Steve','Cosmic0blivion','Bellowing Dragoncrest Ring',2),
('Steve','Cosmic0blivion','Talisman',1),
('Steve','Cosmic0blivion','Sorcerers Catalyst',1),
('Steve','Cosmic0blivion','Lingering Dragoncrest Ring',1),
('Steve','Cosmic0blivion','Crystal Soul Spear',1),
('Allen','WhiteKitten87','Iron Flesh',4),
('Allen','WhiteKitten87','Sorcerers Catalyst',1),
('Allen','WhiteKitten87','Talisman',1),
('Allen','WhiteKitten87','Bellowing Dragoncrest Ring',4),
('Allen','WhiteKitten87','Lingering Dragoncrest Ring',1),
('Allen','WhiteKitten87','Heal',1),
('Allen','WhiteKitten87','Great Heavy Soul Arrow',1),
('Allen','WhiteKitten87','Fire Orb',2),
('Gretchen','AcexMerk','Talisman',1),
('Gretchen','AcexMerk','Fire Orb',1),
('Gretchen','AcexMerk','Sorcerers Catalyst',3),
('Gretchen','AcexMerk','Crystal Soul Spear',1),
('Gretchen','AcexMerk','Iron Flesh',1),
('Destroyer','PapaChopz','Sorcerers Catalyst',1),
('Destroyer','PapaChopz','Heal',1),
('Destroyer','PapaChopz','Talisman',2);



-- Create the Drops table and populate it with sample data

CREATE TABLE Drops
(
    enemyName 			 TEXT 		NOT NULL references Enemies(enemyName),
    itemName 			 TEXT 		NOT NULL references Items(itemName),
    dropRatePercentage	 INT 		NOT NULL,
    PRIMARY KEY (itemName, enemyName)
);

INSERT INTO Drops
	VALUES ('Havel the Rock','Havels Ring',100),
    ('Titanite Demon','Demon Titanite',100),    
    ('Titanite Demon','Titanite Catch Pole',20),    
	('Armored Tusk','Fang Boar Helm',25),
    ('Channeler','Channelers Trident',10),
    ('Butcher','Sack',100),
    ('Slime','Green Titanite Shard',2),
    ('Slime','Large Titanite Shard',2),
	('Basilisk','Eye of Death',6),
    ('Crystal Golem','Blue Titanite Chunk',5),
    ('Hydra','Dusk Crown Ring',100),
    ('Hydra','Dragon Scale',100),
    ('Asylum Demon','Demons Great Hammer',100),
    ('Asylum Demon','Big Pilgrims Key',100),
    ('Asylum Demon','Humanity',100),
    ('Dragon Slayer Ornstein','Leo Ring',100),
    ('Dragon Slayer Ornstein','Soul of Ornstein',100),
    ('Executioner Smough','Soul of Smough',100),
	('Moonlight Butterfly','Soul of the Moonlight Butterfly',100),
    ('Moonlight Butterfly','Humanity',100),
    ('Gwyn, Lord of Cinder','Soul of Gwyn, Lord of Cinder',100);



-- Create the ItemLocations table and populate it with sample data

CREATE TABLE ItemLocations
(
    areaName 	TEXT 	NOT NULL references Areas(areaName),
	itemName 	TEXT 	NOT NULL references Items(itemName),
    PRIMARY KEY (itemName, areaName)
);
INSERT INTO ItemLocations
	VALUES ('Northern Undead Asylum','Soul of a Lost Undead'),
    ('Northern Undead Asylum','Rusted Iron Ring'),
    ('Firelink Shrine','Soul of a Lost Undead'),
    ('Firelink Shrine','Firebomb'),
    ('Firelink Shrine','Large Soul of a Lost Undead'),
    ('Firelink Shrine','Homeward Bone'),
    ('Firelink Shrine','Binoculars'),
    ('Undead Burg','Throwing Knife'),
    ('Undead Burg','Soul of a Nameless Soldier'),
    ('Undead Burg','Soul of a Lost Undead'),
    ('Undead Burg','Gold Pine Resin'),
    ('Undead Burg','Black Firebomb'),
    ('Undead Burg','Large Soul of a Lost Undead'),
    ('Undead Parish','Large Soul of a Lost Undead'),
    ('Undead Parish','Fire Keepers Soul'),
    ('The Depths','Soul of a Nameless Soldier'),
    ('The Depths','Large Titanite Shard'),
    ('The Depths','Humanity'),
    ('The Depths','Large Soul of a Nameless Soldier'),
    ('The Depths','Large Ember'),
	('Blighttown','Fire Keepers Soul'),
	('Blighttown','Large Titanite Shard'),
	('Blighttown','Large Soul of a Proud Knight'),
	('Blighttown','Green Titanite Shard'),
	('Blighttown','Twin Humanities'),
	('Blighttown','Humanity'),
	('Blighttown','Soul of a Proud Knight'),
    ('Blighttown','Large Soul of a Nameless Soldier'),
	('The Great Hollow','Humanity'),
    ('The Great Hollow','Large Soul of a Nameless Soldier'),
    ('The Great Hollow','Titanite Chunk'),
    ('The Great Hollow','Red Titanite Chunk'),
    ('The Great Hollow','Blue Titanite Chunk'),
    ('The Great Hollow','White Titanite Chunk'),
    ('Ash Lake','Dragon Scale'),
    ('Sens Fortress','Soul of a Brave Warrior'),
    ('Sens Fortress','Large Soul of a Brave Warrior'),
    ('Sens Fortress','Soul of a Hero'),
    ('Sens Fortress','Large Titanite Shard'),
	('Anor Londo','Titanite Chunk'),
	('Anor Londo','Soul of a Hero'),
	('Anor Londo','Demon Titanite'),
	('Painted World of Ariamis','Dark Ember'),
    ('Painted World of Ariamis','Large Soul of a Proud Knight'),
	('Painted World of Ariamis','Soul of a Brave Warrior'),
	('Painted World of Ariamis','Soul of a Proud Knight'),
    ('Painted World of Ariamis','Humanity');




-- Create the EnemyLocations table and populate it with sample data
       
CREATE TABLE EnemyLocations
(
    enemyName 		TEXT 		 NOT NULL references Enemies(enemyName),
    areaName		TEXT		 NOT NULL references Areas(areaName),
    health   		INT		 	 NOT NULL,
    soulsYielded 	INT 		 NOT NULL,
    isBoss 			BOOLEAN		 NOT NULL,
    respawns 		BOOLEAN		 NOT NULL,
    PRIMARY KEY (enemyName, areaName)
);

INSERT INTO EnemyLocations
VALUES('Hollow','Northern Undead Asylum',69,20,false,true),
('Hollow','Undead Parish',63,20,false,true),
('Hollow','Undead Burg',53,20,false,true),
('Hollow','The Depths',74,50,false,true),
('Hollow','Painted World of Ariamis',132,300,false,true),
('Havel the Rock','Undead Burg', 1034,3000,false,false),
('Titanite Demon','Undead Parish',1506,2000,false,false),
('Titanite Demon','Sens Fortress',2510,3000,false,false),
('Titanite Demon','Anor Londo',2635,5000,false, false),
('Armored Tusk','Undead Parish',37,750,false, false),
('Armored Tusk','The Dukes Archives',64,1000,false, false),
('Channeler','Undead Parish',186,1000,false, false),
('Channeler','The Depths',186,1000,false, false),
('Channeler','The Dukes Archives',387,800,false,true),
('Butcher','The Depths',672,500,false,false),
('Slime','The Depths',143,100,false, true),
('Basilisk','The Depths',116,200,false, true),
('Basilisk','The Great Hollow',193,400,false, true),
('Basilisk','Ash Lake',193,400,false, true),
('Crystal Golem','The Dukes Archives',68,1200,false, true),
('Hydra','Ash Lake',3863,10000,false, false),
('CragSpider','Blighttown',167,100,false, true),
('Asylum Demon','Northern Undead Asylum',813,2000,true, false),
('Dragon Slayer Ornstein', 'Anor Londo',5626,50000,true, false),
('Executioner Smough','Anor Londo',5736,50000, true, false),
('Moonlight Butterfly','The Dukes Archives',1506,10000,true, false),
('Gwyn, Lord of Cinder','Kiln of the First Flame',4185,70000,true, false);


-- Basic queries to view each table. --------------------------------------------------
SELECT * FROM EnemyLocations ;
SELECT * FROM NonPlayerCharacterLocations ;
SELECT * FROM Sells ;
SELECT * FROM Drops ;
SELECT * FROM ItemLocations ;
SELECT * FROM Inventory ;
SELECT * FROM PlayerCharacters ;
SELECT * FROM NonPlayerCharacters ;
SELECT * FROM Enemies;
SELECT * FROM Gamers ;
SELECT * FROM Areas ;
SELECT * FROM Items ;

-- Views -------------------------------------------------------------------------------

-- EnemyLocationInfo view
-- Finds all Ennemies and their locations
CREATE OR REPLACE VIEW EnemyLocationInfo
AS
SELECT DISTINCT  e.* 
FROM Areas a INNER JOIN EnemyLocations e ON a.areaName= e.areaName
ORDER BY e.areaName;
SELECT * FROM EnemyLocationInfo;



-- ClaimableItems view
-- Finds all Items lying on the ground in every location

CREATE OR REPLACE VIEW ClaimableItems
AS
SELECT DISTINCT a.areaName, itemName 
FROM Areas a INNER JOIN ItemLocations il ON a.areaName=il.areaName
ORDER BY a.areaName;

SELECT * FROM ClaimableItems;



-- Reports --------------------------------------------------------------------

-- Finds all Bosses and their locations

SELECT DISTINCT  e.areaName AS "BossLocation", enemyName AS "BossName" 
FROM Areas a INNER JOIN EnemyLocations e ON a.areaName= e.areaName
WHERE isBoss = true
ORDER BY e.areaName;

-- Finds all Items with less than or equal to a 5% droprate, the enemies that drop them and the enemies locations. 

SELECT DISTINCT  d.itemName AS "Item Name", el.areaName AS "Enemy Location", e.enemyName AS "Enemy Name", dropRatePercentage AS "Drop Rate" 
FROM Enemies e INNER JOIN Drops d ON d.enemyName= e.enemyName
			   INNER JOIN EnemyLocations el ON e.enemyName= el.enemyName
WHERE d.dropRatePercentage <= 5
ORDER BY el.areaName;


-- Stored Procedures ----------------------------------------------------------

-- AdjacentAreastoMe finds Areas adjacent to a player specified by a gamertag and playerName

CREATE OR REPLACE FUNCTION AdjacentAreastoMe(TEXT,TEXT, REFCURSOR) RETURNS refcursor AS 
$$
DECLARE
   playersName TEXT       := $1;
   gamerstag   TEXT 	  := $2;
   resultset   REFCURSOR  := $3;
BEGIN
   OPEN resultset FOR 
      SELECT connection,connection1,connection2,connection3,connection4,connection5
      FROM   PlayerCharacters p INNER JOIN Areas a ON p.areaName = a.areaName
      WHERE  p.playerName = playersName AND p.gamertag = gamerstag;
   RETURN resultset;
END;
$$ 
LANGUAGE plpgsql;

SELECT AdjacentAreastoMe('The Wall','Cosmic0blivion', 'results');
FETCH ALL FROM results;


-- AdjacentAreas finds the areas adjacent to the specified Area

CREATE OR REPLACE FUNCTION AdjacentAreas(TEXT, REFCURSOR) RETURNS refcursor AS 
$$
DECLARE
   specifiedArea    TEXT      := $1;
   resultset   		REFCURSOR := $2;
BEGIN
   OPEN resultset FOR 
      SELECT connection,connection1,connection2,connection3,connection4,connection5
      FROM    Areas
      WHERE  areaName = specifiedArea;
   RETURN resultset;
END;
$$ 
LANGUAGE plpgsql;

SELECT AdjacentAreas('Firelink Shrine', 'results1');
FETCH ALL FROM results1;


-- AffordableItems finds all items for sale that cost less then the souls the player has 

CREATE OR REPLACE FUNCTION AffordableItems(TEXT, TEXT, REFCURSOR) RETURNS refcursor AS 
$$
DECLARE
   specifiedGamertag    	TEXT      := $1;
   specifiedPlayerName    	TEXT      := $2;
   resultset   				REFCURSOR := $3;
BEGIN
   OPEN resultset FOR 
      SELECT *
      FROM   Sells s INNER JOIN Items i ON i.itemName = s.itemName
      WHERE  s.costSouls<(SELECT souls
                          FROM PlayerCharacters
                          WHERE gamertag = specifiedGamertag AND playerName = specifiedPlayerName
                          );
   RETURN resultset;
END;
$$ 
LANGUAGE plpgsql;

SELECT AffordableItems('Cosmic0blivion', 'Steve', 'results2');
FETCH ALL FROM results2;



-- Triggers -----------------------------------------------------

-- emp_Item() checks to see if any of the data being entered is null and tries to alert the user
CREATE OR REPLACE FUNCTION emp_Item() RETURNS trigger AS $emp_Item$
    BEGIN
        -- Check that itemName and itemType are given
        IF NEW.itemName IS NULL THEN
            RAISE EXCEPTION 'itemName cannot be null';
        END IF;
        IF NEW.itemType IS NULL THEN
            RAISE EXCEPTION '% cannot have null type', NEW.itemType;
        END IF;

        
        RETURN NEW;
    END;
$emp_Item$ LANGUAGE plpgsql;

CREATE TRIGGER emp_Item BEFORE INSERT OR UPDATE ON Items
    FOR EACH ROW EXECUTE PROCEDURE emp_Item();
    
-- This is the query that i used to test to make sure the Trigger worked.    
    INSERT INTO Items 
    VALUES('Potato',NULL, NULL);
