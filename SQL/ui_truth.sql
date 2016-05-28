-- 统计12-18号的商品子集的购买对（去重）

-- 创建用于 指定考察日的表
drop table if exists object_day;
create table object_day (obj text);
insert into object_day
(obj) values ('2014-12-18');

-- 输出所有的购买对 ----------------------------------
.header off
.mode csv
.once F:/tianchi_data/feature/ui_truth_18.csv
select user_id, item_id 
from user
join item using(item_id)
where date(time) = '2014-12-18'
and behavior_type = 4
group by 1,2
order by 1,2;

-- 输出 之前有交互的购买对 ---------------------
.header off
.mode csv
.once F:/tianchi_data/feature/ui_truth_active.csv
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
select candidate.user_id, candidate.item_id
from candidate
join truth using(user_id, item_id);


-- 输出 保证用户和商品都是之前出现过的，但不一定是成对出现 ---------------------
.header off
.mode csv
.once F:/tianchi_data/feature/ui_truth_appear.csv
with u as ( -- 选取之前所有的交互作为候选对
	select user_id
	from user, object_day	
	where 
		date(time) < object_day.obj
	group by 1
),
i as (
	select item_id
	from user, object_day	
	where 
		date(time) < object_day.obj
	group by 1
)
truth as (
	select user_id, item_id 
	from user, object_day
	join item using(item_id)
	where date(time) = object_day.obj
	and behavior_type = 4
	group by 1,2
	order by 1,2
)
select truth.user_id, truth.item_id
from truth
where truth.user_id in u
and truth.item_id in i;
