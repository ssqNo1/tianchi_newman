-- ������ļ� ----------------------------------
.header on
.mode csv
.once F:/tianchi_data/feature/feature_train/user_behavior_count.csv
select browse,collect,cart,buy from user_behavior_count;

-- ɾ���� ----------------------------------
drop table user_behavior_count;
