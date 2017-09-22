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
