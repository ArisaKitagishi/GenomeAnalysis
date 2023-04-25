#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:00:00

export SCRDIR=$HOME/genomeAnalysis/dna/annotation/functional/combined
cd $SNIC_TMP

# load modules
module load bioinfo-tools
module load eggNOG-mapper/2.1.9

# paths
dna_prokka=$HOME/genomeAnalysis/dna/annotation/combined/*.gff
echo "path is $dna_prokka"

emapper.py -m diamond --itype genome --genepred 'prodigal' -i $dna_prokka -o emapper_prokka_gff --output_dir $SCRDIR

echo "done everything!"
