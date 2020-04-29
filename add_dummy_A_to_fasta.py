#!/usr/bin/env python3

## written by Kaiya Provost 
## Version 1.0: 29 April 2020
## Usage: python3 add_dummy_A_to_fasta.py <folder of fastas OR single fasta file>

## python3 add_dummy_A_to_fasta.py /Users/kprovost/Downloads/parrot-uces-for-dummy-variables/mafft-nexus-clean-75p_uce-7379.nexus-out.fas
## python3 add_dummy_A_to_fasta.py /Users/kprovost/Downloads/parrot-uces-for-dummy-variables/


import sys
import glob
import os
import gzip
import numpy as np
import copy

def readFasta(fastafile,verbose=False):
	'''This function was originally written in the python file positionToN_1.2.py by K. Provost and has been edited for this program.'''
	with open(fastafile) as fasta:
		text = fasta.read()
	## split the fasta file by ">", remove first because blank
	if verbose==True:
		print("\tFinished Reading Fasta")
	split = text.split(">")[1:]
	if verbose==True:
		print("\tSplit Text (1-5):")
		print(split[0:5])	
	#fastadict = {}
	#seqarray = ""
	return(split)

def addDummy(fastafile,verbose=False):
	data_by_individual = readFasta(fastafile)
	newdata_by_individual = copy.deepcopy(data_by_individual)
	for i in range(len(data_by_individual)):
		ind = data_by_individual[i]
		if verbose==True:
			print(str(i)+":"+str(ind))
		individual_name,individual_data=ind.split("\n",1)
		new_data = "A"+individual_data
		new_ind = ">"+individual_name+"\n"+new_data
		newdata_by_individual[i] = new_ind
	new_fastafile = str(fastafile)+".dummy_added.fasta"
	with open(new_fastafile,"w") as outfile:
		outfile.writelines(newdata_by_individual)


def main():
	try:
		fastafile = sys.argv[1]
		print("File/folder read was: ",str(fastafile))
	except:
		print("No file/folder read, terminating.")
		exit()
		
	if os.path.isdir(fastafile):  
		print("\nInput is a directory")
		fastapath=fastafile
		fasta_filelist=glob.glob(pathname=fastapath+"*.fas")
		for file_index in range(len(fasta_filelist)):
			thisfile = fasta_filelist[file_index]
			#print(thisfile)
			addDummy(thisfile)
	elif os.path.isfile(fastafile):  
		print("\nInput is a normal file")
		addDummy(fastafile)
	else:  
		print("\nCannot process this kind of input! Exiting")
		exit()
	print("Finished")

if __name__ == "__main__":
	main()