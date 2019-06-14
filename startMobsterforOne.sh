#fichier reçoit le bam en entrée
SECONDS=0
fichier=$1
pathtoData=$2
pathtoResult=$3
custom=$4
fullfilename=$(basename $fichier)
extension=${fullfilename##*.}
filename=${fullfilename%.*}
pathtoMobster=/home/denou/Tools/Mobster/Mobster2/mobster
pathtoMobsterVCF=/home/denou/Tools/Mobster/Mobster2/mobster/resources/MobsterVCF

#pathtoResults=/results
cd $pathtoMobster/target
mkdir $pathtoResult/$filename
#mkdir $pathtoResults/$filename

if [custom==TRUE];
then
java -Xmx8G -jar $pathtoMobster/target/MobileInsertions-0.2.4.1.jar -properties $pathtoMobster/target/Mobster.properties_Custom -in $pathtoData/$fichier -sn $filename -out $pathtoResult/$filename/Mobster_$filename
else
java -Xmx8G -jar $pathtoMobster/target/MobileInsertions-0.2.4.1.jar -properties $pathtoMobster/target/Mobster.properties -in $pathtoData/$fichier -sn $filename -out $pathtoResult/$filename/Mobster_$filename
fi
java -jar $pathtoMobsterVCF/MobsterVCF-0.0.1-SNAPSHOT.jar -file $pathtoResult/$filename/Mobster_${filename}_predictions.txt -out $pathtoResult/$filename/${filename}_predictions.vcf

vcftools --vcf $pathtoResult/$filename/${filename}_predictions.vcf --out $pathtoResult/$filename/${filename}_predictions_filtred.vcf --exclude-bed $pathtoMobster/resources/removeFP.bed --recode --recode-INFO-all

#vcftools --vcf $pathtoResult/$filename/${filename}_predictions.vcf --out $pathtoResult/$filename/${filename}_predictions_filtred.vcf -bed $pathtoMobster/resources/NEIGE3_coding_exons_ensembl95_expand_50b.sort.bed --recode --recode-INFO-all

if (( $SECONDS > 3600 )) ; then
    let "hours=SECONDS/3600"
    let "minutes=(SECONDS%3600)/60"
    let "seconds=(SECONDS%3600)%60"
    echo "Completed in $hours hour(s), $minutes minute(s) and $seconds second(s)" 
elif (( $SECONDS > 60 )) ; then
    let "minutes=(SECONDS%3600)/60"
    let "seconds=(SECONDS%3600)%60"
    echo "Completed in $minutes minute(s) and $seconds second(s)"
else
    echo "Completed in $SECONDS seconds"
fi
