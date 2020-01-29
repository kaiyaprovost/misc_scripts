# -*- coding: utf-8 -*-
"""
Created on Thu Dec  1 15:34:22 2016

@author: kprovost
"""

def fasta2string(filename):
    with open(filename,"r") as infile:
        read = infile.read()
        fasta = read.split(">",1)[1].split("\n>")
    return(fasta)

def getSpeciesNames(filename):
    names = []
    with open(filename,"r") as infile:
        lines = infile.readlines()
        for line in lines:
            if line[0] == ">":
                spp = line[1:].split("///")[0]
                #print(spp)
                names.append(spp)
    return(names)
                
def files2species(path,dicti,suffix):
    import os
    import glob
    os.chdir(path)
    for filename in glob.glob("*.fa*"):
        #print(filename)
        
        try:
            gene = "".join(filename.split("_")[9])
        except:
            gene = "".join(filename.split("_")[-1])
        print(filename.split("_"))
        print(gene)
        gene = gene.split(".",1)[0]
        if gene == "1":
            print(filename)
        names = getSpeciesNames(filename)
        for name in names:
            if name in dicti: 
                pass
            else:
                dicti[name] = []
            dicti[name].append(gene+"_"+suffix)      
        print("\tDONE")
    for filename in glob.glob("*.temp"):
        #print(filename)
        try:
            gene = "".join(filename.split("_")[7:-1])
        except:
            gene = "".join(filename.split("_")[6:-1])
        #print(gene)
        if gene == "1":
            print(filename)
        names = getSpeciesNames(filename)
        for name in names:
            if name in dicti: 
                pass
            else:
                dicti[name] = []
            dicti[name].append(gene+"_"+suffix)     
            #dicti[name].append([gene+"_"+suffix,filename])
        print("\tDONE")        
    return(dicti)
    
def main():
    import os
    import sys
    import glob
    
    cwd = os.getcwd()

    try:
        suffix = sys.argv[1]
        print("\tSuffix is: ",suffix)
    except:
        print("Suffix not given")
        print("Suffix is ALL")   
        suffix = "ALL"
   
    try:
        path = sys.argv[2]
        print("\tPath is: ",path)
    except:
        print("Path not given")
        path = os.getcwd()+"/8_goodalignments/"
        print("Path is current directory + 8_goodalignments") 
        
    outpath = cwd+"/pivotTables/"
    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)  

    ### ones that worked
    os.chdir(path)
    geneDict = {}
    geneDict = files2species(path,geneDict,suffix)
        
    print("/////")   
    
    os.chdir(outpath)
    with open("presenceAbsence"+suffix+".csv","w") as outfile:
        outfile.write("SPECIES,GENE\n")
        for key in geneDict.keys():
            for value in geneDict[key]:
                outfile.write(key)
                outfile.write(",")
                outfile.write(value)
                outfile.write("\n")

if __name__ == "__main__":
    main()