#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 5:00:00

# send all input files together

export SCRDIR=$HOME/genomeAnalysis/dna/evaluation_assembly/quast
cd $SNIC_TMP

# load modules
module load bioinfo-tools
module load quast

# paths
dna_assembly=$HOME/genomeAnalysis/dna/assembly/combined/*.contigs.fasta
reference_path=/proj/genomeanalysis2023/Genome_Analysis/2_Christel_2017/reference/OBMB01.fasta

quast.py -o $SCRDIR -r $reference_path $dna_assembly

echo "done everything!"
