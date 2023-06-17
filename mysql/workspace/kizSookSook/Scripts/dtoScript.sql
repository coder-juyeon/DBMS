/* DTO 용 VIEW */
-- tbl_member, tbl_user tbl_member_file join뷰
create view view_member_info as
select m1.user_id, member_name, member_nickname, member_gender, user_identification, 
user_password, user_email, user_phoneNumber, user_address, user_register_date,
mf.file_id, mf.file_path, mf.system_name, mf.org_name
from
(
	select u.user_id, member_name, member_nickname, member_gender, user_identification, 
	user_password, user_email, user_phoneNumber, user_address, user_register_date
	from tbl_member m join tbl_user u 
	on m.user_id = u.user_id
)m1 join tbl_member_file mf
on m1.user_id = mf.user_id;

select m.user_id, member_name, member_nickname, member_gender, user_identification, 
user_password, user_email, user_phoneNumber, user_address, user_register_date
from tbl_member m join tbl_user u 
on m.user_id = u.user_id;

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