#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:00:00

export SCRDIR=$HOME/genomeAnalysis/rna/mapping
cd $SNIC_TMP

# load modules
module load bioinfo-tools
module load bwa
module load samtools

# paths
reference=$HOME/genomeAnalysis/rna/mapping/reference/canu_L_Ferri_combined.contigs.fasta
trimmed_path=$HOME/genomeAnalysis/rna/preprocessing/ERR*

for x in $trimmed_path
do
	file=$(basename "$x")
	file_path="${SCRDIR}/${file}"
	mkdir $file_path
	for y in "${x}/*"
	do
	# bwa sampe generate alignments in SAM format given paired-end reads
	# same issue with bwa aln, cannot use *
	paired_1=$(find $x -name "*_paired_1*")
        paired_2=$(find $x -name "*_paired_2*")
	echo $paired_1
	echo $paired_2

	bwa mem $reference $paired_1 $paired_2 | samtools view -S -b | samtools sort
	done

	cp ./* $file_path
	rm ./*
done

echo "done everything!"
