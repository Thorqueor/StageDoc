# Script pour trouver un path d'un fichier dans une arborescence
# Le fichier en entree ($1) contient par ligne chaque code unique de fichiers cibles
fichier=$1
# passage du fichier windows a unix, retire le \r en fin de ligne pour un \n (optionnel)
dos2unix $fichier

#rm /media/PGM/bioinfo/stageCNV/monfichiertemp.txt 
#creation du fichier de resultats
touch /home/denou/PGM/data/colon_lung_test/monfichiertemp.txt
touch /home/denou/PGM/data/colon_lung_test/monfichiertemp2.txt

# Boucle tournant sur chaque ligne du fichier d'entree
while read line; do
	#echo $line
	# le find va chercher dans l'arborescence le contenu de line 
	#ensuite le grep recupere la ligne unique contenant l'extension 
	#enfin le sed remplace les \ par \t afin d'avoir un fichier tabule en sortie pour requeter sur cut si necessaire.
	#il est necessaire d'avoir une idee du nombre d'etoiles dans le path ou de gerer cela en regex.
	find /run/user/1000/gvfs/sftp:host=129.21.10.5/media/PGM/results*/*/*/*_$line >> /home/denou/PGM/data/colon_lung_test/monfichiertemp.txt 	
done < $fichier
grep '.amplicon.cov.[0-9][0-9][0-9][0-9].xls' /home/denou/PGM/data/colon_lung_test/monfichiertemp.txt >> /home/denou/PGM/data/colon_lung_test/monfichiertemp2.txt
