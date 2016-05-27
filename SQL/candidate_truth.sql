-- 看 候选对 中有多少是18号购买了的 --------------

-- 创建用于 指定考察日的表
drop table if exists object_day;
create table object_day (obj text);
insert into object_day
(obj) values ('2014-12-18');


with candidate as ( -- 选取之前所有的交互作为候选对
	select user_id, item_id
	from user, object_day	
	where 
		date(time) < object_day.obj
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
select count(candidate.user_id) as candidate, -- 候选对数
count(truth.user_id) as truth -- 候选对中的购买数
from candidate
left join truth using(user_id, item_id);


