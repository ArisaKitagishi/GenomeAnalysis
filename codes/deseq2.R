# DESeq2 R version 4.2.1
# Arisa Kitagishi
# Genome Analysis 2023

# takes long time to install 
if(!requireNamespace("BiocManager", quietly = TRUE))
{
  install.packages("BiocManager")
}
BiocManager::install("DESeq2", version = "3.16")
library("DESeq2")
install.packages("pheatmap")
library("pheatmap")
install.packages("seqinr")
library(seqinr)
install.packages("openxlsx", dependencies = TRUE)

prokka_annotation <- read.table(file = "prokka_combined.tsv", sep = '\t', header = TRUE)
prokka_faa <- read.fasta("prokka_combined.faa")
prokka_faa_im <- read.fasta("prokka_combined_improved.faa")

eggnogmapper <- read.delim(file = "emapper_prokka_gff_Nitrospirae.emapper.annotations", sep = '\t', header = TRUE)
eggnogmapper_diamond <- read.delim(file = "emapper_1.emapper.annotations", sep = '\t', header = TRUE)

htseq_table <- read.delim("combined_htseq_output.txt", header = FALSE, sep = '\t', col.names = c("locus_tag", "ERR2036629",  "ERR2036630",  "ERR2036631",  "ERR2036632", "ERR2036633"))
# htseq_transpose <- t(htseq_table[-1])
# colnames(htseq_transpose) <- htseq_table[, 1]

# see what ftypes are in table 
table(prokka_annotation$ftype)

directory <- "./htseq/"
sampleFiles <- grep("ERR",list.files(directory),value=TRUE)
sampleNames <- c("ERR2036629",  "ERR2036630",  "ERR2036631",  "ERR2036632", "ERR2036633")
sampleCondition <- c("Continuous",  "Continuous",  "Bioleaching",  "Bioleaching", "Continuous")
# sampleCondition <- c("CDS", "tmRNA", "tRNA")
sampleTable <- data.frame(sampleName = sampleNames,
                          fileName = sampleFiles,
                          condition = sampleCondition)
id <- c("ERR2036629",  "ERR2036630",  "ERR2036631",  "ERR2036632", "ERR2036633")
sampleTable_condition <- data.frame(sampleName = id,
                          condition = sampleCondition)

# sampleTable$condition <- factor(sampleTable$condition)

deseq_obj <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                        directory = directory,
                                        design = ~ condition)

deseq_result <- DESeq(deseq_obj)

res <- results(deseq_result)
plotMA(res, alpha=0.05, ylim=c(-2,2))

# take lowest and highest log2foldchange from res and plot using heatmap and then look at prokka and eggnogmapper 
# change NA to 0 because it wont work idk what im doing 
# organize data using padj
# take top 10 an lowest 10 log2fold
res_zero <- res
res_zero$padj <- ifelse(is.na(res_zero$padj), 1, res_zero$padj)
res_zero$log2FoldChange <- ifelse(is.na(res_zero$log2FoldChange), 0, res_zero$log2FoldChange)
data_log <- res_zero[res_zero$padj <= 0.05, ]
data_log_sorted <- data_log[ with(data_log, order(data_log$log2FoldChange, decreasing=TRUE)), ]
top_10 <- data_log_sorted[1:10, ]
top_names <- rownames(top_10)

data_log_sorted <- data_log[ with(data_log, order(data_log$log2FoldChange, decreasing=FALSE)), ]
# data_log_sorted[1:10, col_num u want to extract]
low_10 <- data_log_sorted[1:10, ]
low_names <- rownames(low_10)

table(sign(data_log$log2FoldChange))
print(sum(data_log$log2FoldChange > 0))
print(sum(data_log$log2FoldChange < 0))

filter_rows <- c(top_names, low_names)

# plot heatmap compare using prokka and eggnogmapper 
df <- sampleTable_condition
rownames(df) <- colnames(deseq_result)
vsd <- vst(deseq_result)
pheatmap(assay(vsd)[rownames(vsd) %in% filter_rows, ], cluster_rows=TRUE, show_rownames=TRUE, cluster_cols=TRUE, annotation_col = df)

plotPCA(vsd, intgroup=c("condition"))

# if cant find gff, check prokka faa and blast
names_faa <- attr(prokka_faa, "name")
annotations_faa <- sapply(names_faa, function(x) attr(prokka_faa[[x]], "Annot"))
faa_table <- data.frame(names_faa, annotations_faa)
colnames(faa_table) <- c("names", "functions")

names_faa_im <- attr(prokka_faa_im, "name")
annotations_faa_im <- sapply(names_faa_im, function(x) attr(prokka_faa_im[[x]], "Annot"))
faa_table_im <- data.frame(names_faa_im, annotations_faa_im)
colnames(faa_table_im) <- c("names", "functions")

matched_gff <- subset(prokka_annotation, prokka_annotation$locus_tag %in% filter_rows, select = c(locus_tag, product))
matched_faa <- subset(faa_table, faa_table$names %in% filter_rows, select = c(names,functions))
matched_faa$functions <-  sub("^[^ ]+ ", "", matched_faa$functions)

matched_faa_im <- subset(faa_table_im, faa_table_im$names %in% filter_rows, select = c(names,functions))
matched_faa_im$functions <-  sub("^[^ ]+ ", "", matched_faa_im$functions)

# filter eggnogmapper table
eggnogmapper$query <- as.numeric(sub("tig00000001_", "", eggnogmapper$query))
eggnogmapper_diamond$query <- as.numeric(sub("tig00000001_", "", eggnogmapper_diamond$query))

matched_faa$names <- as.numeric(sub("FACCOEPL_0", "", matched_faa$names))
matched_faa_im$names <- as.numeric(sub("FACCOEPL_0", "", matched_faa_im$names))
matched_eggnogmapper <- subset(eggnogmapper, eggnogmapper$query %in% matched_faa$names, select = c(query,Description))
matched_eggnogmapper_diamond <- subset(eggnogmapper_diamond, eggnogmapper_diamond$query %in% matched_faa$names, select = c(query,Description))

matched_eggnogmapper_im <- subset(eggnogmapper, eggnogmapper$query %in% matched_faa_im$names, select = c(query,Description))
matched_eggnogmapper_diamond_im <- subset(eggnogmapper_diamond, eggnogmapper_diamond$query %in% matched_faa_im$names, select = c(query,Description))

openxlsx::write.xlsx(matched_eggnogmapper, "matched_eggnogmapper.xlsx")
openxlsx::write.xlsx(matched_eggnogmapper_diamond, "matched_eggnogmapper_diamond.xlsx")
openxlsx::write.xlsx(matched_faa, "matched_faa.xlsx")
openxlsx::write.xlsx(matched_faa_im, "matched_faa_im.xlsx")




