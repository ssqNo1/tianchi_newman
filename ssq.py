# -*- coding: utf-8 -*-

f = open("F:/tianchi_data/data_sample.csv")

context = f.readlines()

##################### underline check, dwindow = 1                 #####################
##################### use (user_id, item_id, 29) to train          #####################
##################### use (user_id, item_id, 30) offline candidate #####################
##################### use (user_id, item_id, 31) online  candidate #####################

import numpy as np

train_day29 = []
offline_candidate_day30 = []
online_candidate_day31 = []

for line in context:
	line = line.replace('\n','')
	array = line.split(',')
	if array[0] == 'user_id':
		continue
	day = int(array[-1])
	uid = (array[0],array[1],day+1)
	if day == 28:
		train_day29.append(uid)
	if day == 29:
		offline_candidate_day30.append(uid)
	if day == 30:
		online_candidate_day31.append(uid)
		
train_day29 = list(set(train_day29))
offline_candidate_day30 = list(set(offline_candidate_day30))
online_candidate_day31 = list(set(online_candidate_day31))

print 'training item number:\t', len(train_day29)
print '---------------------\n'
print 'offline candidate item number:\t', len(offline_candidate_day30)
print '---------------------\n'

##############################################################

import math
# for feature, for this demo, sum of 4 operations
ui_dict = [{} for i in range(4)]
# for label
ui_buy = {}

for line in context:
	line = line.replace('\n','')
	array = line.split(',')
	if array[0] == 'user_id':
		continue
	uid = (array[0], array[1], int(array[-1]))
	behavior_type = int(array[2]) - 1
	if behavior_type == 3:
		ui_buy[uid] = 1
	if uid in ui_dict[behavior_type]:
		ui_dict[behavior_type][uid] += 1
	else:
		ui_dict[behavior_type][uid] = 1
	
### get train X, y
X = np.zeros((len(train_day29), 4))
y = np.zeros((len(train_day29), 1))
id = 0
for uid in train_day29:
	last_uid = (uid[0], uid[1], uid[2] - 1)
	for i in range(4):
		X[id][i] = math.log1p(ui_dict[i][last_uid] if last_uid in ui_dict[i] else 0)
	y[id] = 1 if uid in ui_buy else 0
	id += 1
	
print 'X = ', X, '\n\n', 'y = ', y
print '------------------------\n\n'
print 'train number = ', len(y), ' positive number = ', sum(y), '\n'

## get predict pX for offline_candidate_day30
pX = np.zeros((len(offline_candidate_day30), 4))
id = 0
for uid in offline_candidate_day30:
	last_uid = (uid[0], uid[1], uid[2] - 1)
	for i in range(4):
		pX[id][i] = math.log1p(ui_dict[i][last_uid] if last_uid in ui_dict[i] else 0)
	id += 1

### training ##############################################

#from sklearn.tree import DecisionTreeClassifier
#from sklearn.ensemble import RandomForestClassifier	
from sklearn.linear_model import logisticRegression
model = logisticRegression()
#model = DecisionTreeClassifier(max_depth = 4)
#model = RandomForestClassifier()
model.fit(X, y)

### evaluating ##############################################
py = model.predict_proba(pX)
npy = []
for a in py:
	npy.append(a[1])
py = npy

### combine
lx = zip(offline_candidate_day30, py)
## sort by predict score
lx = sorted(lx, key = lambda x:x[1], reverse = True)

wf = open('ans.csv', 'w')
wf.write('user_id, item_id\n')
for i in range(437):
	item = lx[i]
	wf.write('%s,%s\n'%(item[0][0], item[0][1]))
wf.close()

	

