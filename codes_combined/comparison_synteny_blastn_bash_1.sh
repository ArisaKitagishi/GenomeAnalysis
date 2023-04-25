#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:00:00

export SCRDIR=$HOME/genomeAnalysis/dna/comparison/
cd $SNIC_TMP
echo "starting code..."
# load modules
module load bioinfo-tools
module load blast
echo "module loaded"
# paths
dna_assembly=$HOME/genomeAnalysis/dna/assembly/combined/canu_L_Ferri_combined.contigs.fasta
blast_strain=$HOME/genomeAnalysis/dna/comparison/strain_BLAST/ml_04_complete_genome.fasta
echo "paths declared..."

blastn -query $dna_assembly -subject $blast_strain -outfmt 6 -out blastn.txt
cp ./* $SCRDIR

echo "done everything!"
