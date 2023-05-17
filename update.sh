mkdir codes
mkdir images
mkdir html

for x in $(find $HOME/genomeAnalysis/ -name '*bash*.sh');
do
  cp -r $x ./codes
done

for x in $(find $HOME/genomeAnalysis/ -name '*.png');
do
  cp -r $x ./images
done

for x in $(find $HOME/genomeAnalysis/ -name '*.html');
do
  cp -r $x ./html
done

git add ./
git commit -m "updated $(date)"
git push

echo "Done everything!"
