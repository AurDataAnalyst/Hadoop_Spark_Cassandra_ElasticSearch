brut = sc.textFile("hdfs:/share/noaa/isd-history.txt")
brut = brut.filter(lambda ligne: len(ligne)>0 and ligne[0] in '0123456789')
