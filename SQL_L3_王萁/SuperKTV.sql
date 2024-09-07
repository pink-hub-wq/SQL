
use SuperKTV
go
--��Ӹ�����������
insert Type (TypeName)values('��������'),('�����ϸ�'),('Ӱ�ӽ���'),('����'),('ҡ��')
--��ѯ������������
select TypeID as '���ͱ��(�Զ�����)',TypeName as ������������  from Type
--��Ӹ�������
insert Singer (SingerName,SingerType,Birthday,Area,PhotoPath)
values ('���һ','Ů','1944-11-10','��½','���һ.jpg'),
	   ('����','Ů','1957-12-12','̨��','����.jpg'),
	   ('������','��','1967-03-26','̨��','������.jpg'),
	   ('Ѧ֮ǫ','��','1983-07-17','��½','Ѧ֮ǫ.jpg'),
	   ('����','��','1979-12-14','��½','����.jpg'),
	   ('����ͬ','��','1983-07-14','���','����ͬ.jpg'),
	   ('����ʫ','Ů','1977-05-10','���','����ʫ.jpg'),
	   ('�ܽ���(JAY)','��','1979-01-18','̨��','�ܽ���jpg'),
	   ('�Ź���','��','1956-09-12','���','�Ź���jpg'),
	   ('������','��','1955-07-17','̨��','������.jpg'),
	   ('�մ���','���','1983-07-17','̨��','�մ���jpg'),
	   ('SHE','���','1983-07-17','̨��','SHE.jpg'),
	   ('������','Ů','1980-09-15','̨��','������.jpg'),
	   ('����к�','���','1983-07-17','ŷ��','����к�.jpg'),
	   ('Michael Jackson','��','1958-08-29','ŷ��','Michael Jackson.jpg'),
	   ('Avril Ramona Lavigne','Ů','1984-09-27','ŷ��','Avril Ramona Lavigne.jpg'),
	   ('super junior','���','1983-07-17','�պ�','super junior.jpg'),
	   ('��������','���','1983-07-17','�պ�','��������.jpg'),
	   ('��ѧ��','��','1961-07-10','���','��ѧ��jpg')
--��ѯ��������
select SingerID as '���(����)',SingerName ������,SingerType ����,Birthday ��������,Area ����,PhotoPath ������Ƭ from Singer
--��Ӹ�������
insert Song (Title,PingTitle,TypeID,SingerID,Hit,Url)
values  ('��˵','cs',1,4,44,'��˵.mp3'),
		('�˳�����','scmm',1,7,23,'�˳�����.mp3'),
		('super star','super star',1,12,15,'super star.mp3'),
		('�ջ�̨','jht',1,8,26,'�ջ�̨.mp3'),
		('ǧɽ��ˮ','qsws',1,8,19,'ǧɽ��ˮ.mp3'),
		('������','gbg',1,6,54,'������.mp3'),
		('�ڰ�','hb',1,6,34,'�ڰ�.mp3'),
		('Im so Blue','Im so Blue',1,15,2,'Im so Blue.mp3'),
		('������','zyj',1,11,10,'������,1.mp3'),
		('����ȵ�����ʹ','dnddwxt',2,19,9,'����ȵ�����ʹ.mp3'),
		('�˼��','rjd',3,19,5,'�˼��.mp3'),
		('��������','nwjx',2,1,8,'��������.mp3'),
		('���¼�ʱ��','myjsy',2,2,3,'���¼�ʱ��.mp3'),
		('����Ԫ����','tsymq',1,5,5,'����Ԫ����.mp3'),
		('ٻŮ�Ļ�','qnyh',3,9,2,'ٻŮ�Ļ�.mp3'),
		('һ��÷','yjm',3,10,4,'һ��÷.mp3'),
		('�¹�','yg',4,3,1,'�¹�.mp3'),
		('����һ����','ajygz',4,3,2,'����һ����.mp3')
--��ѯ��������
select SongID as '�������(����)',Title ������,PingTitle ����ƴ��,TypeID �������ͱ��,SingerID ���ֱ��,Hit as '������(Ĭ��ֵ0)',Url from Song
--��Ӿ�ˮСʳ������
insert Drinks(DrinksName,UnitPrice)
values	('ϲ��',18.00),
		('��ʿ��',20.00),
		('����',15.00),
		('���Ǹɺ�',88.00),
		('��÷',8.50),
		('���Ѹ�',12.50),
		('��Ƭ',7.50),
		('��צ',14.00),
		('���Ĺ�',20.00)
--��ѯ��ˮСʳ������
select DrinksID as '��ˮСʳ���(����)',DrinksName ��ˮСʳ��,UnitPrice as '����(Ԫ)' from Drinks
--��Ӿ�ˮСʳ���ѱ�����
insert Expense(ExpenseDate,DrinksID,Num)
values  ('2013-05-20',2,3),
		('2013-05-20',3,2),
		('2013-05-20',5,1),
		('2013-05-20',8,3)
--��ѯ��ˮСʳ���ѱ�����
select ExpenseID '��ˮ��(����)',ExpenseDate ��������,DrinksID ��ˮСʳ��,Num ���� from Expense
--���¸������ͱ�
update Type set TypeName='��Ϸ����' where TypeName='����'
--���¸������ͱ�
update Singer set SingerType='Ů',Birthday='1949-08-15' where SingerName='��������'
--ɾ��������Ϣ
delete from Singer where Area='�պ�'
--ɾ��������Ϣ
delete from Type where TypeName='��Ϸ����'
--�鿴������Ϣ
select * from Song where TypeID is null 
--���¾�ˮСʳ��
update Drinks set UnitPrice=78.00 where UnitPrice=88.00
--���¾�ˮСʳ���ѱ�����
update Expense set Num=6 where DrinksID=2
--ɾ�����Ǹɺ����ݽ���ˮ��Ϣ����Ϊnull
delete from Drinks where DrinksName='���Ǹɺ�'
--�鿴��ˮ���ѱ�(���Ǹɺ첻�ھ�ˮ���ѱ���)
select * from Expense  where DrinksID is null
--��ѯ�й���½�и�����Ϣ
select SingerID ���ֱ��,SingerName ��������,SingerType ��������,Area �������ڵ��� from Singer where SingerType='��' and Area='��½'
--��ʾ������������1980-1-1��̨��Ů����
select SingerID ���ֱ��,SingerName ��������,SingerType ��������,Area �������ڵ���,PhotoPath ͼƬ from Singer where SingerType='Ů'and Area='̨��'and Birthday>'1980-01-01'
--��ʾŷ������۸���
select SingerID ���ֱ��,SingerName ��������,SingerType ��������,Area �������ڵ���,PhotoPath ͼƬ from Singer where Area='ŷ��'or(Area='���'and SingerType='Ů')
--��ʾ����ΪӰ�ӽ����ĸ�����Ϣ
select * from Type where TypeName='Ӱ�ӽ���'
select * from Song where TypeID=3
--��ʾ��½Ů�����ݳ��ĸ�����Ϣ
select * from Singer where Area='��½'and SingerType='Ů'
select * from Song where SingerID=1
--��ʾ��½������и����ݳ�������Ϊ���������С��ĸ�����Ϣ
select * from Type where TypeName='��������'
select * from Singer where (Area='��½'or Area='���')and SingerType='��'
select * from Song where TypeID=3 and (SingerID=4 or SingerID=5 or SingerID=6 or SingerID=9 or SingerID=19)
--����������������ʾ�и�����Ϣ
select * from Singer where SingerType='��'order by Birthday
--��ʾ������а���ǰ������Ϣ
select top 5 SongID �������,Title ��������,TypeID ���ͱ��,SingerID ���ֱ��,Hit ������ from Song order by Hit desc
--����������������,������������ʾ������Ϣ
select * from Song order by len(Title),Hit desc
--��ʾ��ˮСʳ��Ϣ����������������
select * from Drinks order by UnitPrice
--��ʾ2013-5-20����������ǰ�����ľ�ˮСʳ��Ϣ
select top 3 * from Expense where  ExpenseDate='2013-5-20' order by Num desc
select * from Drinks where DrinksID=2 or DrinksID=8 or DrinksID=3