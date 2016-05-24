-------------- 统计2014-12-18的前七天的每一类行为的数量 ----------
--输出到文件
.mode csv
.once H:/TianChi/tianchi_newman/feature/user_behavior_count.csv
select browse,collect,cart,buy from user_behavior_count;

-- 创建特征表
create table user_behavior_count (
	user_id text,
	item_id text,
	browse text,
	collect text,
	cart text,
	buy text
);

-- 创建用于 指定考察日的表
drop table if exists object_day;
create table object_day (obj text);
insert into object_day
(obj) values ('2014-12-18');

-- 考察日加一天
update object_day set obj = date(datetime(obj, '+1 day'));

-- 将指定考察日的特征 插入到特征表
insert into user_behavior_count
with u as (
	select user_id, item_id, time, behavior_type
	from user, object_day
	-- 选取前一天的所有交互和前七天的非浏览交互
	where date(time) = date(datetime(object_day.obj, '-1 day'))
	or (
		date(time) <= date(datetime(object_day.obj, '-1 day')) and
		date(time) >= date(datetime(object_day.obj, '-7 day')) and
		behavior_type != 1
	)
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
	u.user_id, u.item_id,
	ifnull(browse, 0) as browse,
	ifnull(collect, 0) as collect, 
	ifnull(cart,0) as cart,
	ifnull(buy,0) as buy
from u
left join u1 using (user_id, item_id)
left join u2 using (user_id, item_id)
left join u3 using (user_id, item_id)
left join u4 using (user_id, item_id)
group by 1,2
order by 1,2;