# -*- coding: utf-8 -*-

# 离线 训练，评估


### read data from file ##############################################



## 读取训练测试数据
f_ui_predict = open("F:/tianchi_data/feature/rule_predict_18.csv")
f_ui_truth = open("F:/tianchi_data/feature/ui_truth_appear.csv")

ui_truth = []
ui_predict = []



# ui_truth
data = f_ui_truth.readlines()
for line in data: 
    line = line.replace('\n','')
    user_id, item_id = line.split(',')
    ui_truth.append(user_id+','+item_id)

# ui_predict
data = f_ui_predict.readlines()
for line in data: 
    line = line.replace('\n','')
    user_id, item_id = line.split(',')
    ui_predict.append(user_id+','+item_id)


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
