#!/usr/bin/python
# -*- coding: utf-8 -*-

# pour faciliter l'emploi de map, zip et reduce en Python3
import sys
if sys.version_info > (2,):
    # on est avec Python3 : map, filter et zip -> liste
    map_orig = map
    map = lambda *params: list(map_orig(*params))
    filter_orig = filter
    filter = lambda *params: list(filter_orig(*params))
    zip_orig = zip
    zip = lambda *params: list(zip_orig(*params))
    # importer la fonction reduce
    from functools import reduce


# Question 3.1.a
print("\n### Question 3.1.a")
def carre(n):
    return n*3
print( map(carre, range(1, 7)) )


# Question 3.1.b
print("\n### Question 3.1.b")
def mkimpair(i):
    return "euh?"
print( map(mkimpair, range(1, 7)) )


# Question 3.2.a
print("\n### Question 3.2.a")
phrase = "BARATATINER ecraser son interlocuteur sous une masse de propos pourtant bien legers"
mots = None


# continuez...
