# -*- coding: utf-8 -*-
# 12-17作为训练，12-18号作为测试

#import math

f_x_train = open("F:/tianchi_data/feature/x_train.csv")
f_y_train = open("F:/tianchi_data/feature/y_train.csv")
f_x_test = open("F:/tianchi_data/feature/x_test.csv")
f_y_test = open("F:/tianchi_data/feature/y_test.csv")

x_train = []
y_train = []
x_test = []
y_test = []
#import numpy as np

data = f_x_train.readlines()
for line in data:
    line = line.replace('\n','')
    x_train.append(line.split(','))

data = f_y_train.readlines()
for line in data:
    line = line.replace('\n','')
    y_train.append(line.split(','))	
	
data = f_x_test.readlines()
for line in data:
    line = line.replace('\n','')
    x_test.append(line.split(','))	
	
data = f_y_test.readlines()
for line in data:
    line = line.replace('\n','')
    y_test.append(line.split(','))	
	
from sklearn.linear_model import LogisticRegression
model = LogisticRegression()
model.fit(X_train, y_train)