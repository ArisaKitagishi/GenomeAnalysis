#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 5:00:00

export SCRDIR=$HOME/genomeAnalysis/rna/preprocessing/quality_plots
cd $SNIC_TMP

# load modules
module load bioinfo-tools
module load FastQC

# paths
rna_trimmed=$HOME/genomeAnalysis/rna/preprocessing/ERR*

for x in $rna_trimmed
do
	file=$(basename)
	echo "File is $file"

	file_path="$SCRDIR/$file"
	mkdir $file_path
	echo "file path is $file_path"
	for y in "${x}/*"
		fastqc --outdir $file_path $y
		echo "FastQC done for $y"
	done
done

echo "done everything!"
