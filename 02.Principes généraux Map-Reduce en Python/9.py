with open('arbres.csv') as entree:
    noms = entree.readline().strip().split(';')
    arbres = map(lambda ligne: dict(zip(noms, ligne.strip().split(';'))), entree)
