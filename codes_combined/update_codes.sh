for x in $(find $HOME/genomeAnalysis/dna/ -name '*bash*.sh');
do
  cp -r $x /home/arki7242/github/GenomeAnalysis/codes_combined/
done

for x in $(find $HOME/genomeAnalysis/rna -name '*bash*.sh');
do
  cp -r $x /home/arki7242/github/GenomeAnalysis/codes_combined/
done

git add ./
git commit -m "updated $(date)"
git push 

echo "Done everything!"
