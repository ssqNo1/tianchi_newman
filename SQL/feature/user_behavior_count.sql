-------------- 统计2014-12-18的前七天的每一类行为的数量 ----------
with u1 as (
	select user_id, item_id, count(*) as 'browse'
	from user
	where behavior_type = 1
	group by 1,2
	order by 1,2
),
u2 as (
	select user_id, item_id, count(*) as 'collect'
	from user
	where behavior_type = 2
	group by 1,2
	order by 1,2
),
u3 as (
	select user_id, item_id, count(*) as 'cart'
	from user
	where behavior_type = 3
	group by 1,2
	order by 1,2
),
u4 as (
	select user_id, item_id, count(*) as 'buy'
	from user
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
from user as u
left join u1 using (user_id, item_id)
left join u2 using (user_id, item_id)
left join u3 using (user_id, item_id)
left join u4 using (user_id, item_id)
where date(u.time) <= '2014-12-17'
and date(u.time) >= '2014-12-11'
group by 1,2
order by 1,2;