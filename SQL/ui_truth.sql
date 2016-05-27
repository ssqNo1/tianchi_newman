-- 统计12-18号的商品子集的购买量（去重）

-- 输出到文件 ----------------------------------
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
