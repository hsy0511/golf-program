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
values ('100', '���ʱ�', '�ʱ޹�', 100000, '20220101');
insert into tbl_teacher_202201
values ('200', '���߱�', '�߱޹�', 200000, '20220102');
insert into tbl_teacher_202201
values ('300', '�ڰ��', '��޹�', 300000, '20220103');
insert into tbl_teacher_202201
values ('400', '����ȭ', '��ȭ��', 400000, '20220104');

create table tbl_member_202201 (
	c_no char(5) not null,
	c_name varchar2(15),
	phone varchar2(11),
	address varchar2(50),
	grade varchar2(6),
	primary key(c_no)
);

insert into tbl_member_202201
values ('10001', 'ȫ�浿', '01011112222', '����� ������', '�Ϲ�');
insert into tbl_member_202201
values ('10002', '�����', '01022223333', '������ �д籸', '�Ϲ�');
insert into tbl_member_202201
values ('10003', '�Ӳ���', '01033334444', '������ ������', '�Ϲ�');
insert into tbl_member_202201
values ('20001', '������', '01044445555', '�λ�� ����', 'VIP');
insert into tbl_member_202201
values ('20002', '�̸���', '01055556666', '�뱸�� �ϱ�', 'VIP');

create table tbl_class_202201 (
	resist_month varchar2(6) not null,
	c_no char(5) not null,
	class_area varchar2(15),
	tuition number(8),
	teacher_code char(3),
	primary key(resist_month, c_no)
);

insert into tbl_class_202201
values('202203', '10001', '���ﺻ��', 100000, '100');
insert into tbl_class_202201
values('202203', '10002', '�����п�', 100000, '100');
insert into tbl_class_202201
values('202203', '10003', '�����п�', 200000, '200');
insert into tbl_class_202201
values('202203', '20001', '�λ�п�', 150000, '300');
insert into tbl_class_202201
values('202203', '20002', '�뱸�п�', 200000, '400');

select * from TBL_TEACHER_202201
select * from tbl_member_202201
select * from tbl_class_202201

select teacher_code, teacher_name, class_name,
to_char(class_price,'999,999'),
substr(teach_resist_date,1,4) || '��' || 
substr(teach_resist_date,5,2) || '��' || 
substr(teach_resist_date,7,2) || '��' 
from tbl_teacher_202201


select substr(c.resist_month,1,4) || '��' || 
substr(c.resist_month,5,2) || '��' || 
substr(c.resist_month,7,2) || '��',
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