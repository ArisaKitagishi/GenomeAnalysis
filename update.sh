getridof=/home/arki7242/genomeAnalysis/
for x in $(find $HOME/genomeAnalysis/ -name '*bash*.sh');
do
	# subtract string to get rid of unnecessary directory i.e. home
	srcdir="${x#$getridof}"
	echo $srcdir
	# make directory if it doesnt exist, just gives error if it does whatever
	file_name="$(basename $srcdir)"
	echo $file_name
	# another way to subtract strings
	make_dir="${srcdir/$file_name}"
	echo $make_dir
	mkdir $make_dir
	cp -r $x ./${srcdir}
done

git add ./
git commit -m "updated $(date)"
git push

# update combined codes folder
bash ./codes_combined/update_codes.sh

echo "Done everything!"
