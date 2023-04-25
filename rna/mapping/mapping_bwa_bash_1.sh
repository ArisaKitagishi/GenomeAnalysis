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

# paths
reference=$HOME/genomeAnalysis/rna/mapping/reference/0BMB01.fasta
trimmed_path=$HOME/genomeAnalysis/rna/preprocessing/ERR*

for x in $trimmed_path
do
	file=$(basename "$x")
	file_path="${SCRDIR}/${file}"
	mkdir $file_path
	for y in "${x}/*"
	do
	# had error not finding path to unpaired using *, so will try to use variable and find command
	unpaired_1=$(find $x -name "*unpaired_1*")
	unpaired_2=$(find $x -name "*unpaired_2*")

	# use bwa aln to create .sai files
	bwa aln $reference $unpaired_1 > "${file}_unpaired_1_aln.sai"
	bwa aln $reference $unpaired_2 > "${file}_unpaired_2_aln.sai"

	# bwa sampe generate alignments in SAM format given paired-end reads
	# same issue with bwa aln, cannot use *
	paired_1=$(find $x -name "*_paired_1*")
        paired_2=$(find $x -name "*_paired_2*")
	echo $paired_1
	echo $paired_2

	bwa sampe $reference "${file}_unpaired_1_aln.sai" "${file}_unpaired_2_aln.sai" $paired_1 $paired_2 > "${file}_bwa_sampe.sam"

	done

	cp ./* $file_path
	rm ./*

done

#
# bwa index dna acssembly
# bwa mem dna_assembly.contigs.fasta paired 1 paired 2 | samtools view -S -b | samtools sort

echo "done everything!"
