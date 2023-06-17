create database test;
use test;
create table tbl_member(
	member_id int unsigned auto_increment primary key,
	member_name varchar(500)
);

insert into tbl_member(member_name)
values('한동석');