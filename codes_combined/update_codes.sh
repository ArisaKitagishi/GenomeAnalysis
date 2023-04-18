for x in $(find $HOME/genomeAnalysis/dna/ -name '*bash*.sh');
do
  cp -r $x ./
done

for x in $(find $HOME/genomeAnalysis/rna -name '*bash*.sh');
do
  cp -r $x ./
done

git add ./
git commit -m "updated $(date)"
git push 

echo "Done everything!"
