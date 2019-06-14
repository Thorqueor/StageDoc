#!/bin/bash
#create result file

runname=$1
project=$2
#runname=Auto_user_S5XL-0151-249-Multiplex_panel_ampliseq_V2_ion_chef_530_459
#TODO ajouter $project
pathtoData=/run/user/1000/gvfs/sftp:host=129.21.10.5/media/PGM/results/$project/$runname # use on PAM data
#pathtoData=/run/user/1000/gvfs/sftp:host=129.10.20.36/u02/$project/JDC_Analysis/$runname/trace_back # use on GENEC data
#pathResult=/run/user/1000/gvfs/sftp:host=129.21.10.5/media/PGM/bioinfo/stageCNV/result_ioncopy/$runname
pathtoResult=/home/denou/PGM/data/$runname

#mkdir /run/user/1000/gvfs/sftp:host=129.21.10.5/media/PGM/bioinfo/stageCNV/result_ioncopy/$runname
mkdir $pathtoResult
cd $pathtoResult
touch ioncopy_input.$runname.tsv
if [ -f mesxlstemp.txt ]; then 
rm mesxlstemp.txt
rm mesxls.txt
fi
touch mesxlstemp.txt

counter=0
# run on all .xls files in the current folder
#TODO 
#corriger le find

#for file in $pathtoData/*/*_Ion*amplicon.cov.*.xls; # use on PAM data
#for file in $pathtoData/*/*.exons_cov_stats.tsv; # use on GENEC data
#do 
find $pathtoData/*/*.xls >> $pathtoResult/mesxlstemp.txt
grep '.amplicon.cov.[0-9][0-9][0-9][0-9].xls' $pathtoResult/mesxlstemp.txt > $pathtoResult/mesxls.txt
sed -i '/Blanc/d' $pathtoResult/mesxls.txt
#done
#TODO
# ajouter un traitement sed "espace" = \"espace"

while read line; do
# make ion copy format for one file
/home/denou/myScripts/oneFileIonCopyFormat.sh $line $pathtoResult;
name=$(basename $line)
if test $counter -eq 0  
	# merge all files on a result file
	then 
		cut -f1 $name.tmp.csv > tmp.tmp 
		sed -i 's/_/-/g' tmp.tmp
		sed -i 's/region-id/Target/g' tmp.tmp # use on PAM data
		# sed -i 's/exon/Target/g' tmp.tmp # use on GENEC data
		counter=$(($counter+1))
 		cut -f2 $name.tmp.csv > tmp.value
		paste tmp.tmp tmp.value > ioncopy_input.$runname.tsv
	else
		cut -f2 $name.tmp.csv > tmp.value
		cat ioncopy_input.$runname.tsv > csv.run
		paste ioncopy_input.$runname.tsv  tmp.value > value.tmp
		cat value.tmp > ioncopy_input.$runname.tsv
fi
done < $pathtoResult/mesxls.txt
# remove temporary files
rm value.tmp
rm tmp.value
rm tmp.tmp
rm csv.run
rm *.tmp.csv
