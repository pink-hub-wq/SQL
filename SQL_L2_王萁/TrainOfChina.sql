use master
go
if DB_ID('TrainOfChina')is not null
drop database TrainOfChina
go
create database TrainOfChina
go
use TrainOfChina
go
if OBJECT_ID('TrainInfo') is not null
drop table TrainInfo
go
create table TrainInfo(
	TNumber varchar(16)primary key,
	TFrom varchar(20)not null,
	TDest varchar(20)not null,
	TDistance int,
	TStartTime varchar(50),
	TEndTime varchar(50),
	TDday int,
	TSpeed int not null,
	TUnitPrice money not null
)
if OBJECT_ID('TrainScheduler') is not null
drop table TrainScheduler
go
create table TrainScheduler(
	SNumber varchar(16)primary key foreign key(SNumber)references TrainInfo(TNumber),
	SDate varchar(50)not null,
	SConductor varchar(20),
	SSeatNumber int,
	SLieNumber int,
	SVisaNumber int
)