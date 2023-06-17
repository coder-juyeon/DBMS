create database jimCarry;
use jimCarry;
/*회원*/
create table tbl_user (
user_id bigint unsigned auto_increment primary key,
user_identification varchar(100) not null,
user_password varchar(100) not null,
user_name varchar(50) not null,
user_email varchar(100) not null,
user_phone varchar(100) not null,
user_address varchar(100) not null,
user_address_detail varchar(100) not null,
user_gender varchar(100) check(user_gender in(‘남’,‘여’, ‘선택 안함‘)),
user_birth varchar(50),
user_random_key varchar(50) default null,
user_status tinyint default 0
);

 /*창고등록하기*/
create table tbl_storage(
storage_id bigint unsigned auto_increment primary key,
user_id bigint unsigned,
storage_name varchar(50) not null,
storage_phone varchar(80) not null,
storage_title varchar(80) not null,
storage_size varchar(50) not null check(storage_size in('소', '중', '대', '특대')),
storage_price int default 0,
storage_address varchar(300) not null,
storage_address_detail varchar(300) not null,
storage_use_date varchar(50) not null,
storage_end_date varchar(50) not null,
storage_address_number int,
constraint fk_storage_user foreign key(user_id) references tbl_user(user_id)
);

/*문의하기*/
create table tbl_inquiry(
inquiry_id int unsigned auto_increment primary key,
user_id bigint unsigned not null,
inquiry_title varchar(500) not null,
inquiry_content varchar(1000) not null,
inquiry_regist datetime default current_timestamp(),
inquiry_answer tinyint default 0,
constraint fk_inquiry_user foreign key(user_id) references tbl_user(user_id)
);
drop table tbl_inquiry;
drop table tbl_file;
drop table tbl_storage;
drop table tbl_review;
drop table tbl_review_file;
drop table tbl_payment;
drop table tbl_inquiry_file;
drop table tbl_notice;
 /*창고등록 파일*/
create table tbl_file (
file_id bigint unsigned auto_increment primary key,
storage_id bigint unsigned,
file_path varchar(500) not null,
file_org_name varchar(500) not null,
file_uuid varchar(500) unique not null,
constraint fk_file_storage foreign key(storage_id) references tbl_storage(storage_id)
);
/*공지사항*/
create table tbl_notice (
notice_id int unsigned auto_increment primary key,
notice_title varchar(80) not null,
notice_content varchar(1000) not null,
notice_writer varchar(50),
notice_regist date default (current_date),
notice_update date default (current_date)
);
/*결제하기*/
create table tbl_payment (
pay_id bigint unsigned auto_increment primary key,
user_id bigint unsigned not null,
storage_id bigint unsigned not null,
payment_amount int default 0,
payment_date datetime default current_timestamp(),
constraint fk_payment_user foreign key(user_id) references tbl_user(user_id),
constraint fk_payment_storage foreign key(storage_id) references tbl_storage(storage_id)
);
/*리뷰*/
create table tbl_review (
review_id bigint unsigned auto_increment primary key,
user_id bigint unsigned,
storage_id bigint unsigned,
review_title varchar(30) not null,
review_context varchar(1000) not null,
review_write_date datetime default current_timestamp(),
review_edit_date datetime default current_timestamp(),
constraint fk_review_user foreign key(user_id) references tbl_user(user_id),
constraint fk_review_storage foreign key(storage_id) references tbl_storage(storage_id)
);
/*리뷰 파일*/
create table tbl_review_file (
review_file_id bigint unsigned auto_increment primary key,
review_id bigint unsigned,
review_file_path varchar(500) not null,
review_org_name varchar(500) not null,
review_file_uuid varchar(500) unique not null,
constraint fk_file_review_id foreign key(review_id) references tbl_review(review_id)
);
/*문의 등록 파일 */
create table tbl_inquiry_file (
inquiry_file_id bigint unsigned auto_increment primary key,
inquiry_id int unsigned,
inquiry_file_path varchar(500) not null,
inquiry_org_name varchar(500) not null,
inquiry_file_uuid varchar(500) unique not null,
constraint fk_file_inquiry_id foreign key(inquiry_id) references tbl_inquiry(inquiry_id)
);

/*창고등록 파일*/
create table tbl_storage_file (
storage_file_id bigint unsigned auto_increment primary key,
storage_id bigint unsigned,
storage_file_path varchar(500) not null,
storage_file_org_name varchar(500) not null,
storage_file_uuid varchar(500) unique not null,
constraint fk_file_storage foreign key(storage_id) references tbl_storage(storage_id) on delete cascade
);

INSERT INTO jimcarry.tbl_user
(user_identification, user_password, user_email, user_phone, user_address, user_address_detail, user_gender, user_birth)
VALUES('', '', '', '', '', '', '', '');




select storage_id, u.user_id,  storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date,
        user_identification, user_email, user_phone, user_address, user_address_detail, user_gender, user_birth, user_name
        from
        (
        select user_id, user_identification, user_email, user_phone, user_address, user_address_detail, user_gender, user_birth, user_name
        from tbl_user
        ) u
        join
        (
        select storage_id, user_id,  storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date
        from tbl_storage
        ) r on u.user_id = r.user_id
        order by storage_id desc

INSERT INTO jimcarry.tbl_storage
(user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date)
VALUES(3, '역삼역창고', '중', 50000, '서울시 강남구 역삼동', '303동', '2023-03-25', '2023-09-25');

select * from tbl_user;
delete from tbl_user where user_id = 8;
select * from tbl_storage;
select * from tbl_review;
select * from tbl_payment;
select * from tbl_storage_file;

truncate table tbl_storage;
/* foreign key = 0 이면 해제 1이면 true*/
set FOREIGN_KEY_CHECKS = 0;

INSERT INTO jimcarry.tbl_storage
(user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date, storage_name, storage_phone, storage_address_number)
VALUES(, '', '', 0, '', '', '', '', '', '', 0);

/*리뷰와 파일 추가*/
INSERT INTO jimcarry.tbl_review
(user_id, storage_id, review_title, review_context)
VALUES(11, 1, '넓습니다', '친절하고 좋았어요');
INSERT INTO jimcarry.tbl_review_file
(review_id, review_file_path, review_org_name, review_file_uuid)
VALUES(16, '2023/04/04', 'icon4.png', '32787ed8-3c05-48cd-966c-6866de7b2196');

INSERT INTO jimcarry.tbl_storage_file
(storage_id, storage_file_path, storage_file_org_name, storage_file_uuid)
VALUES(16, '2023/04/04', 'icon4.png', '32787ed8-3c05-48cd-966c-6866de7b2196');


select review_id, u.user_id, storage_id, review_title, review_context, review_write_date, review_edit_date, user_identification, user_password, user_email, user_phone, user_address, user_address_detail, user_gender, user_birth, user_name
from tbl_user u join tbl_review r on r.user_id = u.user_id
where storage_id = 8;

insert into jimcarry.tbl_review
(user_id, storage_id, review_title, review_context)
values(4, 13, 'userServiceTest의 리뷰1', 'userServiceTest의 리뷰context');

/*지역별 창고 inisert*/
INSERT INTO jimcarry.tbl_storage
(user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date, storage_name, storage_phone, storage_address_number)
VALUES(0, '', '', 0, '', '', '', '', '', '', 0);


insert into jimcarry.tbl_storage
(user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date, storage_name, storage_phone, storage_address_number)
values(7, 'user7의창고', '소', 28000, '경북 경산시 감못둑길 80', '305동', '2023-07-01', '2023-11-01', 'user7', '010-3142-3432', '6');


insert into jimcarry.tbl_storage
(user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date, storage_name, storage_phone, storage_address_number)
values(6, 'user6의창고', '중', 56000, '경북 경산시 감못둑길 80', '305동', '2023-07-01', '2023-12-01','user6', '010-3142-3432', '6');

insert into jimcarry.tbl_storage
(user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date, storage_name, storage_phone, storage_address_number)
values(4, 'user4의창고', '중', 56000, '충북 괴산군 감물면 감물로 37', '305동', '2023-03-01', '2023-12-01', 'user4', '010-3142-3432', '4');

insert into jimcarry.tbl_storage
(user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date, storage_name, storage_phone, storage_address_number)
values(3, 'user3의창고', '중', 56000, '충북 괴산군 감물면 감물로 37', '305동', '2023-05-01', '2023-08-01', 'user3', '010-3142-3432', '4');

insert into jimcarry.tbl_storage
(user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date, storage_name, storage_phone, storage_address_number)
values(3, 'user2의창고', '중', 56000, '강원 강릉시 가작로 6', '305동', '2023-05-01', '2023-08-01', 'user2', '010-3142-3432', '3');
/*------------- */


INSERT INTO jimcarry.tbl_user
(user_identification, user_password, user_email, user_phone, user_address, user_address_detail, user_gender, user_birth, user_name)
VALUES('user2', '1234', 'user2@gmail.com', '010-1222-1234', 'user2address', 'user2address detail', '남', '1998-03-01', 'user2name');

select storage_id, u.user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date,user_identification, user_password, user_email, user_phone, user_address, user_address_detail, user_gender, user_birth, user_name 
from tbl_user u join tbl_storage s on u.user_id  = s.user_id;

select storage_id, u.user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date,
        user_identification, user_email, user_phone, user_address, user_address_detail, user_gender, user_birth, user_name
        from
        (
        select user_id, user_identification, user_email, user_phone, user_address, user_address_detail, user_gender, user_birth, user_name
        from tbl_user
        ) u
        join
        (
        select storage_id, user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date
        from tbl_storage
        ) r on u.user_id = r.user_id
        having storage_address like '%경기%'
        order by storage_id desc;

INSERT INTO jimcarry.tbl_payment
(user_id, storage_id, payment_amount)
VALUES(3, 1, 28000);

SELECT storage_id, user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date, storage_name
FROM jimcarry.tbl_storage;

select count(review_id)
from tbl_review;

select count(storage_id) from tbl_storage where storage_address_number = 0;
select user_id, count(storage_id) from tbl_storage group by user_id;

INSERT INTO jimcarry.tbl_file
(storage_id, file_path, file_org_name, file_uuid)
VALUES(2, 'asdf', 'asdf', '한글');

INSERT INTO jimcarry.tbl_storage_file
(storage_id, storage_file_path, storage_file_org_name, storage_file_uuid)
VALUES(2, 'asdf.img', 'file_org_name.img', 'asdfsadfasdf341');


/*상세페이지 창고 대표사진 불러오기*/
select storage_file_id, storage_id, storage_file_path, storage_file_org_name, storage_file_uuid
from jimcarry.tbl_storage_file
where storage_id = 31;

SELECT review_file_id, review_id, review_file_path, review_org_name, review_file_uuid
FROM jimcarry.tbl_review_file;


/*상세페이지 리뷰 사진 목록 불러오기*/
select review_id, user_id, r.storage_id, review_title, review_context, review_write_date, review_edit_date, storage_file_id, storage_file_path, storage_file_org_name, storage_file_uuid
from jimcarry.tbl_review r join tbl_review_file f on r.review_id = f.review_id
where storage_id


select review_file_id, review_id, review_file_path, review_org_name, review_file_uuid
from jimcarry.tbl_review_file;
where storage_id = 1;