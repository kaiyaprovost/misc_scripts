#!/bin/sh

## step 1: Download files off of GenBank 
## (using genbankPull.py and a bash script like downloadMultiGenbank_Mito.sh) 
## as .gb files. Exclude reads from shotgun-sequenced whole genomes. 
## change search term on genbank to match
HOME=$PWD
FOLDER="/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/" #the folder the files will be located in 
cd $FOLDER

echo ">>>Step One"
FILENAME=batchAfrica2
ORGANISM="Turdus migratorius"
CSVFILE="/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/scripts/africa_genera_test.txt" ## csv of genera to download 
BATCH=1 ## whether or not to batch by genus 
## Note: the authors recommend batching if using this program, because
## trying to download large numbers of genbank reads at once led to
## many missing records. 
if [ $BATCH = 1 ]; then
python -u $HOME/genbankPull_batch_spp.py $CSVFILE $FILENAME >> batchLog_africa2.log
else
python $HOME/genbankPull.py '''("Psittaciformes"[Organism] OR "Falco mexicanus"[Organism] OR "Passer montanus"[Organism] OR "Tyrannus tyrannus"[Organism] OR "Acanthisitta chloris"[Organism]) NOT "whole genome shotgun"[All Fields]''' $FILENAME
fi
cp ./${FILENAME}.gb ./${FILENAME}.gb.master
cp ./${FILENAME}.fasta ./${FILENAME}.fasta.master
## need to omit: targeted locus study

## failed: Batis, Hylia, Erythrocercus, Hyliota, Macrosphenus, Phylloscopus Ploceus
##		   Phyllanthus, Modulatrix, Muscicapa, Nicator, Zosterops Oriolus Prionops Sylvietta
##		   -- Parus Phyllastrephus Terpsiphone has a server issue 


## step 2: Put all the .gb files together into one (concatenateGenbankFiles.py) 
## such that homologous genes can be combined together. 
## creates folder "concatGenbankFiles" to put them in
## do this by folder if want to keep genera separate
echo ">>>Step Two"
SEPARATE=0
if [ $SEPARATE = 1 ]; then
cd $FOLDER
for subfolder in */; do 
echo $subfolder
cd $subfolder
python $HOME/concatenateGenbankFiles.py $subfolder
cd ..
done
else
python $HOME/concatenateGenbankFiles.py $FOLDER
fi

## step 3: From .gb file(s), extract the genbank into fasta using gb2fasta_bygene.py
echo ">>>Step Three"
cd $FOLDER
python $HOME/gb2fasta_bygene_betterDelimiters.py #$FOLDER $FOLDER

## step 4: Turn the larger fasta files into individual gene files 
## (deMultiGene_afterGb2fasta.py). 
## puts them in folder called "genes"
echo ">>>Step Four"
python $HOME/deMultiGene_afterGb2fasta.py #$FOLDER

## step 5. Manually check the genes to assess homology. 
## Gene names are not standardized across Genbank, and thus 
## punctuation differences and changes in spelling come out as 
## separate genes using this pipeline. During this step, also remove 
## genes that are not of interest like microsatellites, misc features, 
## gaps, tRNAs, unknown loci, etc. 
echo ">>>Begin Step Five"
cd $FOLDER
cd ./genes 
mkdir ./notWanted
mv *MICROSAT*.fa* ./notWanted
mv *TRN*.fa* ./notWanted
mv *MISCFEATURE*.fa* ./notWanted
mv *GAP.fa* ./notWanted
mv *INTRON.fa* ./notWanted
mv *LOC*.fa* ./notWanted
mv *POLYASIGNALSEQUENCE*.fa* ./notWanted
mv *PROMOTER*.fa* ./notWanted
mv *3UTR*.fa* ./notWanted
mv *5UTR*.fa* ./notWanted
mv *REPEATREGION*.fa* ./notWanted
mv *RETROTRANSPOSON*.fa* ./notWanted
mv *EXON.fa* ./notWanted
mv *PRIMERBIND*.fa* ./notWanted
mv *SIGPEPTIDE*.fa* ./notWanted
mv *TATABOX*.fa* ./notWanted
cd ..
echo "User must manually check genes"
echo "Quitting program - restart after checking"
cd $HOME
