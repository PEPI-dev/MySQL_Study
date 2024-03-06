use kdt;
-- MySQL 문자열 함수
-- concat : 복수의 문자열을 연결해주는 함수
select concat('안녕하세요','MySQL') as concat;
select * from member;
select concat(address1, ' ', address2, ' ', address3) as address
from member where userid = 'orange';

-- left, right : 왼쪽 또는 오른쪽에서 길이만큼 문자열을 가져옴
select left('ABCDEFGHIJKLMN', 5);  # 출력 ABCDE
select userid, left(userid,2) as leftfunc from member;

-- substring : 문자열의 일부를 가져옴
-- substring(문자열, 시작위치) : 시작위치부터 끝까지
-- substring(문자열, 시작위치 ,길이) : 시작위치 부터 길이만큼
select substring('ABCDEFGHIJKLMN', 5) as sub;
select substring('ABCDEFGHIJKLMN',5,3) as sub;

-- char_length : 문자열의 길이를 반환

select char_length('ABCDEFGHIJKLMN') as cnt;
select email, char_length(email) as len from member;

-- lpad, rpad : 왼쪽 또는 오른쪽의 해당 길이만큼 늘리고, 빈 공간을 채울 문자열 반환
-- lpad(문자열, 총길이, 채울문자열)
select lpad('ABCDEFG', 10 , 0) as pad;
select point, lpad(point, 5, 0) as pad from member;

-- ltrim rtrim , trim : 왼쪽 , 오른쪽 , 모든 공백을 제거
select ltrim('       ABCDEF         ' ) as ltrim;

-- replace : 문자열에서 특정 문자열을 변경
-- replace ( 문자열, 대상 , 바꿀 문자열 )
select replace('ABCDEFG', 'CD', ',') as repl;

/*
	유니온(union)
    합집합을 나타내는 연산자로, 중복된 값을 제거함
    서로 같은 종류의 테이블(컬럼이 같아야함) 에서만 적용 가능
    select 컬럼명1, 컬럼명2, .. from 테이블1 union select 컬럼명1, 컬럼명2,.. from 테이블2
*/
create table product(
	code varchar(5) not null,
	name varchar(20) not null,
    detail varchar(1000),
    price int default 0,
    regdate datetime default now()
);
select * from product;
insert into product values('00001','RTX4070ti', '글카업글마려워',1200000,now());
insert into product values('00002','아이폰 15 pro', '아이폰 신작',1800000,now());
insert into product values('00003', '무선 이어폰','노이즈 캔슬링',200000,now());
insert into product values('00004','플립5','접혀요',1300000,now());
insert into product values('00005','모니터','오딧세이 32',700000,now();

create table product_new(
	code varchar(5) not null,
	name varchar(20) not null,
    detail varchar(1000),
    price int default 0,
    regdate datetime default now()
);
insert into product_new values('10001','자동차','포르쉐911',200000000,now());
insert into product_new values('10002','집','한남동',2000000000,now());
insert into product_new values('10003','젤리','하리보',3000,now());
select * from product_new;

-- regdate 값이 다르므로 출력
select code, name, price , regdate from product
union
select code, name , price ,regdate from product_new;

-- 모든 컬럼의 값이 같으므로 중복값이 제거
select code, name, price from product
union
select code, name , price from product_new;

-- union all
-- 중복된 값을 제거하지 않음

select code, name, price from product
union all
select code, name , price from product_new;

/*
	서브쿼리(Sub Query)
    - 다른 쿼리 내부에 포함되어 있는 select 문을 의미
    - 서브쿼리를 포함하고 있는 쿼리를 외부쿼리라고 부르고, 서브쿼는 내부쿼리라고 부름
    - 서브쿼리는 괄호()를 사용해서 표현
    - select, where , from , having 절 등에서 사용할 수 있음
*/
select price from product where code ='00001';
# 상품코드가 '00001'의 가격보다 크거나 같은 가격을 가지고 있는 상품의 모든 정보를 출력
-- where 절
select * from product where price >= (select price from product where code ='00001');
-- select 절
-- code, name , price, max(price)
select code, name, price, (select max(price) from product) as max_price from product;

-- auto_increament : 필드의 identity한 숫자를 자동으로 부여

create table orders(
	no int auto_increment primary key,
	userid varchar(20) not null,
    product_code varchar(5) not null,
    cnt int default 0,
    total_price int default 0,
    regdate datetime default now(),
    foreign key(userid) references member(userid)
);

insert into orders (userid,product_code, cnt, total_price) values('apple','00004',1,1300000);
insert into orders (userid,product_code, cnt, total_price) values('apple','00002',1,1200000);
insert into orders (userid,product_code, cnt, total_price) values('apple','00003',1,200000);
insert into orders (userid,product_code, cnt, total_price) values('banana','00004',1,1300000);
insert into orders (userid,product_code, cnt, total_price) values('orange','00004',1,1300000);
insert into orders (userid,product_code, cnt, total_price) values('orange','00001',1,500000);
insert into orders (userid,product_code, cnt, total_price) values('melon','00004',1,1300000);

select * from member;
select * from orders;

-- 상품을 최소 2번이상 구입한 횟수가 있는 회원의 아이디와 이름, 성별을 출력
select userid, name, gender from member where userid in 
(select userid from orders group by userid having count(no) >= 2);

-- 상품을 최소 2번이상 구입한 아이디의 앞 2글자와 상품 구입횟수를 출력
# select substring(userid,0,2) as id from member where userid in
# (select * from orders group by userid having count(no) >= 2);

-- join 사용
select left(m.userid,2), count(o.no) as cnt from member m inner join orders o on m.userid = o.userid
group by m.userid having cnt >= 2;

-- 서브쿼리 
select left(m.userid, 2), sub.ocnt from member as m inner join
(select userid, count(no) as ocnt from orders group by userid having count(no) >= 2) as sub
on m.userid = sub.userid;


create table orders_new(
	no int auto_increment primary key,
	userid varchar(20) not null,
    product_code varchar(5) not null,
    cnt int default 0,
    total_price int
    default 0,
    regdate datetime default now(),
    foreign key(userid) references member(userid)
);

select * from orders_new;
insert into orders_new(select * from orders);

create table orders_new_new(select* from oders);
select * from orders_new_new;

/*
	MySQL 사용자
    1. 사용자 추가하기
		- MySQL 8.0 Command Line Client에서 root로 로그인
        - 접속 가능한 사용자 추가하기
			create user '사용자명'@'localhost' identified by '비밀번호';
            create user 'apple'@'localhost' identified by '1111';
		- 사용자 목록 조회
			use mysql;
            select user, host from user;
		- 할당 권한 상세 옵션
			create, drop, alter : 테이블에 대한 생성 , 삭제 , 변경 권한
            select, insert , update, delete : 테이블의 데이터를 조회, 삽입, 변경, 삭제에 대한 권한
            all : 모든권한
            usage : 권한을 부여하지 않고 계정만 생성
				grand select on 데이버베이스명.테이블명 to '사용자'@'localhost';
                grand all on *.* to '사용자'@'locatlhost';
                flush privileges;
			grant select on 데이터베이스명.테이블명 to '사용자'@'%'; -- 모든 IP에서 접근가능
            grant select on 데이터베이스명.테이블명 to '사용자'@'특정 ip주소';
	2. 사용자 삭제하기
		drop user 계정명;
	3. 사용자 권한 제거
		revoke 권한명 privileges on 데이터베이스명.테이블명 from '계정명'@'localhost';
	4. 사용자 권한 조회
		show grants for '계정명'@'localhost';
        
*/
-- apple 데이터베이스 생성
create database apple;

-- apple 데이터베이스에 kdt.member 테이블을 복사
create table apple.member(select * from kdt.member);

use apple;
select * from member;

# member-- apple.member에 select 권한만 가능한 apple 계정을 만들어보자.
grant select on apple.member to 'apple'@'localhost';
flush privileges;

-- apple 데이터베이스에 모든 권한을 가진 사용자 'orange'를 생성   # 완
-- orange로 접속하여 테스트 # 완
-- orange의 모든 권한을 제거
-- orange의 사용자를 삭제

-- orange 에게 모든권한 부여
grant all on apple.member to 'orange'@'localhost';
use mysql;

-- 오렌지 권한 조회 
show grants for 'orange'@'localhost';

-- 오렌지 권한 제거
revoke all privileges on apple.* from 'orange'@'localhost';

/*
	뷰(view)
    - 가상의 테이블을 생성
    - 실제 테이블처럼 행과 열을 가지고 있지만 데이터를 직접 저장 하고 있지는 않음
	
    뷰를 만드는 이유
    - SQL 코드를 간결하게 만들기 위함
    - 삽입, 삭제, 수정 작업에 제약 사항을 가짐
    - 내부 데이터를 전체 공개하고 싶지 않을 때
    
    create view 뷰이름 as 쿼리 ...
*/
use kdt;
select * from member;
select userid,name,hp,gender from member;

create view vw_member as select userid,name,hp,gender from member;
select * from vw_member;

select * from member;
select * from profile;
-- member의 userid, name, hp와 profile의 mbti를 출력하는 출력하는 뷰(vw_memberprofile)

create view vw_memberprofile as select m.userid,m.name,m.hp,p.mbti from member m
inner join p on m.userid = p.userid;

-- member의 userid, name, hp와 profile의 mbti를 출력하는 뷰(vw_member_profile)를 만들어보자. 교수님 코드
create view vw_member_profile as
select m.userid, m.name, m.hp, p.mbti from member m left join profile p on
m.userid = p.userid;
select * from vw_member_profile;

/*
	트랜젝션(Transaction)
    - 분할이 불가능한 업무처리의 단위
    - 한꺼번에 수행되어야 할 연산 모음
    
    commit : 모든 작업들을 정상 처리하겠다고 확정하는 명령어. 해당 처리 과정을 DB에 영구적으로 저장
    rollback : 작업 중 문제가 발생되어 트랜젝션의 처리 과정에서 발생한 변경사항을 모두 취소하는 명령어
    
    start transaction
		블록안의 명령어들은 하나의 명령어 처럼 처리됨
        ...
        성공하던지, 실패하던지 둘 중 하나의 결과가 발생
        문제가 발생하면 rollback;
        정상적인 처리가 완료되면 commit;
*/
-- 자동 커밋 확인
show variables like '%commit%';
-- autocommit : ON -> 자동으로 commit 해줌
-- set autocommit=0 -> (off), set autocommit=1 -> (on)
set autocommit=1;

select * from word;
start transaction;
insert into word values('car','자동차',1);
rollback;

insert into word values('car','자동차',1);
commit;

-- 트랜젝션의 예외
-- DDL문(create,drop,alter,rename,truncate)에 대해 예외를 적용 : rollback 대상이 아님

-- truncate
-- 개별적으로 행을 삭제할 수 없으며, 테이블 내부의 모든 데이터 삭제
-- DDL문이기 때문에 rollback 불가능
-- 트랜젝션 로그에 한번만 기록하므로 delete 구분모다 성능면에서 빠름

-- truncate table 테이블명;

select * from product_new;
start transaction;
delete from product_new;
select * from product_new;
rollback;
select * from product_new;

start transaction;
truncate table product_new;
rollback;
