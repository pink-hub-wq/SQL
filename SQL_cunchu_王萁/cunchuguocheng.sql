use master
go
if DB_ID('cunchuguocheng')is not null
drop database cunchuguocheng
go
create database cunchuguocheng
go
use cunchuguocheng
go
if OBJECT_ID('DeptInfo')is not null
drop table DeptInfo
go
CREATE TABLE DeptInfo(
	DeptId int primary key,
	DeptName Varchar(20)not null 	
)
if OBJECT_ID('EmpInfo')is not null
drop table EmpInfo
go
CREATE TABLE EmpInfo(
	EmpID int primary key,
	EmpName Varchar(20) not null,
	EmpDuty Varchar(20) not null,
	EmpSex  char(2)check (EmpSex='男'or EmpSex='女'),
	EmpAge  int check (EmpAge between 20 and 60),
	DeptID  int foreign key (DeptID) references DeptInfo (DeptID) 		
)
insert DeptInfo(DeptId,DeptName)
values  (1,'技术部'),
		(2,'人事部')
insert EmpInfo(EmpID,EmpName,EmpDuty,EmpSex,EmpAge,DeptID)
values  (1001,'张三','员工','男',26,1),
		(1002,'李四','员工','女',31,1),
		(1003,'王五','部门经理','女',32,2),
		(1004,'赵六','部门经理','男',28,1),
		(1005,'马七','员工','男',30,2) 
--1.创建索引
--为了提高查询员工信息的速度，特此要求在员工信息表中的员工姓名这一列创建一个非聚集索引IX_EmpName，并加密，同时使用该索引查询数据
--创建一个非聚集索引
drop index IX_EmpName on EmpInfo
go 
create nonclustered index IX_EmpName on EmpInfo(EmpName)
go
--创建主密钥
drop master key
go 
create master key encryption by password='123'
go
--创建证书
drop certificate cert_Demo
go
create certificate cert_Demo with subject='Database Encryption Certificate'
go 
--创建对称密钥
drop symmetric key cert_Demo2
go
create symmetric key cert_Demo2 with algorithm=aes_256 encryption by certificate cert_Demo
go
--创建一个新列，保存加密后的数据
alter table EmpInfo drop column EmpName2
alter table EmpInfo add EmpName2 varbinary(max)
--更新
open symmetric key cert_Demo2 DECRYPTION BY CERTIFICATE cert_Demo
update EmpInfo SET EmpName2 = EncryptByKey(Key_GUID('cert_Demo2'), EmpName)
close symmetric key cert_Demo2
--查询
open symmetric key cert_Demo2 DECRYPTION BY CERTIFICATE cert_Demo
select * from EmpInfo
close symmetric key cert_Demo2
--2.创建一个视图
--查询出“人事部”的部门经理的信息，显示出员工编号，姓名，职务以及部门名称
drop view DeptInfoManager
go
create view DeptInfoManager as select EmpInfo.EmpID,EmpInfo.EmpName,EmpInfo.EmpDuty,DeptInfo.DeptName from DeptInfo,EmpInfo 
where DeptInfo.DeptId=EmpInfo.DeptID and DeptInfo.DeptName='人事部'and EmpInfo.EmpDuty='部门经理'
go
select * from DeptInfoManager
--3.创建存储过程
--1）创建存储过程，根据指定的员工姓名，查询出该员工的基本信息，显示出员工编号，姓名，职务和部门名称，并调用该存储过程
drop procedure a1
go
create procedure a1 
	@empname varchar(20)
as
begin
	select EmpInfo.EmpID,EmpInfo.EmpName,EmpInfo.EmpDuty,DeptInfo.DeptName from DeptInfo,EmpInfo
	where DeptInfo.DeptId=EmpInfo.DeptID and EmpInfo.EmpName=@empname
end
go 
exec a1 @empname='张三'

--2）创建存储过程，根据指定的员工姓名和部门名称，查询出相应的员工的基本信息，显示出员工编号，姓名，职务和部门名称，并调用该存储过程
drop procedure a2
go
create procedure a2 
	@empname varchar(20),
	@deptname varchar(20)
as
begin
	select EmpInfo.EmpID,EmpInfo.EmpName,EmpInfo.EmpDuty,DeptInfo.DeptName from DeptInfo,EmpInfo
	where DeptInfo.DeptId=EmpInfo.DeptID and EmpInfo.EmpName=@empname and DeptInfo.DeptName=@deptname
end
go 
exec a2 @empname='张三',@deptname='技术部'
--3）创建存储过程，向员工信息表中插入一条员工信息，默认情况下员工的职务为“员工”，性别为“男”，并调用该存储过程向表中插入一条员工信息
drop procedure a3
go
create procedure a3 
	@EmpID int,
	@empname varchar(20),
	@empage int
as
begin
	insert EmpInfo(EmpID,EmpName,EmpDuty,EmpSex,EmpAge)
	values(@EmpID,@EmpName,'员工','男',@EmpAge)
end
go
exec a3 @empname='刘八',@empage=36,@EmpID=1006

--4）创建存储过程，根据指定的员工姓名查询出该员工所在的部门名称，并把该部门作为输出参数返回，然后输出“XXX所在部门名称为XXX”
drop procedure a4
go
create procedure a4 
	@empname varchar(20),
	@deptname varchar(20)output
as
begin
	select @deptname=DeptInfo.DeptName from EmpInfo,DeptInfo
	where DeptInfo.DeptId=EmpInfo.DeptID and @empname=EmpInfo.EmpName 
end
go
--变量定义
declare @deptname2 varchar(20)
exec a4 @empname='张三',@deptname=@deptname2 output
print '张三所在的部门名称为'+@deptname2
--5）创建存储过程，分别计算出男女员工的人数，并判断男员工多还是女员工多，将判断结果返回并输出
drop procedure a5
go
create procedure a5 
as
begin
	declare @mancount int,@womancount int
	select @mancount=count(*) from EmpInfo where EmpSex='男'
	select @mancount=count(*) from EmpInfo where EmpSex='女'
	if @mancount>@womancount
		select '男员工多'
	else if @mancount<@womancount
		select '女员工多'
	else
		select '男女员工数量相等'
end
go
exec a5




