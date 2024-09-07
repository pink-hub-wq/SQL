use master
go
if db_id('SuperKTV')is not null
drop database SuperKTV
go
create database SuperKTV
go
use SuperKTV
go
if object_id('Type')is not null
drop table Type
go
create table Type(
	TypeID int primary key identity(1,1),
	TypeName nvarchar(20)not null
)
go
if object_id('Singer')is not null
drop table Singer
go
create table Singer(
	SingerID int primary key identity(1,1),
	SingerName nvarchar(50)not null,
	SingerType nvarchar(10)not null check(SingerType='ÄÐ'or SingerType='Å®'or SingerType='×éºÏ'),
	Birthday date,
	Area nvarchar(50),
	PhotoPath nvarchar(200)
)
go
if object_id('Song')is not null
drop table Song
go
create table Song(
	SongID int primary key identity(1,1),
	Title nvarchar(50)not null,
	PingTitle varchar(20)not null,
	TypeID int foreign key(TypeID)references Type(TypeID),
	SingerID int foreign key(SingerID)references Singer(SingerID),
	Hit int default(0),
	Url nvarchar(200)
)
if object_id('Drinks')is not null
drop table Drinks
go
create table Drinks(
	DrinksID int primary key identity(1,1),
	DrinksName nvarchar(20) not null,
	UnitPrice decimal(10,2)
)
go
if object_id('Expense')is not null
drop table Expense
go
create table Expense(
	ExpenseID int primary key identity(1,1),
	ExpenseDate date default getDate(),
	DrinksID int foreign key(DrinksID)references Drinks(DrinksID),
	Num int
)
go

