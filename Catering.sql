create table Hotels(
Id int IDENTITY(1,1) PRIMARY KEY,
HotelName nvarChar(100) NOT NULL,
Rating int CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
HotelLocation nvarchar(100) NOT NULL
)

create table Workers(
Id int IDENTITY(1,1) PRIMARY KEY,
HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
WorkerType nvarchar(20) NOT NULL CHECK(WorkerType = 'Janitor' OR WorkerType = 'Recepcionist' OR WorkerType = 'Room service'),
FirstName nvarchar(20) NOT NULL,
LastName nvarchar(20) NOT NULL,
Salary int NOT NULL,
Age int NOT NULL
)

create table Rooms(
Id int IDENTITY(1,1) PRIMARY KEY,
HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
NumberOfBeds int NOT NULL,
RoomNumber int NOT NULL
)

create table Buyers(
Id int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(20) NOT NULL,
LastName nvarchar(20) NOT NULL,
PhoneNumber nvarchar(20) NOT NULL,
OIB nvarchar(30) NOT NULL
)

create table Stays(
Id int IDENTITY(1,1) PRIMARY KEY,
TimeOfStay DateTime2 NOT NULL,
TimeOfDepart DateTime2,
TypeOfStay nvarchar(50) CHECK(TypeOfStay = 'Pansion' OR TypeOfStay = 'Half pansion' OR TypeOfStay = 'Regular') NOT NULL,
Price int NOT NULL,
RoomId int FOREIGN KEY REFERENCES Rooms(Id) NOT NULL,
BuyerId int FOREIGN KEY REFERENCES Buyers(Id) NOT NULL
)

create table Visitors(
Id int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(20) NOT NULL,
LastName nvarchar(20) NOT NULL,
PhoneNumber nvarchar(20) NOT NULL
)

create table VisitorStays(
VisitorId int FOREIGN KEY REFERENCES Visitors(Id) NOT NULL,
StayId int FOREIGN KEY REFERENCES Stays(Id) NOT NULL,
CONSTRAINT VisitorStaysPrimaryKey PRIMARY KEY(VisitorId,StayId)
)

--

insert into Hotels (HotelName,Rating,HotelLocation) VALUES
('Plaza',5,'Split'),
('Hilton',2,'Zagreb'),
('Holiday',4,'Rijeka'),
('Hotel Name',1,'Rim'),
('Raddison',3,'London')

--

insert into Workers (WorkerType,FirstName,LastName,Salary,Age,HotelId) VALUES
('Janitor','Mate','Matić',4000,29,1),
('Room service','Ivo','Ivić',5000,40,2),
('Recepcionist','Ante','Antić',5000,40,3),
('Room service','Teo','Teovski',5000,40,5),
('Janitor','Stipe','Stipić',5000,40,4)

--

insert into Rooms (NumberOfBeds,HotelId,RoomNumber) VALUES
(2,1,3),
(1,1,45),
(2,1,176),
(4,1,623),
(2,3,123),
(3,5,423),
(1,4,323),
(1,2,223)

--

insert into Buyers (FirstName,LastName,PhoneNumber,OIB) VALUES
('Ivan','Ivić','30219830','312567321'),
('Ante','Antić','0943321','31287653321'),
('Stipe','Stipić','09842342321','3131221'),
('Marko','Markić','09814321','3121233321'),
('Šime','Šimić','09812342','31213321')

--

insert into Stays (TimeOfStay,TimeOfDepart,TypeOfStay,Price,RoomId,BuyerId) VALUES
('2020-5-1',NULL,'Pansion',4000,1,5),
('2020-5-5',NULL,'Half pansion',2000,1,5),
('2020-5-3',NULL,'Pansion',1400,1,5),
(GETDATE(),NULL,'Pansion',6000,1,5),
(GETDATE(),NULL,'Half pansion',2000,3,4),
(GETDATE(),NULL,'Pansion',5000,2,3),
(GETDATE(),NULL,'Regular',1000,5,2),
('2019-12-3','2020-12-1','Regular',800,4,1)

--

insert into Visitors (FirstName,LastName,PhoneNumber) VALUES
('Nika','Nikić','4230089'),
('Maura','Maurić','43234254'),
('Luka','Lukić','645654'),
('Roko','Rokić','8766854'),
('Vana','Vanić','35443533')

--

insert into VisitorStays (VisitorId,StayId) VALUES
(1,2),
(2,4),
(3,5),
(4,3),
(1,1)

--

select * from Rooms
WHERE HotelId IN (SELECT Id FROM Hotels Where HotelName ='Plaza')

--

select * from Rooms where RoomNumber LIKE '1%'

--

select FirstName,LastName from Workers where WorkerType = 'Janitor'

--

select * from Stays where Price >= 1000 AND TimeOfStay >= '2020-12-1'

--

select * from Stays where TimeOfDepart IS NULL

--

delete from Stays where TimeOfStay <= '2020-1-1'

--

update Rooms SET NumberOfBeds = 4 WHERE NumberOfBeds = 3 AND HotelId = 2

--

select * from Stays where RoomId = 1 ORDER BY TimeOfStay Asc

--

select * from Stays
where (TypeOfStay = 'Pansion' OR TypeOfStay = 'Half pansion')
AND RoomId IN (SELECT Id FROM Rooms Where HotelId IN (SELECT Id FROM Hotels WHere HotelName = 'Plaza'))
order by Price asc

--

select * from Workers
update Workers SET WorkerType = 'Recepcionist' WHERE Id = 4 OR Id = 2