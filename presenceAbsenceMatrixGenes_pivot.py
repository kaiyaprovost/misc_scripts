# -*- coding: utf-8 -*-
"""
Created on Tue Feb 21 15:48:29 2017

@author: kprovost
"""

def readFile(filename):
    presenceDict = {}
    geneDict = {}
    sppDict = {}
    with open(filename,"r") as infile:
        lines = infile.readlines()
        for i in range(len(lines)):
            line = lines[i]
            if i > 0:
                spp,locus = line.strip().split(",",1)
                get = sppDict.get(spp,None)
                if get == None:
                    sppDict[spp] = 0
                sppDict[spp] += 1
                    
                gene,genome = locus.strip().split("_",1)
                gene = gene.split(".")[0]
                print(gene)
                
                get = geneDict.get(gene,None)
                if get == None:
                    geneDict[gene] = 0
                geneDict[gene] += 1
                
                get = presenceDict.get(spp,None)
                if get == None:
                    presenceDict[spp] = []
                presenceDict[spp] += [gene]
            else:
                print(line)
                
    return(presenceDict,geneDict,sppDict)

def buildBinaryMatrix(geneDict,sppDict,presenceDict,outfile):
    geneList = list(geneDict.keys())
    geneList.sort()
    sppList = list(sppDict.keys())
    sppList.sort()
    print(geneList)

    with open(outfile,"w") as out: 
        out.write("Species,"+",".join(geneList)+",TotalGenes\n")
        for spp in sppList:
            string = ""      
            numGene = 0              
            presGenes = set(presenceDict[spp])
            for gene in geneList:
                geneSet = {gene}
                #print(geneSet)
                #print(presGenes)
                #print(geneSet.issubset(presGenes))
                #print(presGenes.issubset(geneSet))
                if geneSet.issubset(presGenes) == True:
                    string += ",1"
                    numGene += 1
                else:
                    string += ",0"            
            out.write(spp+string+","+str(numGene)+"\n")
    
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
        path = os.getcwd()+"/pivotTables/"
        print("Path is current directory + pivotTables") 
       
    os.chdir(path)
    filename = "presenceAbsence"+suffix+".csv"
    presenceDict,geneDict,sppDict = readFile(filename)
    print(geneDict)
    outfile = "presenceAbsence"+suffix+"_ONEZERO.csv"
    buildBinaryMatrix(geneDict,sppDict,presenceDict,outfile)

    
if __name__ == "__main__":
    main()