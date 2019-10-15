def negatif(n):
    return -n

l1 = [1, 3, -2, 8, -4]
print(l1)
l2 = map(negatif, l1)
print(list(l2))
l3 = map(negatif, map(negatif, l1))
print(list(l3))
