-- 创建数据库
CREATE DATABASE Seiryo;
 
-- 选择数据库
USE Seiryo;
 
-- 创建数据表
CREATE TABLE Company (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Price NVARCHAR(50)
)
-- 创建数据库
CREATE DATABASE SanGuoSha;
 
-- 选择数据库
USE SanGuoSha;

-- 创建数据表
CREATE TABLE Wujiang (
    ID INT PRIMARY KEY,
    Name VARCHAR(20),
	Hp Int,
	Skill varchar(20),
	Emotion varchar(20)
)