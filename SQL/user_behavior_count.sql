-------------- 统计考察日的前一天的每一类行为的数量 

-- 输出到文件 ----------------------------------
.header off
.mode csv
.once F:/tianchi_data/feature/candidate_online.csv
select user_id, item_id from user_behavior_count;

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
(obj) values ('2014-12-19');



-- 将指定考察日的特征 插入到特征表 --------------------

insert into user_behavior_count
with candidate as ( -- 选取前一天的所有交互和前七天的非浏览交互作为候选对
	select user_id, item_id
	from user, object_day	
	where date(time) = date(object_day.obj, '-1 day')
	or (
		date(time) <= date(object_day.obj, '-1 day') and
		date(time) >= date(object_day.obj, '-7 day') and
		behavior_type != 1
	)
),
u as ( -- 只统计前一天的所有交互的每一类行为的数量
	select user_id, item_id, behavior_type
	from user, object_day
	where date(time) = date(object_day.obj, '-1 day')
),
u1 as (
	select user_id, item_id, count(*) as 'browse'
	from u
	where behavior_type = 1
	group by 1,2
	order by 1,2
),
u2 as (
	select user_id, item_id, count(*) as 'collect'
	from u
	where behavior_type = 2
	group by 1,2
	order by 1,2
),
u3 as (
	select user_id, item_id, count(*) as 'cart'
	from u
	where behavior_type = 3
	group by 1,2
	order by 1,2
),
u4 as (
	select user_id, item_id, count(*) as 'buy'
	from u
	where behavior_type = 4
	group by 1,2
	order by 1,2
)
select 
	candidate.user_id, candidate.item_id,
	ifnull(browse, 0) as browse,
	ifnull(collect, 0) as collect, 
	ifnull(cart,0) as cart,
	ifnull(buy,0) as buy
from candidate
left join u1 using (user_id, item_id)
left join u2 using (user_id, item_id)
left join u3 using (user_id, item_id)
left join u4 using (user_id, item_id)
group by 1,2
order by 1,2;

-- 考察日加一天
update object_day set obj = date(datetime(obj, '+1 day'));
select * from object_day;