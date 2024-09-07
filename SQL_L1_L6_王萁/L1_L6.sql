use master
go
if DB_ID('L1_L6')is not null
drop database L1_L6
go
create database L1_L6
go
use L1_L6
go
if OBJECT_ID('STUDENT')is not null
drop table STUDENT
go
CREATE TABLE STUDENT
(SNO VARCHAR(3) NOT NULL, 
SNAME VARCHAR(4) NOT NULL,
SSEX VARCHAR(2) NOT NULL, 
SBIRTHDAY DATETIME,
CLASS VARCHAR(5))
go
if OBJECT_ID('COURSE')is not null
drop table COURSE
go
CREATE TABLE COURSE
(CNO VARCHAR(5) NOT NULL, 
CNAME VARCHAR(10) NOT NULL, 
TNO VARCHAR(10) NOT NULL)
go
if OBJECT_ID('SCORE')is not null
drop table SCORE
go
CREATE TABLE SCORE 
(SNO VARCHAR(3) NOT NULL, 
CNO VARCHAR(5) NOT NULL, 
DEGREE NUMERIC(10, 1) NOT NULL) 
go
if OBJECT_ID('TEACHER')is not null
drop table TEACHER
go
CREATE TABLE TEACHER 
(TNO VARCHAR(3) NOT NULL, 
TNAME VARCHAR(4) NOT NULL, TSEX VARCHAR(2) NOT NULL, 
TBIRTHDAY DATETIME NOT NULL, PROF VARCHAR(6), 
DEPART VARCHAR(10) NOT NULL)

INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('108' ,'����'
,'��' ,'1977-09-01','95033');
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('105' ,'����'
,'��' ,'1975-10-02','95031');
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('107' ,'����'
,'Ů' ,'1976-01-23','95033');
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('101' ,'���'
,'��' ,'1976-02-20','95033');
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('109' ,'����'
,'Ů' ,'1975-02-10','95031');
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('103' ,'½��'
,'��' ,'1974-06-03','95031');
GO
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('3-105' ,'���������','825')
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('3-245' ,'����ϵͳ' ,'804');
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('6-166' ,'���ݵ�·' ,'856');
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('9-888' ,'�ߵ���ѧ' ,'100');
GO
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('103','3-245','86');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('105','3-245','75');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('109','3-245','68');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('103','3-105','92');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('105','3-105','88');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('109','3-105','76');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('101','3-105','64');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('107','3-105','91');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('108','3-105','78');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('101','6-166','85');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('107','6-106','79');
INSERT INTO SCORE(SNO,CNO,DEGREE)VALUES ('108','6-166','81');
GO
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES ('804','���','��','1958-12-02','������','�����ϵ');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES ('856','����','��','1969-03-12','��ʦ','���ӹ���ϵ');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART)
VALUES ('825','��Ƽ','Ů','1972-05-05','����','�����ϵ');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES ('831','����','Ů','1977-08-14','����','���ӹ���ϵ');
select * from Student
select * from TEACHER
select * from SCORE
select * from COURSE
--1.��ѯ Student ���е����м�¼�� Sname,Ssex ��Class��
select Sname,Ssex,Class from Student 

--2.��ѯ��ʦ���еĵ�λ�����ظ���Depart�С�
select Depart ��ʦ���ڵ�λ from TEACHER group by Depart

--3.��ѯ Student������м�¼��
select * from Student

--4.��ѯ Score���гɼ���60��80֮������м�¼��
select * from SCORE where DEGREE between 60 and 80

--5.��ѯ Score ���гɼ�Ϊ 85��86 �� 88 �ļ�¼��
select * from SCORE where DEGREE in ('85','86','88')

--6.��ѯ Student ���С�95031������Ա�Ϊ��Ů����ͬѧ��¼��
select * from STUDENT where CLASS='95031' or SSEX='Ů'

--7.�� Class �����ѯ Student ������м�¼��
select * from STUDENT order by CLASS desc

--8.�� Cno ����Degree �����ѯ Score ������м�¼��
select * from SCORE order by Cno ,Degree desc

--9.��ѯ��95031�����ѧ��������
select count(SNO) as '95031���ѧ������' from Student where CLASS='95031'

--10.��ѯ Score ���е���߷ֵ�ѧ��ѧ�źͿγ̺š�
select SNO ��߷�ѧ��ѧ��,CNO ��߷�ѧ���γ̺� from SCORE WHERE DEGREE=(select max(DEGREE)from SCORE) 

--11.��ѯ��3-105���ſγ̵�ƽ���֡�
select AVG(DEGREE) as '3-105�ſγ̵�ƽ����' from SCORE where CNO='3-105'

--12.��ѯ Score ���������� 5 ��ѧ��ѡ�޵Ĳ��� 3 ��ͷ�Ŀγ̵�ƽ��������
select AVG(DEGREE) as '������ 5 ��ѧ��ѡ�޵Ĳ��� 3 ��ͷ�Ŀγ̵�ƽ������' from SCORE where CNO like '3%'group by CNO having count(CNO)>=5

--13.��ѯ��ͷִ��� 70����߷�С�� 90 �� Sno �С�
select Sno from SCORE where DEGREE between 70 and 90

--14.��ѯ����ѧ���� Sname��Cno �� Degree �С�()
select Sname,Cno,Degree from Student join SCORE on STUDENT.SNO=SCORE.SNO  

--15.��ѯ����ѧ���� Sno��Cname �� Degree ��
select Sno,Cname,Degree from COURSE join SCORE on COURSE.CNO=SCORE.CNO 

--16����ѯ����ѧ���� Sname��Cname �� Degree �С�
select Sname,Cname,Degree from COURSE,SCORE,Student where COURSE.CNO=SCORE.CNO and SCORE.SNO=Student.SNO  

--17����ѯ��95033������ѡ�γ̵�ƽ���֡�
select avg(DEGREE) '95033����ѡ�γ̵�ƽ����' from STUDENT inner join SCORE on STUDENT.SNO=SCORE.SNO where CLASS='95033'

--19����ѯѡ�ޡ�3-105���γ̵ĳɼ����ڡ�109����ͬѧ�ɼ�������ͬѧ�ļ�¼��
select * from SCORE where CNO='3-105'and DEGREE>(select(DEGREE)from SCORE where SNO='109' and CNO='3-105')

--20����ѯ score��ѡѧһ�����Ͽγ̵�ͬѧ�з���Ϊ����߷ֳɼ��ļ�¼��
select * from SCORE where SNO in (select SNO from SCORE group by SNO having COUNT(SNO)>1)and DEGREE not in (select max(DEGREE) from SCORE group by CNO)

--21����ѯ�ɼ�����ѧ��Ϊ��109�����γ̺�Ϊ��3-105���ĳɼ������м�¼��
select * from SCORE where CNO='3-105' and DEGREE>(select max(DEGREE)from SCORE where SNO='109' and CNO='3-105')

--22����ѯ��ѧ��Ϊ 108 ��ͬѧͬ�����������ѧ���� Sno��Sname �� Sbirthday �С�
select Sno,Sname,Sbirthday from STUDENT where year(SBIRTHDAY)=(select year(Sbirthday) from STUDENT where SNO=108)  

--23����ѯ�����񡰽�ʦ�οε�ѧ���ɼ���
select SCORE.* from TEACHER,COURSE,SCORE where TEACHER.TNO=COURSE.TNO and COURSE.CNO=SCORE.CNO and TNAME='����' 

--24����ѯѡ��ĳ�γ̵�ͬѧ�������� 5 �˵Ľ�ʦ������
select TEACHER.TNAME 'ѡ��ĳ�γ̵�ͬѧ��������5�˵Ľ�ʦ����' from Score,TEACHER,COURSE where SCORE.CNO=COURSE.CNO and COURSE.TNO=TEACHER.TNO group by TEACHER.TNAME having count(SCORE.CNO)>5

--25����ѯ 95033 ��� 95031 ��ȫ��ѧ���ļ�¼��
select * from Student where STUDENT.class in ('95031','95033')order by CLASS

--26����ѯ������ 85 �����ϳɼ��Ŀγ� Cno.
select CNO from SCORE where DEGREE>'85'group by CNO

--27����ѯ���������ϵ����ʦ���̿γ̵ĳɼ���
select SCORE.* from SCORE,COURSE,TEACHER where SCORE.CNO=COURSE.CNO and COURSE.TNO=TEACHER.TNO and TEACHER.DEPART='�����ϵ'

--28����ѯ�������ϵ���롰���ӹ���ϵ����ְͬ�ƵĽ�ʦ�� Tname �� Prof��
select Tname,Prof from TEACHER where depart='�����ϵ'and PROF not in (select PROF from TEACHER where depart='���ӹ���ϵ' group by PROF) 
union select Tname,Prof from TEACHER where depart='���ӹ���ϵ'and PROF not in (select PROF from TEACHER where depart='�����ϵ' group by PROF)

--29����ѯѡ�ޱ��Ϊ��3-105���γ��ҳɼ����ٸ���ѡ�ޱ��Ϊ��3-245����ͬѧ�� Cno��Sno ��Degree,���� Degree �Ӹߵ��ʹ�������
select CNO,SNO,DEGREE from SCORE s1 where cno='3-105'and s1.DEGREE>(select DEGREE from SCORE where CNO='3-245'and SNO=s1.SNO)order by DEGREE desc 

--30����ѯѡ�ޱ��Ϊ��3-105���ҳɼ�����ѡ�ޱ��Ϊ��3-245���γ̵�ͬѧ�� Cno��Sno ��Degree.
select CNO,SNO,DEGREE from SCORE s1 where CNO='3-105'and DEGREE>(select DEGREE from SCORE where s1.SNO=SNO and CNO='3-245')

--31����ѯ���н�ʦ��ͬѧ�� name��sex �� birthday.
select SNAME name,SSEX sex,SBIRTHDAY birthday from STUDENT union select TNAME,TSEX,TBIRTHDAY from TEACHER

--32����ѯ���С�Ů����ʦ�͡�Ů��ͬѧ�� name��sex �� birthday.
select SNAME name,SSEX sex,SBIRTHDAY birthday from STUDENT where STUDENT.SSEX='Ů'union select TNAME,TSEX,TBIRTHDAY from TEACHER where TEACHER.TSEX='Ů'

----33����ѯ�ɼ��ȸÿγ�ƽ���ɼ��͵�ͬѧ�ĳɼ��� 
select * from SCORE s1 where DEGREE<(select AVG(DEGREE) from score where s1.CNO=CNO group by CNO)

--34����ѯ�����ον�ʦ�� Tname �� Depart.
select Tname,Depart from TEACHER where TNO IN (select TNO from COURSE where CNO IN(select (CNO) from SCORE group by CNO))

--35 ��ѯ����δ���εĽ�ʦ�� Tname �� Depart.
select Tname,Depart from TEACHER where TNO not IN(select TNO from COURSE where CNO IN(select (CNO) from SCORE group by CNO)) 

--36����ѯ������ 2 �������İ�š�
select CLASS from Student where SSEX='��' group by CLASS having count(SSEX)>=2 

--37����ѯ Student ���в��ա�������ͬѧ��¼��
select * from STUDENT where SNAME like '[^��]%'

--38����ѯ Student ����ÿ��ѧ�������������䡣
select SNAME ����,year(GETDATE())-year(SBIRTHDAY) ���� from STUDENT

--39����ѯ Student ����������С�� Sbirthday ����ֵ��
select max(Sbirthday) ��С��Sbirthday,min(Sbirthday) ����Sbirthday from STUDENT

--40���԰�ź�����Ӵ�С��˳���ѯ Student ���е�ȫ����¼��
select * from STUDENT order by CLASS desc,SBIRTHDAY

--41����ѯ���С���ʦ�������ϵĿγ̡�
select * from TEACHER,COURSE where TEACHER.TNO=COURSE.TNO and TSEX='��'

----42����ѯ��߷�ͬѧ�� Sno��Cno �� Degree �С�
select Sno,Cno,Degree from Score where DEGREE=(select max(degree)from SCORE)

--43����ѯ�͡������ͬ�Ա������ͬѧ�� Sname.
select Sname �����ͬ�Ա��ͬѧ from Student where SSEX=(select SSEX from STUDENT where SNAME='���')

--44����ѯ�͡������ͬ�Ա�ͬ���ͬѧ Sname.
select Sname �����ͬ�Ա�ͬ���ͬѧ from Student where SSEX=(select(SSEX) from STUDENT where SNAME='���')and CLASS=(select class from STUDENT where SNAME='���')

--45����ѯ����ѡ�ޡ���������ۡ��γ̵ġ��С�ͬѧ�ĳɼ��� 
select SCORE.* from Student left join SCORE on STUDENT.SNO=SCORE.SNO  left join COURSE on SCORE.CNO=COURSE.CNO left join TEACHER on COURSE.TNO=TEACHER.TNO where COURSE.CNAME='���������'and STUDENT.SSEX='��'
