use easyShopping
go
--�޸ġ�����FD302�緹�ҡ�������Ʒ����Ϊ228.00Ԫ
update Goods set unitprice='228.00'where GoodsName='����FD302�緹��'

--ɾ��������FD302�緹�ҡ�
delete from Goods where GoodsName='����FD302�緹��'

--��ʾ���۴���100Ԫ����Ʒ��Ϣ������������������
select * from Goods where Unitprice>100 order by Unitprice

--��ʾ���۴���50Ԫ����Ʒ��Ϣ��������Ʒ�������򣬵��۽�������
select * from Goods where Unitprice>50 order by Category,Unitprice desc

--��ʾ������50~100Ԫ����Ʒ��Ϣ
select * from Goods where Unitprice between 50 and 100

--ͳ��ÿ����Ʒ��ƽ������,��ߵ��ۣ���͵���
select Category ��Ʒ����,avg(Unitprice)ƽ������,max(Unitprice)��ߵ���,min(Unitprice)��͵��� from Goods group by Category

--ͳ��ÿ����Ʒ��������һ�������ݣ���ʾ��Ʒ�����������
select Category ��Ʒ����,sum(Quantity) ��Ʒ���� from Goods join OrdersDetail on Goods.GoodsID=OrdersDetail.GoodsID group by Category   


--��ʾ�ͻ��ź�����������Ʒ��Ϣ����ʾ�ͻ�������Ʒ������Ʒ����
select CustomerName �ͻ���,GoodsName ��Ʒ��,Unitprice ��Ʒ���� from Customer,Goods,OrdersDetail,Orders where Customer.CustomerID=Orders.CustomerID and Orders.OrdersID=OrdersDetail.OrdersID and OrdersDetail.GoodsID=Goods.GoodsID and CustomerName='�ź���'

--��ʾ�ͻ��ź��������Ĳ�ͬ�������Ʒ�����������ʾ��Ʒ���ͼ���
select GoodsName ��Ʒ��,sum(Quantity) ���� from Customer,Goods,OrdersDetail,Orders where Customer.CustomerID=Orders.CustomerID and Orders.OrdersID=OrdersDetail.OrdersID and OrdersDetail.GoodsID=Goods.GoodsID and CustomerName='�ź���'
group by Category,GoodsName