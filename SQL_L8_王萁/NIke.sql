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
insert Type (TypeName)values('鞋类'),('服装'),('装备')
insert Type (TypeName,ParentID)values ('篮球鞋',1),('足球鞋',1),('跑步鞋',1),('外套',2),('T恤',2)
insert Goods (BarCode,TypeID,GoodsName,StorePrice,SalePrice,Discount,StockNum,StockDate)
values  ('212312',4,'ZOOM HYPERFRANCHESE男子篮球鞋',550,1099,0.85,40,'2013-06-27'),
		('423423',4,'JORDAN XOURT AC.1男子篮球鞋',42,649,1,30,'2013-06-27'),
		('423465',5,'BOMBAII男子足球鞋',330,529,0.9,25,'2013-06-27'),
		('545334',5,'MERCURIAL VELOCE AG 男子足球鞋',999,1099,0.9,19,'2013-06-27'),
		('364643',6,'FERR5.0+男子跑步鞋',518,869,0.8,45,'2013-06-27'),
		('553311',6,'LUNARGLIDE+4男子跑步鞋',481,969,0.88,29,'2013-06-27')
insert Salesman (SalesmanName,Mobile,Pwd,Gender,Wage,CommissionRate,Role)
values	('韩树青','13912345678','A123','男',1800,0.02,'导航员'),
		('张晓静','13812345555','B456','女',2900,0.02,'店长'),
		('刘小慧','15912345678','C789','女',1800,0.02,'导航员'),
		('李春波','13625718726','D789','女',2000,0.01,'收银员')
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
--查询类型名为篮球鞋的产品信息
select Goods.* from Type,Goods where Type.TypeID=Goods.TypeID and Type.TypeName='篮球鞋'

--查询足球鞋单价在600~1000之间的产品信息
select Goods.* from Type,Goods where Type.TypeID=Goods.TypeID and Type.TypeName='足球鞋'and SalePrice between 600 and 1000

--统计不同类型的产品数量，单件产品的最低进货价和最高销售毛利
select TypeID,sum(StockNum)产品数量,min(StorePrice)最低进货价,max(SalePrice-StorePrice)最高销售毛利 from Goods group by TypeID

--显示产品类型名及其上级产品类型名
select t1.TypeName 产品类型名,t2.TypeName 上级产品类型名 from type t1 join Type t2 on t1.ParentID=t2.TypeID

--计算销售账单的销售金额，并按销售金额升序排列
select SalesID,sum(Goods.SalePrice*Goods.Discount*SalesDetail.Quantity) 销售金额 from Goods join SalesDetail on Goods.GoodsID=SalesDetail.GoodsID
group by SalesID
order by 销售金额

--查询店员韩树青的销售账单信息，显示销售单编号，销售日期，销售金额和营业员姓名
select SalesID 销售单编号,SalesDate 销售日期,SalesmanName 营业员姓名  from Salesman join Sales on Salesman.SalesmanID=Sales.SalesmanID where Salesman.SalesmanName='韩树青'

--统计每天产品销售的数量
select SalesDate 销售日期,sum(Quantity)销售数量 from Sales join SalesDetail on Sales.SalesID=SalesDetail.SalesID group by SalesDate
select * from Type