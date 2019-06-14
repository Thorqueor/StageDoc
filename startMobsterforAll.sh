start=$(date +%s)
runname=$1
pathtoResult=/home/denou/Tools/Mobster/Mobster2/mobster/results/$runname
pathtoData=/run/user/1000/gvfs/sftp:host=129.10.20.36/u02/NextSeq/JDC_Analysis/$runname/Alignment
#pathtoData=/home/denou/Tools/Mobster/Mobster2/mobster/test_files
pathtoMobster=/home/denou/Tools/Mobster/Mobster2/mobster
mkdir $pathtoResult
cd $pathtoData

tableau=''
count=0
for i in $(ls *.bam); do tableau[$count]=$i && count=$count+1 && i=$i+1;done
count2=0

for i in $(ls *.bam)
	do
		tests=""$(echo "${tableau[$count2]}")""
		count2=$count2+1
		fullfilename=$(basename $tests)
		filename=${fullfilename%.*}
		if [ -f $pathtoResult/$filename/${filename}_predictions.vcf ]; then
			if [ -s $pathtoResult/$filename/${filename}_predictions.vcf ]; then
				continue
			fi
		fi
		/home/denou/myScripts/startMobsterforOne.sh $tests $pathtoData $pathtoResult
	done

end=$(date +%s)

seconds=$(echo "$end - $start" | bc)
echo $seconds' sec'

echo 'Formatted:'
awk -v t=$seconds 'BEGIN{t=int(t*1000); printf "%d:%02d:%02d\n", t/3600000, t/60000%60, t/1000%60}'
