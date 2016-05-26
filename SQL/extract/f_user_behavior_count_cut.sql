-- 将特征复制到新表 ----------------------------------
create table temp as
select browse,collect,cart,buy from user_behavior_count;

-- 删除旧表 ----------------------------------
drop table user_behavior_count;

-- 重命名新表 ----------------------------
alter table temp rename to user_behavior_count;
