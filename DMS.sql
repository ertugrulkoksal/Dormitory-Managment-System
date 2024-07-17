CREATE TABLE Block( 
blockId int identity(1,1) NOT NULL PRIMARY KEY,
blockName varchar(10) NOT NULL UNIQUE,
numberOfMaterial int NOT NULL, 
numberOfStudents int NOT NULL,  
)


CREATE TABLE Room( 
roomId int identity(1,1) NOT NULL PRIMARY KEY,
blockName varchar(10) NOT NULL ,
roomNumber int NOT NULL UNIQUE,
typeofRoom varchar(15) NOT NULL,
numOfPerson int ,
numOfCabinet int NOT NULL,
numOfBed int NOT NULL,
FOREIGN KEY(blockName) REFERENCES Block(blockName),
)



CREATE TABLE Student( 
studentId int identity(1,1) NOT NULL PRIMARY KEY,
blockId int,
roomId int,
firstName nvarchar(50) NOT NULL,
lastName nvarchar(50) NOT NULL,
ssn varchar(11) NOT NULL UNIQUE,
collegeNumber varchar(20) NOT NULL UNIQUE,
phoneNumber varchar(20) NOT NULL UNIQUE,
emergencyId int NOT NULL,
parentId int NOT NULL,
birthDate datetime,
address varchar(200),
schollEmail varchar(70),
scholarshipRate varchar(5),
gender char(1),
amountOfPayment varchar(10),
formOfPayment varchar(10),
FOREIGN KEY(parentId) REFERENCES Parent(parentId),
FOREIGN KEY(emergencyId) REFERENCES EmergencyContact(emergencyId),
FOREIGN KEY(blockId) REFERENCES Block(blockId),
FOREIGN KEY(roomId) REFERENCES Room(roomId ),
)



CREATE TABLE Employee( 
employeeId int identity(1,1) NOT NULL PRIMARY KEY,
ssn varchar(11) NOT NULL UNIQUE,
firstName nvarchar(50) NOT NULL,
lastName nvarchar(50) NOT NULL,
phoneNumber varchar(20)NOT NULL UNIQUE,
workingArea varchar (20),
salary float NOT NULL,
birthDate datetime,
address varchar(200),
holidays int,
gender char(1),
)



CREATE TABLE EmergencyContact(
emergencyId int identity(1,1) NOT NULL PRIMARY KEY,
nameofEmergencyContact varchar(100) NOT NULL UNIQUE,
phoneNumber varchar(20)NOT NULL UNIQUE,
)



CREATE TABLE Parent(
parentId int identity(1,1) NOT NULL PRIMARY KEY,
firstName varchar(50) NOT NULL, 
lastName varchar(50) NOT NULL,
phoneNumber varchar(15) NOT NULL UNIQUE,
address varchar(200),
email varchar(25),
contactStudentSsn varchar(20) NOT NULL,
)


CREATE TABLE PublicArea( 
idOfMaterial int identity(1,1) NOT NULL PRIMARY KEY, 
priceOfMaterials int,
blockName varchar(10),
FOREIGN KEY(blockName) REFERENCES Block(blockName)
)



CREATE VIEW [femaleStudents] AS
SELECT studentId, firstName, lastName, collegeNumber, phoneNumber
FROM Student
WHERE gender= 'K';



CREATE VIEW [maleStudents] AS
SELECT studentId, firstName, lastName, collegeNumber, phoneNumber
FROM Student
WHERE gender= 'E';



CREATE PROCEDURE empProcedure @wArea varchar(50), @lName varchar(50)
AS
SELECT * FROM Employee WHERE workingArea = @wArea AND lastName = @lName

EXEC empProcedure @wArea= 'cleaner' ,@lName= 'Yýlmaz'; --example




CREATE trigger updateNumOfMaterails
on Room 
after insert
as 
begin
	declare @blockNamevarchar(10)
	declare @numofbed int
	declare @numofcabinet int
	select  @numofbed= numOfBed, @numofcabinet= numOfCabinet from inserted
	
	update Block
	set numberOfMaterial = numberOfMaterial + @numofbed +@numofcabinet	
	where blockName=@blockName
end;
