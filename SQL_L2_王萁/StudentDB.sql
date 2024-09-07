use master
go
if db_id('StudentDB')is not null
drop database StudentDB
go
create database StudentDB
go
use StudentDB
go
if OBJECT_ID('StudentInfo')is not null
drop table StudentInfo
go
create table StudentInfo(
	StuId char(10)primary key,
	StuName varchar(30)not null,
	StuSex varchar(4)not null default('��')check(StuSex='��'or StuSex='Ů'),
	StuAge int not null check(StuAge > 16 and StuAge < 30),
	StuTel varchar(11) not null check(len(StuTel)=7 or len(StuTel)=11),
	StuEmail varchar(100),
	StuAddress varchar(200)default('��ַ����ϸ')
)
go
if OBJECT_ID('CourseInfo')is not null
drop table CourseInfo
go
create table CourseInfo(
	CourseId int primary key identity(1,1),
	CourseName varchar(30)not null
)
go
if OBJECT_ID('ScoreInfo')is not null
drop table ScoreInfo
go
create table ScoreInfo(
	ScoreId int primary key identity(1,1),
	StuId char(10)not null foreign key(StuId)references StudentInfo(StuId),
	CourseId int not null foreign key(CourseId)references CourseInfo(CourseId),
	Score int not null default(0)
)
go
insert into StudentInfo(StuId,StuName,StuAge,StuTel,StuEmail,StuAddress)
values ('1','����',22,'1111111','1','�й�')
insert into CourseInfo(CourseName)
values ('��ѧ')
insert into CourseInfo(CourseName)
values ('Ӣ��')
insert into ScoreInfo(StuId,CourseId)
values ('1',1)