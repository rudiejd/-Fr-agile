
USE master
GO

IF DB_ID('PlantProDB') IS NOT NULL	DROP DATABASE PlantProDB
GO

CREATE DATABASE PlantProDB
GO

USE [PlantProDB]

CREATE TABLE [User]( 
	userId		int				NOT NULL,
	email		varchar(30)		NOT NULL,
	password	varchar(30)		NOT NULL,
	firstName	varchar(30)		NOT NULL,
	lastName	varchar(30)		NOT NULL,
	location	point			NOT NULL,
	isDeleted	bit				NOT NULL,
	PRIMARY KEY (userId)
)

CREATE TABLE Comment(
	commentId			int				NOT NULL,
	userId				int				NOT NULL,
	plantSubmissionId	int				NOT NULL,
	body				varchar(120)	NOT NULL,
	date				date			NOT NULL,
	PRIMARY KEY (commentId),
	FOREIGN KEY (userId) REFERENCES [User] (userId),
	FOREIGN KEY (plantSubmissionId) REFERENCES PlantSubmission (plantSubmissionId)
) 

CREATE TABLE PlantSubmission(
	plantSubmissionId	int				NOT NULL, 
	userId				int				NOT NULL, 
	plantId				int				NOT NULL, 
	date				date			NOT NULL, 
	location			point			NOT NULL, 
	description			varchar(120)	NOT NULL,
	PRIMARY KEY (plantSubmissionId),
	FOREIGN KEY (userId) REFERENCES [User] (userId),
	FOREIGN KEY (plantId) REFERENCES Plant (plantId)
)

CREATE TABLE PLANT(
	plantId			int						NOT NULL,
	division		varchar(64)				NOT NULL,
	class			varchar(64)				NOT NULL,
	[order]			varchar(64)				NOT NULL,
	family			varchar(64)				NOT NULL,
	genus			varchar(64)				NOT NULL,
	species			varchar(64)				NOT NULL,
	variety			varchar(64)				NOT NULL,
	isDeleted		bit						NOT NULL,
	PRIMARY KEY (plantId)
)
