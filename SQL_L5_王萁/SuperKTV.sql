use SuperKTV
go
--��ʾ���ո�����Ϣ
select * from Singer where SingerName like '��%'
--��ʾ����������Ϊ�����ֵĸ���
select * from Singer where SingerName like '��__'
--��ʾ������30~40֮��ĸ�����Ϣ
select * from Singer where year(GETDATE())-year(Birthday) between 30 and 40
--��ʾ����Ϊŷ�����պ����ֵ���Ϣ�������޸��˲������ݣ�
select * from Singer where Area in ('ŷ��','�պ�')
--��ʾ��һ����ͷ�ĸ�����Ϣ
select * from Song where Title like 'һ%'
--��ʾ����������Ϊ4�ĸ�����Ϣ
select * from Song where LEN(Title)=4
--��ʾ�����ϸ��Ӱ�ӽ���������Ϣ
select * from Type where TypeName in ('�����ϸ�','Ӱ�ӽ���')
select * from Song where TypeID in (2,3)
--��ʾ��������30~60�ĸ�����Ϣ
select * from Song where Hit between 30 and 60
--��ѯ��̨��������������������С��Ů���ֵ�����
select max(Birthday)������С��̨Ů��������,min(Birthday)��������̨Ů�������� from Singer where SingerType='Ů'and Area in ('���','̨��')
--�����½�и���ƽ������
select YEAR(GETDATE())-YEAR(Birthday) ��½�и������� from Singer where SingerType='��'and Area='��½'
select AVG(YEAR(GETDATE())-YEAR(Birthday)) ��½�и���ƽ������ from Singer where SingerType='��'and Area='��½'
--ͳ�Ƹ�̨Ů��������
select COUNT(*)��̨Ů�������� from Singer where SingerType='Ů'and Area in ('���','̨��')
--���ܸ���������
select SUM(Hit) �ܵ����� from Song 
--��ѯ�ݳ��߱��Ϊ12�����ܻ�ӭ�����ĵ������
select max(Hit) �ݳ��߱��Ϊ12�����ܻ�ӭ�����ĵ������ from Song where SingerID=12
--��ѯ������Ϊ���������С�����ܻ�ӭ�����ĵ�����
select * from Type where TypeName='��������'
select min(Hit) as ������Ϊ�������е���ܻ�ӭ�����ĵ����� from Song where TypeID=1
--�������и�����ƽ��������
select avg(Hit) from Song
--�����������Ϊ�������ϸ衱�ĸ�������
select * from Type where TypeName='�����ϸ�'
select count(*) ��������Ϊ�����ϸ�ĸ������� from Song where TypeID=2