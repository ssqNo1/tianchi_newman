--启动
.open F:/tianchi_data/fresh.db
.header on
.mode column
--输出结果
.once F:/tianchi_data/
--补全时间信息
UPDATE user SET time = time||':00:00';

--截取12-17 偶数小时的数据存成表oneday
create table oneday as 
	select * from user
	where date(time) = '2014-12-17'
	and strftime('%H',time)%2=0;




	

