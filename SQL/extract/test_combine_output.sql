
-- 合并 测试集的 各个特征 ---------------------
drop table if exists x_test;
create table x_test as 
	select * from 
	user_behavior_count;
	-- wait to add
	

-- 输出合并结果 ---------------------
.header off
.mode csv
.once F:/tianchi_data/feature/x_test.csv
select * from x_test;

-- 从数据库中 删除 各个特征 ---------------------
drop table if exists user_behavior_count;
-- wait to add

