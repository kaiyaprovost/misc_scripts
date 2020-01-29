#!/bin/sh
echo "Starting second half of pipeline"
HOME=$PWD
FOLDER="/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/" ## this must be the same as in RunGenbankPipeline_1.sh
cd $FOLDER

## step 6. Combine genes together that are homologous but misnamed 
## using combineHomologousGenes.py. 
## moves these to a folder called "1_originals"
echo ">>>Step 6"
python $HOME/combineHomologousGenes.py $FOLDER/genes/
#python $HOME/combineHomologousGenes.py "/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/genes/Alethe/"
#python $HOME/combineHomologousGenes.py "/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/genes/Criniger/"
#python $HOME/combineHomologousGenes.py "/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/genes/Illadopsis/"
#python $HOME/combineHomologousGenes.py "/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/genes/Malimbus/"

## Note: the $FOLDER flag above is optional

## step 7. Remove duplicate entries (removeDupFasta.py).
## moves these to a folder called "2_deduplicated"
echo ">>>Step 7"
python $HOME/removeDupFasta.py
#python $HOME/removeDupFasta.py "/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/genes/Alethe/"
#python $HOME/removeDupFasta.py "/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/genes/Bleda/"
#python $HOME/removeDupFasta.py "/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/genes/Criniger/"
#python $HOME/removeDupFasta.py "/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/genes/Illadopsis/"
#python $HOME/removeDupFasta.py "/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/genes/Malimbus/"

SIZELIMIT=3 ## removes genes with this many or fewer reads
echo "Removing all genes with ${SIZELIMIT} or fewer reads"
cd ./2_deduplicated
mkdir ./tooSmall
for i in $(seq 0 $SIZELIMIT); do 
mv ./${i}_*.fa* ./tooSmall
done
cd ..

## step 8. Change the names! (renameMultiTaxa)
## moves these to a folder called "2.5_multiTaxaNamefix"
echo ">>>Step 8"
RENAME=0 ## 1 if want to rename, 0 if want to not rename
CSV2="parrotNamesNeedingChanging.txt" ## this is a csv file of parrot names to change
python $HOME/renameMultinameTaxa_fix.py $RENAME $CSV2

## step 9. Shorten names to accession number and species only 
## to assist with future processing (fastaNameShortener.py).
## moves these to a folder called "3_short names"
echo ">>>Step 9"
python $HOME/fastaNameShortener_newdelimiter.py $RENAME 
if [ $RENAME==1 ]; then
cd 3_short\ names
mkdir ./temp
mkdir ./notNameFix
mv *_MisnameTaxaFix_*.fa* ./temp
mv *.fa* ./notNameFix
cd ./temp
mv *.fa* ../
cd ..
cd $FOLDER
fi

## step 10. Choose one individual of each species with the most complete sequence, 
## or the largest number of basepairs without gaps (if aligned) or ?/Ns 
## (chooseBestOfSpecies.py). Remove individuals whose sequences are less 
## than 100 basepairs in length. Sequences smaller than this were found to cause strange alignments.
## moves these to a folder called "4_single species"
echo ">>>Step 10"
SEQLENNEEDED=100 ## the specified number of basepairs sequences must be to be retained
#python $HOME/chooseBestOfSpecies.py $SEQLENNEEDED
python /Users/kprovost/Dropbox (AMNH)/Dissertation/CHAPTER1_REVIEW/Genbank/SCRIPTS/chooseBestOfSpecies_keepAllInds.py $SEQLENNEEDED

OUTCSV="parrotOutgroups.csv"
SIZELIMIT2=3 ## removes genes with this many or fewer species
echo "Removing all genes with ${SIZELIMIT2} or fewer parrot species"
cd 4_single\ species
mkdir ./tooSmall
cd ..
#python $HOME/removeTooManyOutgroups.py $SIZELIMIT2 $OUTCSV
cd 4_single\ species
for i in $(seq 0 $SIZELIMIT2); do 
mv ./BEST_${i}_*.fa* ./tooSmall
for f in ./BEST_${i}_*.fa*; do
mv $f ./tooSmall
done
done
cd ..
if [ $RENAME==1 ]; then
cd 4_single\ species
mkdir ./temp
mkdir ./notNameFix
mv *_MisnameTaxaFix_*.fa* ./temp
mv *.fa* ./notNameFix
cd ./temp
mv *.fa* ../
cd ..
cd $FOLDER
fi

## step 11. Reverse complement the sequences and add them to files (addRevComp.py).
## moves these to a folder called "5_withrev"
echo ">>>Step 11"
echo "Adding reverse complements"
#python $HOME/addRevComplement.py "/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data/3_short names/notNameFix/"
python $HOME/addRevComplement.py 

## step 12. Using Muscle, check for reverse complementation and extract sequences 
## that are in-phase with each other (muscleTree.py). Any genes that fail 
## this pipeline have issues with paralogy and should be manually corrected, if possible. 
## moves trees to a folder called "6_alignment trees"
## moves alignments to a folder called "7_ready to align"
echo ">>>Step 12"
MUSCLE=muscle3.8.31_i86darwin64
python $HOME/muscleTree.py $MUSCLE 

cd ./5_withrev
mv *.tre ../6_alignmenttrees
cd ../

## step 13. Align files (muscleAlign.py) and visually assess alignments for 
## alignment errors. Anomalous alignments should be removed from the analysis. 
## moves these to a folder called "8_good alignments" 
echo ">>>Step 13"
python "/Users/kprovost/Africa_Genbank/scripts/muscleAlign.py" $MUSCLE
cd ./7_readytoalign
mv ALIGN*.fa* ../8_goodalignments
cd ..
echo ">>>Manually assess alignments and remove bad alignments as needed."