#!/usr/bin/env python
import sys
import csv
import glob
import openpyxl
import numpy as np

cna_folder = sys.argv[1]
input_file= sys.argv[2]
with open(cna_folder+'/col4.tmp','r') as amp_list:
	amp_header=""
	amp=""
	for l in amp_list:
		amp_header = l
		amp_header = amp_header[:-1]
		listamp=amp_header.split(",")
		break
amp_list.close()

with open(cna_folder+'/col2.tmp','r') as sample_list:
	sample_header=""
	sample=""
	for l in sample_list:
		sample_header = l
		sample_header = sample_header[:-1]
		listsample=sample_header.split(",")
		break
sample_list.close()

data = {}
ioncopy_res_file = open(cna_folder+input_file,'r')
res_reader = csv.reader(ioncopy_res_file,delimiter=",")
for line in res_reader:
	testamp=line[0]
	testsample=line[1]
	data[(testamp,testsample)]=line[2]

defaut_value="CN=2 p=NA"

for amp in listamp:
	for sample in listsample:
		if (amp,sample) in data.keys() :
			pass
		else :
			data[(amp,sample)]=defaut_value

header =[""]
header.extend(listsample)
counter=0 
with open(cna_folder+input_file+'.output.csv','w') as toto:
	writer=csv.writer(toto)
	writer.writerow(header)
	for amp in listamp:
		row=[]
		row.append(amp)
		for sample in listsample:
			row.append(data[(amp,sample)])
		writer.writerow(row)

toto.close()
