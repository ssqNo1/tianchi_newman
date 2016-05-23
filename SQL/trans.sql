--2014-12-18前10天购物车的转化率	
with pre as (
	select * 
	from user 
	where behavior_type == 3 
	and date(time) <= '2014-12-10'
	and date(time) >= '2014-12-01'
),now as (
	select * 
	from user 
	where behavior_type == 4 
	and date(time) == '2014-12-11'
)
select julianday(date('2014-12-11')) -
	julianday(date(pre.time)) 
	as 'x day before',
	100.0*count(distinct now.user_id||','||now.item_id)/
	count(distinct pre.user_id||','||pre.item_id)
	as '2day_cart_trans(%)'
from pre
left join now on
	pre.user_id == now.user_id and
	pre.item_id == now.item_id
group by 1
order by 1;