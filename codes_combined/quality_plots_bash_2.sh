#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 5:00:00

export SCRDIR=$HOME/genomeAnalysis/rna/preprocessing/quality_plots/quality_plots_2
cd $SNIC_TMP

# load modules
module load bioinfo-tools
module load FastQC
echo "loaded modules"
# paths
rna_trimmed=$HOME/genomeAnalysis/rna/preprocessing/ERR*
echo $rna_trimmed

for x in $rna_trimmed
do
	file=$(basename $x)
	echo "File is $file"

	file_path="${SCRDIR}/${file}"
	mkdir $file_path
	echo "file path is ${file_path}"
	for y in "${x}/*"
	do
		fastqc --outdir $file_path $y
		echo "FastQC done for ${y}"
	done
done

echo "done everything!"
