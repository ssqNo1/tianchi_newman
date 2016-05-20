# -*- coding: utf-8 -*-
f = open("F:/SelfTeach/TianChi/fresh_comp/fresh_comp_offline/tianchi_fresh_comp_train_user.csv")
context = f.readlines()

wf = open('sample.csv', 'w')
wf.write('user_id,item_id,day\n')

count = 0;
for line in context:
    line = line.replace('\n','')
    user_id, item_id, behavior_type, user_geohash, item_category, time = line.split(',')
    if user_id == 'user_id':
	continue
    date, hour = time.split(' ')
    year, month, day = date.split('-')
    if day in ['28','29','30']:
	count += 1
	wf.write('%s,%s,%s\n' % (user_id, item_id, day))
	
print 'sample size:', count