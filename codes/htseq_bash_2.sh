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
file_path="${SCRDIR}/combined"
mkdir $file_path
htseq-count -f bam -r pos -s reverse -t CDS -i ID ${alignments}/*.bam $prokka_gff > "${file_path}/combined_output"

echo "done everything!"
