create table Hotels(
Id int IDENTITY(1,1) PRIMARY KEY,
HotelName nvarChar(100) NOT NULL,
Rating int CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
HotelLocation nvarchar(100) NOT NULL
)

create table Workers(
Id int IDENTITY(1,1) PRIMARY KEY,
WorkerType nvarchar(20) NOT NULL CHECK(WorkerType = 'Janitor' OR WorkerType = 'Recepcionist' OR WorkerType = 'Room service'),
FirstName nvarchar(20) NOT NULL,
LastName nvarchar(20) NOT NULL,
Salary int NOT NULL,
Age int NOT NULL,
HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL
)

create table Rooms(
Id int IDENTITY(1,1) PRIMARY KEY,
HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
NumberOfBeds int NOT NULL
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
TypeOfStay nvarchar(50) CHECK(TypeOfStay = 'Pansion' OR TypeOfStay = 'Half pansion' OR TypeOfStay = 'Regular') NOT NULL,
Price int NOT NULL,
RoomsId int FOREIGN KEY REFERENCES Rooms(Id) NOT NULL,
BuyersId int FOREIGN KEY REFERENCES Buyers(Id) NOT NULL
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

insert into Rooms (NumberOfBeds,HotelId) VALUES
(4,1),
(2,3),
(3,5),
(1,4),
(1,2)

--

insert into Buyers (FirstName,LastName,PhoneNumber,OIB) VALUES
('Ivan','Ivić','30219830','312567321'),
('Ante','Antić','0943321','31287653321'),
('Stipe','Stipić','09842342321','3131221'),
('Marko','Markić','09814321','3121233321'),
('Šime','Šimić','09812342','31213321')

--

insert into Stays (TimeOfStay,TypeOfStay,Price,RoomsId,BuyersId) VALUES
(GETDATE(),'Pansion',6000,1,5),
(GETDATE(),'Half pansion',2000,3,4),
(GETDATE(),'Pansion',5000,2,3),
(GETDATE(),'Regular',1000,5,2),
(GETDATE(),'Regular',800,4,1)

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

