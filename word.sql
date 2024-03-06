-- database 생성

create database voca;

use voca;

create table words (
	idx int auto_increment primary key,
    eng varchar(50) unique not null,
	kor varchar(50) not null,
    lev int default 1,
    regdate datetime default now()
);



select * from words;




