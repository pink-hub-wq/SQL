use SuperKTV
go
--显示李姓歌手信息
select * from Singer where SingerName like '李%'
--显示蔡姓且姓名为三个字的歌手
select * from Singer where SingerName like '蔡__'
--显示年龄在30~40之间的歌手信息
select * from Singer where year(GETDATE())-year(Birthday) between 30 and 40
--显示地区为欧美和日韩歌手的信息（昨天修改了部分数据）
select * from Singer where Area in ('欧美','日韩')
--显示“一”开头的歌曲信息
select * from Song where Title like '一%'
--显示歌曲名长度为4的歌曲信息
select * from Song where LEN(Title)=4
--显示经典老歌和影视金曲歌曲信息
select * from Type where TypeName in ('经典老歌','影视金曲')
select * from Song where TypeID in (2,3)
--显示点歌次数在30~60的歌曲信息
select * from Song where Hit between 30 and 60
--查询港台歌手中年龄最大和年龄最小的女歌手的生日
select max(Birthday)年龄最小港台女歌手生日,min(Birthday)年龄最大港台女歌手生日 from Singer where SingerType='女'and Area in ('香港','台湾')
--计算大陆男歌手平均年龄
select YEAR(GETDATE())-YEAR(Birthday) 大陆男歌手年龄 from Singer where SingerType='男'and Area='大陆'
select AVG(YEAR(GETDATE())-YEAR(Birthday)) 大陆男歌手平均年龄 from Singer where SingerType='男'and Area='大陆'
--统计港台女歌手数量
select COUNT(*)港台女歌手数量 from Singer where SingerType='女'and Area in ('香港','台湾')
--汇总歌曲点歌次数
select SUM(Hit) 总点歌次数 from Song 
--查询演唱者编号为12的最受欢迎歌曲的点击次数
select max(Hit) 演唱者编号为12的最受欢迎歌曲的点击次数 from Song where SingerID=12
--查询类型名为“热门流行”的最不受欢迎歌曲的点歌次数
select * from Type where TypeName='热门流行'
select min(Hit) as 类型名为热门流行的最不受欢迎歌曲的点歌次数 from Song where TypeID=1
--计算所有歌曲的平均点歌次数
select avg(Hit) from Song
--计算歌曲类型为“经典老歌”的歌曲数量
select * from Type where TypeName='经典老歌'
select count(*) 歌曲类型为经典老歌的歌曲数量 from Song where TypeID=2