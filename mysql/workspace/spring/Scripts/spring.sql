create database spring;
use spring;

create table tbl_product(
	product_id int unsigned auto_increment primary key,
	product_name varchar(500) not null,
	product_price int default 0,
	product_stock int default 0
);

select * from tbl_product;

alter table product rename to tbl_product;

create table tbl_order(
	order_id int unsigned auto_increment primary key,
	product_id int unsigned,
	product_count int default 1,
	order_date datetime default current_timestamp(),
	constraint fk_order_product foreign key(product_id)
	references tbl_product(product_id)
);

select * from tbl_order;
select * from tbl_product;

insert into spring.tbl_order
(product_id, product_count, order_date)
values(2, 1, current_timestamp);

INSERT INTO spring.tbl_product
(product_name, product_price, product_stock)
VALUES('자유시간', 1000, 20);


delete from spring.tbl_order
where order_id=0;

/* 물건 하나당 총 결제 금액 조회
 * 오더 테이블에서
 * 물건의 아이디로 물건의 개수를 세서
 * 결제 금액에 개수를 곱해*/

/*조회*/
select product_price * (select count(product_id)
from tbl_order), product_id
from tbl_product
group by product_id;


where product_id = 1;

create table tbl_board(
   board_id int unsigned auto_increment primary key,
   board_title varchar(500) not null,
   board_writer varchar(500) not null,
   board_content varchar(500) not null,
   board_register_date datetime default current_timestamp,
   board_update_date datetime default current_timestamp
);

create table tbl_file(
   file_id int unsigned auto_increment primary key,
   file_original_name varchar(500) not null,
   file_uuid varchar(500) not null,
   file_path varchar(500) not null,
   file_size varchar(100) not null,
   file_type char(1) default 0,
   board_id int unsigned not null,
   constraint fk_file_board foreign key(board_id) 
   references tbl_board(board_id)
);

