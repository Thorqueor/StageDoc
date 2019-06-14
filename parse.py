#!/usr/bin/env python
import sys
import csv
import glob
import openpyxl

cna_folder = sys.argv[1]
ioncopy_res_file = open(cna_folder+'/resamp2.tmp','r')
res_reader = csv.reader(ioncopy_res_file,delimiter="\t")
data ={}
for line in res_reader:
	amp=line[0]
	cnv=line[1].split(";")
	data[amp]=cnv

result={}
for key, value in data.items():
	for i in range(len(value)):
		patient=value[i].split("(")
		if patient[0]!=' ""':
			result[key,patient[0]]=patient[1]
		else :
			result[key,patient[0]]=""

with open(cna_folder+'/names.csv','w') as csvfile:
	fieldnames=['amplicon', 'echantillon', 'value']
	writer=csv.DictWriter(csvfile,fieldnames=fieldnames)
	writer.writeheader()
	for key, value in data.items():
		for i in range(len(value)):
			patient=value[i].split("(")
			if patient[0]!=' ""':
				writer.writerow({'amplicon': key, 'echantillon':patient[0], 'value':patient[1]})
			else :
				writer.writerow({'amplicon': key, 'echantillon':"", 'value':patient[0]})

csvfile.close() 

#	mavariable = re.search(r'monpatientid (*?);')

