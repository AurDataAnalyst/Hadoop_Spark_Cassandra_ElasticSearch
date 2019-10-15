#!/usr/bin/python
# -*- coding: utf-8 -*-

# keyspace pour les exercices
KEYSPACE = "undefined"  # mettez "share" si vous n'avez pas fait l'injection des données

# vérification que le keyspace a bien été défini correctement
if KEYSPACE == "undefined": raise Exception("Vous n'avez pas changé le keyspace, éditez le début du script")


# lancement par spark-submit --py-files /usr/lib/spark/jars/pyspark-cassandra-0.7.0.jar livres.py


# nom de l'application
appName = "TP5 partie Spark/Cassandra"


# bibliothèques pour travailler avec Cassandra
from pyspark import SparkConf
from pyspark_cassandra import CassandraSparkContext

# contexte d'exécution pour spark-submit
conf = SparkConf()  \
       .setAppName(appName) \
       .setMaster("spark://master:7077") \
       .set("spark.cassandra.connection.host", "master")
csc = CassandraSparkContext(conf=conf)


# ouvrir une table Cassandra à l'aide de csc
livres = csc.cassandraTable(KEYSPACE, "livres");

# nombre de livres de Jules Verne
print livres.filter(lambda livre: livre.auteur=="Jules Verne").count()
