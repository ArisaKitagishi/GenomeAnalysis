$HOME/genomeAnalysis/ -name '*bash*.sh' | cpio -pdm dna/
git add dna 
git add rna 
git add ./*.sh
git commit -m "updated $(date)"
git push 

echo "Done everything!"
