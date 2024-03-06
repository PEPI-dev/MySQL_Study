-- 엄카 사용하기 프로그램

-- 1. 철수는 자취를 시작했다. 철수의 어머니는 철수가 독립을 한게 대견스러워 자취방좀 꾸미라고 철수에게 카드를 주었다.
-- 2. 한도는 500만원 철수는 백화점에 달려갔다.
-- 3. 백화점에는 여러가지 상품들이 있다.
-- 4. 하지만 함정매장에서 물건을 살경우 어머니에게 문자가서 카드가 정지됩니다.
-- 5. 함정 물건을 피해서 사고싶은 물건을 사시오
-- 6. 500만원 이상 넘어가면 프로그램 종료 


-- -------- 출력 -------------
-- 1. print(' 얏호 엄카를 맘껏 사용할수있다니 사고싶은거 다사야징 ㅎㅎ')
-- 2. input(' 행동 선택 1. 쇼핑하기 2. 남은한도 확인 3. 집가기')
-- 3. input(' 어느 매장에 방문하실겁니까? (의류, 가구, 전자기기, 생필품,명품)
-- 4. ex) input ( 의류매장에 오셨습니다. 상품을 선택해주세요 (톰브라운 가디건, 구찌 모자, 아디다스 신발 ......)
-- 5. ex) print ( oo상품을 선택하셨습니다. 가격 : n원, 남은 한도 : n원 ) -> 3번으로 돌아감
-- 6. 함정 매장 ex) input ( 전자기기 매장에 오셨습니다. 상품을 선택해주세요 ( 닌텐도스위치, 노트북, ps5 ....)
-- 7. ex) print ( oo상품을 구입했습니다. 남은 한도 n원)
-- 8. print(' 어머니에게 전화가 와서 엄청 혼이나고 카드가 정지됩니다....')  프로그램 종료



create database mall;

use mall;

create table item(
	product varchar(20) primary key,
    price int(5) not null,
    count int default 3
);

create table it_shop(
	product varchar(20) primary key,
    price int(5) not null,
    count int default 3
);


create table furniture(
	product varchar(20) primary key,
    price int(5) not null,
    count int default 3
);

create table living(
	product varchar(20) primary key,
    price int(5) not null,
    count int default 3
);


select * from item;

select * from it_shop;


insert into item (product, price, count) values
('아디다스 신발', 100000, 10);

insert into item (product, price, count) values
('톰 브라운 가디건', 300000, 3);

insert into item (product, price, count) values
('에이스 침대', 1800000, 3);

insert into item (product, price, count) values
('책상', 200000, 3);

insert into item (product, price, count) values
('의자', 50000, 3);

insert into item (product, price, count) values
('에이스 침대', 1800000, 3);

insert into item (product, price, count) values
('닌텐도 스위치', 400000, 3);

insert into item (product, price, count) values
('ps5', 600000, 3);

insert into item (product, price, count) values
('PC', 2000000, 3);

insert into item (product, price, count) values
('아이패드', 1000000, 3);

insert into item (product, price, count) values
('맥북', 3000000, 3);

insert into living (product, price, count) values
('거울', 30000, 3);

insert into living (product, price, count) values
('칫솔', 10000, 3);

insert into living (product, price, count) values
('샴푸', 8000, 3);

insert into living (product, price, count) values
('전등', 30000, 3);

insert into item (product, price, count) values
('칫솔', 10000, 3);

insert into item (product, price, count) values
('샴푸', 8000, 3);








    

