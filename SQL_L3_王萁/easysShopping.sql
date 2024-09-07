use master
go
if db_id('easyShopping')is not null
drop database easyShopping
go
create database easyShopping
go
use easyShopping
go
if OBJECT_ID('Goods')is not null
drop table Goods
go
create table Goods(
	GoodsID Int primary key identity(1,1),
	GoodsName Nvarchar(50)not null,
	Category Nvarchar(50),
	Unitprice Decimal(10,2)
)
go
if OBJECT_ID('Customer')is not null
drop table Customer
go
create table Customer(
	CustomerID int primary key identity(1,1),
	LoginID Nvarchar(50) not null,
	Pwd Nvarchar(50)not null,
	CustomerName Nvarchar(50)not null,
	IdentityID Nvarchar(18)not null,
	Address Nvarchar(50),
	Phone Nvarchar(50)
)
go
if OBJECT_ID('Orders')is not null
drop table Orders
go
create table Orders(
	OrdersID int primary key identity(1,1),
	OrdersDate date not null,
	Amount Decimal (10,2),
	CustomerID Int foreign key (CustomerID) references Customer(CustomerID),
	DeliveryDate Nvarchar(50) 
)
if OBJECT_ID('OrdersDetail')is not null
drop table OrdersDetail
go
create table OrdersDetail(
	OrdersID int primary key identity(1,1) foreign key(OrdersID)references Orders(OrdersID),
	GoodsID int not null foreign key(GoodsID)references Goods(GoodsID),
	Quantity int,
	Money Decimal (10,2)
)
insert Goods
values	('����ѡ����ǻۣ������','�鼮',18.50),
		('java��������̣������٣�','�鼮',52.60),
		('��̸�й��Ļ����ϻ�誣�','�鼮',13.00),
		('������FSW65R-5��ص����','�������',199.00),
		('������HD3035/05�緹��','�������',269.00),
		('����FD302�緹��','�������',248.00),
		('����KYT-2503̨ʽתҳ��','�������',88.00),
		('�����˹Yonex��ë����','������Ʒ',209.60),
		('NIKE����BB0361-823','������Ʒ',89.60),
		('��ͷTrain5��pu����TS011','������Ʒ',135.60 )
insert Customer
values	('abc111','111','��һ��','110227198001050134','�����г�������Դ��·14��','13901212345'),
		('abc222','222','������','110227198001059876','�����ж���������԰·16��','01062111234'),
		('abc333','333','������','110227198001059999','�����ж�������ֱ�Ŵ��2��','13501229678'),
		('abc444','444','�ź���','310104198407062657','�Ϻ������������·126��','1381892999'),
		('abc555','555','����ǿ','310110197507098723','�Ϻ��г���������·1548','1367164888'),
		('abc666','666','������','31010619841023426','�Ϻ��о��������·347','1391706777'),
		('abc777','777','������','420102197209022678','�人�н�������ͥ��67��','18774060972'),
		('abc888','888','���׻�','420111198511091278','�人�к�ɽ����ɽһ·45��','18662791254'),
		('abc999','999','������','450103197909111892','�人�н������ƼҴ�·5��','15926353456')
insert Orders
values	('2013-04-10',78.60,2,'2013-04-12'),
		('2013-05-16',702.20,5,'2013-05-19'),
		('2013-03-18',773.00,1,'2013-03-19'),
		('2013-04-12',1416.00,3,'2013-04-12'),
		('2013-04-10',264.00,4,'2013-04-12'),
		('2013-05-16',411.00,8,'2013-05-17'),
		('2013-03-18',509.00,7,'2013-03-21'),
		('2013-06-19',535.00,6,'2013-06-20'),
		('2013-04-12',290.00,9,'2013-04-13'),
		('2013-05-28',484.00,5,'2013-05-30'),
		('2013-03-08',656.20,2,'2013-03-09'),
		('2013-03-08',551.20,4,'2013-03-10'),
		('2013-03-08',431.80,2,'2013-03-09'),
		('2013-03-18',646.00,1,'2013-03-19'),
		('2013-04-10',435.00,4,'2013-04-13')
insert OrdersDetail(GoodsID,Quantity)
values	(3,2),(4,3),(2,1),(1,2),(3,2),
		(2,1),(3,2),(3,3),(3,2),(3,3),
		(2,2),(3,3),(1,2),(3,3),(1,2)
select * from Goods
select * from Customer
select * from Orders
select * from OrdersDetail

