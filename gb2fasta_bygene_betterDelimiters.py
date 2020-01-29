# -*- coding: utf-8 -*-
"""
Created on Mon Nov 21 14:05:48 2016

@author: kprovost

Takes a genbank .gb file and converts it to a fasta by gene
Sorts the genes based on sequence feature types (CDS, rRNA, etc)
"""

def gb2fasta(gbPath,faPath,gbk_filename,faa_filename,outpath):

    from Bio import SeqIO


    seq_types = []

    input_handle  = open(gbPath+gbk_filename, "r")
    output_handle = open(faPath+faa_filename, "w")
    
    for seq_record in SeqIO.parse(input_handle, "genbank"):
        #print("Dealing with GenBank record %s" % seq_record.id)
        #print(seq_record.features)
        for seq_feature in seq_record.features :
            #print(seq_record.organism)
            if seq_feature.type == "source":
                #print()
                organism = seq_feature.qualifiers["organism"][0]
            elif seq_feature.type in["CDS","gene","D-loop","rRNA","tRNA","misc_feature","gap","mat_peptide","misc_RNA","ncRNA","intron","exon","mRNA"]:
                #print(seq_feature.extract(seq_record.seq))
                #print(seq_record.description)
                #assert len(seq_feature.qualifiers['translation'])==1
                #print(seq_feature.qualifiers)
                try:
                    output_handle.write(">%s from %s///%s///%s\n%s\n" % (seq_feature.qualifiers['gene'][0],seq_record.name,organism,seq_record.description,seq_feature.extract(seq_record.seq)))
                except:
                    try:
                        output_handle.write(">%s from %s///%s///%s\n%s\n" % (seq_feature.qualifiers['locus_tag'][0],seq_record.name,organism,seq_record.description,seq_feature.extract(seq_record.seq)))
                    except:
                        try:
                            output_handle.write(">%s from %s///%s///%s\n%s\n" % (seq_feature.qualifiers['product'][0],seq_record.name,organism,seq_record.description,seq_feature.extract(seq_record.seq)))
                        except:
                            try:
                                output_handle.write(">%s from %s///%s///%s\n%s\n" % (seq_feature.type,seq_record.name,organism,seq_record.description,seq_feature.extract(seq_record.seq)))
                            except:
                                print("ERROR",seq_feature.type,seq_record.id)
            elif seq_feature.type in["STS","repeat_region","primer_bind","5'UTR","3'UTR","mobile_element","ncRNA","regulatory","sig_peptide"]:
                try:
                    output_handle.write(">%s from %s///%s///%s\n%s\n" % (seq_feature.qualifiers['gene'][0],seq_record.name,organism,seq_record.description,seq_feature.extract(seq_record.seq)))
                except:
                    try:
                        output_handle.write(">%s from %s///%s///%s\n%s\n" % (seq_feature.qualifiers['standard_name'][0],seq_record.name,organism,seq_record.description,seq_feature.extract(seq_record.seq)))
                    except:
                        try:
                            output_handle.write(">%s from %s///%s///%s\n%s\n" % (seq_feature.qualifiers['satellite'][0],seq_record.name,organism,seq_record.description,seq_feature.extract(seq_record.seq)))
                        except:
                            try:
                                output_handle.write(">%s from %s///%s///%s\n%s\n" % (seq_feature.qualifiers['regulatory_class'][0],seq_record.name,organism,seq_record.description,seq_feature.extract(seq_record.seq)))
                            except:
                                try:
                                    output_handle.write(">%s from %s///%s///%s\n%s\n" % (seq_feature.qualifiers['mobile_element_type'][0],seq_record.name,organism,seq_record.description,seq_feature.extract(seq_record.seq)))
                                except:
                                    try: ## MUST BE LAST
                                        output_handle.write(">%s from %s///%s///%s\n%s\n" % (seq_feature.type,seq_record.name,organism,seq_record.description,seq_feature.extract(seq_record.seq)))
                                    except: ## MUST BE LAST
                                        print("ERROR",seq_feature.type,seq_record.id)
            else:
                seq_types.append(seq_feature.type)
                
    
    
    output_handle.close()
    input_handle.close()
    print("###DONE")
    
    print(set(seq_types))
    

def main():
    import glob
    import sys
    import os
    
    try:
        gbPath = sys.argv[1]
        print("\tGenbank path: ",gbPath)
    except:
        print("No genbank path given, using current working directory")
        gbPath = os.getcwd()+"/concatGenbankFiles/"
        print(gbPath)
    try:
        faPath = sys.argv[2]
        print("\Fasta path: ",faPath)
    except:
        print("No fasta path given, using current working directory")
        faPath = os.getcwd()+"/concatGenbankFiles/"
        print(faPath)

    print("Current directory")
    print(os.getcwd())

    #gbPath = "/Users/kprovost/Documents/Classes/Systematics/"
    #faPath = "/Users/kprovost/Documents/Classes/Systematics/"   
    
    #gbk_filename = "parrotmtCytbConcat.gb"
    #faa_filename = "TEST_parrotmtCytbConcat.fasta"
    
    outpath = gbPath+"genes/"
    print("Out directory:")
    print(outpath)
    
    for filename in glob.glob(gbPath+"*.gb"):
        print(gbPath)
        print(faPath)
        gbk_filename = filename.split("/")[-1]
        faa_filename = filename.split("/")[-1].split(".")[0]+".fasta"
        print("\n",gbk_filename)        
        
        gb2fasta(gbPath,faPath,gbk_filename,faa_filename,outpath)
        

if __name__ == "__main__":
    main()