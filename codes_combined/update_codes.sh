for x in $(find $HOME/genomeAnalysis/ -name '*bash*.sh');
do
  cp -r $x /home/arki7242/github/GenomeAnalysis/codes_combined
done

git add ./
git commit -m "updated $(date)"
git push 

echo "Done everything!"
