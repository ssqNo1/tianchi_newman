# -*- coding: utf-8 -*-

# 离线 训练，评估


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
f_x_test_off = open("F:/tianchi_data/feature/x_test_offline.csv")
f_candidate_off = open("F:/tianchi_data/feature/candidate_offline.csv")
f_ui_truth = open("F:/tianchi_data/feature/ui_truth_appear.csv")

x_train = []
y_train = []
x_test = []

candidate = []
ui_truth = []

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
data = f_x_test_off.readlines()
for line in data:
    line = line.replace('\n','')
    array = line.split(',')
    for i in range(len(array)):
        array[i] = int(array[i])
    x_test.append(array)	
    
# candidate
data = f_candidate_off.readlines()
for line in data:   
    line = line.replace('\n','')
    user_id, item_id = line.split(',')
    candidate.append((user_id, item_id));

# ui_truth
data = f_ui_truth.readlines()
for line in data: 
    line = line.replace('\n','')
    user_id, item_id = line.split(',')
    ui_truth.append(user_id+','+item_id)

print '--data loaded'
print 'training size = ', len(x_train)
print 'feature num = ', len(x_train[0])

### train and predict ##############################################

from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression

#model = LogisticRegression()
model = RandomForestClassifier()

model.fit(x_train, y_train)

print '--training done'

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
predict_num = 517


ui_predict = []
for c in comb:
    user_id, item_id = c[0]   
    if item_id in item_set:
        ui = user_id+','+item_id
        ui_predict.append(ui)
        if len(ui_predict) >= predict_num:
            break


### evaluate ##############################################


answer = set(ui_truth)
you = set(ui_predict)
inter = answer & you

print 'hit number = ', len(inter)
if len(inter) > 0:
    a = len(answer)
    b = len(you)
    c = len(inter)
    R = 100.0 * c / a
    P = 100.0 * c / b
    F1 = 2.0 * R * P / (R + P)
    print 'predict/truth,  F1,P,R:  %d/%d,  %.2f%%,%.2f%%,%.2f%%\n' % (b, a, F1, P, R)
