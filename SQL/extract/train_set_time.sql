
-- 创建用于 指定 第一个训练日的表 ---------------------
drop table if exists object_day;
create table object_day (obj text);
insert into object_day
(obj) values ('2014-11-25');
