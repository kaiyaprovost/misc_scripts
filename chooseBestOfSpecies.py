# -*- coding: utf-8 -*-
"""
Created on Tue Nov 29 19:39:45 seqLenNeeded16

@author: kprovost

Compares aligned FASTA file for the same species 
Select one individual per species with the largest amount of sequence
(not gaps and not Ns)
If tie, first one in file is chosen
"""

def removeUnwantedWords(string):
    punct = [",",";",":"]
    for i in punct:
        string = string.replace(i,"")
    split = string.split("_")
    unwanted = ["complete","mitochondrion",",","partial","voucher","LGEMA","cytochrome",
                "oxidase","isolate"]
    new = [word for word in split if word not in unwanted]
    name = "_".join(new)
    return(name)
    
def binomialNameOnly(string):
    split = string.split("_")
    if len(split) <= 2:
        new = "_".join(split)
    else:
        new = "_".join(split[0:2])
    return(new)
    
def fasta2dict(filename):
    with open(filename,"r") as infile:
        read = infile.read()
        fasta = read.split(">",1)[1].split("\n>")
        sppDict = {}
        for line in fasta:
            #print(line[0:100])
            identifier,sequence = line.split("\n",1)
            accession,name = identifier.split("///",1)
            #print(accession,name,sequence[0:25])
            #new = removeUnwantedWords(name)
            new = binomialNameOnly(name)
            tup = (sequence,accession)
            if sppDict.get(new,None) == None:
                sppDict[new] = []
                sppDict[new].append(tup)
            else:
                #print("\n\nADDING")
                #print(sequence,accession)
                sppDict[new].append(tup)
                #print(sppDict.get(new))
    return(sppDict)       

def getBestRead(sppDict,seqLenNeeded):
    bestDict = {}
    for key,value in sppDict.items():
        #print("\n",key)
        # key is spp
        # value is seq,accession
        
        if bestDict.get(key,None) == None:
            bestDict[key] = [0,(0,0)]
        currentBest = bestDict[key][0]
        bestPair = bestDict[key][1]
        
        
        for entry in value:
            #print(entry)
            seq = str(entry[0]).replace("\n","")
            accession = entry[1]
            #print("\t",seq,"\n\t",accession)
            
            length = len(seq)
            #print(length)
            gaps = seq.count("-")
            missing = seq.count("N")+seq.count("n")+seq.count("?")+seq.count("X")
            
            good = length - gaps - missing
            if good > currentBest:
                #print("NEW BEST",key)
                currentBest = good
                bestPair = (seq,accession)
                bestDict[key] = [good,(seq,accession)]
                #print(bestDict[key])
        if bestDict[key][0] < seqLenNeeded:
            print("\n\t",key," has length of ",bestDict[key][0],"\n")
            del bestDict[key]
    return(bestDict)

def dict2fasta(bestDict,filename,seqLenNeeded):
    with open(filename,"w") as outfile:
        for key,value in bestDict.items():
            length = value[0]
            
            if length >= seqLenNeeded:
                tup = value[1]
                seq = tup[0]
                accession = tup[1]
            
                toPrint = ">"+str(key)+"///"+str(accession)+"\n"+str(seq)+"\n"
                #print(toPrint)
                outfile.write(toPrint)
            else:
                print(key+" TOO SHORT")
        
    
def main():
    import os
    import glob
    import sys
    
    cwd = os.getcwd()
    
    try:
        seqLenNeeded = sys.argv[1]
        #print("#")
        #print(seqLenNeeded)
        #print("$")
        #print(type(seqLenNeeded))
        try:
            seqLenNeeded = int(seqLenNeeded)
            print("\tSequence length needed is: ",seqLenNeeded)
        except:
            print("\tSequence length is not an integer value")
            print("\tDefaunting to 20")
            seqLenNeeded = 20
    except:
        print("Sequence length not given, defaulting to 20")
        seqLenNeeded = 20 
        
    try:
        path = sys.argv[2]
        print("\tPath is: ",path)
    except:
        print("Path not given")
        path = os.getcwd()+"/3_short names/"
        print("Path is current directory + 3_short names")           
    
    outpath = cwd+"/4_single species/"
    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)       

    os.chdir(path)    
    for filename in glob.glob("*.fa*"):
        print(filename)
        sppDict = fasta2dict(filename)
        #print(testDict)
        #print(testDict.keys())
        bestDict = getBestRead(sppDict,seqLenNeeded)
        #print("\t",bestDict.get("Ara_ararauna","none"))
        outfileName = outpath+"BEST"+str(seqLenNeeded)+"_"+str(len(bestDict))+"_"+filename
        dict2fasta(bestDict,outfileName,seqLenNeeded)

if __name__ == "__main__":
    main()