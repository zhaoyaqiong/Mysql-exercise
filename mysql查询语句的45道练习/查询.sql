-- 1.查询Student表中的所有记录的Sname、Ssex和Class列。
select Sname,Ssex,Class from Student;
-- 2.查询教师所有的单位即不重复的Depart列。
select distinct Depart from Teacher;
-- 3.查询Student表的所有记录。
select * from Student;
-- 4.查询Score表中成绩在60到80之间的所有记录。
select * from Score where Degree between 60 and 80;
-- 5.查询Score表中成绩为85，86或88的记录。
select * from Score where Degree in(85,86,88);
-- 6.查询Student表中“95031”班或性别为“女”的同学记录。
select * from Student where Class = '95031' or Ssex = '女';
-- 7.以Class降序查询Student表的所有记录。
select * from Student order by Class desc;
-- 8.以Class升序查询Student表的所有记录。
select * from Student order by Class asc;
-- 9.以Cno升序、Degree降序查询Score表的所有记录。
select * from Score order by Cno asc,Degree desc;
-- 10.查询“95031”班的学生人数。
select count(*) from Student where Class = '95031';
-- 11.查询Score表中的最高分的学生学号和课程号。（子查询或者排序）
select Sno,Cno from Score order by Degree desc limit 0,1;
select Sno,Cno from Score where Degree in(select max(Degree) from Score);
-- 12.查询每门课的平均成绩。
select avg(Degree) from Score group by Cno;
-- 13.查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
-- 这里这个5名学生略有些多查不出来，我们改为2名学生。
select Cno,avg(Degree) from Score where Cno like '3%' group by Cno having count(Sno)>=2;
-- 14.查询分数大于70，小于90的Sno列。
select Sno from Score where Degree>70 and Degree < 90;
select Sno from Score where Degree between 70 and 90;
-- 15.查询所有学生的Sname、Cno和Degree列。
select st.Sname,sc.Cno,sc.Degree from Student st,Score sc where st.Sno = sc.Sno;
select st.Sname,sc.Cno,sc.Degree from Student st inner join Score sc on st.Sno = sc.Sno;
-- 16.查询所有学生的Sname、Cname和Degree列。
select Sname,Cname,Degree from Student inner join Score on Student.Sno = Score.sno inner join Course on Course.Cno = score.Cno;
-- 17.查询“95033”班学生的平均分。(这里95033没有成绩 = =)
select class,avg(Degree) from Student,Score where Student.Sno = Score.Sno group by Student.Class having Student.Class = '95033';
-- 18.假设使用如下命令建立了一个grade表：
create table grade(low  int(3),upp  int(3),rank  char(1));
insert into grade values(90,100,'A');
insert into grade values(80,89,'B');
insert into grade values(70,79,'C');
insert into grade values(60,69,'D');
insert into grade values(0,59,'E');
-- 现查询所有同学的Sno、Cno和rank列。
select st.Sno,sc.Cno,gr.rank from Student st,Score sc,grade gr where st.Sno = sc.Sno and sc.Degree between gr.low and gr.upp;
select Sno,Cno,rank from Score,grade where degree between low and upp;
-- 19.查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。
select * from Score where Cno = '3-105' and Degree > all(select Degree from Score where Sno = '109');
-- 20.选了多门课程并且是这个课程下不是最高分的
select * from Score where Sno in (select Sno from Score group by Sno having count(*)>=2);
-- 21.查询成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。
select * from score where cno = '3-105' and degree > (select degree from score where sno='109' and cno='3-105');
-- 22.查询和学号为108、101的同学同年出生的所有学生的Sno、Sname和Sbirthday列。
select Sno,Sname from Student where year(Sbirthday) in (select year(Sbirthday) from Student where Sno='108' or  Sno = '101') and Sno != '108' and Sno != '101';
-- 23.查询“张旭“教师任课的学生成绩。
select st.Sname,sc.Degree from Student st,Score sc where st.Sno = sc.Sno and sc.Cno in (select Cno from Course c,Teacher t where c.Tno = t.Tno and t.Tname = '张旭');
-- 24.查询选修某课程的同学人数多于5人的教师姓名。(注意一下这里也没有符合条件的，可以自己再添加一些数据)
select t.Tname from Teacher t,Course c where t.Tno = c.Tno and c.Cno in (select Cno from Score group by Cno having count(*)>5);
-- 25.查询95033班和95031班全体学生的记录。
select * from Student where Class in('95033','95031');
-- 26.查询存在有85分以上成绩的课程Cno。
select distinct Cno from Score where Degree > 85;
-- 27.查询出“计算机系“教师所教课程的成绩表。
select * from Score s,Course c where s.Cno = C.Cno and C.Tno in(select Tno from Teacher where Depart='计算机系');
-- 28.查询“计算 机系”与“电子工程系“不同职称的教师的Tname和Prof。
select Tname,Prof from Teacher where Depart in('计算机系','电子工程系');
-- 29.查询选修编号为“3-105“课程且成绩至少高于选修编号为“3-245”的同学的Cno、Sno和Degree,并按Degree从高到低次序排序。
select Cno,Sno,Degree from Score where Cno = '3-105' and Degree > any(select Degree from Score where Cno='3-245');
-- 30.查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的Cno、Sno和Degree.
select Cno,Sno,Degree from Score where Cno = '3-105' and Degree > all(select Degree from Score where Cno='3-245');
-- 31.查询所有教师和同学的name、sex和birthday.
select Sname name,Ssex sex,Sbirthday birthday from Student union select Tname,Tsex,Tbrithday from Teacher;
-- 这里我teacher的列名拼写错了，修改列名
alter table Teacher change column Tbrithday Tbirthday datetime;
-- 32.查询所有“女”教师和“女”同学的name、sex和birthday.
select Sname name,Ssex sex,Sbirthday birthday from Student where Ssex = '女' union select Tname,Tsex,Tbirthday from Teacher where Tsex = '女';
-- 33.查询成绩比该课程平均成绩低的同学的成绩表。
select * from score a  where degree < (select avg(degree) from score b where b.cno=a.cno);









