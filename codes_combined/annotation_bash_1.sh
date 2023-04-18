#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 5:00:00

export SCRDIR=$HOME/genomeAnalysis/dna/annotation
cd $SNIC_TMP

# load modules 
module load bioinfo-tools
module load prokka

# paths 
dna_assembly=$HOME/genomeAnalysis/dna/assembly/ERR20*


for x in $dna_assembly
do
	file=$(basename $x)
	echo "File is $file"

	file_path="$SCRDIR/$file"
	echo "file path is $file_path"
	
	prokka --outdir $file_path --prefix prokka $HOME/genomeAnalysis/dna/assembly/$file/*.contigs.fasta 
done 

echo "done everything!"

