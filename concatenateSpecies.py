# -*- coding: utf-8 -*-
"""
Created on Fri Dec 2 2016

@author: kprovost
"""

def files2data(path,geneList,sppList,lengthDict,sppGeneDict):
    import os
    import glob
    os.chdir(path)    
    
    for filename in glob.glob("*.fa*"):
        try:
            gene = filename.split("_")[9]
        except:
            gene = filename.split("_")[-1]
        gene = gene.split(".")[0]
        geneList.append(gene)
        
        with open(filename,"r") as infile:
            lines = infile.readlines()
            for line in lines:
                if line[0] == ">": ## is spp line
                    spp = line[1:].split("///")[0]
                    sppList.append(spp)
                else: ## is seq line
                    sppGene = spp+"_"+gene
                    if sppGene in sppGeneDict:
                        oldSeq = sppGeneDict[sppGene].strip()
                        newSeq = oldSeq + line.strip()
                        sppGeneDict[sppGene] = newSeq
                    else:
                        sppGeneDict[sppGene] = line.strip()
        fullSeq = sppGeneDict[sppGene].strip()
        lengthDict[gene] = len(fullSeq)
    return(geneList,sppList,lengthDict,sppGeneDict)
       ## make sure spplist is unique at end            

def main():
    import os
    import sys
    import glob
    
    cwd = os.getcwd()

    try:
        final = sys.argv[1]
        print("\tFinal filename is: ",final)
    except:
        print("Final filename not given")
        print("Defaulting to supermatrix.fasta")   
        final = "supermatrix.fasta"
   
    try:
        path = sys.argv[2]
        print("\tPath is: ",path)
    except:
        print("Path not given")
        path = os.getcwd()+"/8_goodalignments/"
        print("Path is current directory + 8_goodalignments") 
        
    outpath = cwd+"/supermatrix/"
    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)     
    
    geneList = [] ## list of genes
    sppList = [] ## list of species
    lengthDict = {} ## key: gene, value: length of gene
    sppGeneDict = {} ## key: spp-gene pair, value: sequence

    geneList,sppList,lengthDict,sppGeneDict = files2data(path,geneList,sppList,lengthDict,sppGeneDict)     
    sppList = list(set(sppList))
    
    
    print(lengthDict)    
    print(len(geneList))
    print(len(sppList))
    
    os.chdir(outpath) 
    geneListString = ",".join(geneList)
    
    #with open("test.fasta","w") as outfile:    
    with open(final,"w") as outfile,open("shortnames_"+final,"w") as shortfile,open("missing"+final+".csv","w") as missingfile:
        missingfile.write("SPECIES,MISSINGBP\n")        
        for spp in sppList: # for each species:
            countN = 0
            # print > + spp name + delimiter + gene list to file with \n in between
            #print(spp)
            outfile.write(">"+spp+"///"+geneListString+"\n")
            shortfile.write(">"+spp+"\n")
            for gene in geneList: # for each gene:
                #print("\t"+gene)
                sppGene = sppGene = spp+"_"+gene
                if sppGene in sppGeneDict: # if spp-gene pair in map:
                    #print("\t\thas")
                    seq = sppGeneDict[sppGene] # fill in seq from map
                    outfile.write(seq+"\n") # print seq to file with \n in between
                    shortfile.write(seq+"\n")
                    geneN = seq.count("N")+seq.count("n")+seq.count("?")+seq.count("X")
                    countN += geneN
                else: # if spp-gene pair not in map:
                    #print("\t\tnot")
                    length = lengthDict[gene] # look up gene length
                    nullSeq = "?"*(length) # create string of N * gene length
                    outfile.write(nullSeq+"\n") # print N string to file with \n in between
                    shortfile.write(nullSeq+"\n")
                    countN += length
            missingfile.write(spp+","+str(countN)+"\n")
    
if __name__ == "__main__":
    main()