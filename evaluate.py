def evaluate(answer, you):
    answer = set(answer)
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
        print 'F1,P,R %.2f%%,%.2f%%,%.2f%%\n' % (F1, P, R)