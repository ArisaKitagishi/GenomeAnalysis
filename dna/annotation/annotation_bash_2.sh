#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 5:00:00

export SCRDIR=$HOME/genomeAnalysis/dna/annotation/combined
cd $SNIC_TMP

# load modules
module load bioinfo-tools
module load prokka

# paths
dna_assembly=$HOME/genomeAnalysis/dna/assembly/combined/*.contigs.fasta

prokka --outdir $SCRDIR --prefix prokka_combined $dna_assembly

echo "done everything!"
