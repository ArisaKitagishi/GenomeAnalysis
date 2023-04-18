getridof=/home/arki7242/genomeAnalysis/
for x in $(find $HOME/genomeAnalysis/ -name '*bash*.sh');
do
	# subtract string to get rid of unnecessary directory i.e. home
	srcdir="${x#$getridof}"
	echo $srcdir	
	cp -r $x ./${srcdir}
done
 
git add ./
git commit -m "updated $(date)"
git push 

echo "Done everything!"
