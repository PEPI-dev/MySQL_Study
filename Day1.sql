-- SQL 문법
-- 주석문: # 또는 -- (한줄 주석문), /* code */ (여러줄 주석문)
-- 대소문자를 구별하지 않음
-- SELECT 와 select 는 같다. 적어도 SQL문법에서는
-- 문자열을 저장할 때 ''(작은 따옴표)만 사용
-- sql = "select * from tb_member where userid='apple'"
-- 테이블 : 데이터를 열과 행으로 저장할수 있는 구조
-- ctrl + enter로 실행
-- 데이터베이스 확인

show databases;
/*
	테이블 : 데이터를 행(레코드,로우)과 열(컬럼, 필드)로 스키마에 따라 저장할 수 있는 구조
    스키마 : 데이터베이스의 구조와 제약조건에 관한 명세를 기술한 집합
	create table 테이블명 (
		필드명1 데이터타입 제약조건,
        필드명2 데이터타입 제약조건,
        필드명3 데이터타입 제약조건,
        ... )
        
-- 데이터 타입
1. 숫자형 타입
	tinyint: 정수(1byte), -128 ~ 127
    smallint: 정수(2byte), -32768 ~ 32767
    int : 정수(4byte), -21억 ~ 약 21억
    bingint : 정수(8byte), 거의 무제한 
    flaot : 부동 소수형 데이터 타입(4byte)
    double: 부동 소수형 데이터 타입(8byte)
    decimal(길이, 소수): 고정 소수형 데이터 타입 1.00000
    
2. 문자형 타입
	char : 고정 길이 데이터 타입(최대 255byte), 
    지정된 길이보다 짧은 데이터를 입력하면 나머지 공간을 채움
    varchar : 가변길이 데이터 타입 ( 최대 65535byte)
    지정된 길이보다 짧은 데이터를 입력하면 나머지 공간을 채우지 않음
    text : 문자열 데이터 타입(최대 65535byte)
    longtext : 무제한 문자열 데이터 타입
3. 이진 데이터 타입
	banary, byte : char 형태의 이진 데이터 타입(최대 255byte)
    varbinary : varchar 형태의 이진 데이터 타입(최대 65535byte)
    
4. 날짜 데이터 타입
	data : 날짜(년도, 월, 일) 형태의 데이터 타입(3byte)
    time : 시간(시, 분, 초) 형태의 타입(3byte)
    datetime : 날짜와 시간 형태의 데이터 타입(8byte)
    timestamp : 1970년 1월 1일 0시 0분 0초부터 시작한 ms타입의 시간이 저장(4byte)
    
- 제약 조건(constraint)
  - 데이터의 무결성을 지키기 위해 데이터를 입력 받을 때 실행되는 검사 규칙을 의미
    
    not null
    - null 값을 허용하지 않음, 하지만 중복값은 허용
    
    unique
    - 중복값을 허용하지 않음, 하지만 null 값을 허용
    
    primary key(기본키)
    - null 값 허용하지 않음
    - 중복 값도 허용하지 않음
    - 테이블에 단 하나만 설정 가능 (MySQL 에선 하나만)
    - foreign key(참조키)와 쌍으로 연결됨
    - 인덱싱을 설정
    
    foreign key(참조키)
    - primary key를 가진 테이블과 연결하는 역할
    
    default
    - null 값을 삽입할 때 기본이 되는 값을 설정함
    
    enum
    - 원하는 범위를 설정하고 해당 범위의 값만 저장 # 권장하지 않음
    
    
*/
-- 데이터베이스 선택
-- use 데이터베이스명
use kdt;

-- 테이블 만들기
create table member (
	userid varchar(20) primary key,
    userpw varchar(20) not null,
    name varchar(20) not null,
    hp varchar(20) unique not null,
    email varchar(50) not null,
    gender varchar(10) not null,
    ssn1 char(6) not null,
    ssn2 char(7) not null,
    zipcode varchar(5),
    address1 varchar(100),
    address2 varchar(100),
    address3 varchar(100),
    regdate datetime default now(),
    point int default 0
);

-- 테이블 확인하기
-- desc 테이블명
desc member;

-- 테이블 삭제하기
-- drop table 테이블명
drop table member;

-- 필드 추가하기
-- alter table 테이블명 add 컬럼명 데이터타입 제약조건
alter table member add mbti varchar(10);

-- 필드 수정하기
-- alter table 테이블명 modify column 컬럼명 데이터타입 제약조건
alter table member modify column mbti varchar(20);

-- 필드 삭제하기
-- alter table 테이블명 drop 컬럼명
alter table member drop mbti;

-- 데이터 삽입 실습 member 테이블에 적용
-- apple, banana, orange, melon , avocado

insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2) values
('apple', '1234', '김사과','010-1234-1331','apple@naver.com','남자','123456','5432112');

insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2) values
('banana', '1234', '바나나','010-1512-1331','banana@naver.com','여자','43456','5432112');

insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2) values
('orange', 'sdfk12', '오렌지','010-1234-5329','orange@naver.com','여자','123456','5432112');

insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2) values
('melon', 'melon12', '메론','010-1134-1335','melon@naver.com','남자','123456','5432112');

insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2) values
('avocado', 'avo123', '아보카도','010-7264-1231','avocado@naver.com','남자','123456','5432112');



select * from member;

/*
	데이터 삽입하기
	insert into 테이블명 values(값1, 값2, 값3, ....)
    insert into 테이블명 (필드명1, 필드명2, 필드명3 ...) values (값1, 값2, 값3 ...)
*/

create table word(
	eng varchar(50) primary key,
    kor varchar(50) not null,
    lev int default 1
);

drop table word;

insert into word values('apple', '사과', 2);
select * from word   -- 데이터 잘 들어간지 확인
order by eng;
-- insert into word value('aa','사과');  -- word의 값은 3가지 종류인데 2가지만 넣어서 에러발생
insert into word values('banana','바나나',null);

insert into word (eng, kor , lev) values ('orange','오렌지',1);
insert into word (eng, kor) values ('melon', '메론');
insert into word (lev, eng, kor) values (1, 'cherry', '체리');
insert into word (eng) values ('berry');



desc word;

-- 데이터베이스 만들기
-- create database 데이터베이스명;
create database kdt;
	
