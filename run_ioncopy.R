#!/usr/bin/env Rscript

# utiliser ce script : Rscript --vanilla run_ioncopy.R test_data/
# Rscript --vanilla run_ioncopy.R {Mon_run} {Mon_repertoire_test}
# le fichier issu de la commande makeioncopyformat.sh doit se trouver dans le répertoire test_data 
args = commandArgs(trailingOnly=TRUE)

runname <- args[1]
cnaDir <- args[2]
controle <- args[3]
#outDir <- "_CNA/ioncopy"
#dir.create(file.path(runDir, outDir))
#setwd(file.path(mainDir, subDir))

## program...
library(ioncopy)
datapath<-c(cnaDir,"/ioncopy_input.",runname,".tsv")
data<-paste(datapath, collapse="")
#target.files <- reactive(input$target.files)
file.names <- file.path(data)
chip.names <- substr("", 1, 40)
coverage <- read.coverages(chip.names, file.names)
if (controle=="TRUE") {
datapath<-c(cnaDir,"/ioncopy_input.",runname,".controle.tsv")
data<-paste(datapath, collapse="")
file.names <- file.path(data)
chip.names <- substr("", 1, 40)
coverage2 <- read.coverages(chip.names, file.names)
} else {coverage2 <- NULL}

#coverage2 <- read.table(file.path(controles),sep="\t", header=TRUE, row.names=1)
# USELESS ?? coverage <- data.matrix(read_coverage, rownames.force = NA)
cn <- assess.CNA(coverage, coverage.source=coverage2, method.pooled="amplicon", thres.cov=100)

cna <- call.CNA(cn, analysis.mode="amplicon-wise", method.p="samples_genes/amplicons", method.mt="bonferroni", thres.p=0.05, sig.call=0, sig.per=0)
sumcna <- summarize.CNA(cna)
resultsSample <- sumcna$sample
resultsAmplicon <- sumcna$amplicon
#CN <- calculate.CN(coverage, method.pooled = "amplicon", method.mt = "bonferroni",thres.cov = 100, thres.p = 0.05)
#Acalls <- call.amplicons(CN, direction = "gain", method.p = "p_samples", thres.p = 0.05)
#Lcalls <- call.amplicons(CN, direction = "loss", method.p = "p_samples", thres.p = 0.05)
#Gain <- cna[["gain"]]
#Loss <- cna[["loss"]]
#Gcalls <- call.genes(CN, direction = "gain", method.p.det = "p_samples_amplicons",method.p.val = "p_samples", n.validated = 1, thres.p = 0.05)

write.csv(resultsSample,file.path(cnaDir,"ioncopy_res.tsv"), sep="\t")
write.csv(resultsAmplicon,file.path(cnaDir,"ioncopy_resamp.tsv"), sep="\t")
#write.table(Loss,file.path(cnaDir,"ioncopy_loss.tsv"),sep="\t")
