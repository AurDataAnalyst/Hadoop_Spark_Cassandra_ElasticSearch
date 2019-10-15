def produit(a, b):
    return a * b

print("10! = %d" % reduce(produit, range(1,11)))
