-- 读取 训练集的 各个特征 到数据库 ---------------------
drop table if exists user_behavior_count;
.mode csv
.import F:/tianchi_data/feature/feature_train/user_behavior_count.csv user_behavior_count
-- wait to add

-- 合并 各个特征 ---------------------
drop table if exists x_train;
create table x_train as 
	select * from
	user_behavior_count
	-- wait to add
	

-- 输出合并结果 ---------------------
.header off
.mode csv
.once F:/tianchi_data/feature/x_train.csv
select * from x_train;

-- 从数据库中 删除 各个特征 ---------------------
drop table if exists user_behavior_count;
-- wait to add
