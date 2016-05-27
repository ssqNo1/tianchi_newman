--启动
.open F:/tianchi_data/fresh.db
.header on
.mode column
--输出结果
.once F:/tianchi_data/
--补全时间信息
UPDATE user SET time = time||':00:00';

--截取12-17 偶数小时的数据存成表oneday
create table oneday as 
	select * from user
	where date(time) = '2014-12-17'
	and strftime('%H',time)%2=0;

-- 统计每一天的商品子集的购买量（去重）
select date(time), count(distinct user_id||','||item_id)
from user
join item using(item_id)
where behavior_type = 4
group by 1
order by 1;


select count(*) as buy_count from (
	select user_id, item_id 
	from user
	join item using(item_id)
	where date(time) = '2014-12-18'
	and behavior_type = 4
	group by 1,2
	order by 1,2
);

	


	

