-- ��ȡ ѵ������ �������� �����ݿ� ---------------------
drop table if exists user_behavior_count;
.mode csv
.import F:/tianchi_data/feature/feature_train/user_behavior_count.csv user_behavior_count
-- wait to add

-- �ϲ� �������� ---------------------
drop table if exists x_train;
create table x_train as 
	select * from
	user_behavior_count
	-- wait to add
	

-- ����ϲ���� ---------------------
.header off
.mode csv
.once F:/tianchi_data/feature/x_train.csv
select * from x_train;

-- �����ݿ��� ɾ�� �������� ---------------------
drop table if exists user_behavior_count;
-- wait to add
