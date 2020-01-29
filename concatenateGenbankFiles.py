# -*- coding: utf-8 -*-
"""
Created on Fri Dec  9 18:27:49 2016

@author: kprovost

This script takes multiple genbank .gb files adn turns them into one file

Usage: give path, creates a folder
python concatenateGenbankFiles.py <optional path>

"""

def concatGB(filename,outfile):
    with open(filename,"r") as infile, open(outfile,"a") as outfile:
        entry = infile.read()
        outfile.write(entry+"\n")
        
def main():
    import glob
    import os
    import sys
    
    #path = sys.argv[1]
    
    try:
        path = sys.argv[1]
        print("\tPath entered: ",searchTerm)
    except:
        print("No path given, using current working directory")
        path = os.getcwd()
    print(path)       
    
    os.chdir(path) 

    outpath = path+"/concatGenbankFiles/"   

    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)
    
    concatName = "ConcatenatedGbFiles.gb"
    print("Concatenated file: ",concatName)
    
    outfile = outpath+concatName
    
    os.chdir(path)
    
    for filename in glob.glob("*.gb"):
        concatGB(filename,outfile)
    
if __name__ == "__main__":
    main()