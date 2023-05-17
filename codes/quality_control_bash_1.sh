#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 1:00:00

export SCRDIR=$HOME/genomeAnalysis/rna/quality_control
cd $SNIC_TMP

# load modules 
module load bioinfo-tools
module load FastQC

# paths 
rna_rawdata=/proj/genomeanalysis2023/Genome_Analysis/2_Christel_2017/RNA_raw_data/*

for x in $rna_rawdata
do
	file=$(basename $x .fastq.gz)
	echo "File is $file"
	
	file_path="$SCRDIR/$file"
	mkdir $file_path
	echo "file path is $file_path"
	
	fastqc --outdir $file_path $x 
	echo "FastQC done for $x"
done 

echo "done everything!"
