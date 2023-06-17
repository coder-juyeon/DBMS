use jimcarry;

select inquiry_id, user_id, inquiry_title, inquiry_content, inquiry_regist, inquiry_answer
from jimcarry.tbl_inquiry;

select inquiry_file_id, inquiry_id, inquiry_file_path, inquiry_org_name, inquiry_file_uuid
from jimcarry.tbl_inquiry_file;

select notice_id, notice_title, notice_content, notice_writer, notice_regist, notice_update
from jimcarry.tbl_notice;

select pay_id, user_id, storage_id, payment_amount, payment_date
from jimcarry.tbl_payment;

select review_id, user_id, storage_id, review_title, review_context, review_write_date, review_edit_date
from jimcarry.tbl_review
where storage_id = 1;

select review_file_id, review_id, review_file_path, review_org_name, review_file_uuid
from jimcarry.tbl_review_file;

select storage_id, user_id, storage_title, storage_size, storage_price, storage_address, storage_address_detail, storage_use_date, storage_end_date, storage_name, storage_phone, storage_address_number
from jimcarry.tbl_storage;

select storage_file_id, storage_id, storage_file_path, storage_file_org_name, storage_file_uuid
from jimcarry.tbl_storage_file;

select user_id, user_identification, user_password, user_email, user_phone, user_address, user_address_detail, user_gender, user_birth, user_name, user_random_key, user_status
from jimcarry.tbl_user
