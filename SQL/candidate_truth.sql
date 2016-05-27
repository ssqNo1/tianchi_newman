-- 看候选对中有多少是考察日购买了的

-- 创建用于 指定考察日的表 ---------------------
drop table if exists object_day;
create table object_day (obj text);
insert into object_day
(obj) values ('2014-12-18');



with candidate as ( -- 选取前一天的所有交互和前七天的非浏览交互作为候选对
	select user_id, item_id
	from user, object_day	
	where date(time) = date(object_day.obj, '-1 day')
	or (
		date(time) <= date(object_day.obj, '-1 day') and
		date(time) >= date(object_day.obj, '-7 day') and
		behavior_type != 1
	)
	group by 1,2
	order by 1,2
),
truth as (
	select user_id, item_id 
	from user, object_day
	join item using(item_id)
	where date(time) = object_day.obj
	and behavior_type = 4
	group by 1,2
	order by 1,2
)
select count(*) as buy_count
from candidate
join truth using(user_id, item_id);
