# -*- coding: utf-8 -*-
"""
Created on Thu Mar 31 00:21:52 2016

@edited by K Provost
"""

#Aligning sequences
#Muscle software installed required: http://www.drive5.com/muscle/downloads.htm    
def align(filename,outpath,cwd,muscle_exe):
    import os
    from Bio.Align.Applications import MuscleCommandline
    from Bio import AlignIO
    muscle_exe = "/Users/kprovost/Documents/muscle3.8.31_i86darwin64"
    outname = "ALIGNED_"+filename
    print("ALIGNING: "+filename)
    with open(filename,"r") as infile:
        read = infile.read()
        count = read.count(">")
        if count <= 1: 
            with open(outpath+outname,"w") as outfile:
                outfile.write(read)
                print("ONLY ONE SEQ, DONE")
        else:
            try:
                muscle_cline = MuscleCommandline(muscle_exe, input=filename, out=outname)
                stdout, stderr = muscle_cline()
                AlignIO.read(outname, "fasta")
                print("ALIGNED")    
            except:
                print("??? ERROR")
                print(filename)
    
def main():
    from Bio.Align.Applications import MuscleCommandline
    from Bio import AlignIO
    import os
    import sys
    import glob
    import shutil
   
    cwd = os.getcwd()
   

   
    try:
        muscle_exe = sys.argv[1]
        print("\tMuscle path exists")
    except:
        print("Muscle defaulting to:")
        print("/Users/kprovost/Documents/muscle3.8.31_i86darwin64")
        #print("Muscle not given, quitting")
        muscle_exe = "/Users/kprovost/Documents/muscle3.8.31_i86darwin64"
        #quit()

    try:
        path = sys.argv[2]
        print("\tPath is: ",path)
    except:
        print("Path not given")
        path = os.getcwd()+"/7_readytoalign/"
        print("Path is current directory + 7_readytoalign") 

    treepath = cwd+"/9_badalignments/"
    if not os.path.exists(treepath):
        print("creating folder: ",treepath)
        os.makedirs(treepath)   
        
    outpath = cwd+"/8_goodalignments/"
    if not os.path.exists(outpath):
        print("creating folder: ",outpath)
        os.makedirs(outpath)  

    os.chdir(path)
    for filename in glob.glob("*.fa*"):
        align(filename,outpath,cwd,muscle_exe)
    print("\n\nDONE")
   
   
# from Bio import SeqIO
# filename = "NC_005816.gb"
# locus_to_gene = dict()
# for record in SeqIO.parse(filename, "genbank"):
#     for f in record.features:
#         if f.type == "CDS":
#             if "gene" in f.qualifiers:
#                 if "locus_tag" in f.qualifiers:
#                     genes = f.qualifiers["gene"]
#                     locus_tags = f.qualifiers["locus_tag"]
#                     assert len(genes) == 1, genes
#                     assert len(locus_tags) == 1, locus_tags
#                     locus_to_gene[locus_tags[0]] = genes[0]
# print("Mapped %i locus tags to genes" % len(locus_to_gene))
                
    
if __name__ == "__main__":
    main()
    #import os
    #os.chdir("/Users/kprovost/Documents/Publications/Parrots/ParrotPipelineRedo/OUTGROUPS/")
    #muscle_exe = "/Users/kprovost/Documents/Publications/Parrots/ParrotPipelineRedo/SCRIPTS/muscle3.8.31_i86darwin64"
    #align("Mascarinus_OLDANDNEW.fasta","ALIGNED_Mascarinus_OLDANDNEW.fasta",os.getcwd(),muscle_exe)