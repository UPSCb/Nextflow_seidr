#' ---
#' title: "Network data preparation"
#' author: "UPSCb"
#' date: "`r Sys.Date()`"
#' output:
#'  html_document:
#'    toc: true
#'    number_sections: true
#' ---
#' # Setup
suppressPackageStartupMessages({
  library(here)
  library(readr)
  library(tidyverse)
  library(readr)
  library(matrixStats)
})

#' Helper
source(here("UPSCb-common/src/R/featureSelection.R"))

#' # Data 
#' ```{r CHANGEME2,eval=FALSE,echo=FALSE}
#'  CHANGEME is the variance stabilised data, where the transformation was done taking the
#'  model into account (_i.e._ `blind=FALSE`)
#' ```



#' # Filter
#' Different ways of filtering are considered. An cutoff on the absolute expression level
#' or on the variance (standard score), respectively. The latter might be more adequate to
#' avoid filtering lowly expressed genes that show sufficient, metadata relevant, variance.
samples <- read_csv(here("samples.csv"))

dds <- readRDS(file=here("dds.rds"))

vsd <- varianceStabilizingTransformation(dds,blind=FALSE)
vst <- assay(vsd)
vst <- vst - min(vst)

#Check order
identical(samples$SampleID, colnames(vst))

# Check for NA values
any(is.na(vst))

#' sels <- rangeFeatureSelect(counts=as.matrix(vst),
#'                            conditions=factor(samples$Condition),
#'                            nrep=3)
#' 
#' e.cutoff <- 1
#' 
#' s.sels <- rangeFeatureSelect(counts=as.matrix(vst),
#'                              conditions=factor(samples$Condition),
#'                              nrep=3,scale=TRUE)
#' s.cutoff <- 1
#' 
#' table(s.sels[[s.cutoff]],sels[[e.cutoff  + 1]])
#' sum(featureSelect(as.matrix(vst),
#'                   factor(samples$Condition),
#'                   exp=0.1,3))
#' sum(featureSelect(as.matrix(vst),
#'                   factor(samples$Condition),
#'                   exp=0.05,3,scale=TRUE))
#' 
#' #' ```{r CHANGEME3,eval=FALSE,echo=FALSE}
#' #'  CHANGEME is the vst cutoff devised from the plot above. The goal is to remove / reduce
#' #'  the signal to noise. Typically, this means trimming the data after the first sharp decrease 
#' #'  on the y axis, most visible in the non logarithmic version of the plot
#' #' ```
#' vst.cutoff <- 0.5

## NO control

#' # Export
dir.create(here("data/seidr"), recursive=TRUE)


#' Here we filter the VST matrix to include all genes with any expression above a standard deviation 
#' of 0 across all samples. This way we don't lose genes that might are lowly expressed but might be 
#' very central and play an important role in our networks.
#' 
filtered_vst <- vst[which(rowSds(vst) > 0),]

#' * gene by column, without names matrix
write.table(t(filtered_vst),
            file=here("data/headless.tsv"),
            col.names=FALSE,
            row.names=FALSE,
            sep="\t",quote=FALSE)


#' * gene names, one row
write.table(t(rownames(filtered_vst)),
            file=here("data/genes.tsv"),
            col.names=FALSE,
            row.names=FALSE,
            sep="\t",quote=FALSE)

#' * save filtered vst
saveRDS(filtered_vst, here("data/filtered_vst.rds"))




#' # Session Info
#' ```{r session info, echo=FALSE}
#' sessionInfo()
#' ```
