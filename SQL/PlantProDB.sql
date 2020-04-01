
DROP DATABASE IF EXISTS PlantPro;
CREATE DATABASE PlantPro;
USE PlantPro;

CREATE TABLE User( 
	userId		int				NOT NULL		AUTO_INCREMENT,
	email		varchar(30)		NOT NULL,
	password	varchar(30)		NOT NULL,
	firstName	varchar(30)		NOT NULL,
	lastName	varchar(30)		NOT NULL,
	location	point			NOT NULL,
	isDeleted	bit				NOT NULL		DEFAULT 0,
	PRIMARY KEY (userId)
);

CREATE TABLE Comment(
	commentId			int				NOT NULL		AUTO_INCREMENT,
	userId				int				NOT NULL,
	plantSubmissionId	int				NOT NULL,
	body				varchar(120)	NOT NULL,
	date				datetime		NOT NULL,
	PRIMARY KEY (commentId),
	FOREIGN KEY (userId) REFERENCES User (userId),
	FOREIGN KEY (plantSubmissionId) REFERENCES PlantSubmission (plantSubmissionId)
); 

CREATE TABLE PlantSubmission(
	plantSubmissionId	int				NOT NULL		AUTO_INCREMENT, 
	userId				int				NOT NULL, 
	plantId				int				NOT NULL, 
	date				datetime		NOT NULL, 
	location			point			NOT NULL, 
	description			varchar(120)	NOT NULL,
	PRIMARY KEY (plantSubmissionId),
	FOREIGN KEY (userId) REFERENCES User (userId),
	FOREIGN KEY (plantId) REFERENCES Plant (plantId)
);


CREATE TABLE PLANT(
	plantId			int						NOT NULL		AUTO_INCREMENT,
	division		varchar(64)				NOT NULL,
	class			varchar(64)				NOT NULL,
	`order`			varchar(64)				NOT NULL,
	family			varchar(64)				NOT NULL,
	genus			varchar(64)				NOT NULL,
	species			varchar(64)				NOT NULL,
	variety			varchar(64)				NOT NULL,
	isDeleted		bit						NOT NULL		DEFAULT 0,
	PRIMARY KEY (plantId)
)
