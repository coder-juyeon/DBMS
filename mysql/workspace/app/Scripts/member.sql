create database app;

use app;

create table tbl_member(
   member_id int unsigned auto_increment primary key,
   member_identification varchar(500) unique not null,
   member_password varchar(500) not null,
   member_name varchar(500) not null,
   member_birth date not null,
   member_phone varchar(100) not null,
   member_email varchar(500) not null
);

drop table tbl_member;

select * from tbl_member;


INSERT INTO app.tbl_member
(member_identification, member_password, member_name, member_birth, member_phone, member_email)
VALUES('23asd', '1234', 'juyeon', '000313', '010-1234-1234', 'ere@dadf');
