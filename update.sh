# Extra lnes of code for reference 
# /home/arki7242/genomeAnalysis/dna/assembly/assembly_bash_1.sh
# find $HOME/genomeAnalysis/dna/ -name '*bash*.sh' -print | cpio -pdm dna/ 
# find $HOME/genomeAnalysis/rna/ -name '*bash*.sh' -print | cpio -pdm rna/

getridof=/home/arki7242/genomeAnalysis/
for x in $(find $HOME/genomeAnalysis/ -name '*bash*.sh');
do
	# need to cut to avoid home 
	srcdir="${x#$getridof}"
	echo $srcdir	
	cp -r $x ./${srcdir}
done
 
git add ./
git commit -m "updated $(date)"
git push 

echo "Done everything!"
