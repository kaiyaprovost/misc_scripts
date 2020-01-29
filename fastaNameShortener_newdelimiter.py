# -*- coding: utf-8 -*-
"""
Created on Tue Nov 29 18:05:22 2016

@author: kprovost

Updated Fri Dec 9th: added lines to remove PREDICTED and UNVERIFIED

"""

def nameShorten(filename,outpath):
    ## format going in: gene from accession///organism///descript
    with open(filename,"r") as infile,open(outpath+"SHORT_"+filename,"w") as outfile:
        lines = infile.readlines()
        for line in lines:
            #print(line)
            if line.strip() != "":
                line = line.replace(" ","_")
                line = line.replace(",","")
                line = line.replace("PREDICTED:_","")
                line = line.replace("UNVERIFIED:_","")
                if line[0] == ">":
                    title = line[1:]
                    try:
                        gene,information = title.split("_from_",1)
                    except:
                        try:
                            information = title
                            genetemp = filename.split("_")[-1]
                            gene = filename.slit(".")[0]
                        except:
                            print("ERROR IN SPLIT TITLE")
                            print(title)
                    #print("\t",information)
                    try:
                        accession,organism,description = information.split("///")
                    except:
                        try:
                            organism,accession = information.strip().split("///")
                        except:
                            print("ERROR IN SPLIT INFORMATION")
                            print(information)
                    outfile.write(">"+accession+"///"+organism+"\n")
                else:
                    outfile.write(line)
            else:
                pass

def main():
    import os
    import glob
    import sys
    
    cwd = os.getcwd()
    print(cwd)

    try:
        renamed = ""
        renameYN = sys.argv[1]
        if renameYN.strip() == "0":
            print("Didn't rename files")
            renamed = False
        elif renameYN.strip() == "1":
            print("Renamed files")
            renamed = True
        else:
            print("Unaccepted input")
            renamed = ""
    except: 
        print("No input detected")
        renamed = ""   
    try:
        path = sys.argv[2]
        print("\tPath is: ",path)
    except:
        print("Path not given")
        path = os.getcwd()+"/2.5_multiTaxaNamefix/"
        print("Path is current directory + 2.5_multiTaxaNamefix")           

    if len(glob.glob(path+"*.fa*")) == 0:
        print("No renamed files exist")
        print("Changing path to current directory + 2_deduplicated")
        path = cwd+"/2_deduplicated/"

    outpath = cwd+"/3_short names/"
    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)   
        
    os.chdir(path)
    for filename in glob.glob("*.fa*"):
        print(filename)
        nameShorten(filename,outpath)
        print("\tDONE") 

if __name__ == "__main__":
    main()