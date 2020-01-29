# -*- coding: utf-8 -*-
"""
Created on Fri Dec  9 18:34:54 2016

@author: kprovost


Combines files with same prefix i.e. GENE.fa with GENE_2.fa with GENE_3.fa
"""

def combineFiles(path,outpath):        
    import os
    import glob
    os.chdir(path)
    
    print(path)
    
    listfile = glob.glob("*.fa*")
    
    filedict = {}
    
    for filename in listfile:
        print(filename)
        if len(filename.split("_")) <= 1:
            prefix = ".".join(filename.split(".")[0:-1])
            suffix = filename.split(".")[-1]
            splitter = "."
            #print(prefix, suffix)
        else:
            prefix = "_".join(filename.split("_")[0:-1])
            suffix = filename.split("_")[-1]
            splitter = "_"
            #print(prefix, suffix)
        if prefix in filedict:
            filedict[prefix].append(suffix)
        else:
            filedict[prefix] = [suffix]
            
    print("~~~~~")
            
    for prefix in filedict.keys():
        with open(outpath+prefix+".fasta","a") as outfile:
            for suffix in filedict[prefix]:
            	#print(prefix+splitter+suffix)
                with open(prefix+splitter+suffix,"r") as infile:
                    read = infile.read()
                    outfile.write(read+"\n")     

def main():
    import os
    import sys
    
    cwd = os.getcwd()
    
    try:
        path = sys.argv[1]
        print("\tPath is: ",path)
    except:
        print("Path not given, using current working directory + genes")
        path = os.getcwd()+"/genes/"

    outpath = path+"/1_originals/"
    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)

    combineFiles(path,outpath)

if __name__ == "__main__":
    main()