#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 23:00:00

export SCRDIR=$HOME/genomeAnalysis/dna/annotation/functional/hmmer
cd $SNIC_TMP

# load modules
module load bioinfo-tools
module load eggNOG-mapper/2.1.9
module load hmmer

# paths
dna_prokka=$HOME/genomeAnalysis/dna/annotation/combined/*.gff
echo "path is $dna_prokka"

# check database through $EGGNOG_DATA_ROOT/hmmer
emapper.py -m hmmer -d Nitrospirae -i $dna_prokka -o emapper_prokka_gff_Nitrospirae --output_dir $SCRDIR --itype genome --genepred 'prodigal'

# emapper.py -m diamond --itype genome --genepred 'prodigal' -i $dna_assembly -o emapper_2 --output_dir $SCRDIR

echo "done everything!"
