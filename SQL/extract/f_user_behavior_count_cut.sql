-- ���������Ƶ��±� ----------------------------------
create table temp as
select browse,collect,cart,buy from user_behavior_count;

-- ɾ���ɱ� ----------------------------------
drop table user_behavior_count;

-- �������±� ----------------------------
alter table temp rename to user_behavior_count;
