
use SuperKTV
go
--添加歌曲类型数据
insert Type (TypeName)values('热门流行'),('经典老歌'),('影视金曲'),('动漫'),('摇滚')
--查询歌曲类型数据
select TypeID as '类型编号(自动增长)',TypeName as 歌曲类型名称  from Type
--添加歌手数据
insert Singer (SingerName,SingerType,Birthday,Area,PhotoPath)
values ('李谷一','女','1944-11-10','大陆','李谷一.jpg'),
	   ('蔡琴','女','1957-12-12','台湾','蔡琴.jpg'),
	   ('张信哲','男','1967-03-26','台湾','张信哲.jpg'),
	   ('薛之谦','男','1983-07-17','大陆','薛之谦.jpg'),
	   ('后弦','男','1979-12-14','大陆','后弦.jpg'),
	   ('方大同','男','1983-07-14','香港','方大同.jpg'),
	   ('何韵诗','女','1977-05-10','香港','何韵诗.jpg'),
	   ('周杰伦(JAY)','男','1979-01-18','台湾','周杰伦jpg'),
	   ('张国荣','男','1956-09-12','香港','张国荣jpg'),
	   ('费玉清','男','1955-07-17','台湾','费玉清.jpg'),
	   ('苏打绿','组合','1983-07-17','台湾','苏打绿jpg'),
	   ('SHE','组合','1983-07-17','台湾','SHE.jpg'),
	   ('蔡依林','女','1980-09-15','台湾','蔡依林.jpg'),
	   ('后街男孩','组合','1983-07-17','欧美','后街男孩.jpg'),
	   ('Michael Jackson','男','1958-08-29','欧美','Michael Jackson.jpg'),
	   ('Avril Ramona Lavigne','女','1984-09-27','欧美','Avril Ramona Lavigne.jpg'),
	   ('super junior','组合','1983-07-17','日韩','super junior.jpg'),
	   ('东方神起','组合','1983-07-17','日韩','东方神起.jpg'),
	   ('张学友','男','1961-07-10','香港','张学友jpg')
--查询歌手数据
select SingerID as '编号(自增)',SingerName 歌手名,SingerType 类型,Birthday 出生年月,Area 地区,PhotoPath 歌手相片 from Singer
--添加歌曲数据
insert Song (Title,PingTitle,TypeID,SingerID,Hit,Url)
values  ('传说','cs',1,4,44,'传说.mp3'),
		('伤城秘密','scmm',1,7,23,'伤城秘密.mp3'),
		('super star','super star',1,12,15,'super star.mp3'),
		('菊花台','jht',1,8,26,'菊花台.mp3'),
		('千山万水','qsws',1,8,19,'千山万水.mp3'),
		('够不够','gbg',1,6,54,'够不够.mp3'),
		('黑白','hb',1,6,34,'黑白.mp3'),
		('Im so Blue','Im so Blue',1,15,2,'Im so Blue.mp3'),
		('在遇见','zyj',1,11,10,'在遇见,1.mp3'),
		('等你等到我心痛','dnddwxt',2,19,9,'等你等到我心痛.mp3'),
		('人间道','rjd',3,19,5,'人间道.mp3'),
		('难忘今宵','nwjx',2,1,8,'难忘今宵.mp3'),
		('明月几时有','myjsy',2,2,3,'明月几时有.mp3'),
		('唐宋元明清','tsymq',1,5,5,'唐宋元明清.mp3'),
		('倩女幽魂','qnyh',3,9,2,'倩女幽魂.mp3'),
		('一剪梅','yjm',3,10,4,'一剪梅.mp3'),
		('月光','yg',4,3,1,'月光.mp3'),
		('爱就一个字','ajygz',4,3,2,'爱就一个字.mp3')
--查询歌曲数据
select SongID as '歌曲编号(自增)',Title 歌曲名,PingTitle 歌曲拼音,TypeID 歌曲类型编号,SingerID 歌手编号,Hit as '点歌次数(默认值0)',Url from Song
--添加酒水小食表数据
insert Drinks(DrinksName,UnitPrice)
values	('喜力',18.00),
		('嘉士伯',20.00),
		('百威',15.00),
		('长城干红',88.00),
		('话梅',8.50),
		('葡萄干',12.50),
		('薯片',7.50),
		('鸡爪',14.00),
		('开心果',20.00)
--查询酒水小食表数据
select DrinksID as '酒水小食编号(自增)',DrinksName 酒水小食名,UnitPrice as '单价(元)' from Drinks
--添加酒水小食消费表数据
insert Expense(ExpenseDate,DrinksID,Num)
values  ('2013-05-20',2,3),
		('2013-05-20',3,2),
		('2013-05-20',5,1),
		('2013-05-20',8,3)
--查询酒水小食消费表数据
select ExpenseID '流水号(自增)',ExpenseDate 消费日期,DrinksID 酒水小食名,Num 数量 from Expense
--更新歌曲类型表
update Type set TypeName='游戏动漫' where TypeName='动漫'
--更新歌手类型表
update Singer set SingerType='女',Birthday='1949-08-15' where SingerName='东方神起'
--删除歌手信息
delete from Singer where Area='日韩'
--删除歌曲信息
delete from Type where TypeName='游戏动漫'
--查看歌曲信息
select * from Song where TypeID is null 
--更新酒水小食表
update Drinks set UnitPrice=78.00 where UnitPrice=88.00
--更新酒水小食消费表数据
update Expense set Num=6 where DrinksID=2
--删除长城干红数据将酒水信息设置为null
delete from Drinks where DrinksName='长城干红'
--查看酒水消费表(长城干红不在酒水消费表中)
select * from Expense  where DrinksID is null
--查询中国大陆男歌手信息
select SingerID 歌手编号,SingerName 歌手姓名,SingerType 歌手类型,Area 歌手所在地区 from Singer where SingerType='男' and Area='大陆'
--显示出生年月晚于1980-1-1的台湾女歌手
select SingerID 歌手编号,SingerName 歌手姓名,SingerType 歌手类型,Area 歌手所在地区,PhotoPath 图片 from Singer where SingerType='女'and Area='台湾'and Birthday>'1980-01-01'
--显示欧美及香港歌手
select SingerID 歌手编号,SingerName 歌手姓名,SingerType 歌手类型,Area 歌手所在地区,PhotoPath 图片 from Singer where Area='欧美'or(Area='香港'and SingerType='女')
--显示类型为影视金曲的歌曲信息
select * from Type where TypeName='影视金曲'
select * from Song where TypeID=3
--显示大陆女歌手演唱的歌曲信息
select * from Singer where Area='大陆'and SingerType='女'
select * from Song where SingerID=1
--显示大陆和香港男歌手演唱的类型为“热门流行”的歌曲信息
select * from Type where TypeName='热门流行'
select * from Singer where (Area='大陆'or Area='香港')and SingerType='男'
select * from Song where TypeID=3 and (SingerID=4 or SingerID=5 or SingerID=6 or SingerID=9 or SingerID=19)
--按出生年月升序显示男歌手信息
select * from Singer where SingerType='男'order by Birthday
--显示点歌排行榜中前五名信息
select top 5 SongID 歌曲编号,Title 歌曲名称,TypeID 类型编号,SingerID 歌手编号,Hit 点歌次数 from Song order by Hit desc
--按歌曲名长度升序,点歌次数降序显示歌曲信息
select * from Song order by len(Title),Hit desc
--显示酒水小食信息，按单价升序排列
select * from Drinks order by UnitPrice
--显示2013-5-20日消费数量前三名的酒水小食信息
select top 3 * from Expense where  ExpenseDate='2013-5-20' order by Num desc
select * from Drinks where DrinksID=2 or DrinksID=8 or DrinksID=3