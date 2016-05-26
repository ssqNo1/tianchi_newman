-- 创建特征表 ----------------------------------
drop table if exists user_behavior_count;
create table user_behavior_count (
	user_id text,
	item_id text,
	browse text,
	collect text,
	cart text,
	buy text
);

-- 创建用于 指定考察日的表 ---------------------
drop table if exists object_day;
create table object_day (obj text);
insert into object_day
(obj) values ('2014-11-25');
