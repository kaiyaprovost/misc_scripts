# -*- coding: utf-8 -*-
"""
Created on Wed Jan 11 21:27:32 2017

@author: kprovost
"""

class Academic:
    def __init__(self,name):
        self.name = name
        self.phd = []
        self.bachelor = []
        self.postdoc = []
        self.master = []
        self.other = []
        self.student = []

    def changeName(self,name):
        self.name = name
        
    def addPhd(self,phd):
        #self.phd.append(phd)
        phdObj = Academic(phd)
        self.phd.append(phdObj)
        
    def addBachelor(self,bachelor):
        #self.bachelor.append(bachelor)
        bachObj = Academic(bachelor)
        self.bachelor.append(bachObj)
        
    def addPostdoc(self,postdoc):
        #self.postdoc.append(postdoc)
        postObj = Academic(postdoc)
        self.postdoc.append(postObj)
        
    def addMaster(self,master):
        #self.master.append(master)
        mastObj = Academic(master)
        self.master.append(mastObj)
        
    def addOther(self,other):
        #self.other.append(other)
        othObj = Academic(other)
        self.other.append(othObj)        
                
    def addStudent(self,student):
        #self.student.append(student)
        studObj = Academic(student)
        self.student.append(studObj)
    
    def getLineage(self):
        #print("dev")
        toprint = ""
        toprint += self.name
        toprint += "\nAdvisors:\n\t"

        advisors = self.bachelor + self.master + self.phd + self.postdoc + self.other        
        if len(advisors) == 0:
            toprint += "None"
        else:
            for a in range(len(advisors)):
                adv = advisors[a]
                toprint += adv.name
                if a != len(advisors)-1:
                    toprint += ","
                    
        ## STUDENTS            
        toprint += "\nStudents:\n\t"
        for j in range(len(self.student)):
            student = self.student[j]
            toprint += student.name
            if j != len(self.student)-1:
                toprint += ","
        print(toprint)          
        
    def __str__(self):
        return(self.name)
        
        
brian = Academic("Brian Tilston Smith")
brian.changeName("Brian Smith")
brian.addPhd("John Klicka")
brian.addPostdoc("Robb Brumfield")
brian.addStudent("Kaiya Provost")
brian.addStudent("Jordan Koch")
brian.addStudent("Lucas Moreira")
#print(brian)
#x = brian.postdoc
#print(x[0])
brian.getLineage()