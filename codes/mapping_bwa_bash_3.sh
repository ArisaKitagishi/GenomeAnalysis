#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 15:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user arkitagishi@gmail.com

export SCRDIR=$HOME/genomeAnalysis/rna/mapping

# load modules
module load bioinfo-tools
module load bwa
module load samtools

# paths
reference=$HOME/genomeAnalysis/rna/mapping/reference/canu_L_Ferri_combined.contigs.fasta
trimmed_path=$HOME/genomeAnalysis/rna/preprocessing/ERR*

# copy bwa index to snic_tmp
cp $reference $SNIC_TMP/

cd $SNIC_TMP
bwa index $SNIC_TMP/canu_L_Ferri_combined.contigs.fasta
for x in $trimmed_path
do
	file=$(basename "$x")
	file_path="${SCRDIR}/${file}"
	mkdir $file_path
	
	paired_1=$(find $x -name "*_paired_1*")
        paired_2=$(find $x -name "*_paired_2*")
	echo $paired_1
	echo $paired_2
	echo "path is $file_path"
	echo "running bwa mem"
	bwa mem -t 5 $SNIC_TMP/canu_L_Ferri_combined.contigs.fasta $paired_1 $paired_2 | samtools sort -@ 4 -m 10G -O bam -o $SNIC_TMP/${file}_sorted_bwa.bam 
	echo "sorted ........................................................................................................"
	echo ./*_sorted_*.bam
	cp $SNIC_TMP/${file}_sorted_bwa.bam $file_path
	
done

echo "done everything!"
