# get files from the calling
fichier=$1
pathtoResult=$2
#fichier="myfilename.xls"
name=$(basename $fichier)
# make ioncopy format for one file
touch $pathtoResult/$name.tmp.csv | head -1 $fichier | awk 'BEGIN{FS="\t"}{OFS="\t"}{print $4,$10}' | sed "s/total_reads/"${name}"/g" > $pathtoResult/$name.tmp.csv
#touch $pathtoResult/$name.tmp.csv | head -1 $fichier | awk 'BEGIN{FS="\t"}{OFS="\t"}{print $1,$11}' | sed "s/median/"${name}"/g" > $pathtoResult/$name.tmp.csv
#awk 'BEGIN{FS="\t"}{OFS="\t"}{print $1,$11}' "$fichier" >> $pathtoResult/$name.tmp.csv
sort -k 1.4n,1 -k 2n,2 $fichier | awk 'BEGIN{FS="\t"}{OFS="\t"}{print $4,$10}' >> $pathtoResult/$name.tmp.csv
#awk 'BEGIN{FS="\t"}{OFS="\t"}{print $4,$10}' "$fichier" | sort >> $pathtoResult/$name.tmp.csv
#awk 'BEGIN{FS="\t"}{OFS="\t"}{print $0}' "$fichier" | sort -k 1.4n,1 -k 2n,2  >> $pathtoResult/$name.tmp.tsv
sed -i '/start/d' $pathtoResult/$name.tmp.csv
#temporarly files will be remove by the core program

