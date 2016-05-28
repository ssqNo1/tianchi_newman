-- 利用规则来预测
.header off
.mode csv
.once F:/tianchi_data/rule_predict_19.csv
select * from rule;

-- 创建用于 指定考察日的表
drop table if exists object_day;
create table object_day (obj text);
insert into object_day
(obj) values ('2014-12-19');

-- 规则： 在前一天后半天加购物车且没买的
drop table if exists rule;
create table rule as
select a.user_id as user_id, a.item_id as item_id
from (
	select user_id, item_id from user, object_day
	where date(time) = date(object_day.obj, '-1 day') and
		time(time) >= '12:00:00' and
		behavior_type = 3
	group by 1,2
) as a
join item using (item_id)
left join (
	select user_id from user, object_day
	where date(time) = date(object_day.obj, '-1 day') and
		time(time) >= '12:00:00' and
		behavior_type = 4
	group by 1
) as b using(user_id)	
where b.user_id is null
group by 1,2;

select count(*) from rule;


