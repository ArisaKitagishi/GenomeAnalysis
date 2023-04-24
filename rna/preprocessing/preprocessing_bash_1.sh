#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 5:00:00

export SCRDIR=$HOME/genomeAnalysis/rna/preprocessing
cd $SNIC_TMP

# load modules
module load bioinfo-tools
module load trimmomatic/0.39

# paths
rna_rawdata=/proj/genomeanalysis2023/Genome_Analysis/2_Christel_2017/RNA_raw_data/*

for x in $rna_rawdata
do
	file=$(basename "$x" .fastq.gz)
	file="$(cut -d'_' -f1 <<<$file)"
	echo "File is $file"

	file_path="${SCRDIR}/${file}"
	if [ -d $file_path ]; then
		rm -r $file_path
	fi
	if [ ! -d $file_path ]; then
		mkdir $file_path
		echo "file path is $file_path"
		rna_rawdata_forward="/proj/genomeanalysis2023/Genome_Analysis/2_Christel_2017/RNA_raw_data/${file}_1*"
		rna_rawdata_reverse="/proj/genomeanalysis2023/Genome_Analysis/2_Christel_2017/RNA_raw_data/${file}_2*"
		trimmomatic PE -phred33 $rna_rawdata_forward $rna_rawdata_reverse "${file}_paired_1.fastq.gz" "${file}_unpaired_1.fastq.gz" "${file}_paired_2.fastq.gz" "${file}_unpaired_2.fastq.gz" ILLUMINACLIP:$TRIMMOMATIC_ROOT/adapters/TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36 SLIDINGWINDOW:4:15
		cp ./* $file_path
		rm ./*
	fi
done

echo "done everything!"
