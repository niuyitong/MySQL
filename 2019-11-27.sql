
regedit

LOCAL_MACHINE
SYSTEM
CurrentControlSet
Services
MySQL

ImagePath

数据库对用户
库(database)	表(table)		行(row)		列(column)
IDEA 的一个工程	类				一个对象	一个属性

数据库对文件系统：
文件夹 - 库
一组文件 - 表

CREATE DATABASE java20;//创建库

SHOW DATABASES;//显示库

USE java20;//使用库  USE是为数不多的不需要分号的命令

SELECT DATABASE();//查看当前库

// 表
CREATE TABLE students (
	name VARCHAR(20),
	age INT,
	sn INT
);

SHOW TABLES;


1. 关于库的命令
	1. CREATE DATABASE `库名`; 
	2. SHOW DATABASES;
	3. USE `库名`;  //进库
	4. DROP DATABASE `库名`;   //删除库
	5. SELECT DATABASE();
2. 关于表的命令(必须在 USE 库之后)
	1. CREATE TABLE `表名` (
		... 列的定义(Column)
	);
	2. SHOW TABLES;
	3. DROP TABLE;
	4. SHOW CREATE TABLE `表名`;//列出创建的表的信息及内容
	5. DESC `表名`;				//同上 （列出的形式不一样）
3. 表的数据类型
	1. 数值类型
		1. 整型
			INT	/ BIGINT
		2. 浮点型
			FLOAT/DOUBLE 有精度损失
			DECIMAL/NUMERIC 无精度损失
	2. 字符串类型（二进制的/文本的）
		CHAR(10)
		VARCHAR(10)		TEXT		文本的
		视频/音频/图片	BLOB		二进制的
	3. 时间相关的
		DATE		年-月-日
		TIME		时:分:秒
		DATETIME	年-月-日 时:分:秒
		TIMESTAMP	1970-2038
		
		
		
1. 图书管理系统(bms)
CREATE DATABASE bms;
USE bms;

CREATE TABLE books (
	name VARCHAR(100),
	author VARCHAR(100),
	price INT,
	category VARCHAR(20),//分类
	is_borrowed TINYINT  //是否借出
);

上架:
INSERT INTO books 
	(name, author, price, category, is_borrowed)
	VALUES
	("三国演义", "罗贯中", 8800, "古典名著", 0),
	("三体", "刘慈欣", 6600, "科幻小说", 0),
	("Java从编程到放弃", "高博", 100, "心理建设", 0);
	
查看已有书籍:
SELECT * FROM books;

借书:
UPDATE books SET is_borrowed = 1 WHERE name = "Java从编程到放弃";

下架:
DELETE FROM books WHERE name = "三体";







