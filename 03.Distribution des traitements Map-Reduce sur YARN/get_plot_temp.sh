#!/bin/bash

# dessine les données calculées par MapReduce

# configuration
N=2                 # mettre la valeur de N (demi-largeur de fenêtre)
SORTIE=resultats    # mettre le nom du dossier HDFS contenant part-r-*

# messages
cat <<message
Je vais récupérer les moyennes de températures du dossier hdfs:$SORTIE
Je suis configuré pour une fenêtre de N=$N années.
Je peux traiter des données qui contiennent 3 colonnes :
- l'identifiant de la station,
- l'année,
- la moyenne.
Si vous avez seulement deux colonnes (année, moyenne), alors
décommentez la ligne qui commence par ##2 COLONNES## dans mon source
et commentez la ligne précédente.
message


# récupérer les moyennes
rm -f *.csv *.pdf
# Récupérer seulement les colonnes 2 et 3 des données
hdfs dfs -cat "$SORTIE/part-r-*" | awk '{print $2"\t"$3 >> $1".csv"}'
##2 COLONNES## hdfs dfs -cat "$SORTIE/part-r-*" > station.csv
sed -i -e "1,${N}d;/^$(date +%Y)/,\$d" *.csv
sed -i -e '1i Année\tTempérature moyenne (°C)' *.csv

# traiter tous les fichiers CSV
for fichier in *.csv
do
    if test ! -f "$fichier"
    then
        echo "$fichier non trouvé"
        continue
    fi

    base=$(basename "$fichier" .csv)

    # on lance gnuplot pour tracer les données
    gnuplot <<commandes
# sortie
set terminal pdf monochrome
set output "${base}.pdf"

# légende
set key bottom right

# grille
set grid

# données à dessiner
plot "$fichier" with lines title columnhead
commandes

echo "c'est fini, regardez les fichiers pdf du dossier courant"

done
