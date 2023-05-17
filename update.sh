mkdir codes
mkdir images

for x in $(find $HOME/genomeAnalysis/ -name '*bash*.sh');
do
  cp -r $x ./codes
done

for x in $(find $HOME/genomeAnalysis/ -name '*.png');
do
  cp -r $x ./images
done

git add ./
git commit -m "updated $(date)"
git push

echo "Done everything!"
