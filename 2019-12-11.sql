INSERT INTO 表名 (列名) VALUES (值), (值);

DELETE FROM 表名 WHERE 条件;

UPDATE 表名 SET 列 = 新的值, 列 = 新的值 WHERE 条件;

SELECT
	* | 表达式 | DISTINCT 列名
FROM 表名
WHERE 条件
ORDER BY 排序列
LIMIT ...


CREATE DATABASE JAVA20_20191211;
USE JAVA20_20191211;
CREATE TABLE students(
	name VARCHAR(20),
	gender VARCHAR(3),
	age INT,
	height DOUBLE COMMENT "身高，单位是厘米",
	weight DOUBLE COMMENT "体重，单位是公斤"
);

INSERT INTO students VALUES
('孙悟空','男',18,160,30),
('唐三藏','保密',6,70,60),
('猪八戒','女',34,185,200),
('观世音菩萨','保密',500,170,50),
('沙悟净','男',50,180,70);

找出年龄是 18 岁的姓名	
SELECT name FROM students WHERE age = 18;
找出未成年的人的姓名 <= 18
SELECT name FROM students WHERE age <= 18;
定义健康的标准是：身高 和 体重的比值 < 2.1 就是健康的
SELECT name FROM students WHERE (height / weight) >= 2.1;
找出年龄最大的一个人
SELECT name FROM students ORDER BY age DESC LIMIT 1;
找出年龄第三大的一个人
SELECT name FROM students ORDER BY age DESC LIMIT 1 OFFSET 2;//显示一个 从偏移量2开始
把孙悟空的性别改成女
UPDATE students SET gender = '女' WHERE name = '孙悟空';
所有人都加 1 岁
UPDATE students SET age = age + 1;
身高排序查看所有人信息
SELECT * FROM students ORDER BY height;
删除观世音
DELETE FROM students WHERE name LIKE '%观世音%';

SHOW CREATE TABLE students;//


//新

drop table teachers;

CREATE TABLE teachers(
	name VARCHAR(20) UNIQUE,//唯一
	gender VARCHAR(3) NOT NULL DEFAULT '保密',//不允许为空，若无输入默认保密
	age INT NOT NULL DEFAULT 0,
	height DOUBLE NOT NULL DEFAULT 0,
	weight DOUBLE NOT NULL DEFAULT 0
);
INSERT INTO teachers (name) VALUES('玉皇大帝');
INSERT INTO teachers (name) VALUES('玉皇大帝');//不行
INSERT INTO teachers (name) VALUES(NULL);
INSERT INTO teachers (name) VALUES(NULL);//可以插入两个NULL,NULL不视为相同的

//主键一般用自增INT数值
CREATE TABLE slavers(
	id INT PRIMARY KEY AUTO_INCREMENT,//PRIMARY KEY主键  AUTO_INCREMENT自增 不用手动插入
	name VARCHAR(20) UNIQUE,
	gender VARCHAR(3) NOT NULL DEFAULT '保密',
	age INT NOT NULL DEFAULT 0,
	height DOUBLE NOT NULL DEFAULT 0,
	weight DOUBLE NOT NULL DEFAULT 0
);
INSERT INTO slavers (name) VALUES('三金');
SELECT * FROM slavers;

UNIQUE vs PRIMARY KEY
相同点: 不允许重复
不同点：UNIQUE 可以为 NULL，同时 NULL 不视为重复
		PRIMARY 不允许为 NULL，MySQL 实际存储时，依赖主键


//如何设计一个表
1.表的三大范式（范式：指导性意见）
	1.表中的每个字段含义是独立的，不可再分的（业务相关的）
		学生表：
			1.姓名/年龄/身高，单位
	2.前提：每张表都有主键，表中的字段和完整主键有关系，而不是部分主键
		反例：成绩表（学号+课程）//复合主键 两个加起来不允许重复
		学号
		课程
	3.前提：每张表都有主键，表中的字段和主键有直接关系，而不是间接关系

//学生选课系统
CREATE DATABASE java20_20191211_02;
USE java20_20191211_02;
CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT,
	class_id INT NOT NULL,
	name VARCHAR(20)
);

CREATE TABLE classes (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20)
);

CREATE TABLE courses (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20)
);

CREATE TABLE student_course_relationship (
	student_id INT,
	course_id INT,
	PRIMARY KEY (student_id, course_id)
);

INSERT INTO classes (name) VALUES ('五班');
SELECT LAST_INSERT_ID();
INSERT INTO students (class_id, name) VALUES
	(1, '三金'),
	(1, '亦木');
	
	
//小博客系统
CREATE TABLE users (
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE articles (
	id INT PRIMARY KEY AUTO_INCREMENT,
	author_id INT NOT NULL,
	title VARCHAR(100) NOT NULL,
	content TEXT NOT NULL,
	published_at DATETIME NOT NULL
);
CREATE TABLE comments (
	id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT NOT NULL,
	article_id INT NOT NULL,
	content VARCHAR(100) NOT NULL,
	published_at DATETIME NOT NULL
);
CREATE TABLE user_article_like_relation (
	user_id INT NOT NULL,
	article_id INT NOT NULL,
	PRIMARY KEY (user_id, article_id)
);

注册用户: 三金/亦木
INSERT INTO users (username) VALUES ('三金');
INSERT INTO users (username) VALUES ('亦木');
三金发表了一篇文章 《论找实习的重要性》 "非常重要"
SELECT id FROM users WHERE username = "三金";
INSERT INTO articles (author_id, title, content, published_at)
	VALUES (1, "论找实习的重要性", "非常重要", "2019-12-11 21:39:00");
亦木评论三金的文章《论找实习的重要性》，"同意执行"
SELECT id FROM users WHERE username = "亦木";
SELECT id FROM articles WHERE title = "论找实习的重要性";
INSERT INTO comments (user_id, article_id, content, published_at)
	VALUES (2, 1, "同意执行", "2019-12-11 21:41:00");
亦木点赞该文章
SELECT id FROM users WHERE username = "亦木";
SELECT id FROM articles WHERE title = "论找实习的重要性";
INSERT INTO user_article_like_relation (user_id, article_id)
	VALUES (2, 1);
三金的文章主页
SELECT id FROM users WHERE username = "三金";
SELECT id, title, published_at FROM articles WHERE author_id = 1
	ORDER BY published_at DESC LIMIT 10 OFFSET 0;

1.分析需求
2.优先找实体，其次找关系
3.借助E-R图 描述实体与关系
4.设计属性（字段）：借助三大范式
5.描述属性的类型+约束
6.写出建表语句	
	
	
	
	
	
	
	
	
	
	
	
	
	





