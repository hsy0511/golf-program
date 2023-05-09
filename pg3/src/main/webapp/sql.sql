drop table tbl_teacher_202201
drop table tbl_member_202201
drop table tbl_class_202201

create table tbl_teacher_202201 (
	teacher_code char(3) not null,
	teacher_name varchar2(15),
	class_name varchar2(20),
	class_price number(8),
	teach_resist_date varchar2(8),
	primary key(teacher_code)
);

insert into tbl_teacher_202201
values ('100', '이초급', '초급반', 100000, '20220101');
insert into tbl_teacher_202201
values ('200', '김중급', '중급반', 200000, '20220102');
insert into tbl_teacher_202201
values ('300', '박고급', '고급반', 300000, '20220103');
insert into tbl_teacher_202201
values ('400', '정심화', '심화반', 400000, '20220104');

create table tbl_member_202201 (
	c_no char(5) not null,
	c_name varchar2(15),
	phone varchar2(11),
	address varchar2(50),
	grade varchar2(6),
	primary key(c_no)
);

insert into tbl_member_202201
values ('10001', '홍길동', '01011112222', '서울시 강남구', '일반');
insert into tbl_member_202201
values ('10002', '장발장', '01022223333', '성남시 분당구', '일반');
insert into tbl_member_202201
values ('10003', '임꺽정', '01033334444', '대전시 유성구', '일반');
insert into tbl_member_202201
values ('20001', '성춘향', '01044445555', '부산시 서구', 'VIP');
insert into tbl_member_202201
values ('20002', '이몽룡', '01055556666', '대구시 북구', 'VIP');

create table tbl_class_202201 (
	resist_month varchar2(6) not null,
	c_no char(5) not null,
	class_area varchar2(15),
	tuition number(8),
	teacher_code char(3),
	primary key(resist_month, c_no)
);

insert into tbl_class_202201
values('202203', '10001', '서울본원', 100000, '100');
insert into tbl_class_202201
values('202203', '10002', '성남분원', 100000, '100');
insert into tbl_class_202201
values('202203', '10003', '대전분원', 200000, '200');
insert into tbl_class_202201
values('202203', '20001', '부산분원', 150000, '300');
insert into tbl_class_202201
values('202203', '20002', '대구분원', 200000, '400');

select * from TBL_TEACHER_202201
select * from tbl_member_202201
select * from tbl_class_202201

select teacher_code, teacher_name, class_name,
to_char(class_price,'999,999'),
substr(teach_resist_date,1,4) || '년' || 
substr(teach_resist_date,5,2) || '월' || 
substr(teach_resist_date,7,2) || '일' 
from tbl_teacher_202201


select substr(c.resist_month,1,4) || '년' || 
substr(c.resist_month,5,2) || '월' || 
substr(c.resist_month,7,2) || '일',
m.c_no, m.c_name, t.class_name, c.class_area, 
to_char(class_price,'999,999'), m.grade 
from tbl_teacher_202201 t, tbl_member_202201 m, tbl_class_202201 c
where m.c_no = c.c_no and t.teacher_code = c.teacher_code


select c.teacher_code, t.class_name, t.teacher_name, 
to_char(sum(c.tuition),'L999,999') 
from tbl_teacher_202201 t, tbl_class_202201 c 
where t.teacher_code = c.teacher_code 
group by c.teacher_code, t.class_name, t.teacher_name 
order by teacher_code