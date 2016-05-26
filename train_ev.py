# -*- coding: utf-8 -*-
# 12-17作为训练，12-18号作为测试

### read data from file ##############################################

### 读取商品子集
f_item = open("F:/tianchi_data/tianchi_fresh_comp_train_item.csv")
item_set = set()
data = f_item.readlines()
for line in data:
    line = line.replace('\n','')
    array = line.split(',')
    item_set.add(array[0])

## 读取训练测试数据
f_x_train = open("F:/tianchi_data/feature/x_train.csv")
f_y_train = open("F:/tianchi_data/feature/y_train.csv")
f_x_test = open("F:/tianchi_data/feature/x_test.csv")
f_y_test = open("F:/tianchi_data/feature/y_test.csv")

x_train = []
y_train = []
x_test = []


# x_train
data = f_x_train.readlines()
for line in data:
    line = line.replace('\n','')
    array = line.split(',')
    for i in range(len(array)):
        array[i] = int(array[i])
    x_train.append(array)

# y_train
data = f_y_train.readlines()
for line in data:
    y_train.append(int(line[0]))	

# x_test
data = f_x_test.readlines()
for line in data:
    line = line.replace('\n','')
    array = line.split(',')
    for i in range(len(array)):
        array[i] = int(array[i])
    x_test.append(array)	

# y_test
data = f_y_test.readlines()
candidate = []
y_truth = []
for line in data:
    line = line.replace('\n','')
    user_id, item_id, label = line.split(',')
    candidate.append((user_id, item_id));
    if label == '1' and item_id in item_set:
        y_truth.append(user_id+','+item_id)
	
### train and predict ##############################################
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
model = LogisticRegression()
#model = RandomForestClassifier()
model.fit(x_train, y_train)
y_prob = model.predict_proba(x_test)
y_p = []
for p in y_prob:
    y_p.append(p[1])
y_prob = y_p

### combine
comb = zip(candidate, y_prob)

## sort by predict score
comb = sorted(comb, key = lambda x:x[1], reverse = True)

## select top candidate
predict_num = 450

wf = open('F:/tianchi_data/test/predict.csv', 'w')
wf.write('user_id, item_id\n')
y_predict = []
for c in comb:
    user_id, item_id = c[0]   
    if item_id in item_set:
        ui = user_id+','+item_id
        wf.write(ui+'\n')
        y_predict.append(ui)
        if len(y_predict) >= predict_num:
            break
wf.close()
print 'predict num = ',len(y_predict)
### evaluate ##############################################

import sys
sys.path.append('F:/SelfTeach/TianChi/fresh_comp/code')
from evaluate import evaluate
evaluate(y_truth,y_predict);




