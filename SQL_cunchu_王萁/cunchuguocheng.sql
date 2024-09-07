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
	EmpSex  char(2)check (EmpSex='��'or EmpSex='Ů'),
	EmpAge  int check (EmpAge between 20 and 60),
	DeptID  int foreign key (DeptID) references DeptInfo (DeptID) 		
)
insert DeptInfo(DeptId,DeptName)
values  (1,'������'),
		(2,'���²�')
insert EmpInfo(EmpID,EmpName,EmpDuty,EmpSex,EmpAge,DeptID)
values  (1001,'����','Ա��','��',26,1),
		(1002,'����','Ա��','Ů',31,1),
		(1003,'����','���ž���','Ů',32,2),
		(1004,'����','���ž���','��',28,1),
		(1005,'����','Ա��','��',30,2) 
--1.��������
--Ϊ����߲�ѯԱ����Ϣ���ٶȣ��ش�Ҫ����Ա����Ϣ���е�Ա��������һ�д���һ���Ǿۼ�����IX_EmpName�������ܣ�ͬʱʹ�ø�������ѯ����
--����һ���Ǿۼ�����
drop index IX_EmpName on EmpInfo
go 
create nonclustered index IX_EmpName on EmpInfo(EmpName)
go
--��������Կ
drop master key
go 
create master key encryption by password='123'
go
--����֤��
drop certificate cert_Demo
go
create certificate cert_Demo with subject='Database Encryption Certificate'
go 
--�����Գ���Կ
drop symmetric key cert_Demo2
go
create symmetric key cert_Demo2 with algorithm=aes_256 encryption by certificate cert_Demo
go
--����һ�����У�������ܺ������
alter table EmpInfo drop column EmpName2
alter table EmpInfo add EmpName2 varbinary(max)
--����
open symmetric key cert_Demo2 DECRYPTION BY CERTIFICATE cert_Demo
update EmpInfo SET EmpName2 = EncryptByKey(Key_GUID('cert_Demo2'), EmpName)
close symmetric key cert_Demo2
--��ѯ
open symmetric key cert_Demo2 DECRYPTION BY CERTIFICATE cert_Demo
select * from EmpInfo
close symmetric key cert_Demo2
--2.����һ����ͼ
--��ѯ�������²����Ĳ��ž������Ϣ����ʾ��Ա����ţ�������ְ���Լ���������
drop view DeptInfoManager
go
create view DeptInfoManager as select EmpInfo.EmpID,EmpInfo.EmpName,EmpInfo.EmpDuty,DeptInfo.DeptName from DeptInfo,EmpInfo 
where DeptInfo.DeptId=EmpInfo.DeptID and DeptInfo.DeptName='���²�'and EmpInfo.EmpDuty='���ž���'
go
select * from DeptInfoManager
--3.�����洢����
--1�������洢���̣�����ָ����Ա����������ѯ����Ա���Ļ�����Ϣ����ʾ��Ա����ţ�������ְ��Ͳ������ƣ������øô洢����
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
exec a1 @empname='����'

--2�������洢���̣�����ָ����Ա�������Ͳ������ƣ���ѯ����Ӧ��Ա���Ļ�����Ϣ����ʾ��Ա����ţ�������ְ��Ͳ������ƣ������øô洢����
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
exec a2 @empname='����',@deptname='������'
--3�������洢���̣���Ա����Ϣ���в���һ��Ա����Ϣ��Ĭ�������Ա����ְ��Ϊ��Ա�������Ա�Ϊ���С��������øô洢��������в���һ��Ա����Ϣ
drop procedure a3
go
create procedure a3 
	@EmpID int,
	@empname varchar(20),
	@empage int
as
begin
	insert EmpInfo(EmpID,EmpName,EmpDuty,EmpSex,EmpAge)
	values(@EmpID,@EmpName,'Ա��','��',@EmpAge)
end
go
exec a3 @empname='����',@empage=36,@EmpID=1006

--4�������洢���̣�����ָ����Ա��������ѯ����Ա�����ڵĲ������ƣ����Ѹò�����Ϊ����������أ�Ȼ�������XXX���ڲ�������ΪXXX��
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
--��������
declare @deptname2 varchar(20)
exec a4 @empname='����',@deptname=@deptname2 output
print '�������ڵĲ�������Ϊ'+@deptname2
--5�������洢���̣��ֱ�������ŮԱ�������������ж���Ա���໹��ŮԱ���࣬���жϽ�����ز����
drop procedure a5
go
create procedure a5 
as
begin
	declare @mancount int,@womancount int
	select @mancount=count(*) from EmpInfo where EmpSex='��'
	select @mancount=count(*) from EmpInfo where EmpSex='Ů'
	if @mancount>@womancount
		select '��Ա����'
	else if @mancount<@womancount
		select 'ŮԱ����'
	else
		select '��ŮԱ���������'
end
go
exec a5




