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
dna_assembly=$HOME/genomeAnalysis/dna/assembly/combined/*.contigs.fasta
echo "path is $dna_assembly"

emapper.py -m diamond --itype genome --genepred 'prodigal' -i $dna_assembly -o emapper_1 --output_dir $SCRDIR

echo "done everything!"
