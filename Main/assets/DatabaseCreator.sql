CREATE SCHEMA zbaasdr;

CREATE TABLE Account (
	user_id int NOT NULL AUTO_INCREMENT, 
	username varchar(150), 
	PRIMARY KEY(user_id)
	);
	
CREATE TABLE Achievement (
	achievementid int NOT NULL AUTO_INCREMENT,
	name varchar(300),
	PRIMARY KEY(achievementid)
	);
	
CREATE TABLE Achieved (
	user_id int NOT NULL,
	achievementid int NOT NULL,
	PRIMARY KEY(user_id, achievementid),
	FOREIGN KEY(user_id) REFERENCES Account(user_id),
	FOREIGN KEY(achievementid) REFERENCES Achievement(achievementid)
	);
	
CREATE TABLE Highscore (
	user_id int NOT NULL,
	score float NOT NULL,
	PRIMARY KEY(user_id)
	FOREIGN KEY(user_id) REFERENCES Account(user_id)
	);
	
CREATE TABLE Money (
	user_id int NOT NULL,
	coins,
	PRIMARY KEY(user_id),
	FOREIGN KEY(user_id) REFERENCES Account(user_id)
	);
	
CREATE TABLE Item (
	itemid int NOT NULL AUTO_INCREMENT,
	name varchar(200),
	value int,
	level int,
	PRIMARY KEY(itemid)
	);
	
CREATE TABLE Shop (
	user_id int NOT NULL,
	itemid int NOT NULL,
	PRIMARY KEY(user_id, itemid),
	FOREIGN KEY(user_id) REFERENCES Account(user_id),
	FOREIGN KEY(itemid) REFERENCES Item(itemid)
	);
	
CREATE TABLE Gamerun (
	userId int, 
	startTime int, 
	enemiesKilled int, 
	bossesKilled int, 
	score int, 
	PRIMARY KEY(userId, startTime), 
	FOREIGN KEY(userId) REFERENCES Account(user_id)
	);
	
CREATE TABLE Statistic (
	userId int, 
	totalRuns int, 
	totalEnemiesKilled int, 
	totalBossesKilled int, 
	highScore int, 
	PRIMARY KEY(userId), 
	FOREIGN KEY(userId) REFERENCES Account(user_id)
	);