fichier=$1
dos2unix $fichier
touch $fichier.oncocnv.bed | head -1 $fichier > $fichier.oncocnv.bed
if test $(awk '{print NF}' < $fichier | tail -1) -eq 6 ; then 
cut -s -f6 $fichier > col6
cut -s -f5 $fichier > col5
cut -s -f4 $fichier > col4
cut -s -f3 $fichier > col3
cut -s -f2 $fichier > col2
cut -s -f1 $fichier > col1
sed -i "s/./0/g" col5

sed -i "s/GENE_ID=//g" col6
sed -i "s/;[^][^]*//g" col6

paste col1 col2 col3 col4 col5 col6 >> $fichier.oncocnv.bed
rm col*

else 

cut -s -f8 $fichier > col6
cut -s -f7 $fichier > col5
cut -s -f4 $fichier > col4
cut -s -f3 $fichier > col3
cut -s -f2 $fichier > col2
cut -s -f1 $fichier > col1
sed -i "s/./0/g" col5

sed -i "s/GENE_ID=//g" col6
sed -i "s/;[^][^]*//g" col6

paste col1 col2 col3 col4 col5 col6 >> $fichier.oncocnv.bed
rm col*
fi
