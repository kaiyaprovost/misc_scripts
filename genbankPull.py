## less than 100 genbanks at at time on their preferred server

def main():
    from Bio import Entrez
    from Bio import SeqIO
    import os
    #import glob
    from datetime import datetime
    import sys
    
    ## USAGE: python genbankPull.py '''searchTerm''' nameTerm
        
    
    Entrez.email = "klp2143@columbia.edu"
    
    handle = Entrez.einfo()
    
    
    #handle = Entrez.esearch(db="nucleotide",retmax=500000,term="Psittaciformes[Orgn] OR psittaciformes[All Fields]")
    
    path = os.getcwd()
    print(path)
        
    ##### SEARCH TERMS #####
        # biomol_genomic[PROP] ## for genomic dna
        # AND mitochondrion[filter] ## for mtDNA???
        # "Psittaciformes"[Orgn] AND mitochondrion[filter] AND "genome"[All Fields] ## will give you all mtDNA genomes
        # "Psittaciformes"[Orgn] AND mitochondrion[filter] NOT "genome"[All Fields] ## will give you rest of mtDNA, not whole genomes

    
    try:
        searchTerm = sys.argv[1]
        print("\tSearching for ",searchTerm)
    except:
        print("Search term not given, quitting program")
        quit()
    try:
        nameTerm = sys.argv[2]
        print("\tFile name ",nameTerm)
    except:
        print("Name not given, quitting program")
        quit()
    
#    searchTerm = input("String to search:\t")
#    print("\tSearching for ",searchTerm)
#    nameTerm = input("Name of file:\t") ##mitoIncomplete
#    print("\tFile name ",nameTerm)
    
    handle = Entrez.esearch(db="nucleotide",retmax=5000000,term=searchTerm) # change to 500000 for actual searches
    record = Entrez.read(handle)
    print(record["Count"],datetime.now())
    
    parrotTest = []  
    count = 0
    
    for i in record["IdList"]:
        #print("\n\n",i)
        count += 1
        if count % 10 == 0:
            print("\t",count,datetime.now())
        handle = Entrez.efetch(db="nucleotide",id=i,rettype="gb",retmode="text")
        #print(handle)
        for record in SeqIO.parse(handle,"genbank"):
            #print(record)
            #parrotTest.append(record)
            #test = open(path+nameTerm+".gb","a")
            #SeqIO.write(parrotTest,test,"gb")
            #test.close()
            with open(path+"/"+nameTerm+".gb","a") as parrotTestFile:
                SeqIO.write(record,parrotTestFile,"gb")
    print("fasta #################################")
#     with open(path+"/"+nameTerm+".fasta","w") as parrotTestFile:
#         SeqIO.write(parrotTest,parrotTestFile,"fasta")
#     print("genbank #################################")
#     test = open(path+"/"+nameTerm+".gb","w")
#     SeqIO.write(parrotTest,test,"gb")
#     test.close()
    
    handle.close()
    
    #print(record)

    print("@@@@@@@@@@@@@@@@@@@@ FINISHED @@@@@@@@@@@@@@@@@@@@")

if __name__ == '__main__':
    main()


