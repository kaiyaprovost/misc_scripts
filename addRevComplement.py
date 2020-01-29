# -*- coding: utf-8 -*-
"""
Created on Sat Dec 10 13:45:08 2016

@author: kprovost
"""

def revcomp(dna):
    dna = dna.upper()
    revcomp = ""
    for bp in range(1,len(dna)+1):
        if dna[-bp] == "A":
            revcomp = revcomp + "T"
        elif dna[-bp] == "T":
            revcomp = revcomp + "A"
        elif dna[-bp] == "U":
            revcomp = revcomp + "A"            
        elif dna[-bp] == "G":
            revcomp = revcomp + "C"
        elif dna[-bp] == "C":
            revcomp = revcomp + "G" 
        elif dna[-bp] == "K":
            revcomp = revcomp + "M"
        elif dna[-bp] == "M":
            revcomp = revcomp + "K" 
        elif dna[-bp] == "R":
            revcomp = revcomp + "Y"
        elif dna[-bp] == "Y":
            revcomp = revcomp + "R" 
        elif dna[-bp] == "S":
            revcomp = revcomp + "S"
        elif dna[-bp] == "W":
            revcomp = revcomp + "W"  
        elif dna[-bp] == "B":
            revcomp = revcomp + "V"
        elif dna[-bp] == "V":
            revcomp = revcomp + "B"  
        elif dna[-bp] == "H":
            revcomp = revcomp + "D"
        elif dna[-bp] == "D":
            revcomp = revcomp + "H"    
        elif dna[-bp] == "N":
            revcomp = revcomp + "N"
        elif dna[-bp] == "X":
            revcomp = revcomp + "N" 
        elif dna[-bp] == "?":
            revcomp = revcomp + "N"
        elif dna[-bp] == "-":
            revcomp = revcomp + "-"            
        else: 
            revcomp = revcomp + dna[-bp]
    return(revcomp)

def addcomp(filename,outpath):
    '''
    This function assumes that the names are in the shortname format 
    '''
    with open(filename,"r") as infile,open(outpath+"WITHREV_"+filename,"w") as outfile:
        read = infile.read()
        fasta = read.split(">",1)[1].split("\n>")
        for line in fasta:
            identifier,sequence = line.split("\n",1)
            sequence = "".join(sequence.split("\n"))
            printID = ">"+identifier+"\n"
            revID = ">"+identifier+"~~~REV\n"
            printSeq = sequence+"\n"
            revSeq = revcomp(sequence)+"\n"
            outfile.write(printID+printSeq+revID+revSeq) 
   
def main():
    import os
    import glob
    import sys
    
    cwd = os.getcwd()
    
    try:
        path = sys.argv[1]
        print("\tPath is: ",path)
    except:
        print("Path not given")
        path = os.getcwd()+"/4_single species/"
        print("Path is current directory + 4_single species")    

    outpath = cwd+"/5_withrev/"
    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)   
    
    os.chdir(path)      
    for filename in glob.glob("*.fa*"):
        print(filename)
        addcomp(filename,outpath)

if __name__ == "__main__":
    main()