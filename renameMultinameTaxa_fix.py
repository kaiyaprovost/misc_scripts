# -*- coding: utf-8 -*-
"""
Created on Fri Feb 10 16:51:34 2017

@author: kprovost
"""

def csv2renameDict(csv):
    csvDict = {}
    with open(csv,"r") as csvfile:
        lines = csvfile.readlines()
        for line in lines:
            badname,goodname = line.strip().split(",")
            csvDict[badname] = goodname
    return csvDict

def changeFastaNames(filename,csvDict):
    changedNames = []
    with open(filename,"r") as infile:
        lines = infile.readlines()
    with open("MisnameTaxaFix_"+filename,"w") as outfile:
        for i in range(len(lines)):
            line = lines[i]
            if line[0] == ">":
                split = line.split("///")
                name = split[1].strip()
                temp = "_".join(name.split()[0:2])
                print(temp)
                #temp = name.replace(" ","_")
                #name = line[1:].strip()
                print(name)
                get = csvDict.get(temp,None)
                #print(get)
                if get != None:
                    line = line.replace(name,get)
                    print(name,get)
                    print(line)
                    #print("changed")
                    changedNames.append(get)
                else:
                    #print("not in dict")
                    pass            
            else: 
                #print("gene")
                pass
            outfile.write(line)
    return(changedNames)


def main():
    import os
    import glob
    import sys
    
    cwd = os.getcwd()

    try:
        quitYN = False
        renameYN = sys.argv[1]
        if renameYN.strip() == "0":
            print("Don't rename files")
            quitYN = True
        elif renameYN.strip() == "1":
            print("Rename files")
        else:
            print("Unaccepted input")
    except: 
        print("No input detected")   
    #print(quitYN)
    if quitYN == True:
        quit()
    try:
        csv = sys.argv[2]
        print("\CSV is: ",csv)
    except:
        answered = False
        while answered == False:
            cont = input("No CSV file given. Do you wish to continue without name changes? Y/N: ")
            if cont.strip() in ["Y","y","YES","yes","Yes"]:
                print("Continuing without renaming")
                answered = True
                quit()
            elif cont.strip() in ["N","n","NO","no","No"]:
                print("Running name changing")
                answered = True
            else:
                print("Unrecognized input!")
    try:
        path = sys.argv[3]
        print("\tPath is: ",path)
    except:
        print("Path not given, using current working directory + 2_deduplicated")
        path = os.getcwd()+"/2_deduplicated/"            
        
        path = os.getcwd()+"/2_deduplicated/"

    outpath = cwd+"/2.5_multiTaxaNamefix/"
    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)
    
    
    #path = "/Users/kprovost/Documents/Publications/Parrots/"    
    os.chdir(path)
    
    #csv = "parrotNamesNeedingChanging.txt"
    
    csvDict = csv2renameDict(csv)
    #print(csvDict) 

    #pathMT = "/Users/kprovost/Documents/Publications/Parrots/ParrotPipelineRedo/sequence data/mito/2_deduplicated/"
    #pathNUC = "/Users/kprovost/Documents/Publications/Parrots/ParrotPipelineRedo/sequence data/nuclear/2_deduplicated/"

    os.chdir(path)
    for filename in glob.glob("*.fa*"):       
        changedNames = changeFastaNames(filename,csvDict)

    #os.chdir(pathNUC)
    #for filename in glob.glob("*.fa*"):
        #changedNames = changeFastaNames(filename,csvDict)


if __name__ == "__main__":
    main()