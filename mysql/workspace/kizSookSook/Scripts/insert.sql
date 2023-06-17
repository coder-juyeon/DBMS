INSERT INTO kids.tbl_user
(user_identification, user_password, user_email, user_phoneNumber, user_address, user_register_date)
VALUES('dawn43', '1234', 'dawn43@naver.com', '01029670403', '서울시 송파구', CURRENT_TIMESTAMP);

INSERT INTO kids.tbl_user
(user_identification, user_password, user_email, user_phoneNumber, user_address, user_register_date)
VALUES('b', '1234', 'b43@naver.com', '01029671234', '서울시 송파구', CURRENT_TIMESTAMP);

INSERT INTO kids.tbl_user
(user_identification, user_password, user_email, user_phoneNumber, user_address, user_register_date)
VALUES('c', '1234', 'c43@naver.com', '01029673432', '서울시 송파구', CURRENT_TIMESTAMP);

INSERT INTO kids.tbl_user
(user_identification, user_password, user_email, user_phoneNumber, user_address, user_register_date)
VALUES('d', '1234', 'd43@naver.com', '01029674353', '서울시 송파구', CURRENT_TIMESTAMP);

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
VALUES(4, '김주연', '쭈', '여');

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

===============================================================
drop table tbl_member_file;
drop table tbl_member;
drop table tbl_user; 

drop view view_institution_info;

drop view view_member_info;

select * from tbl_member;
select * from tbl_user;


select * from tbl_field_trip;

select * from tbl_user;

select * from tbl_member;

select * from tbl_institution;

select * from view_member_info;

select * from view_institution_info;

select * from tbl_category;

select * from tbl_payment;

select * from view_field_trip;

select * from view_field_tripdto;

select * from tbl_customer_enquiry;

select p.field_trip_id
from tbl_payment p inner join view_field_trip f on p.field_trip_id = f.field_trip_id and p.user_id = f.user_id;

SELECT user_id, member_name, member_nickname, member_gender, user_identification, user_password, user_email, user_phoneNumber, user_address, user_register_date
FROM kids.view_member_info;

/* 유저가 구매한 체험학습목록 */
select user_id, field_trip_id, category_name, field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, field_trip_name,
		field_trip_place, field_trip_price, field_trip_context_description, recommemd_count, field_trip_filePath, field_trip_system_name, field_trip_org_name 
		from view_field_tripdto
		where (select field_trip_id from kids.view_user_payment where user_id = 4);
	
	
select user_id, field_trip_id, category_name, field_trip_name, 
		field_trip_registation_date, field_trip_deadline_date, field_trip_program_date, 
		field_trip_place, field_trip_price, field_trip_context_description, recommemd_count, 
		field_trip_filePath, field_trip_system_name, field_trip_org_name 
		from view_field_tripdto
		where (select field_trip_id from view_user_payment where user_id = 4) 
		and category_name = '역사'
	    and field_trip_program_date between '2023-03-04' and '2023-04-01';
/*		and field_trip_name like concat('%', 'want', '%');*/
		
select * from 
(select user_id, user_identification from tbl_user where user_id = 1) u right join tbl_member m
on u.user_id = m.member_id; 

/* 내 문의목록 조회*/
select enquiry_id, user_id, user_email, enquiry_title, enquiry_content, enquiry_date, enquiry_confirm
from kids.tbl_customer_enquiry
where user_id=4;
