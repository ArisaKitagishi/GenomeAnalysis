#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 15:00:00

export SCRDIR=$HOME/genomeAnalysis/dna/assembly
cd $SNIC_TMP

# load modules 
module load bioinfo-tools
module load canu

# paths 
dna_rawdata=/proj/genomeanalysis2023/Genome_Analysis/2_Christel_2017/DNA_raw_data/*

for x in $dna_rawdata
do
# maxMemory = 15000 gb
file=$(basename $x .fastq.gz)
echo "File is $file"

file_path="$SCRDIR/$file"
echo "file path is $file_path"
	canu\
		-p canu_L_Ferri -d $file_path\
		genomeSize=2.4m\
		useGrid=false\
		-pacbio $x
	
	echo "Canu done for $x"
done 

echo "done everything!"

