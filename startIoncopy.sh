runname=$1
controle=$2
project=$3
pathtoResult=/home/denou/PGM/data/$runname
./makeIoncopyFormat.sh $runname $project
# TODO verifier que le format est correct (pas de double panel, meme nombre de lignes)
Rscript --vanilla run_ioncopy.R $runname $pathtoResult $controle
./FormatIoncopyRes.sh $pathtoResult
python make_cnv_finalreport.py $pathtoResult /home/denou/myScripts/CNV_Report_Empty_ioncopy.xlsx $runname
#head -2 $pathtoResult/CNV_finalReport.xlsx > $pathtoResult/report.xlsx
#sed -i '1,2d' $pathtoResult/CNV_finalReport.xlsx
#sort $pathtoResult/CNV_finalReport.xlsx
#awk '{Print $0}' $pathtoResult/report.xlsx >> $pathtoResult/CNV_finalReport_ioncopy.$runname.xlsx
#awk '{Print $0}' $pathtoResult/CNV_finalReport.xlsx >> $pathtoResult/CNV_finalReport_ioncopy.$runname.xlsx
