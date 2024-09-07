use easyShopping
go
--修改“美的FD302电饭煲”的是商品单价为228.00元
update Goods set unitprice='228.00'where GoodsName='美的FD302电饭煲'

--删除“美的FD302电饭煲”
delete from Goods where GoodsName='美的FD302电饭煲'

--显示单价大于100元的商品信息，并按单价升序排列
select * from Goods where Unitprice>100 order by Unitprice

--显示单价大于50元的商品信息，并按商品种类升序，单价降序排列
select * from Goods where Unitprice>50 order by Category,Unitprice desc

--显示单价在50~100元的商品信息
select * from Goods where Unitprice between 50 and 100

--统计每种商品的平均单价,最高单价，最低单价
select Category 商品种类,avg(Unitprice)平均单价,max(Unitprice)最高单价,min(Unitprice)最低单价 from Goods group by Category

--统计每种商品件数大于一件的数据，显示商品的种类与件数
select Category 商品种类,sum(Quantity) 商品件数 from Goods join OrdersDetail on Goods.GoodsID=OrdersDetail.GoodsID group by Category   


--显示客户张洪涛所购的商品信息，显示客户名，商品名，商品单价
select CustomerName 客户名,GoodsName 商品名,Unitprice 商品单价 from Customer,Goods,OrdersDetail,Orders where Customer.CustomerID=Orders.CustomerID and Orders.OrdersID=OrdersDetail.OrdersID and OrdersDetail.GoodsID=Goods.GoodsID and CustomerName='张洪涛'

--显示客户张洪涛所购的不同种类的商品及其件数，显示商品名和件数
select GoodsName 商品名,sum(Quantity) 件数 from Customer,Goods,OrdersDetail,Orders where Customer.CustomerID=Orders.CustomerID and Orders.OrdersID=OrdersDetail.OrdersID and OrdersDetail.GoodsID=Goods.GoodsID and CustomerName='张洪涛'
group by Category,GoodsName