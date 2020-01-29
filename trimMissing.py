# -*- coding: utf-8 -*-
"""
Created on Tue Feb 21 15:42:09 2017

@author: kprovost

This program requires a pivot table-style (with 0 and 1) gene 
presence/absence matrix. With it, it subsets full FASTA files 
so that only species that have at least some threshhold number of 
genes are included 

"""

def trimFastaPivot(pivot,fasta,threshGenes):
    
    outfasta = "ThreshGenes"+str(threshGenes)+"_"+fasta    
    #outfasta = "test.fasta"
   
    with open(pivot,"r") as pivotfile:
        pivlines = pivotfile.readlines()
      
    goodspp = []
    badspp = []
    for i in range(len(pivlines)):
        pivline = pivlines[i]
        if i > 0:
            split = pivline.strip().split(",")
            spp = ">"+str(split[0])
            num = int(split[-1])
            
            if num >= threshGenes:
                goodspp.append(spp)
            else:
                badspp.append(spp)
    
    seqDict = {}

    with open(fasta,"r") as fastafile,open(outfasta,"w") as outfile:
        faslines = fastafile.readlines()
        toDelete = False
        for j in range(len(faslines)):
            print(toDelete)
            line = faslines[j]
            if line[0] == ">":
                spp = line.strip()
                print(spp)
                seqDict[spp] = ""
                if spp in goodspp:
                    toDelete = False
                    outfile.write(line)
                elif spp in badspp:
                    toDelete = True
                    print(spp+" DELETING")
                    del seqDict[spp]
                    outfile.write("~~~~~"+line)
                else:
                    outfile.write("~~~")
                    pass
            else:
                if toDelete == False:
                    outfile.write(line)
                    print("wrote")
                    seqDict[spp] += line
                elif toDelete == True:
                    outfile.write("~~~~~"+line)
                    print("\tdone")
                    pass
                else:
                    outfile.write("~~~")
                    pass
        
    print("\n\nDELETED",str(len(badspp)),"SPECIES AT THRESH OF",threshGenes,"GENES")          
    return(outfasta,seqDict)
    
def seqDict2Deleted(seqDict):
    print(seqDict.keys())
    sppList = list(seqDict.keys())
    seqList = list(seqDict.values()) ## python dictionaries keep these in corresponding order    
    print("SEQ",seqList[0])
    
    with open("texttest.txt","w") as outfile:
        for i in range(len(sppList)):
            outfile.write(sppList[i]+"\t"+seqList[i][0:50]+"\n")
    
    print("#\n",sppList)
    print(len(seqList[0]))
    toPrint = []
    for k in range(len(sppList)):
        toPrint.append(sppList[k]+"\n")
        print(sppList[k][0:10],seqList[k][0:10])
    
    for temp in seqList:
        print("TEMLEN",len(temp),temp[0:10])
        pass
    
    tempPrint = []
    print(sppList)
    for pos in range(len(seqList[0])):
        print("POS",pos)
        removePos = True
        endseq = False
        while removePos == True and endseq == False:
            #endSeq = False
            print("TEMP1",tempPrint)
            tempPrint = []
            for j in range(len(seqList)):
                seq = seqList[j]
                print(j)
                print("#\n",seq)
                print(seq[pos])
                tempPrint.append(seq[pos])
                if seq[pos] not in ["N","n","-","X","?"]:
                    print(seq[pos])
                    removePos = False
                    print("FALSE",seq[pos])
                else:
                    pass
                if j == len(seqList) - 1:
                    endseq = True
                else:
                    pass
            #endseq = False
        print("TEMP",tempPrint)
        if removePos == True:
            print("REMOVE",pos)
            #toRemove.append(pos)
        else:
            for i in range(len(tempPrint)):
                toPrint[i] += str(tempPrint[i])
                
    
    return(toPrint)
    
def getMissingPerSpecies(filename,outname):
    gene = ""
    with open(filename,"r") as infile,open(outname,"w") as outfile:
        lines = infile.read()
        split = lines.split(">")
        outfile.write("SPECIES,NOTMISSING")
        wrote = False
        print(split[0:25][0:25])
        for i in range(len(split)):
            if split[i] != "":
                name,gene = split[i].split("\n",1)
                gene = "".join(gene)
                full = len(gene)
                if wrote == False:
                    outfile.write("_"+str(full)+"\n")
                    wrote = True
                print(gene[0:10])
                print(len(gene))
                print(gene.count("N"))
                gene = gene.replace("N","") 
                gene = gene.replace("n","") 
                gene = gene.replace("-","") 
                gene = gene.replace("X","") 
                gene = gene.replace("?","") 
                print(len(gene),name,full)
                outfile.write(name+","+str(len(gene))+"\n")
            else:
                pass
                
            
def removeDeletedTaxa(filename):
    with open(filename,"r") as infile:
        lines = infile.readlines()
    with open(filename,"w") as outfile:
        for line in lines:
            if line[0] == "~":
                print("skipping")
                pass
            else:
                outfile.write(line)        
    
def runPipeline(pivot,fasta,threshGenes,removeBases):
    outfasta,seqDict = trimFastaPivot(pivot,fasta,threshGenes)
    print(seqDict)  
    
    if removeBases == True:
        toPrint = seqDict2Deleted(seqDict)
        toPrint = "\n".join(toPrint)
        print(toPrint[0])
    
        with open(outfasta,"w") as outfile:
            outfile.write(toPrint)        

    else:
        print("Not Removing Bases")
        removeDeletedTaxa(outfasta)

    getMissingPerSpecies(outfasta,"missingBasePairs_"+str(threshGenes)+".csv")

def main():
    import os
    import glob
    import sys
    #path = "/Users/kprovost/Documents/Publications/Parrots/ParrotPipelineRedo/March2017/supermatrix/"
    #os.chdir(path)    

    print(sys.argv)

    try:
        maxThresh = sys.argv[1]
        try:
            maxThresh = int(maxThresh)
            print("\tSpecies per genes cutoff is: ",maxThresh)
        except:
            print("\tSpecies per genes is not an integer value")
            print("\tDefaulting to 20")
            maxThresh =20
    except:
        print("Species per genes not given, defaulting to 20")
        maxThresh = 20

    try:
        pivot = sys.argv[2]
        print("\tPivot is:",pivot)
    except:
        print("pivot not given.")
        print("Quitting program.")
        quit()
        
    try:
        path = sys.argv[3]
        print("\tPath is: ",path)
    except:
        print("Path not given")
        path = os.getcwd()+"/supermatrix/"
        print("Path is current directory + /supermatrix/")   
 
    os.chdir(path)
 
    for fasta in glob.glob("shortnames_*.fa*"):
        for t in range(maxThresh+1):
            print(t,"#########################",t)
            runPipeline(pivot,fasta,threshGenes=t,removeBases=False) 

if __name__ == "__main__":
    main()