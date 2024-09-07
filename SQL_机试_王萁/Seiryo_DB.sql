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
values	('��ζС��Ͱ������',54.00),
		('������������ײ�',35.50),
		('�ƽ����Ƿ��ײ�',37.50),
		('�㿾���ռ��ȷ��ײ�',37.50),
		('���Ģ���������ײ�',33.50),
		('��������',5.50)
insert S_Orders(OrderDate,GoodId, Quantity)
values  ('2016-06-02',1,1),
		('2016-06-02',2,2),
		('2016-06-03',1,2),
		('2016-06-03',3,3),
		('2016-06-03',4,4)
--1) ���һ����Ʒ��Ϣ����Ʒ����:Seiryo ����Ͱ����Ʒ�۸�:82.50��
insert S_Goods(GoodName,GoodPrice) values ('Seiryo ����Ͱ',82.50)

--2) ���һ��������Ϣ�����ڣ���ǰ���ڣ�����Ʒ��ţ�id Ϊ1����������2).
insert S_Orders(GoodId, Quantity)values (1,2)
	
-- 3) ɾ����Ʒ���Ϊ 6 ����Ʒ��
delete from S_Goods where GoodID=6

--4) ��������Ʒ���ۿ��޸�Ϊ�Ű��ۣ�0.98����Ʒ���Ϊ 3 �ĳ���
update S_Goods set Rebate=0.98 where GoodID!=3

--5) �޸���Ʒ���Ϊ 3 �ļ۸����Ϊ 29.80
update S_Goods set GoodPrice=29.8 where GoodID=3

--6) ��ѯ�۸���� 50 Ԫ����Ʒ����
select count(*) �۸����50Ԫ����Ʒ���� from S_Goods where GoodPrice>50 

--7) ��ѯ�۸��� 35 Ԫ�� 50 Ԫ֮�����Ʒ��Ϣ���ñ�����ʾ���ƣ��۸��ۿۣ����� 35��50Ԫ)
select GoodName ��Ʒ����,GoodPrice �۸�,Rebate �ۿ� from S_Goods where GoodPrice between 35 and 50  

--8) ͳ��ÿ����Ʒ�Ķ�������������������������������ʾ��Ʒ������������
select S_Goods.GoodName ��Ʒ��,sum(Quantity) �������� from S_Goods join S_Orders on S_Goods.GoodID=S_Orders.GoodId group by S_Goods.GoodName order by count(*)desc

--9) ͳ��ÿ���µ����ڵ������ܶ����������
select S_Orders.OrderDate ����,SUM(S_Orders.Quantity * S_Goods.GoodPrice * S_Goods.Rebate) �����ܶ� from S_Orders join S_Goods on S_Goods.GoodID=S_Orders.GoodId group by S_Orders.OrderDate order by �����ܶ� 

--10��ͳ�Ʊ��µ������������ʾ��Ʒ�����۳���������� 
select S_Goods.GoodName ��Ʒ��,sum(S_Orders.Quantity)�۳�����,SUM(S_Orders.Quantity * S_Goods.GoodPrice * S_Goods.Rebate) �����ܶ� from S_Goods join S_Orders on S_Goods.GoodID=S_Orders.GoodId
where year(S_Orders.OrderDate)=year(GETDATE())and month(S_Orders.OrderDate)=month(GETDATE())group by S_Goods.GoodName order by �۳����� DESC
