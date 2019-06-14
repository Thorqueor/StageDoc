DATADIR=../BAMfiles
cd $DATADIR
tableau=''
count=0
for i in $(ls *.bam); do tableau[$count]=$i && count=$count+1 && i=$i+1;done
count2=0
for i in $(ls *.bam)
	do
		tests=""$(echo "${tableau[$count2]}")""
		offcontrol=""$(echo "${tableau[$count2]}")""
		count2=$count2+1
		controls=""$(ls *.bam | sed "/"$offcontrol"/d" | tr '\n' ',' | sed "s/.$//")""
		#$controls = $(echo -n $controls)
		#$tests= $(echo -n $tests)
		/home/denou/Tools/ONCOCNV-master/scripts/ONCOCNV_Modified.sh $controls $tests
	done





