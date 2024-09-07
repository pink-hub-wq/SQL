use SuperKTV
go
--按歌手地区分组统计歌手人数
select Area 歌手地区,count(*) 歌手人数 from Singer group by Area

--按歌手类型和歌手地区统计歌手人数
select Area 歌手地区,SingerType 歌手类型, count(*) 歌手人数 from Singer group by Area,SingerType

--统计歌手人数大于一
select Area 歌手地区,SingerType 歌手类型, count(*) 歌手人数 from Singer group by Area,SingerType having count(*)>1

--不统计组合
select Area 歌手地区,SingerType 歌手类型, count(*) 歌手人数 from Singer group by Area,SingerType having count(*)>1 and SingerType not like '%组合%'

--根据歌曲类型，统计歌曲数
select TypeID 歌曲类型,count(*) 歌曲数 from Song group by TypeID 

--根据歌曲的类型和歌手，统计歌曲数 
select TypeID 歌曲类型,SingerID 歌手,count(*) 歌曲数 from Song group by TypeID,SingerID

--根据歌曲的类型和歌手，统计歌曲数大于1的分组信息
select TypeID 歌曲类型,SingerID 歌手,count(*) 歌曲数 from Song group by TypeID,SingerID having count(*)>1 

--根据歌曲的类型和歌手，统计歌曲数大于1的分组信息，但影视金曲类歌曲不参与统计
select * from Type where TypeName='影视金曲'
select TypeID 歌曲类型,SingerID 歌手,count(*) 歌曲数 from Song group by TypeID,SingerID having count(*)>1 and TypeID NOT LIKE 3

--查询张学友所唱的歌曲名，要求列出歌手名和歌曲名
select SingerName 歌手名,Title 歌曲名 from Singer inner join Song on Singer.SingerID=Song.SingerID and SingerName='张学友'

--统计每位歌手所唱的歌曲名，要求列出歌手名和歌曲数，并按歌曲数量升序排列
select SingerName 歌手名,count(SongID) 歌曲数 from Singer join Song on Singer.SingerID=Song.SingerID 
group by SingerName
order by count(SongID)

--计算每位歌手所唱歌曲点歌数的总和。要求列出歌手名和歌曲总点歌数，并按总点歌数升序排列
select SingerName 歌手名,sum(Hit) 总点歌数 from Singer join Song on Singer.SingerID=Song.SingerID
group by SingerName 
order by sum(Hit)

--列出每位歌手所唱歌曲点歌数的总和超过30的统计信息。要求列出歌手名和歌曲总点歌数，并按总点歌数升序排列
select SingerName 歌手名,sum(Hit) 总点歌数 from Singer join Song on Singer.SingerID=Song.SingerID
group by SingerName 
having sum(Hit)>30
order by sum(Hit)

--查询热门流行歌曲的歌曲名
select * from Type where TypeName='热门流行'
select Title 热门流行歌曲的歌曲名 from Song join Type on Song.TypeID=Type.TypeID and Song.TypeID=1

--根据歌曲的类型统计歌曲的数量，要求列出歌曲类型名称，并按歌曲数量升序排列
select TypeName 歌曲类型,count(SongID) 歌曲数量 from Song join Type on Song.TypeID=Type.TypeID
group by Type.TypeName 
order by count(SongID) 

--计算每一类歌曲的总点歌数，要求列出歌曲类型名称，并按总点歌数升序排列
select TypeName 歌曲类型,sum(Hit) 总点歌数 from Song join Type on Song.TypeID=Type.TypeID
group by Type.TypeName 
order by sum(Hit)

----计算每一类歌曲的总点歌数超过30的统计信息（书上没写具体超过多少），要求列出歌曲类型名称，并按总点歌数升序排列
select TypeName 歌曲类型,sum(Hit) 总点歌数 from Song join Type on Song.TypeID=Type.TypeID
group by Type.TypeName 
having sum(Hit)>30
order by sum(Hit)