#!/bin/sh

echo "Starting third part of pipeline"
HOME=$PWD
FOLDER="/Users/kprovost/Dropbox (AMNH)/Side_Projects/Africa_Genbank/Genbank_Data"
cd $FOLDER

## step 14. Create list of presences per gene (presenceAbsenceMatrixGenes.py). 
## This allows for the creation of a human-readable matrix of presences 
## and absences for genes within species. 
## Also run presenceAbsenceMatrixGenes_pivot.py
echo ">>>Step 14"
BASEPAIRS=100 ## the specified number of basepairs sequences must be to be retained. This should be the same as SEQLENNEEDED in RunGenbankPipeline_2.sh
SUFFIX="Suffix_${BASEPAIRS}" ## this suffix can be changed to any desired suffix
python $HOME/presenceAbsenceMatrixGenes.py $SUFFIX "${FOLDER}/8_goodalignments_${BASEPAIRS}"
python $HOME/presenceAbsenceMatrixGenes_pivot.py $SUFFIX 
mkdir "${FOLDER}pivotTables_${BASEPAIRS}"
cd ./pivotTables
mv *.csv "../pivotTables_${BASEPAIRS}"
cd ..

## step 15. Concatenate alignments by species into a supermatrix 
## (concatenateSpecies.py). Species that lack a gene have the entire 
## length of that gene coded as missing. 
echo ">>>Step 15"
FINALNAME="parrot_${SUFFIX}_supermatrix_${BASEPAIRS}.fasta"
python $HOME/concatenateSpecies.py $FINALNAME "./8_goodalignments_${BASEPAIRS}"
mkdir "${FOLDER}supermatrix_${BASEPAIRS}"
cd ./supermatrix
mv *.fasta "../supermatrix_${BASEPAIRS}"
mv *.csv "../supermatrix_${BASEPAIRS}"
cd ..

## step 16. Begin threshholding. This will create GENETHRESH aligned subsets, where in each
## subset, species will only be retained if they have at least N genes, where N ranges 
## between 0 and GENETHRESH. 
echo ">>>Step 16."
echo "Threshholding."
GENETHRESH=20 ## the maximum number of subsets you wish to create.
SPPTHRESH=3
PIVOT="${FOLDER}pivotTables_${BASEPAIRS}/presenceAbsence${SUFFIX}_ONEZERO.csv"
python $HOME/trimMissing.py $GENETHRESH $PIVOT "${FOLDER}supermatrix_${BASEPAIRS}" >> "${FOLDER}supermatrix_${BASEPAIRS}/testlog.txt"

echo ">>>COMPLETE<<<"

