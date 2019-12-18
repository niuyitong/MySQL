// 用户	文章  评论  点赞
CREATE DATABASE sql_20191218;
USE sql_20191218;

CREATE TABLE users (
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(100) UNIQUE
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

CREATE TABLE likes (
	user_id INT NOT NULL,
	article_id INT NOT NULL,
	PRIMARY KEY (user_id, article_id)
);

