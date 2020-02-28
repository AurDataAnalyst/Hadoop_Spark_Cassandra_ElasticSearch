#!/bin/bash

### récupère les données météo de la NOAA

# usage
if test $# = 0
then
    echo "usage: $0 USAF..."
    echo "   les paramètres sont les codes USAF des stations météo, chercher dans isd-history.txt"
    exit 1
fi

# récupérer la liste de tous les fichiers .gz du serveur, avec leur taille
rm -f liste.txt
hdfs dfs -get /share/noaa/liste.txt

# traiter les paramètres = codes USAF des stations
for station
do
    # créer le dossier pour la station
    hdfs dfs -mkdir -p /share/noaa/data/${station}
    hdfs dfs -chmod go+rx /share/noaa/data/${station}
    # récupération des données de la station
    for annee in $(seq 1901 $(date +%Y)) ; do
        # récupérer le nom exact et la taille du fichier, il est dans le fichier liste.txt
        infos=($(grep "${station}-[0-9]*-${annee}" liste.txt))
        # si le fichier est inconnu (pas dans liste.txt car station et/ou année absente)
        if test -z "${infos}" ; then continue ; fi
        # nom et taille du fichier à télécharger
        nom=${infos[0]}
        taillevoulue=${infos[1]}
        fichier=/share/noaa/data/${station}/$(basename ${nom} .gz)
        # est-ce que le fichier a déjà été téléchargé ?
        if hdfs dfs -test -f ${fichier} ; then
            # sa taille est-elle bonne ?
            taille=$(hdfs dfs -du -s ${fichier} | cut -d' ' -f1)
            if test ${taille} -eq ${taillevoulue} ; then continue ; fi
            # la taille n'est pas bonne, supprimer le fichier
            hdfs dfs -rm -f ${fichier}
        fi
        # télécharger le fichier .gz, le décompresser et le placer sur HDFS
        url=http://www1.ncdc.noaa.gov/pub/data/noaa/${annee}/${nom}
        wget -nv -O - $url | gunzip | hdfs dfs -put - ${fichier}
        # supprimer le fichier s'il y a eu une erreur (fichier vide)
        if hdfs dfs -test -z ${fichier}
        then
            hdfs dfs -rm -f ${fichier}
        else
            hdfs dfs -chmod go+r ${fichier}
        fi
    done
done

rm -f liste.txt
