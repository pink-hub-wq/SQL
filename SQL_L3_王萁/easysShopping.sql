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
values	('从心选择的智慧（李开复）','书籍',18.50),
		('java面向对象编程（孙卫琴）','书籍',52.60),
		('漫谈中国文化（南怀瑾）','书籍',13.00),
		('艾美特FSW65R-5落地电风扇','生活电器',199.00),
		('飞利浦HD3035/05电饭煲','生活电器',269.00),
		('美的FD302电饭煲','生活电器',248.00),
		('格力KYT-2503台式转页扇','生活电器',88.00),
		('尤尼克斯Yonex羽毛球拍','体育用品',209.60),
		('NIKE篮球BB0361-823','体育用品',89.60),
		('火车头Train5号pu足球TS011','体育用品',135.60 )
insert Customer
values	('abc111','111','刘一鸣','110227198001050134','北京市朝阳区鑫源南路14号','13901212345'),
		('abc222','222','王传华','110227198001059876','北京市东城区番和园路16号','01062111234'),
		('abc333','333','张晓静','110227198001059999','北京市东城区东直门大街2号','13501229678'),
		('abc444','444','张洪涛','310104198407062657','上海市徐汇区大连路126号','1381892999'),
		('abc555','555','王永强','310110197507098723','上海市场浦区大连路1548','1367164888'),
		('abc666','666','张鹏飞','31010619841023426','上海市静安区大沽路347','1391706777'),
		('abc777','777','刘亚其','420102197209022678','武汉市江岸区洞庭区67号','18774060972'),
		('abc888','888','张兆辉','420111198511091278','武汉市洪山区关山一路45号','18662791254'),
		('abc999','999','王怀东','450103197909111892','武汉市江汉区唐家村路5号','15926353456')
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

