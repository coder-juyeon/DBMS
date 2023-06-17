use app;

create table tbl_board(
	board_id int unsigned auto_increment primary key,
	board_title varchar(500) not null,
	board_content varchar(500) not null,
	board_register_date datetime default now(),
	board_update_date datetime default now(),
	board_read_count int unsigned default 0,
	member_id int unsigned not null,
	constraint fk_board_member foreign key(member_id) 
	references tbl_member(member_id)
);

select * from tbl_board order by board_id desc;

update tbl_board
set board_read_count = 25
where board_id = 16535;

insert into tbl_board
(board_title, board_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);
insert into tbl_board
(board_title, board_content, member_id)
values('테스트 제목2', '테스트 내용2', 5);
insert into tbl_board
(board_title, board_content, member_id)
values('테스트 제목3', '테스트 내용3', 5);
insert into tbl_board
(board_title, board_content, member_id)
values('테스트 제목4', '테스트 내용4', 5);
insert into tbl_board
(board_title, board_content, member_id)
values('테스트 제목5', '테스트 내용5', 5);

insert into tbl_board (board_title, board_content, member_id)
(select board_title, board_content, member_id from tbl_board);

create view view_board as
(
	select board_id, board_title, board_content, board_register_date, 
	board_update_date, board_read_count, member_name
	from tbl_member m join tbl_board b
	on m.member_id = b.member_id
);

select * from view_board;


use app;

create table tbl_reply(
   reply_id int unsigned auto_increment primary key,
   reply_content varchar(1000) not null,
   reply_register_date datetime default current_timestamp(),
   reply_update_date datetime default current_timestamp(),
   member_id int unsigned not null,
   board_id int unsigned not null,
   constraint fk_reply_member foreign key(member_id) 
   references tbl_member(member_id),
   constraint fk_reply_board foreign key(board_id) 
   references tbl_board(board_id) on delete cascade
);

/*쿼리를 시작하자마자*/
select now() from dual;
select current_timestamp() from dual;
/*특정 상위 버전부터는 now가 current_timestamp로 대체된다.
 * now()를 사용하면 자동으로 current_timestamp()로 변경되기 때문에,
 * 작업을 줄이고자 now대신 current_timestamp를 사용하는 것이 좋다.
 * */

/*sysdate()함수를 사용할 때 마다*/
select sysdate() from dual;


/*alter table [테이블명] change column [기존 컬럼명] [새로운 컬럼명] [새로운 자료형] [제약조건]*/
alter table tbl_reply change column reply_register_date reply_register_date datetime default now();
alter table tbl_reply change column reply_update_date reply_update_date datetime default now();
alter table tbl_reply change column reply_content reply_content varchar(1000) not null;
alter table tbl_reply change column member_id member_id int unsigned not null;
alter table tbl_reply change column board_id board_id int unsigned not null;
/*alter table tbl_reply add (reply_update_date datetime);*/

select * from tbl_reply;

















