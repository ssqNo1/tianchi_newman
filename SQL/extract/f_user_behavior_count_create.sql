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

