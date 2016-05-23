--启动
.open F:/tianchi_data/fresh.db
.header on
.mode column
--输出结果
.once F:/tianchi_data/
--补全时间信息
UPDATE user SET time = time||':00:00';


--2014-12-18前一天浏览的转化率	
with pre_browse as (
	select * 
	from user 
	where behavior_type == 1 
	and date(time) == '2014-12-17'
),now_buy as (
	select * 
	from user 
	where behavior_type == 4 
	and date(time) == '2014-12-18'
)
select 100.0*count(distinct now_buy.user_id||','||now_buy.item_id)/
count(distinct pre_browse.user_id||','||pre_browse.item_id)
as 'browse_trans(%)'
from pre_browse
left join now_buy on
	pre_browse.user_id == now_buy.user_id and
	pre_browse.item_id == now_buy.item_id;

	
--每一天的前一天浏览的转化率
with now as (
	select *
	from user
	where behavior_type == 4
)
select
	date(pre.time) as 'date',
	100.0*count(distinct now.user_id||','||now.item_id)/
	count(distinct pre.user_id||','||pre.item_id)
	as '1day_collect_trans(%)'
from user as pre
left join now on
	pre.user_id == now.user_id and
	pre.item_id == now.item_id and
	date(pre.time) == date(datetime(now.time, '-1 day'))
where 
	pre.behavior_type == 2
group by 1
order by 1;
