#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 5:00:00

# send all input files together

export SCRDIR=$HOME/genomeAnalysis/dna/evaluation_assembly/mummerplot
cd $SNIC_TMP

# load modules
module load bioinfo-tools
module load MUMmer

# paths
dna_assembly=$HOME/genomeAnalysis/dna/assembly/combined/*.contigs.fasta
reference_path=/proj/genomeanalysis2023/Genome_Analysis/2_Christel_2017/reference/OBMB01.fasta

# use mummer to get input for mummerplot
# mummer [options] <reference file> <query file1> . . . [query file32]
# mummer $reference_path $dna_assembly > mummer_file
# mummerplot -r $reference_path ./mummer_file

nucmer --prefix=ref_qry $reference_path $dna_assembly
# show-coords -rcl ref_qry.delta > ref_qry.coords
# cat ref_qry.coords
# show-aligns ref_qry.delta refname qryname > ref_qry.aligns
mummerplot ref_qry.delta -p mummerplot_output_nofilter_nolayout -R $reference_path -Q $dna_assembly --png

cp ./* $SCRDIR
echo "done everything!"
