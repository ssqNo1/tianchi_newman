#!/user/bin/env python
# coding=utf-8

import sys

st = open('./offline_groundtruth.txt')
const = st.realines()

answer = []
for a in const:
	if a[0] == 'u':
		continue
	answer.append(a)
answer = set(answer)

f = open(sys.argv[1])
con = f.readlines()
you = []
for a in con:
	if a[0] == 'u':
		continue
	you.append(a)
you = set(you)

inter = answer & you

print 'hit number = ', len(inter)
if len(inter) > 0:
	a = len(answer)
	b = len(you)
	c = len(inter)
	R = 100.0 * c / a
	P = 100.0 * c / b
	F1 = 2.0 * R * P / (R + P)
	print 'F1/P/R %.2f%%/%.2f%%/%.2f%%\n' % (F1, P, R)