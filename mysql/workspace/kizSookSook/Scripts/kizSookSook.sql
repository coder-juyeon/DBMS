create database kids;
use kids;
​

create table tbl_user(
	user_id bigint unsigned auto_increment primary key,
	user_identification varchar(300) not null,
	user_password varchar(300) not null,
	user_email varchar(300) unique not null,
	user_phoneNumber varchar(300),
	user_address varchar(300),
	user_address_detail varchar(300),
	user_register_date datetime default now()
);
​

create table tbl_member (
	user_id bigint unsigned,
	member_name varchar(300) not null,
	member_nickname varchar(300) /*not null*/,
	member_gender varchar(300), 
	constraint fk_member_id foreign key(user_id) references tbl_user(user_id), 
	constraint primary key(user_id)
);
​

create table tbl_institution (
	user_id bigint unsigned auto_increment,
	institution_name varchar(300),
	institution_business_number varchar(300),
	constraint fk_institution_id foreign key(user_id) references tbl_user(user_id), 
	constraint primary key(user_id)
);
​

create table tbl_member_file(
	file_id int unsigned auto_increment primary key,
	user_id bigint unsigned,
	file_path varchar(300) not null,
	system_name varchar(300) not null,
	org_name varchar(300) not null,
	constraint fk_member_file foreign key(user_id) references tbl_member(user_id)
);
​
​
drop table tbl_member_file;
drop table tbl_member;
​

create table tbl_institution_file (
	institution_file_id int unsigned auto_increment primary key,
	user_id bigint unsigned,
	institution_file_path varchar(300) not null,
	institution_system_name varchar(300) not null,
	institution_org_name varchar(300) not null,
	constraint fk_institution_file foreign key(user_id) references tbl_institution(user_id)
);
​

create table tbl_customer_enquiry (
	enquiry_id bigint unsigned auto_increment primary key,
	user_id bigint unsigned,
	user_email varchar(300),
	enquiry_title varchar(300) not null,
	enquiry_content varchar(300) not null,
	enquiry_date datetime not null,
	enquiry_confirm boolean,
	constraint fk_customer_enquiry foreign key(user_id) references tbl_user(user_id),
	constraint fk_customer_email foreign key(user_email) references tbl_user(user_email)
);
​

create table tbl_enquiry_file (
	enquiry_file_id int unsigned auto_increment primary key,
	enquiry_id bigint unsigned,
	enquiry_filePath varchar(500) not null,
	enquiry_system_name varchar(300) not null,
	enquiry_org_name varchar(300) not null,
	constraint fk_enquiry_file foreign key(enquiry_id) references tbl_customer_enquiry(enquiry_id)
);
​
drop table tbl_enquiry_file;
​

create table tbl_category(
	category_id int unsigned auto_increment primary key,
	category_name varchar(200) not null
);
​

create table tbl_field_trip (
	field_trip_id bigint unsigned auto_increment primary key,
	user_id bigint unsigned,
	category_id int unsigned,
	field_trip_registation_date datetime default now(),
	field_trip_name varchar(300),
	field_trip_deadline_date datetime,
	field_trip_program_date date,
	field_trip_place varchar(300),
	field_trip_price int default '0',
	field_trip_context_description varchar(800),
	constraint fk_field_trip_user_id foreign key(user_id) references tbl_user(user_id),
	constraint fk_field_trip_category_id foreign key(category_id) references tbl_category(category_id)
);

create table tbl_field_trip_file (
	field_trip_file_id int unsigned auto_increment primary key,
	field_trip_id bigint unsigned,
	field_trip_filePath varchar(500) not null,
	field_trip_system_name varchar(300) not null,
	field_trip_org_name varchar(300) not null,
	constraint fk_field_trip_file_fieldTrip_id foreign key(field_trip_id) references tbl_field_trip(field_trip_id)
);

create table tbl_review (
	review_id bigint unsigned auto_increment primary key,
	user_id bigint unsigned,
	field_trip_id bigint unsigned,
	review_write_date date,
	review_alter_date date,
	review_good int not null,
 	review_title varchar(300),
 	review_context varchar(1000),
 	constraint fk_review_user_id foreign key(user_id) references tbl_user(user_id),
 	constraint fk_review_id foreign key(field_trip_id) references tbl_field_trip(field_trip_id)
);
​

create table tbl_field_trip_recommend (
	field_trip_recommend_id int unsigned auto_increment primary key,
	user_id bigint unsigned,
	field_trip_id bigint unsigned,
	constraint fk_field_trip_recommend_user_id foreign key(user_id) references tbl_user(user_id),
 	constraint fk_field_trip_recommend_id foreign key(field_trip_id) references tbl_field_trip(field_trip_id)
);


create table tbl_review_file (
	review_file_id int unsigned auto_increment primary key,
	review_id bigint unsigned,
	review_file_filePath varchar(500) not null,
	review_file_system_name varchar(300) not null,
	review_file_org_name varchar(300) not null,
	constraint review_file_review_id foreign key(review_id) references tbl_review(review_id)
);
​

create table tbl_payment (
payment_id int unsigned auto_increment primary key,
user_id bigint unsigned,
field_trip_id bigint unsigned,
payment_headcount int,
payment_amount int default '0',
payment_date datetime default now(),
constraint payment_user_id foreign key(user_id) references tbl_member(user_id) on delete cascade,
constraint payment_field_trip_id foreign key(field_trip_id) references tbl_field_trip(field_trip_id) on delete cascade
);



create table tbl_customer_notice (
	notice_id int unsigned auto_increment primary key,
	notice_title varchar(200) not null,
	notice_context varchar(1000) not null,
	notice_date date,
	notice_alter_date date
);
​

create table tbl_cash (
	cash_id bigint unsigned auto_increment primary key,
	user_id bigint unsigned,
	payment_cash tinyint,
	review_cash tinyint,
	cash_save_date datetime,
	review_save_date datetime,
	constraint cash_member_id foreign key(user_id) references tbl_member(user_id)
);
​
create table tbl_field_trip_detail(
		field_trip_id bigint unsigned auto_increment primary key,
		field_trip_detail_context varchar(300),
		field_trip_detail_institution_info varchar(300),
		field_trip_detail_use_time varchar(50),
		field_trip_detail_refund_policy varchar(1000),
		field_trip_detail_one_review varchar(1000),
		constraint fk_field_trip_detail foreign key(field_trip_id) references tbl_field_trip(field_trip_id)
);

create table tbl_cash_history(
   cash_history_id bigint unsigned auto_increment primary key,
    user_id bigint unsigned,
    payment_cash int default 0,
   review_cash int default 0,
    cash_save_date datetime,
    review_save_date datetime,
    constraint cash_histroy_member_id foreign key(user_id) references tbl_member(user_id) on delete cascade
);

/* DTO 용 VIEW */
-- tbl_member, tbl_user tbl_member_file join뷰
create or replace view view_member_info as
select m1.user_id, member_name, member_nickname, member_gender, user_identification, 
user_password, user_email, user_phoneNumber, user_address, user_address_detail, user_register_date,
mf.file_id, mf.system_name, mf.org_name
from
(
	select u.user_id, member_name, member_nickname, member_gender, user_identification, 
	user_password, user_email, user_phoneNumber, user_address, user_address_detail, user_register_date
	from tbl_member m join tbl_user u 
	on m.user_id = u.user_id
)m1 join tbl_member_file mf
on m1.user_id = mf.user_id;


select * from tbl_user;

select user_id, member_name, member_nickname, member_gender, user_identification, user_password,
			user_email, user_phoneNumber, user_address, user_address_detail, user_register_date, file_id, system_name, org_name
			from tbl_user u join tbl_member m
			on u.user_id  = m.user_id
			where user_id = 1;


select m.user_id, member_name, member_nickname, member_gender, user_identification, 
user_password, user_email, user_phoneNumber, user_address, user_register_date
from tbl_member m join tbl_user u 
on m.user_id = u.user_id

select m.user_id, member_name, member_nickname, member_gender, user_identification, 
user_password, user_email, user_phoneNumber, user_address, user_register_date
from tbl_member m join tbl_user u 
on m.user_id = u.user_id

-- tbl_institution, tbl_user tbl_institution_file join뷰
create view view_institution_info as
select t1.user_id, institution_name , institution_business_number , user_identification, 
	user_password, user_email, user_phoneNumber, user_address, user_register_date,
	tf.institution_file_id, tf.institution_file_path, tf.institution_system_name, tf.institution_org_name
from 
(
	select t.user_id, institution_name , institution_business_number , user_identification, 
	user_password, user_email, user_phoneNumber, user_address, user_register_date
	from tbl_institution t join tbl_user u 
	on t.user_id = u.user_id
)t1 join tbl_institution_file tf 
on t1.user_id = tf.user_id;

-- tbl_field_trip, tbl_category, tbl_field_trip_file
create view view_field_trip as
select d1.field_trip_id, field_trip_name, category_name, user_id, field_trip_registation_date, field_trip_deadline_date, 
field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description,
field_trip_filePath, field_trip_system_name, field_trip_org_name
from
(
	select field_trip_id, field_trip_name, category_name, user_id, field_trip_registation_date, field_trip_deadline_date, 
	field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description
	from tbl_category c join tbl_field_trip t
	on c.category_id = t.category_id
) d1 join tbl_field_trip_file tf
on d1.field_trip_id = tf.field_trip_id;

create view view_field_tripDTO as
select f.field_trip_id, category_name, user_id, field_trip_registation_date, field_trip_deadline_date,
field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description, d1.recommend_count,
field_trip_filePath, field_trip_system_name, field_trip_org_name, field_trip_name
from view_field_trip f
left outer join
(
select r.field_trip_id , count(r.field_trip_recommend_id) as recommemd_count
from tbl_field_trip_recommend r
group by r.field_trip_id
) d1
on f.field_trip_id = d1.field_trip_id;

create view view_field_tripDTO as
select f.field_trip_id, category_id, category_name, user_id, field_trip_name, field_trip_registation_date, field_trip_deadline_date,
field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description,
ifnull(d1.recommemd_count, 0) as recommend_count,
field_trip_system_name, field_trip_org_name
from view_field_trip f
left outer join
(
select r.field_trip_id , count(r.field_trip_recommend_id) as recommemd_count
from tbl_field_trip_recommend r
group by r.field_trip_id
) d1


create view view_field_trip_top10 as
select d1.field_trip_id, user_id, category_id, field_trip_name, field_trip_registation_date,
field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price,
field_trip_context_description,
field_trip_filePath, field_trip_system_name, field_trip_org_name
from tbl_field_trip_file tftf right outer join
(
select tft.field_trip_id, tft.user_id, category_id, field_trip_name, field_trip_registation_date,
field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description
from tbl_field_trip tft join tbl_payment tp
on tft.field_trip_id = tp.field_trip_id and payment_date > date_add(now(), interval -7 day)
group by field_trip_id
order by count(payment_headcount) desc
limit 10
) d1
on tftf.field_trip_id = d1.field_trip_id;

============================================
INSERT INTO kids.tbl_user
(user_identification, user_password, user_email, user_address, user_register_date)
VALUES('dawn43', '1234', 'dawn43@naver.com', '서울시 송파구', CURRENT_TIMESTAMP);


INSERT INTO kids.tbl_user
(user_identification, user_password, user_email, user_address, user_register_date)
VALUES('hds1234', '5678', 'hds1234@naver.com', '서울시 송파구', CURRENT_TIMESTAMP);


INSERT INTO kids.tbl_user
(user_identification, user_password, user_email, user_address, user_register_date)
VALUES('dawn431', '1235', 'dawn431@naver.com', '서울시 송파구', CURRENT_TIMESTAMP);
​
truncate table tbl_member;  

INSERT INTO kids.tbl_member
(member_id, member_identification, member_phoneNumber, member_gender)
VALUES((select user_id from tbl_user where user_identification = 'dawn43'), '1234','01029670403', '여자');
​
INSERT INTO kids.tbl_member
(member_identification, member_phoneNumber, member_gender)
VALUES('1234','01029670403', '여자');
​
INSERT INTO kids.tbl_member
(member_identification, member_phoneNumber, member_gender)
VALUES('1234','01029670403', '여자');
​
INSERT INTO kids.tbl_institution
(institution_name, institution_business_number)
VALUES('', '');
​
INSERT INTO kids.tbl_member
(user_id, member_name, member_nickname, member_gender)
VALUES(1, '은서', '새벽43', '여');


INSERT INTO kids.tbl_user
(user_identification, user_password, user_email, user_phoneNumber, user_address, user_register_date)
VALUES('kjy12', 'password1234', 'kjy12@naver.com', '010-1234-5678', '서울시 송파구', CURRENT_TIMESTAMP);

INSERT INTO kids.tbl_member
(user_id, member_name, member_nickname, member_gender)
VALUES(5, '김주연', '쭈', '여');

INSERT INTO kids.tbl_category
(category_name)
VALUES('역사');

INSERT INTO kids.tbl_payment
(user_id, field_trip_id, payment_amount, payment_date)
VALUES(4, 1, 30000, '2023-02-27');

INSERT INTO kids.tbl_field_trip
(user_id, category_id, field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description)
VALUES(4, 1, CURRENT_TIMESTAMP, '2023-03-25', '2023-04-01', '역삼동', 30000, '역사체험을 해보세요');

INSERT INTO kids.tbl_field_trip_file
(field_trip_id, field_trip_filePath, field_trip_system_name, field_trip_org_name)
VALUES(1, '', '', '');

INSERT INTO kids.tbl_user
(user_identification, user_password, user_email, user_phoneNumber, user_address, user_register_date)
VALUES('test12', '1234', 'test@g', '010-3333-3333', '강남구', CURRENT_TIMESTAMP);

INSERT INTO kids.tbl_institution
(institution_name, institution_business_number)
VALUES('코리아아이티아카데미', '703-383123-03134');

INSERT INTO kids.tbl_customer_enquiry
(user_id, user_email, enquiry_title, enquiry_content, enquiry_date, enquiry_confirm)
VALUES(4, 'kjy12@naver.com', '환불했는데 돈이 안들어와요', '과학 체험학습 등록일 하루전날에 환불했는데 돈이 안들어왔어요 어떡하죠', '2023-03-06', false);

INSERT INTO kids.tbl_category
(category_name)
VALUES('역사');


INSERT INTO kids.tbl_field_trip
(user_id, category_id, field_trip_name, field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description)
VALUES(1, 1, '역사체험',CURRENT_TIMESTAMP, '2023-03-25', '2023-04-01', '역삼동', 30000, '역사체험을 해보세요');

INSERT INTO kids.tbl_member
(user_id, member_name, member_nickname, member_gender)
VALUES(1, '김주연', '쭈', '여');

INSERT INTO kids.tbl_payment
(user_id, field_trip_id, payment_headcount, payment_amount, payment_date)
VALUES(1, 2, 1, 30000, CURRENT_TIMESTAMP);

INSERT INTO kids.tbl_cash
(user_id, payment_cash, review_cash, cash_save_date, review_save_date)
VALUES(1, 100, 200, '2023-03-25', '2023-04-01');

INSERT INTO kids.tbl_customer_enquiry
(user_id, user_email, enquiry_title, enquiry_content, enquiry_date, enquiry_confirm)
VALUES(1, 'dawn43@naver.com', '환불 안됨', '환불 눌렀는데 안돼요 환불해주세요', '2023-04-01', false);

INSERT INTO kids.tbl_review
(user_id, field_trip_id, review_write_date, review_alter_date, review_context)
VALUES(1, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '너무 유익했어요');



===============================================================
drop table tbl_member_file;
drop table tbl_member;
drop table tbl_user; 

drop view view_institution_info;

drop view view_member_info;

select * from tbl_member;
select * from tbl_user;

select * from tbl_customer_enquiry;

select * from tbl_field_trip;

select * from tbl_user;

select * from tbl_member;

select * from tbl_institution;

select * from view_member_info;

select * from view_institution_info;

select * from tbl_category;

select * from tbl_cash;

select * from tbl_payment;

select * from view_field_trip;

select * from view_field_tripdto;

select * from tbl_customer_enquiry;

select * from tbl_review;

select field_trip_id from kids.view_user_payment where user_id = 1;

SELECT user_id, member_name, member_nickname, member_gender, user_identification, user_password, user_email, user_phoneNumber, user_address, user_register_date
FROM kids.view_member_info;

/* 유저가 구매한 체험학습목록 */
select user_id, field_trip_id, category_name, field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, field_trip_name,
		field_trip_place, field_trip_price, field_trip_context_description, recommend_count,field_trip_system_name, field_trip_org_name 
		from view_field_tripdto
		where field_trip_id = (select field_trip_id from kids.view_user_payment where user_id = 1);
	
select user_id, field_trip_id, category_name, field_trip_name, 
		field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, 
		field_trip_place, field_trip_price, field_trip_context_description, recommend_count, 
		field_trip_system_name, field_trip_org_name 
		from view_field_tripdto
		where (select field_trip_id from view_user_payment where user_id = 1)
		and category_name = '역사'
	    and field_trip_program_date between CURDATE() and '2023-04-01';
/*		and field_trip_name like concat('%', 'want', '%');*/

INSERT INTO kids.tbl_field_trip
(user_id, category_id, field_trip_name, field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description)
VALUES(1, 2, '유차차', CURRENT_TIMESTAMP, '2023-03-07', '2023-03-08', '선릉', 3330, '방송관련 체험');


INSERT INTO kids.tbl_payment
(user_id, field_trip_id, payment_headcount, payment_amount, payment_date)
VALUES(1, 10, 1, 3330, CURRENT_TIMESTAMP);

/* 체험예정 셀렉트 */
select count(field_trip_id)
		from view_field_tripdto
		where field_trip_id = any(select field_trip_id from view_user_payment where user_id = 1)
		and field_trip_program_date between CURDATE() and ADDDATE(CURDATE(),interval 120 day);

/* 체험완료조회 */
select count(field_trip_id)
from view_field_tripdto
where field_trip_id = any(select field_trip_id from view_user_payment where user_id = 1)
and field_trip_program_date > NOW() - interval 12 MONTH);
	
/* 내 문의목록 조회*/
select enquiry_id, user_id, user_email, enquiry_title, enquiry_content, enquiry_date, enquiry_confirm
from kids.tbl_customer_enquiry
where user_id=4;

/*내 캐쉬목록 조회*/
select cash_id, user_id, payment_cash, review_cash, cash_save_date, review_save_date
		from kids.tbl_cash
		where user_id =1;
	
	
/*내 리뷰목록 조회*/
SELECT review_id, user_id, field_trip_id, review_write_date, review_alter_date, review_context
FROM kids.tbl_review
where user_id = 1;



/* 추천수 insert */
select * from view_field_tripdto;

INSERT INTO kids.tbl_category
(category_name)
VALUES('사회');

INSERT INTO kids.tbl_field_trip
(user_id, category_id, field_trip_name, field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description)
VALUES(2, 1, '역사체험', CURRENT_TIMESTAMP, '2023-03-04', '2023-03-10', '역삼동', 30000, '역사체험을 해보세요!');

INSERT INTO kids.tbl_field_trip
(user_id, category_id, field_trip_name, field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description)
VALUES(2, 1, '소방관', CURRENT_TIMESTAMP, '2023-03-04', '2023-03-10', '역삼동', 30000, '소방관직업체험을 해보세요!');

INSERT INTO kids.tbl_field_trip
(user_id, category_id, field_trip_name, field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description)
VALUES(2, 1, '의사', CURRENT_TIMESTAMP, '2023-03-04', '2023-03-10', '역삼동', 20000, '의사직업체험을 해보세요!');

INSERT INTO kids.tbl_field_trip
(user_id, category_id, field_trip_name, field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, field_trip_place, field_trip_price, field_trip_context_description)
VALUES(2, 1, '햄버거 요리사', CURRENT_TIMESTAMP, '2023-03-04', '2023-03-10', '강남', 15000, '햄버거 요리을 해보세요!');

select * from tbl_field_trip_recommend;

INSERT INTO kids.tbl_field_trip_recommend
(user_id, field_trip_id)
VALUES(4, 5);

/* 추천순 랭킹 */
select recommend_count, field_trip_name 
from view_field_tripdto
order by recommend_count desc;

/* 내 정보 수정 */

/* 회원탈퇴 */
DELETE FROM tbl_user
WHERE user_email= 'test@g';

select * from tbl_member m join tbl_user u on m.user_id = u.user_id;

select * from tbl_user;
/* 이메일 찾기 */
select user_email
from tbl_member m join tbl_user u on m.user_id = u.user_id
where m.user_id = 1;

select * from view_member_info;
