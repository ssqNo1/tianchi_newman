with u1 as (
	select user_id, item_id, count(*) as 'cnt'
	from user 
	where behavior_type == 1
	group by 1,2
	order by 1,2
)
select 
	u.user_id, u.item_id, 
	count(u1.*)
	--count(u2.user_id),
	--count(u3.user_id),
	--count(u4.user_id)
from user as u
join () as u1 using (user_id, item_id)
--	u.user_id = u1.user_id and
--	u.item_id = u1.item_id
--join (select * from user where u1.behavior_type == 2) as u2 using (user_id, item_id)
--join (select * from user where u1.behavior_type == 3) as u3 using (user_id, item_id)
--join (select * from user where u1.behavior_type == 4) as u4 using (user_id, item_id)
where date(u.time) = '2014-12-18'
group by 1,2
order by 1,2
limit 10;