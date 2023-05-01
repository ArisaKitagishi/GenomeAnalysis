#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 10:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user arkitagishi@gmail.com

export SCRDIR=$HOME/genomeAnalysis/differential_expression/htseq

# load modules
module load bioinfo-tools
module load htseq

# paths
prokka_gff=$HOME/genomeAnalysis/dna/annotation/combined/prokka_combined_nonucleotide.gff
alignments=/proj/genomeanalysis2023/nobackup/work/arki_bwa/ERR*

cd $SNIC_TMP
for x in $alignments
do
	file=$(basename "$x")
	file_path="${SCRDIR}/${file}"
	mkdir $file_path
	
	htseq-count -f bam $x/*.bam $prokka_gff > "${file_path}/${file}_output" 
	
done

echo "done everything!"
