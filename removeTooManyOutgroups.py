
# -*- coding: utf-8 -*-
"""
Spyder Editor

This script parses fasta files (the BEST files) and prunes out
loci that have less than some # of non-outgroup taxa
"""

def checkNumOutgroups(filename,csv,outpath,parrotsNeeded,path):
    import os
    with open(filename,"r") as infile:
        lines = infile.readlines()
    with open(csv,"r") as csvfile:
        outgroups = csvfile.readlines()
        for i in range(len(outgroups)):
            outgroups[i] = outgroups[i].strip().replace(" ","_")
    
    #print(outgroups) 

    counttaxa = 0    
    countparrot = 0
     
    for line in lines:
        if line[0] == ">":
            counttaxa += 1
            spp = line.split("///")[0][1:]
            print(spp)
            if spp not in outgroups:
                countparrot += 1
    print(countparrot,parrotsNeeded)
    if countparrot <= parrotsNeeded:
        os.rename(path+filename,outpath+filename)
        print("MOVED")
     
    #os.rename("path/to/current/file.foo", "path/to/new/desination/for/file.foo")

def main():
    import os
    import glob
    import sys
    
    cwd = os.getcwd()
    
    try:
        parrotsNeeded = sys.argv[1]
        #print("#")
        #print(seqLenNeeded)
        #print("$")
        #print(type(seqLenNeeded))
        try:
            parrotsNeeded = int(parrotsNeeded)
            print("\tSequence length needed is: ",parrotsNeeded)
        except:
            print("\tSequence length is not an integer value")
            print("\tDefaulting to 3")
            parrotsNeeded =3
    except:
        print("Sequence length not given, defaulting to 3")
        parrotsNeeded = 3 

    try:
        csv = sys.argv[2]
        print("\tCSV is:",csv)
    except:
        print("Outgroup CSV not given.")
        csv = "parrotGenera_test.csv"
        print("Defaulting to:",csv)
        
    try:
        path = sys.argv[3]
        print("\tPath is: ",path)
    except:
        print("Path not given")
        path = os.getcwd()+"/4_single species/"
        print("Path is current directory + /4_single species/")           
    
    outpath = cwd+"/4_single species/tooSmall/"
    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)       

    os.chdir(path)    
    for filename in glob.glob("*.fa*"):
        print(filename)
        checkNumOutgroups(filename,csv,outpath,parrotsNeeded,path)

if __name__ == "__main__":
    main()