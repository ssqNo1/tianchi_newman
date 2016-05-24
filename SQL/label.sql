-- 提取2014-12-18的标签

-- 创建标签表
create table label (
	user_id text,
	item_id text,
	label text
);
-- 创建用于 指定考察日的表
drop table if exists object_day;
create table object_day (obj text);
insert into object_day
(obj) values ('2014-12-18');

-- 考察日加一天
update object_day set obj = date(datetime(obj, '+1 day'));

-- 将指定考察日的标签插入到标签表
insert into label
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
u4 as (
	select user_id, item_id, 1 as 'buy'
	from u
	where behavior_type = 4
	group by 1,2
	order by 1,2
)
select 
	u.user_id, u.item_id,
	ifnull(buy,0) as buy
from u
left join u4 using (user_id, item_id)
group by 1,2
order by 1,2;
