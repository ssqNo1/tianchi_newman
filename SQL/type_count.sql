-- 简单的group
select 
	user_id, item_id, behavior_type, count(*)
from oneday
--where date(time) = '2014-12-18'
group by 1,2,3
order by 1,2,3
limit 100;

-------------- 统计每一类的数量 ----------
create table type_count (
	user_id text,
	item_id text,
	browse text default 0,
	collect text default 0,
	cart text default 0,
	buy text default 0
);

insert into type_count
with u1 as (
	select user_id, item_id, count(*) as 'browse'
	from oneday
	where behavior_type = 1
	group by 1,2
	order by 1,2
),
u2 as (
	select user_id, item_id, count(*) as 'collect'
	from oneday
	where behavior_type = 2
	group by 1,2
	order by 1,2
),
u3 as (
	select user_id, item_id, count(*) as 'cart'
	from oneday
	where behavior_type = 3
	group by 1,2
	order by 1,2
),
u4 as (
	select user_id, item_id, count(*) as 'buy'
	from oneday
	where behavior_type = 4
	group by 1,2
	order by 1,2
)
select 
	u.user_id as user_id, 
	u.item_id as item_id, 
	ifnull(browse, 0) as browse,
	ifnull(collect, 0) as collect, 
	ifnull(cart,0) as cart,
	ifnull(buy,0) as buy
from oneday as u
left join u1 using (user_id, item_id)
left join u2 using (user_id, item_id)
left join u3 using (user_id, item_id)
left join u4 using (user_id, item_id)
group by 1,2
order by 1,2;