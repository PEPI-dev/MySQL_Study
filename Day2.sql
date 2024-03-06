use kdt;

select * from word;

/*
	데이터 수정하기
	update 테이블명 set 필드명1 = 값1, 필드명2 = 값2 ...;  한꺼번에 바꾸기
	update 테이블명 set 필드명1 = 값1, 필드명2 = 값2 ... where 조건절; 조건을 통해 바꾸기
*/

update word set lev = 2 where eng = 'orange';  # where 뒤에 일어나는 '=' 연산자는 if문처럼 같다면 이라는 연산자이다.
-- You are using safe update mode and you tried to update a table without a WHERE
update word set lev = 2; # Safe 모드 걸린 코드
-- set sql_safe_updates = 0;  일시적인 Safe모드 해제
-- Workbench Preferences에서 SQL Editor -> Safe Updates 체크 해제

set sql_safe_updates = 0;
update word set lev=2;

-- insert into word values('orange','오렌지',2);

select * from member;

-- 모든 유저에게 50 point 더해주기

update member set point = point + 50;

-- 아이디가 'orange'인 회원에 대해 우편번호는 '12345', 주소1은 '서울시 서초구'
-- 주소2는 '양재동', 주소3은 'xx아파트 201동'으로 수정

update member set zipcode = 2,address1 = '서울시 서초구',address2 = '양재동',address3 = 'xx아파트 201동' where userid = 'orange';

/* 
	데이터 삭제
	delete from 테이블명;
    delete from 테이블명 where 조건철;
    
*/
delete from word where eng = 'avocado';
select * from word;

/* 
	SQL 연산자
    1. 산술 연산자 : + , - , * , /(나눗셈), mod(나머지 연산자), div(몫)
    2. 비교 연산자 : = ( 다른언어의 ==와 같은상황이있음), < , > , >= , <= , <> ( 다르다 )
    3. 대입 연산자 : = 
    4. 논리 연산자 : and , or, not , xor
    5. 기타 연산자
		is : 양쪽의 피연산자가 모두 같으면 True, 아니면 False
        between A and B : 값이 A보다는 크거나 같고, B보다는 작거나 같으면 True, 아니면 False
        in : 매개변수로 전달된 리스트에 값이 존재하면 True , 아니면 False
        like : 패턴으로 문자열을 검색하여 값이 존재하면 True, 아니면 False
        
*/

/*
	데이터 검색하기
	select 필드명1, 필드명2, ... from 테이블명;
*/
select eng from word;
select eng,kor from word;

select 100;  # 결과 : 100
select 100 + 50; # 결과 : 150

-- 별명
select 100 + 50 as '덧셈'; # 결과 : 덧셈 항목 150
select 100 + 50 as 덧셈; # 따옴표 없어도 댐
select 100 + 50 as 덧셈 연산; # 띄어쓰기를 사용하면 에러발생
select 100 + 50 as '덧셈 연산'; # 따옴표를 사용하는 이유는 띄어쓰기를 사용할수도 있어서
select 100 + 50 '덧셈';

select eng '영단어', kor '뜻' from word;

-- * : 모든 컬럼 가져오기
select * from word; # word 테이블에 속한 모든 컬럼을 가져온다. (추천하지는 않음)
select * from member;

-- null과 ''의 차이 비교해보기
select null; # 데이터가 없음, insert 가 되지 않은 것
select ''; # 해당 셀에 ''(공백) 데이터가 삽입된 것
select 100 + null; # sql에서는 null과 연산이 불가능해서 결과는 null이다.
select 100+''; # 결과 100, 연산 가능

/*
	조건절
    select 필드명1, 필드명2, ... from 테이블명 where 조건절;
*/
select * from member where userid = 'apple';
select * from member where gender = '남자';
select * from member where point >= 200; # point가 200이상인 유저를 모두 출력

-- 로그인
select * from member where userid = 'apple' and userpw = '1234';
select * from member where userid = 'apple' and userpw = '1111';
select * from member;

# zipcode가 null인 필드를 찾기
select * from member where zipcode = 'null '; # x
select * from member where zipcode = null; # x
select * from member where zipcode is null;
select * from member where zipcode is not null;

select * from member where point between 300 and 500; # 300이상 500이하

select * from member where point >= 300 and point <= 500;

select * from member where name in ('김사과','바나나','오렌지');

select * from member where userid like 'a%'; # a로 시작하는 문자열
select * from member where userid like '%a'; # a로 끝나는 문자열
select * from member where userid like '%a%'; # a를 포함하는 문자열
select * from member where userid like 'ap%'; # ap로 시작하는 문자열

/*
	정렬
	select 필드명1, 필드명2, ... from 테이블명 [where 조건절] order by 정렬할 필드명 [asc, desc];
*/
select * from member order by userid asc; # userid로 오름차순
select * from member order by userid; # userid로 오름차순
select * from member order by userid desc; # userid로 내림차순

-- 포인트순으로 오름차순을 하고, 포인트가 같다면 userid로 내림차순
select * from member order by point asc, userid desc;

-- 남자인 회원중에서 아이디를 내림차순으로 정렬하여 출력
select * from member where gender = '남자' order by userid desc;

/*
	limit
	select 필드명1, 필드명2, .. from 테이블명 limit 가져올 로우의 갯수
    select 필드명1, 필드명2, .. from 테이블명 limit 시작로우(인덱스),마지막로우(인덱스) # 인덱스 범위 지정해서 가져올 로우의 갯수
    select 필드명1, 필드명2, .. from 테이블명 order by 정렬할 필드명 [asc,desc] limit 가져올 로우의 갯수
*/
select * from member;
select * from member limit 3;  # 3개의 로우를 가져옴
select * from member limit 2,2; # 3번쨰 인덱스가져옴
select * from member order by point desc limit 3; 

-- 집계 함수
-- count: 행의 갯수를 세는 함수
select * from member;
select count(*) 전체인원 from member;
select count(*) as 전체인원 from member;
select count(userid) from member; -- primary key를 선택하는 것을 추천
select count(zipcode) from member; -- null을 포함하지 않음

-- sum : 행의 값을 더함
select sum(point) as 포인트합 from member;
select userid, sum(point) as 포인트합 from member; # select절에 일반 컬럼을 쓰지 못함

-- avg : 행의 평균을 구함
select avg(point) as 평균 from member;
select avg(point) as '여성 평균' from member where gender = '여자';

-- min : 행의 최솟값 구함
select min(point) as 최소 from member;
select min(point) as '남성 평균' from member where gender = '남자';

-- max : 행의 최댓값 구함
select max(point) as 최대 from member;

/*
	그룹
    select 그룹을 맺을 컬럼 또는 집계함수 from 테이블명 group by 그룹을 맺을 필드명;
    select 그룹을 맺을 컬럼 또는 집계함수 from 테이블명 group by 그룹을 맺으 필드명 having 조건절;
*/
select * from member;
select gender from member group by gender;
select gender, sum(point) as '합계' from member group by gender;    
select gender, count(userid) as '인원수' from member group by gender;
select gender from member group by gender having gender = '여자';

-- 포인트가 0을 초과하는 회원들 중에서 남자, 여자로 그룹을 나눠 포인트의 평균을 구하고
-- 평균 포인트가 150 이상인 성별에 대해 출력
-- (단, 포인트가 많ㅇ느 성별을 우선으로 출력)
select gender,avg(point) as '성별 평균' from member where point > 150 group by gender order by gender desc; # 내 풀이

select gender,avg(point) as avg from member where point > 0  # 교수님 풀이
group by gender having avg >= 150 order by avg desc;

-- 프로필 테이블 생성
create table profile(
	userid varchar(20) not null,     
    height double,
    weight double,
    mbti varchar(10),
    foreign key(userid) references member(userid)    # 참조키를 member 테이블의 userid를 참조한다는 뜻
);

desc profile;

insert into profile values ('grapes',190,100,'ESTP');
insert into profile values ('apple',160,50,'ISTP');
insert into profile values ('orange',170,60,'ENFP');
insert into profile values ('banana',155,45,'ISTJ');

/*
	조인
    select 필드명1,필드명2, ... from 테이블1 [inner,left,right] join 테이블2
    on 테이블1.연결할필드 = 테이블2.연결할필드
*/

select * from member;
select * from profile;

-- inner 조인
-- 조인하는 테이블의 on 절의 조건이 일치하는 결과만 출력
-- 두 테이블의 교집합
-- join, inner join, corss join 모두 같은 의미로 사용됨
select m.userid,m.name,m.gender,p.mbti from member m inner join profile p
on m.userid = p.userid;

-- left/right outer 조인
-- 두 테이블이 조인될 때 왼쪽/오른쪽을 기준으로 기준 테이블의 데이터를 모두 출력
-- outer join은 조인하는 테이블의 on 절의 조건 중 한쪽의 데이터를 모두 가져옴
select m.userid, m.name, m.gender, p.mbti from member m left outer join 
profile p on m.userid = p.userid;

select m.userid, m.name, m.gender, p.mbti from member m right outer join 
profile p on m.userid = p.userid;

/*
	데이터 정규화
	- 데이터 베이스를 설계할 때 중복을 최소화하는 것
    - 조직화되어 있지 않은 테이블과 관계들을 조직화된 테이블과 관계들로 나누는 것
    
    데이터 정규화가 필요한 경우
    - 데이터를 갱신, 삽입, 삭제하는 등의 테이블을 수정할 때.. 원하지 않게 데이터가 삭제되거나 가공되는 일이 발생할 수 있음 -> '이상 현상'
    - '이상 현상' 이 발생할 가능성이 있다면 정규화가 반드시 필요
    
/*
	정규화의 종류
	1. 1NF(제 1정규화)
	- 테이블 안의 모든 값들은 단일 값이어야 함
    - 더 이상 쪼개질 수 없는 단위로 저장
    2. 2NF(제 2정규화)
    - 1NF를 만족하면서, 완전 함수 종속성을 가진 관계들로만 테이블 생성
    - 종속성들 중 중속 관계에 있는 열들끼리 테이블을 구분해 주는 것
    - 기본키에 속하지 않은 속성 모두가 기본키에 완전 함수 종속인 정규형
    - 함수 종속성 : x값에 따라 y값이 결정되는 경우
    3. 3NF(제 3정규화)
    - 2NF를 만족하면서, 기본키에 대해 이행적 함수 종속이 되지 않는 것을 의미
    4. 비정규화
    - 정규형에 일치하게 되어 있는 테이블을 정규형을 지키지 않는 테이블로 변경
    - 테이블을 조회하는 용도로 사용하거나, 너무 데이터가 많이 나뉘어 성능이 저하된다면 비정규화를 하여
    테이블을 다루는 것이 더 효율적일 수 있음
    - 어떤 작업을 수행하는지, 어떤 데이터를 사용하는지에 따라 적절한 정규화를 하는 것이 좋음
*/
