
 
CREATE DATABASE `java20_20191204`;
USE `java20_20191204`;

CREATE TABLE `books` (
	`name` VARCHAR(20),
	`author` VARCHAR(20),
	`category` VARCHAR(10),
	`price`	FLOAT,
	`is_borrowed` TINYINT
);


CREATE TABLE students (
	id INT,
	sn INT COMMENT '学号',
	name VARCHAR(20) COMMENT '姓名',
	qq_mail VARCHAR(20) COMMENT '邮箱'
);

INSERT INTO students VALUES (100, 10000, '孙悟空', '111');//单行插入
INSERT INTO students VALUES (101, 10001, '唐僧', NULL);

INSERT INTO students (sn, name)			//多行插入
VALUES 
(103, "贾宝玉"),
(104, "林黛玉"),
(105, "伏地魔");

select * from student;//查询表的所有列
select sn,name,from student; //表的指定列查询

CREATE TABLE exam_result (
	id INT,
	name VARCHAR(20),
	语文 DECIMAL,
	数学 DECIMAL,
	英语 DECIMAL
);

INSERT INTO exam_result (id, name, 语文, 数学, 英语)
VALUES
(1, '唐三藏', 67, 98, 56),
(2, '孙悟空', 87, 78, 77),
(3, '猪悟能', 88, 98, 90),
(4, '曹孟德', 100, 82, 88),
(5, '孙权', 88, 18, 92),
(6, '张三丰', 100, 100, 100),
(7, '高博', 80, 80, 80),
(8, '小龙女', 90, 100, 90),
(9, '过儿', 98, 98, 90),
(10, '雕', 5, 3, 9),
(11, '张无忌', 88, 98, 90);

SELECT name, 英语 FROM exam_result;
SELECT name, 英语, 10 FROM exam_result;
SELECT name, 英语, 英语 + 10 FROM exam_result;
SELECT name, 英语, 英语 + 语文 + 数学 FROM exam_result;
SELECT name, 英语 + 语文 + 数学 AS 总分 FROM exam_result;
SELECT name, 英语 + 语文 + 数学 总分 FROM exam_result;

SELECT DISTINCT 数学 FROM exam_result;

SELECT * FROM exam_result ORDER BY (语文 + 数学 + 英语) DESC; 

SELECT * FROM exam_result WHERE 语文 < 60;

CREATE TABLE threads (
	`creator` VARCHAR(20),
	`content` TEXT,
	`created_at` DATETIME
);

// 发帖
INSERT INTO threads VALUES ("高博", "40实习个实习生有点难", "2019-12-04 21:00:00");
INSERT INTO threads VALUES ("陈沛鑫", "老铁有点信心!", "2019-12-04 21:02:00");
INSERT INTO threads VALUES ("王倩倩", "至少我没问题", "2019-12-04 21:04:00");

// 每页有 10 个帖子
// 一定先用 ORDER BY，LIMIT 才有意义。
SELECT * FROM threads ORDER BY created_at LIMIT 10 OFFSET 0;
SELECT * FROM threads ORDER BY created_at LIMIT 10 OFFSET 10;
SELECT * FROM threads ORDER BY created_at LIMIT 10 OFFSET 20;




