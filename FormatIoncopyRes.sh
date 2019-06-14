pathtoResult=$1
cd $pathtoResult
sed 's/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/' ioncopy_res.tsv | sed 's/_//' | awk 'BEGIN{FS="\t"}{print $1,"\t", $10}' | sed '1d' > res.tmp
sed 's/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/;s/,/\t/' ioncopy_resamp.tsv | awk 'BEGIN{FS="\t"}{print $1,"\t", $9}' | sed '1d' > resamp.tmp
touch ioncopy_final.tmp
cut -f1 resamp.tmp > col1.tmp
sed -i '1i\\n' col1.tmp
cut -f1 res.tmp | tr '\n' ',' > col2.tmp
sed -i '/^$/d' col1.tmp
tr '\n' ',' < col1.tmp > col4.tmp
sed -i 's/"//g' col4.tmp
sed -i 's/"//g' col2.tmp
sed -i 's/.amplicon.cov.[0-9][0-9][0-9][0-9]//g' col2.tmp

cut -f2 resamp.tmp > col3.tmp
sed 's/,//g' res.tmp | sed 's/.amplicon.cov.[0-9][0-9][0-9][0-9]//g' > res2.tmp
sed 's/,//g' resamp.tmp | sed 's/.amplicon.cov.[0-9][0-9][0-9][0-9]//g' > resamp2.tmp

cd /home/denou/myScripts
python parse.py $pathtoResult

cd $pathtoResult
sed -i 's/"_//g' names.csv
sed -i 's/\ _//g' names.csv
sed -i 's/"\ "//g' names.csv
sed -i 's/\ "//g' names.csv
sed -i 's/)"""//g' names.csv
sed -i 's/)//g' names.csv
sed -i 's/,"/,/g' names.csv
sed -i 's/,\ /,/g' names.csv
sed -i 's/\ ,/,/g' names.csv
sed -i 's/,/\ ,/g' names.csv
head -1 names.csv > loss.csv
head -1 names.csv > gain.csv
grep 'LOSS' names.csv >> loss.csv
grep 'GAIN' names.csv >> gain.csv
sed -i 's/GAIN\ //g' gain.csv
sed -i 's/LOSS\ //g' loss.csv
cd /home/denou/myScripts
python writeRes.py $pathtoResult /loss.csv
python writeRes.py $pathtoResult /gain.csv
cd $pathtoResult
sed -i 's/CN=2 p=NA//g' gain.csv.output.csv
sed -i 's/CN=2 p=NA//g' loss.csv.output.csv
sed -i 's/,/\t/g' gain.csv.output.csv
sed -i 's/,/\t/g' loss.csv.output.csv
sed -i 's/ p=/, p=/g' gain.csv.output.csv
sed -i 's/ p=/, p=/g' loss.csv.output.csv




