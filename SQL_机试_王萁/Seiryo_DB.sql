use master
go
if DB_ID('Seiryo_DB')is not null
drop database Seiryo_DB
go
create database Seiryo_DB
go
use Seiryo_DB
go
if OBJECT_ID('S_Goods')is not null
drop table S_Goods
go
CREATE TABLE S_Goods
(GoodID int primary key identity(1,1), 
GoodName NVARCHAR(50)not null unique,
GoodPrice money, 
Rebate decimal(10,2)default 1 not null)
go
if OBJECT_ID('S_Orders')is not null
drop table S_Orders
go
CREATE TABLE S_Orders
(OrderID int primary key identity(1,1), 
OrderDate datetime default getdate(),
 GoodId int foreign key(GoodId)references S_Goods(GoodId),
 Quantity int )
go
insert S_Goods(GoodName,GoodPrice)
values	('五味小吃桶升级版',54.00),
		('培根鸡腿燕麦堡套餐',35.50),
		('黄金咖喱猪扒饭套餐',37.50),
		('香烤照烧鸡腿饭套餐',37.50),
		('培根蘑菇鸡柳饭套餐',33.50),
		('骨肉相连',5.50)
insert S_Orders(OrderDate,GoodId, Quantity)
values  ('2016-06-02',1,1),
		('2016-06-02',2,2),
		('2016-06-03',1,2),
		('2016-06-03',3,3),
		('2016-06-03',4,4)
--1) 添加一条商品信息：商品名称:Seiryo 土豪桶，商品价格:82.50。
insert S_Goods(GoodName,GoodPrice) values ('Seiryo 土豪桶',82.50)

--2) 添加一条订单信息：日期（当前日期），商品编号（id 为1），数量（2).
insert S_Orders(GoodId, Quantity)values (1,2)
	
-- 3) 删除商品编号为 6 的商品。
delete from S_Goods where GoodID=6

--4) 将所有商品的折扣修改为九八折（0.98）商品编号为 3 的除外
update S_Goods set Rebate=0.98 where GoodID!=3

--5) 修改商品编号为 3 的价格更改为 29.80
update S_Goods set GoodPrice=29.8 where GoodID=3

--6) 查询价格大于 50 元的商品数量
select count(*) 价格大于50元的商品数量 from S_Goods where GoodPrice>50 

--7) 查询价格在 35 元到 50 元之间的商品信息，用别名显示名称，价格，折扣（包含 35、50元)
select GoodName 商品名称,GoodPrice 价格,Rebate 折扣 from S_Goods where GoodPrice between 35 and 50  

--8) 统计每个商品的订单数量，并按订单数量降序排序，显示商品名，订单数量
select S_Goods.GoodName 商品名,sum(Quantity) 订单数量 from S_Goods join S_Orders on S_Goods.GoodID=S_Orders.GoodId group by S_Goods.GoodName order by count(*)desc

--9) 统计每个下单日期的销售总额，按升序排列
select S_Orders.OrderDate 日期,SUM(S_Orders.Quantity * S_Goods.GoodPrice * S_Goods.Rebate) 销售总额 from S_Orders join S_Goods on S_Goods.GoodID=S_Orders.GoodId group by S_Orders.OrderDate order by 销售总额 

--10）统计本月的销售情况，显示商品名，售出数量，金额 
select S_Goods.GoodName 商品名,sum(S_Orders.Quantity)售出数量,SUM(S_Orders.Quantity * S_Goods.GoodPrice * S_Goods.Rebate) 销售总额 from S_Goods join S_Orders on S_Goods.GoodID=S_Orders.GoodId
where year(S_Orders.OrderDate)=year(GETDATE())and month(S_Orders.OrderDate)=month(GETDATE())group by S_Goods.GoodName order by 售出数量 DESC
