use master
go
if db_id('Nike')is not null
drop database Nike
go
create database Nike
go
use Nike
go
if OBJECT_ID('Type')is not null
drop table Type
go
create table Type(
	TypeID int primary key identity(1,1),
	TypeName nvarchar(50)not null,
	ParentID int foreign key (ParentID) references Type(TypeID)
)
go
if OBJECT_ID('Goods')is not null
drop table Goods
go
create table Goods(
	GoodsID int primary key identity(1,1),
	BarCode nvarchar(6)not null unique,
	TypeID int not null foreign key (TypeID) references Type(TypeID),
	GoodsName nvarchar(50)not null,
	StorePrice decimal(8,2),
	SalePrice decimal(8,2),
	Discount decimal(4,2)not null default 1,
	StockNum int,
	StockDate datetime default getdate()
)
if OBJECT_ID('Salesman')is not null
drop table Salesman
go
create table Salesman(
	SalesmanID int primary key identity(1,1),
	SalesmanName nvarchar(10)not null,
	Mobile nvarchar(20)not null unique,
	Pwd nvarchar(20)not null,
	Gender nvarchar(2)not null,
	Wage Decimal(8,2),
	CommissionRate Decimal(8,2),
	Role nvarchar(20)
)
if OBJECT_ID('Sales')is not null
drop table Sales
go
create table Sales(
	SalesID int primary key identity(1,1),
	ReceiptsCode nvarchar(14)unique,
	SalesDate date not null default getdate(),
	Amount Decimal(8,2),
	SalesmanID int foreign key (SalesmanID) references Salesman(SalesmanID),
	CashierID int foreign key (CashierID) references Salesman(SalesmanID) 
)
if OBJECT_ID('SalesDetail')is not null
drop table SalesDetail
go
create table SalesDetail(
	SDID int primary key identity(1,1),
	SalesID int not null foreign key(SalesID)references Sales(SalesID),
	GoodsID int not null foreign key(GoodsID)references Goods(GoodsID),
	Quantity int not null
)
insert Type (TypeName)values('Ь��'),('��װ'),('װ��')
insert Type (TypeName,ParentID)values ('����Ь',1),('����Ь',1),('�ܲ�Ь',1),('����',2),('T��',2)
insert Goods (BarCode,TypeID,GoodsName,StorePrice,SalePrice,Discount,StockNum,StockDate)
values  ('212312',4,'ZOOM HYPERFRANCHESE��������Ь',550,1099,0.85,40,'2013-06-27'),
		('423423',4,'JORDAN XOURT AC.1��������Ь',42,649,1,30,'2013-06-27'),
		('423465',5,'BOMBAII��������Ь',330,529,0.9,25,'2013-06-27'),
		('545334',5,'MERCURIAL VELOCE AG ��������Ь',999,1099,0.9,19,'2013-06-27'),
		('364643',6,'FERR5.0+�����ܲ�Ь',518,869,0.8,45,'2013-06-27'),
		('553311',6,'LUNARGLIDE+4�����ܲ�Ь',481,969,0.88,29,'2013-06-27')
insert Salesman (SalesmanName,Mobile,Pwd,Gender,Wage,CommissionRate,Role)
values	('������','13912345678','A123','��',1800,0.02,'����Ա'),
		('������','13812345555','B456','Ů',2900,0.02,'�곤'),
		('��С��','15912345678','C789','Ů',1800,0.02,'����Ա'),
		('���','13625718726','D789','Ů',2000,0.01,'����Ա')
insert Sales (ReceiptsCode,SalesDate,SalesmanID,CashierID)
values  ('20130626121','2013-06-21',2,4),
		('20130626122','2013-06-22',3,4),
		('20130626123','2013-06-23',1,4),
		('20130626124','2013-06-24',1,4),
		('20130626125','2013-06-25',3,4),
		('20130626126','2013-06-26',2,4),
		('20130626127','2013-06-27',1,4),
		('20130626128','2013-06-28',1,4),
		('20130626129','2013-06-29',1,4)
insert SalesDetail(SalesID,GoodsID,Quantity)
values	(1,2,3),(1,4,2),(3,1,2),(3,5,1),(3,3,2),(2,4,2),(3,2,2),
		(4,1,2),(4,3,1),(7,2,1),(7,3,2),(8,4,3),(9,2,1),(9,4,2)
--��ѯ������Ϊ����Ь�Ĳ�Ʒ��Ϣ
select Goods.* from Type,Goods where Type.TypeID=Goods.TypeID and Type.TypeName='����Ь'

--��ѯ����Ь������600~1000֮��Ĳ�Ʒ��Ϣ
select Goods.* from Type,Goods where Type.TypeID=Goods.TypeID and Type.TypeName='����Ь'and SalePrice between 600 and 1000

--ͳ�Ʋ�ͬ���͵Ĳ�Ʒ������������Ʒ����ͽ����ۺ��������ë��
select TypeID,sum(StockNum)��Ʒ����,min(StorePrice)��ͽ�����,max(SalePrice-StorePrice)�������ë�� from Goods group by TypeID

--��ʾ��Ʒ�����������ϼ���Ʒ������
select t1.TypeName ��Ʒ������,t2.TypeName �ϼ���Ʒ������ from type t1 join Type t2 on t1.ParentID=t2.TypeID

--���������˵������۽��������۽����������
select SalesID,sum(Goods.SalePrice*Goods.Discount*SalesDetail.Quantity) ���۽�� from Goods join SalesDetail on Goods.GoodsID=SalesDetail.GoodsID
group by SalesID
order by ���۽��

--��ѯ��Ա������������˵���Ϣ����ʾ���۵���ţ��������ڣ����۽���ӪҵԱ����
select SalesID ���۵����,SalesDate ��������,SalesmanName ӪҵԱ����  from Salesman join Sales on Salesman.SalesmanID=Sales.SalesmanID where Salesman.SalesmanName='������'

--ͳ��ÿ���Ʒ���۵�����
select SalesDate ��������,sum(Quantity)�������� from Sales join SalesDetail on Sales.SalesID=SalesDetail.SalesID group by SalesDate
select * from Type