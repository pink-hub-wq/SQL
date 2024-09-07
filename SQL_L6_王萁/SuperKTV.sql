use SuperKTV
go
--�����ֵ�������ͳ�Ƹ�������
select Area ���ֵ���,count(*) �������� from Singer group by Area

--���������ͺ͸��ֵ���ͳ�Ƹ�������
select Area ���ֵ���,SingerType ��������, count(*) �������� from Singer group by Area,SingerType

--ͳ�Ƹ�����������һ
select Area ���ֵ���,SingerType ��������, count(*) �������� from Singer group by Area,SingerType having count(*)>1

--��ͳ�����
select Area ���ֵ���,SingerType ��������, count(*) �������� from Singer group by Area,SingerType having count(*)>1 and SingerType not like '%���%'

--���ݸ������ͣ�ͳ�Ƹ�����
select TypeID ��������,count(*) ������ from Song group by TypeID 

--���ݸ��������ͺ͸��֣�ͳ�Ƹ����� 
select TypeID ��������,SingerID ����,count(*) ������ from Song group by TypeID,SingerID

--���ݸ��������ͺ͸��֣�ͳ�Ƹ���������1�ķ�����Ϣ
select TypeID ��������,SingerID ����,count(*) ������ from Song group by TypeID,SingerID having count(*)>1 

--���ݸ��������ͺ͸��֣�ͳ�Ƹ���������1�ķ�����Ϣ����Ӱ�ӽ��������������ͳ��
select * from Type where TypeName='Ӱ�ӽ���'
select TypeID ��������,SingerID ����,count(*) ������ from Song group by TypeID,SingerID having count(*)>1 and TypeID NOT LIKE 3

--��ѯ��ѧ�������ĸ�������Ҫ���г��������͸�����
select SingerName ������,Title ������ from Singer inner join Song on Singer.SingerID=Song.SingerID and SingerName='��ѧ��'

--ͳ��ÿλ���������ĸ�������Ҫ���г��������͸���������������������������
select SingerName ������,count(SongID) ������ from Singer join Song on Singer.SingerID=Song.SingerID 
group by SingerName
order by count(SongID)

--����ÿλ��������������������ܺ͡�Ҫ���г��������͸����ܵ�����������ܵ������������
select SingerName ������,sum(Hit) �ܵ���� from Singer join Song on Singer.SingerID=Song.SingerID
group by SingerName 
order by sum(Hit)

--�г�ÿλ��������������������ܺͳ���30��ͳ����Ϣ��Ҫ���г��������͸����ܵ�����������ܵ������������
select SingerName ������,sum(Hit) �ܵ���� from Singer join Song on Singer.SingerID=Song.SingerID
group by SingerName 
having sum(Hit)>30
order by sum(Hit)

--��ѯ�������и����ĸ�����
select * from Type where TypeName='��������'
select Title �������и����ĸ����� from Song join Type on Song.TypeID=Type.TypeID and Song.TypeID=1

--���ݸ���������ͳ�Ƹ�����������Ҫ���г������������ƣ���������������������
select TypeName ��������,count(SongID) �������� from Song join Type on Song.TypeID=Type.TypeID
group by Type.TypeName 
order by count(SongID) 

--����ÿһ��������ܵ������Ҫ���г������������ƣ������ܵ������������
select TypeName ��������,sum(Hit) �ܵ���� from Song join Type on Song.TypeID=Type.TypeID
group by Type.TypeName 
order by sum(Hit)

----����ÿһ��������ܵ��������30��ͳ����Ϣ������ûд���峬�����٣���Ҫ���г������������ƣ������ܵ������������
select TypeName ��������,sum(Hit) �ܵ���� from Song join Type on Song.TypeID=Type.TypeID
group by Type.TypeName 
having sum(Hit)>30
order by sum(Hit)