# -*- coding: utf-8 -*-
"""
Program to remove multiple genes from a FASTA file

Requires that the first term of the FASTA file is the gene identity



Edited on 10 dec 2016 - NOT TESTED

@author: kprovost
"""

def main():
    import sys
    import glob
    import os
    
    cwd = os.getcwd()
    
    try:
        path = sys.argv[1]
        print("\tPath is: ",path)
    except:
        print("Path not given, using current working directory + concatGenbankFiles")
        path = os.getcwd()+"/concatGenbankFiles/"
        
        
    outpath = path+"/genes/"   

    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)
    
    #path = "/Users/kprovost/Documents/Classes/Systematics/ParrotPipelineRedo/" 
        
    os.chdir(path)
    
    for filename in glob.glob("*.fa*"):  
        
        print("FILE IS ",filename)
        
        currentFile = "temp"        
        
        with open(filename,"r") as infile:
            lines = infile.readlines()
            for line in lines:
                if line[0] == ">":
                    gene,descrip = line.split(" from ",1)
                    gene = gene[1:].strip().replace(" ","").replace("/","").upper().replace("-","").replace("\t","")
                    gene = gene.replace(",","").replace(":","").replace("'","").replace(";","").replace("_","")
                    descrip = descrip.strip().upper()
                    #print("\tGENE IS ",gene)
                    #currentFile = gene+"_"+filename
                    currentFile = filename[:-7]+gene+".fa"
                    with open(outpath+currentFile,"a") as outfile:
                        outfile.write(line)
                else:
                    with open(outpath+currentFile,"a") as outfile:
                        outfile.write(line)
                    
        

if __name__ == "__main__":
    main()