-- 创建标签表
drop table if exists label;
create table label (
	user_id text,
	item_id text,
	label text
);
