create database school;
use school;
-- 创建学生表
create table Student(
	Sno varchar(20) primary key,
	Sname varchar(20) not null,
	Ssex varchar(20) not null,
	Sbirthday datetime,
	Class varchar(20)	
);
-- 创建教师表
create table Teacher(
	Tno varchar(20) primary key,
	Tname varchar(20) not null,
	Tsex varchar(20) not null,
	Tbrithday datetime,
	Prof varchar(20),
	Depart varchar(20) not null

);
-- 创建课程表
create table Course(
	Cno varchar(20) primary key,
	Cname varchar(20) not null,
	Tno varchar(20) not null,
	foreign key(Tno) references Teacher(Tno)
);
-- 创建成绩表
create table Score(
	Sno varchar(20) not null,
	foreign key(Sno) references Student(Sno),
	-- 外键在表外添加
	Cno varchar(20) not null,
	-- 成绩
	Degree Decimal
);
alter table Score add primary key(Sno,Cno);
alter table Score add constraint foreign key(Cno) references Course(Cno);

