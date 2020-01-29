# -*- coding: utf-8 -*-
"""
Created on Tue Nov 29 11:32:58 2016

@author: kprovost
"""

def deDuplicate(filename,output,outpath):
    with open(filename,"r") as infile:
        read = infile.read()
        fasta = read.split(">",1)[1].split("\n>")
        #print(fasta[0:2])
        unique = set(fasta)
        #print("Entries2: ",len(unique))
        outname = str(len(unique))+"_"+output
        with open(outpath+outname,"w") as outfile:
            first = True            
            for line in unique:
                if line != "":
                    if first == True:
                        outfile.write(">"+line)
                        first = False
                    else:
                        outfile.write("\n>"+line)
                else:
                    print("BLANK")
            removeDoubleSpace(outname,outpath)
                    
def removeDoubleSpace(filename,outpath):
    with open(outpath+filename,"r") as infile:
        read = infile.read()
        print(read[0:100])
        read2 = read.replace("\n\n","\n")
    with open(outpath+filename,"w") as outfile:
        outfile.write(read2)
    print("removed")
         
def countUnique(filename):
    with open(filename,"r") as infile:
        read = infile.read()
        count = read.count(">")  
        #print("Entries1: ",count)
         
def main():
    import glob    
    import os
    import sys
    
    cwd = os.getcwd()
    
    try:
        path = sys.argv[1]
        print("\tPath is: ",path)
    except:
        print("Path not given, using current working directory + 1_originals")
        path = os.getcwd()+"/1_originals/"

    outpath = cwd+"/2_deduplicated/"
    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)
        
    #path = "/Users/kprovost/Documents/Classes/Systematics/Genbank/nucDNA/aligning/1_aligned/2_small/originals (before dedup)/" ##### CHANGE THIS 
    #outpath = "/Users/kprovost/Documents/Classes/Systematics/Genbank/nucDNA/test/1_aligned/"
    #path = "/Users/kprovost/Documents/Classes/Systematics/ParrotPipelineRedo/"
    
    os.chdir(path)    
    
    for filename in glob.glob("*.fa*"):
        #countUnique(filename)
        print(filename)
        output = "DEDUP_"+filename
        deDuplicate(filename,output,outpath)    
        print("\tDONE")
        
if __name__ == "__main__":
    main()