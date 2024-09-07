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

INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('108' ,'曾华'
,'男' ,'1977-09-01','95033');
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('105' ,'匡明'
,'男' ,'1975-10-02','95031');
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('107' ,'王丽'
,'女' ,'1976-01-23','95033');
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('101' ,'李军'
,'男' ,'1976-02-20','95033');
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('109' ,'王芳'
,'女' ,'1975-02-10','95031');
INSERT INTO STUDENT (SNO,SNAME,SSEX,SBIRTHDAY,CLASS) VALUES ('103' ,'陆君'
,'男' ,'1974-06-03','95031');
GO
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('3-105' ,'计算机导论','825')
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('3-245' ,'操作系统' ,'804');
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('6-166' ,'数据电路' ,'856');
INSERT INTO COURSE(CNO,CNAME,TNO)VALUES ('9-888' ,'高等数学' ,'100');
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
VALUES ('804','李诚','男','1958-12-02','副教授','计算机系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES ('856','张旭','男','1969-03-12','讲师','电子工程系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART)
VALUES ('825','王萍','女','1972-05-05','助教','计算机系');
INSERT INTO TEACHER(TNO,TNAME,TSEX,TBIRTHDAY,PROF,DEPART) 
VALUES ('831','刘冰','女','1977-08-14','助教','电子工程系');
select * from Student
select * from TEACHER
select * from SCORE
select * from COURSE
--1.查询 Student 表中的所有记录的 Sname,Ssex 和Class列
select Sname,Ssex,Class from Student 

--2.查询教师所有的单位即不重复的Depart列。
select Depart 教师所在单位 from TEACHER group by Depart

--3.查询 Student表的所有记录。
select * from Student

--4.查询 Score表中成绩在60到80之间的所有记录。
select * from SCORE where DEGREE between 60 and 80

--5.查询 Score 表中成绩为 85，86 或 88 的记录。
select * from SCORE where DEGREE in ('85','86','88')

--6.查询 Student 表中“95031”班或性别为“女”的同学记录。
select * from STUDENT where CLASS='95031' or SSEX='女'

--7.以 Class 降序查询 Student 表的所有记录。
select * from STUDENT order by CLASS desc

--8.以 Cno 升序、Degree 降序查询 Score 表的所有记录。
select * from SCORE order by Cno ,Degree desc

--9.查询“95031”班的学生人数。
select count(SNO) as '95031班的学生人数' from Student where CLASS='95031'

--10.查询 Score 表中的最高分的学生学号和课程号。
select SNO 最高分学生学号,CNO 最高分学生课程号 from SCORE WHERE DEGREE=(select max(DEGREE)from SCORE) 

--11.查询‘3-105’号课程的平均分。
select AVG(DEGREE) as '3-105号课程的平均分' from SCORE where CNO='3-105'

--12.查询 Score 表中至少有 5 名学生选修的并以 3 开头的课程的平均分数。
select AVG(DEGREE) as '至少有 5 名学生选修的并以 3 开头的课程的平均分数' from SCORE where CNO like '3%'group by CNO having count(CNO)>=5

--13.查询最低分大于 70，最高分小于 90 的 Sno 列。
select Sno from SCORE where DEGREE between 70 and 90

--14.查询所有学生的 Sname、Cno 和 Degree 列。()
select Sname,Cno,Degree from Student join SCORE on STUDENT.SNO=SCORE.SNO  

--15.查询所有学生的 Sno、Cname 和 Degree 列
select Sno,Cname,Degree from COURSE join SCORE on COURSE.CNO=SCORE.CNO 

--16、查询所有学生的 Sname、Cname 和 Degree 列。
select Sname,Cname,Degree from COURSE,SCORE,Student where COURSE.CNO=SCORE.CNO and SCORE.SNO=Student.SNO  

--17、查询“95033”班所选课程的平均分。
select avg(DEGREE) '95033班所选课程的平均分' from STUDENT inner join SCORE on STUDENT.SNO=SCORE.SNO where CLASS='95033'

--19、查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。
select * from SCORE where CNO='3-105'and DEGREE>(select(DEGREE)from SCORE where SNO='109' and CNO='3-105')

--20、查询 score中选学一门以上课程的同学中分数为非最高分成绩的记录。
select * from SCORE where SNO in (select SNO from SCORE group by SNO having COUNT(SNO)>1)and DEGREE not in (select max(DEGREE) from SCORE group by CNO)

--21、查询成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。
select * from SCORE where CNO='3-105' and DEGREE>(select max(DEGREE)from SCORE where SNO='109' and CNO='3-105')

--22、查询和学号为 108 的同学同年出生的所有学生的 Sno、Sname 和 Sbirthday 列。
select Sno,Sname,Sbirthday from STUDENT where year(SBIRTHDAY)=(select year(Sbirthday) from STUDENT where SNO=108)  

--23、查询“张旭“教师任课的学生成绩。
select SCORE.* from TEACHER,COURSE,SCORE where TEACHER.TNO=COURSE.TNO and COURSE.CNO=SCORE.CNO and TNAME='张旭' 

--24、查询选修某课程的同学人数多于 5 人的教师姓名。
select TEACHER.TNAME '选修某课程的同学人数多于5人的教师姓名' from Score,TEACHER,COURSE where SCORE.CNO=COURSE.CNO and COURSE.TNO=TEACHER.TNO group by TEACHER.TNAME having count(SCORE.CNO)>5

--25、查询 95033 班和 95031 班全体学生的记录。
select * from Student where STUDENT.class in ('95031','95033')order by CLASS

--26、查询存在有 85 分以上成绩的课程 Cno.
select CNO from SCORE where DEGREE>'85'group by CNO

--27、查询出“计算机系“教师所教课程的成绩表。
select SCORE.* from SCORE,COURSE,TEACHER where SCORE.CNO=COURSE.CNO and COURSE.TNO=TEACHER.TNO and TEACHER.DEPART='计算机系'

--28、查询“计算机系”与“电子工程系“不同职称的教师的 Tname 和 Prof。
select Tname,Prof from TEACHER where depart='计算机系'and PROF not in (select PROF from TEACHER where depart='电子工程系' group by PROF) 
union select Tname,Prof from TEACHER where depart='电子工程系'and PROF not in (select PROF from TEACHER where depart='计算机系' group by PROF)

--29、查询选修编号为“3-105“课程且成绩至少高于选修编号为“3-245”的同学的 Cno、Sno 和Degree,并按 Degree 从高到低次序排序。
select CNO,SNO,DEGREE from SCORE s1 where cno='3-105'and s1.DEGREE>(select DEGREE from SCORE where CNO='3-245'and SNO=s1.SNO)order by DEGREE desc 

--30、查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的 Cno、Sno 和Degree.
select CNO,SNO,DEGREE from SCORE s1 where CNO='3-105'and DEGREE>(select DEGREE from SCORE where s1.SNO=SNO and CNO='3-245')

--31、查询所有教师和同学的 name、sex 和 birthday.
select SNAME name,SSEX sex,SBIRTHDAY birthday from STUDENT union select TNAME,TSEX,TBIRTHDAY from TEACHER

--32、查询所有“女”教师和“女”同学的 name、sex 和 birthday.
select SNAME name,SSEX sex,SBIRTHDAY birthday from STUDENT where STUDENT.SSEX='女'union select TNAME,TSEX,TBIRTHDAY from TEACHER where TEACHER.TSEX='女'

----33、查询成绩比该课程平均成绩低的同学的成绩表。 
select * from SCORE s1 where DEGREE<(select AVG(DEGREE) from score where s1.CNO=CNO group by CNO)

--34、查询所有任课教师的 Tname 和 Depart.
select Tname,Depart from TEACHER where TNO IN (select TNO from COURSE where CNO IN(select (CNO) from SCORE group by CNO))

--35 查询所有未讲课的教师的 Tname 和 Depart.
select Tname,Depart from TEACHER where TNO not IN(select TNO from COURSE where CNO IN(select (CNO) from SCORE group by CNO)) 

--36、查询至少有 2 名男生的班号。
select CLASS from Student where SSEX='男' group by CLASS having count(SSEX)>=2 

--37、查询 Student 表中不姓“王”的同学记录。
select * from STUDENT where SNAME like '[^王]%'

--38、查询 Student 表中每个学生的姓名和年龄。
select SNAME 姓名,year(GETDATE())-year(SBIRTHDAY) 年龄 from STUDENT

--39、查询 Student 表中最大和最小的 Sbirthday 日期值。
select max(Sbirthday) 最小的Sbirthday,min(Sbirthday) 最大的Sbirthday from STUDENT

--40、以班号和年龄从大到小的顺序查询 Student 表中的全部记录。
select * from STUDENT order by CLASS desc,SBIRTHDAY

--41、查询“男”教师及其所上的课程。
select * from TEACHER,COURSE where TEACHER.TNO=COURSE.TNO and TSEX='男'

----42、查询最高分同学的 Sno、Cno 和 Degree 列。
select Sno,Cno,Degree from Score where DEGREE=(select max(degree)from SCORE)

--43、查询和“李军”同性别的所有同学的 Sname.
select Sname 和李军同性别的同学 from Student where SSEX=(select SSEX from STUDENT where SNAME='李军')

--44、查询和“李军”同性别并同班的同学 Sname.
select Sname 和李军同性别并同班的同学 from Student where SSEX=(select(SSEX) from STUDENT where SNAME='李军')and CLASS=(select class from STUDENT where SNAME='李军')

--45、查询所有选修“计算机导论”课程的“男”同学的成绩表 
select SCORE.* from Student left join SCORE on STUDENT.SNO=SCORE.SNO  left join COURSE on SCORE.CNO=COURSE.CNO left join TEACHER on COURSE.TNO=TEACHER.TNO where COURSE.CNAME='计算机导论'and STUDENT.SSEX='男'
