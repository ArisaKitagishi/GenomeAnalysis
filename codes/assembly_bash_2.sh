#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 15:00:00

# send all input files together 

export SCRDIR=$HOME/genomeAnalysis/dna/assembly/combined
cd $SNIC_TMP

# load modules 
module load bioinfo-tools
module load canu/2.2

# paths 
dna_rawdata=/proj/genomeanalysis2023/Genome_Analysis/2_Christel_2017/DNA_raw_data/*

canu\
	-p canu_L_Ferri_combined -d $SCRDIR\
	genomeSize=2.4m\
	useGrid=false\
	-pacbio $dna_rawdata

echo "done everything!"

