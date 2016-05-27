-- ��ָ�������յı�ǩ���뵽��ǩ��
insert into label
with u as ( -- ѡȡǰһ������н�����ǰ����ķ��������
	select user_id, item_id, time, behavior_type
	from user, object_day	
	where date(time) = date(object_day.obj, '-1 day')
	or (
		date(time) <= date(object_day.obj, '-1 day') and
		date(time) >= date(object_day.obj, '-7 day') and
		behavior_type != 1
	)
),
u4 as ( -- �������յ����Ƿ��й�����Ϊ
	select user_id, item_id, 1 as 'buy'
	from user, object_day
	where behavior_type = 4
	and date(time) = object_day.obj
	group by 1,2
	order by 1,2
)
select 
	u.user_id, u.item_id,
	ifnull(buy,0)
from u
left join u4 using (user_id, item_id)
group by 1,2
order by 1,2;

-- �����ռ�һ��
update object_day set obj = date(obj, '+1 day');
