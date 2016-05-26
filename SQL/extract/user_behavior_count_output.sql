-- 输出到文件 ----------------------------------
.header off
.mode csv
.once F:/tianchi_data/feature/user_behavior_count.csv
select browse,collect,cart,buy from user_behavior_count;

