#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:00:00

export SCRDIR=$HOME/genomeAnalysis/dna/annotation/functional/hmmer
cd $SNIC_TMP

# load modules
module load bioinfo-tools
module load eggNOG-mapper/2.1.9
module load hmmer

# paths
dna_assembly=$HOME/genomeAnalysis/dna/assembly/combined/*.contigs.fasta
echo "path is $dna_assembly"

# check database through $EGGNOG_DATA_ROOT/hmmer
emapper.py -m hmmer -d Acidobacteria -i $dna_assembly -o emapper_Acidobacteria --output_dir $SCRDIR --itype genome --genepred 'prodigal'

# emapper.py -m diamond --itype genome --genepred 'prodigal' -i $dna_assembly -o emapper_2 --output_dir $SCRDIR

echo "done everything!"
