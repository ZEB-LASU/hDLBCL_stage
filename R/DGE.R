# Copyright (C) 2021  Abdulazeez Giwa <abdulazeez.giwa@lasu.edu.ng>
#		       Azeez Fatai <azeez.fatai@lasu.edu.ng>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>

library(edgeR)
library(DESeq2)
library(ggplot2)
library(RColorBrewer)
library(pheatmap)


exprs <- as.matrix(read.csv("../counts.csv", row.names = 1))
head(exprs)



group <- factor(c(rep("S4",12), rep("S1",8)))
dge <- DGEList(counts = exprs, group = group)
keep <- filterByExpr(dge) 
table(keep) 
summary(keep)
dge <- dge[keep, , keep.lib.sizes=FALSE]
m <- dge$counts

pData <- read.csv("../phenotype_dge.csv", row.names=1)

all(rownames(pData)==colnames(exprs)) 
metadata <- data.frame(labelDescription=c("Sample condition name"), row.names = c("conditionName"))
phenoData <- new("AnnotatedDataFrame", data = pData, varMetadata=metadata)
conditionName <- phenoData$conditionName
eset <- ExpressionSet(assayData = exprs, phenoData = phenoData)
colData <- DataFrame(pData(eset))

se <- SummarizedExperiment(exprs(eset), colData=colData)
dds <- DESeqDataSet(se, design = ~ conditionName)
dds$conditionName <- relevel(dds$conditionName, ref="S1")
dds_rlog <- vst(dds, blind = FALSE)
dds <- DESeq(dds) 

resLFC <- results(dds, lfcThreshold = 0.585, alpha = 0.05)
resLFC
summary(resLFC)
resSig <- subset(resLFC, padj < 0.05)

# order by padj
DEGs <- resSig[order(resSig$padj),]
write.csv(DEGs, "../DEG-padj.csv")

# order by logFoldChange
resSig2 <- resSig[order(resSig$log2FoldChange),] 
write.csv(resSig2, "../DEG-lfc.csv") 


#create matrix for heatmap plotting
mat <- assay(dds_rlog[row.names(resSig2)])    
df = as.data.frame(colData(dds_rlog)[,c("conditionName")]) 
colnames(df) = "conditionName" 
rownames(df) = colnames(mat) 

row.names(mat)

row.names(mat) <- c("CTD-2026A21.1", "MSMB", "FBP2", "LINC00992", "NLRP4", "lnc-KY-2", "CDH16", "MUC16", "PDZK1IP1", "lnc-GJA10-4", "PRSS8", "LINC01088", "CPA6", "CTSE", "LIPI", "AGR2", "IGHVII-60-1", "CAMP", "SDR16C5", "TMPRSS2", "lnc-SAMSN1-2", "LMO3", "TMEM125", "LINC01747", "CCDC85A", "lnc-MEF2C-4", "TSPAN1", "ALOX15", "KCNQ1OT1", "VWCE", "ABCA9", "lnc-PABPN1L-1", "CFAP91", "SPTBN2", "KCNJ2", "WNT9A", "TBC1D27P", "CASP5", "LINC01415", "lnc-IRF2BP2-1", "PTBP1P", "BCL2L10", "TMEM132B", "ACOD1", "MYOCD", "SACS-AS1")

# plot heatmap
png(file = "../Heatmap.png", height = 2000, width = 2500, res=400) 
pheatmap(mat = mat, 
         scale = "row", 
         annotation_col = df, 
         fontsize = 6.5, 
         show_colnames = T)

dev.off()


