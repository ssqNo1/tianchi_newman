
-- �ϲ� ���Լ��� �������� ---------------------
drop table if exists x_test;
create table x_test as 
	select * from 
	user_behavior_count;
	-- wait to add
	

-- ����ϲ���� ---------------------
.header off
.mode csv
.once F:/tianchi_data/feature/x_test.csv
select * from x_test;

-- �����ݿ��� ɾ�� �������� ---------------------
drop table if exists user_behavior_count;
-- wait to add

