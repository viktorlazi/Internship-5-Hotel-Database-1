create table Hotels(
Id int IDENTITY(1,1) PRIMARY KEY,
HotelName nvarChar(100) NOT NULL,
Rating int NOT NULL,
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

create table Capacities(
Id int IDENTITY(1,1) PRIMARY KEY,
NumberOfRooms int NOT NULL
)

create table Rooms(
Id int IDENTITY(1,1) PRIMARY KEY,
HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
CapacitiesId int FOREIGN KEY REFERENCES Capacities(Id) NOT NULL
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
TypeOfStay nvarchar(50) NOT NULL,
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

