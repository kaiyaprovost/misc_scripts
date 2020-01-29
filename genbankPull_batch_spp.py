## less than 100 genbanks at at time on their preferred server

def genbankIterate(record,path,nameTerm):
    from Bio import Entrez
    from Bio import SeqIO
    import os
    #import glob
    from datetime import datetime
    import sys
    import time
    parrotTest = []  
    count = 0
    for i in record["IdList"]:
        count += 1
        if count % 10 == 0:
            print("\t",count,datetime.now())
        handle = Entrez.efetch(db="nucleotide",id=i,rettype="gb",retmode="text")
        time.sleep(1)
        for record in SeqIO.parse(handle,"genbank"):
            with open(path+"/"+nameTerm+".gb","a") as parrotTestFile:
                SeqIO.write(record,parrotTestFile,"gb")

def genbankMultiSearch(searchTerm,nameTerm,spp,path):
    from Bio import Entrez
    from Bio import SeqIO
    import os
    from datetime import datetime
    import sys
    import time
    Entrez.email = "klp2143@columbia.edu"
    handle = Entrez.einfo()
    
    name = nameTerm+"_"+spp
    
    han = Entrez.esearch(db="nucleotide",retmax=500000,term=searchTerm) # change to 500000 for actual searches
    rec = Entrez.read(han)
    numRecords = len(rec["IdList"])
    print(rec["Count"],datetime.now())
    time.sleep(1)
    
    batchSize = 500000
    for start in range(0,numRecords,batchSize):
        print("SPECIES:",spp,"BATCH: ",start,datetime.now())
        handle = Entrez.esearch(db="nucleotide",retmax=batchSize,term=searchTerm,start=start)
        record = Entrez.read(handle)
        genbankIterate(record,path,name+"_"+str(start))
        handle.close()
        time.sleep(1)
    han.close()  

def main():
    from Bio import Entrez
    from Bio import SeqIO
    import os
    #import glob
    from datetime import datetime
    import sys
    import time
    
    ## USAGE: python genbankPull.py '''searchTerm''' nameTerm
    
    #handle = Entrez.esearch(db="nucleotide",retmax=500000,term="Psittaciformes[Orgn] OR psittaciformes[All Fields]")
    
    path = os.getcwd()
    print(path)
        
    ##### SEARCH TERMS #####
        # biomol_genomic[PROP] ## for genomic dna
        # AND mitochondrion[filter] ## for mtDNA???
        # "Psittaciformes"[Orgn] AND mitochondrion[filter] AND "genome"[All Fields] ## will give you all mtDNA genomes
        # "Psittaciformes"[Orgn] AND mitochondrion[filter] NOT "genome"[All Fields] ## will give you rest of mtDNA, not whole genomes
    
    try:
        csvFile = sys.argv[1]
        print("\tUsing Csvfile: ",csvFile)
    except:
        csvFile="/Users/kprovost/Documents/Publications/Parrots/ParrotPipelineRedo/parrotGenera.csv"
        print("CsvFile not given, defaulting to:",csvFile)
        #quit()
    try:
        nameTerm = sys.argv[2]
        print("\tFile name ",nameTerm)
    except:
        print("Name not given, quitting program")
        quit()
    
    firstSearch = '''''' ## removed the wgs statement because screwing up
    #firstSearch = ''' NOT "whole genome shotgun"[All Fields]'''    
    print("START")
    with open(csvFile,"r") as csv:
        lines = csv.readlines()
    for line in lines:
        ## giving the too many requests error 
        spp = line.strip()
        print("Species:",spp)
        searchTerm = '''"'''+spp+'''"[Orgn] AND '''+firstSearch
        genbankMultiSearch(searchTerm,nameTerm,spp,path)
    
#    searchTerm = input("String to search:\t")
#    print("\tSearching for ",searchTerm)
#    nameTerm = input("Name of file:\t") ##mitoIncomplete
#    print("\tFile name ",nameTerm)

if __name__ == '__main__':
    main()


