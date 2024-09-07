use master
go
if db_id('NetBar')is not null
drop database NetBar
go
create database NetBar
go
use NetBar
go
if OBJECT_ID('Card')is not null
drop table Card
go
create table Card(
	ID varchar(10)primary key,
	PassWord varchar(50)not null check(len(PassWord)>6),
	Balance int check(Balance>10),
	UserName varchar(50)
)
if OBJECT_ID('Computer')is not null
drop table Computer
go
create table Computer(
	ID varchar(10)primary key,
	OnUse varchar(1)not null,
	Note varchar(100)
)
if OBJECT_ID('Record')is not null
drop table Record
go
create table Record(
	ID int primary key,
	CardID varchar(10)not null foreign key(CardID)references Card(ID),
	ComputerID varchar(10)not null foreign key(ComputerID)references Computer(ID),
	BeginTime varchar(50),
	EndTime varchar(50),
	Fee numeric
)
