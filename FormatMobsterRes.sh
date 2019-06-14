#runname=$1
#pathtoResult=$2

cd /home/denou/Tools/Mobster/Mobster2/mobster/results/Resultats_180126_NB501254_0019_AHVV5TAFXX_Mobster_custom
#cd $pathtoResult 
grep ALU\> /home/denou/Tools/Mobster/Mobster2/mobster/results/Resultats_180126_NB501254_0019_AHVV5TAFXX_Mobster_custom/*/*.recode.vcf > alus.txt
#grep ALU\> $pathtoResult/$runname/*/*.recode.vcf > alus.txt
sed -i 's/\/home\/denou\/Tools\/Mobster\/Mobster2\/mobster\/results\/Resultats_180126_NB501254_0019_AHVV5TAFXX_Mobster_custom\///g' alus.txt
cut -f1 alus.txt > col1.tmp
cut -f2 alus.txt > col2.tmp
cut -f8 alus.txt > col3.tmp
paste col1.tmp col2.tmp > col4.tmp
paste col4.tmp col3.tmp > col5.tmp
sed -i 's/:/\t/g' col5.tmp
sed -i 's/\//\t/g' col5.tmp
cut -f1 col5.tmp > col11.tmp
cut -f3 col5.tmp > col12.tmp
cut -f4 col5.tmp > col13.tmp
sed -i 's/;/\t/g' col5.tmp
cut -f8 col5.tmp > col14.tmp
cut -f7 col5.tmp > col18.tmp
paste col11.tmp col12.tmp > col15.tmp
paste col13.tmp col14.tmp > col16.tmp
paste col15.tmp col16.tmp > col20.tmp
paste col20.tmp col18.tmp > Mobsterfinalresult.csv
sed -i 's/CIPOS=//g' Mobsterfinalresult.csv
sed -i 's/,/\t/g' Mobsterfinalresult.csv
python
while line
samtools view col1/Mobster_col1_splitanchors.bam col2:col4-col5 | grep 'ME:Z:Alu' > messequences_col1.txt
samtools merge messequences_col1.txt
#rm *.tmp
#rm alus.txt

