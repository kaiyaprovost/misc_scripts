file = "/Users/kprovost/Documents/Dissertation/CHAPTER1_REVIEW/for_review_figure.csv"
x = read.csv(file)
plot(x$START,1:nrow(x),
     xlim=c(0,25))
points(x$END,1:nrow(x),
       xlim=c(0,25))

times = c("Mio","Mio/Plio","Plio","Plio/Pleis","Pleis","?")
notsplit_notmono = c(-0,-0,-0,-2,-4,-1)
notsplit_mono = c(-0,-0,-1,-0,-1,-2)
split_notmono = c(1,0,1,0,1,2)
split_mono = c(0,3,6,1,12,12)

y = data.frame(notsplit_notmono,notsplit_mono,
               split_notmono,split_mono)
rownames(y) = times
y = as.matrix(y)
png("Chapter_1_Mono_Split.png")
par(mar=c(3,5,0,1),bg=NA,col.axis = "white",
    fg = "white",
    col.lab = "white",
    col.main = "white")
barplot(t(y[,1:2]),horiz=T,las=1,col=c("darkred","red","cyan","blue"),
        xlim=c(-15,15),xaxt="n")
barplot(t(y[,3:4]),horiz=T,las=1,col=c("cyan","blue","darkred","red"),
        xlim=c(-15,15),add=T,xaxt="n")
axis(1,at=c(-15,-10,-5,0,5,10,15),labels=c(15,10,5,0,5,10,15))
abline(v=0)
legend("bottomright",legend=c("Not Mono","Mono"),
       col=c("cyan","blue"),bty="n",title="Split",
       fill=c("cyan","blue"))
legend("bottomleft",legend=c("Not Mono","Mono"),
       col=c("darkred","red"),bty="n",title="Not Split",
       fill=c("darkred","red"))
dev.off()



y = data.frame(split_notmono,split_mono)
rownames(y) = times
y = as.matrix(y)
png("Chapter_1_Mono_SplitOnly.png",width=700,height=450)
par(mar=c(3,5,0,1),bg=NA,col.axis = "white",
    fg = "white",
    col.lab = "white",
    col.main = "white")
barplot(t(y[,1:2]),horiz=T,las=1,col=c("red","cyan"),
        xlim=c(-0,15))
legend("bottomright",legend=c("Not Mono","Mono"),
       col=c("red","cyan"),bty="n",title="Split",
       fill=c("red","cyan"))
dev.off()


times = c("Not Split","Mio","Mio/Plio","Plio","Plio/Pleis","Pleis","?")
gf_no = c(7,2,1,2,1,6,18)
gf_yesyes = c(1,1,1,2,1,5,2)
gf_yesunk = c(4,0,1,4,0,5,0)
gf_yesno = c(2,0,0,0,0,2,1)
mono_yes = c(-0,-2,-2,-7,-1,-14,-14)
mono_unk = c(-2,-1,-1,-1,-1,-2,-5)
mono_no = c(-12,-0,-0,-0,-0,-2,-2)


y = data.frame(gf_no,gf_yesyes,
               gf_yesunk,gf_yesno,
               mono_yes,mono_unk,mono_no)
rownames(y) = times
y = as.matrix(y)
png("Chapter_1_GF_dark.png")
par(mar=c(3,5,0,1),bg=NA#,
    #col.axis = "white",
    #fg = "white",
    #col.lab = "white",
    #col.main = "white"
)
barplot(t(y[,1]),horiz=T,las=1,col=c("darkblue","red","orange","yellow"),
        xlim=c(-15,10))
barplot(t(y[,2:4]),horiz=T,las=1,col=c("red","orange","yellow"),
        xlim=c(-15,10),add=T)
abline(v=0)
legend("bottomleft",legend=c("Not Estimated","Present",
                             "Unclear","Absent"),
       col=c("darkblue","red","orange","yellow"),bty="n",title="Gene Flow",
       fill=c("darkblue","red","orange","yellow"))
dev.off()


png("Chapter_1_GF_mono_dark.png")
par(mar=c(3,5.5,0,1),bg=NA#,
    #col.axis = "white",
    #fg = "white",
    #col.lab = "white",
    #col.main = "white"
)
barplot(t(y[,1:4]),horiz=T,las=1,col=c("darkblue","red","orange","yellow"),
        xlim=c(-20,20),xaxt="n")
barplot(t(y[,5:7]),horiz=T,las=1,col=c("darkgreen","green","lightgreen"),
        xlim=c(-20,20),add=T,xaxt="n")
abline(v=0)
legend("right",legend=c("Not Est.","Present",
                        "Unclear","Absent"),
       col=c("darkblue","red","orange","yellow"),bty="n",title="Gene Flow",
       fill=c("darkblue","red","orange","yellow"))
legend("left",legend=c("Yes","Unclear","No"),
       col=c("darkgreen","green","lightgreen"),bty="n",title="Monophyly",
       fill=c("darkgreen","green","lightgreen"))
axis(1,at=c(-20,-15,-10,-5,0,5,10,15,20),labels=c(20,15,10,5,0,5,10,15,20))

dev.off()

## make fig overlaps
df = read.table("/Users/kprovost/Dropbox (AMNH)/Dissertation/CHAPTER1_REVIEW/cfb_ch1_width.txt",
                sep="\t",header=T)
vals=seq(-119,-98,0.01)
counts=sapply(vals,FUN=function(x){
  sum((df$W.Location.Barrier <= x) & (df$E.Location.Barrier >= x))
})
plot(counts)
propcounts = counts/nrow(df)

png("proportion_within_range_cfb.png")
plot(vals,propcounts,ylim=c(-0.2,0.7),type="l")
#points(df$W.Location.Barrier,seq(1,0.7,length.out=39),cex=0.5,col=viridis(39))
#points(df$E.Location.Barrier,seq(1,0.7,length.out=39),cex=0.5,col=viridis(39))
#segments(df$W.Location.Barrier,seq(1,0.7,length.out=39),
#         df$E.Location.Barrier,seq(1,0.7,length.out=39),
#         col=viridis(39))
points(df$W.Location.Barrier,seq(0.3,-0.2,length.out=39),cex=0.5,col=viridis(39))
points(df$E.Location.Barrier,seq(0.3,-0.2,length.out=39),cex=0.5,col=viridis(39))
segments(df$W.Location.Barrier,seq(0.3,-0.2,length.out=39),
         df$E.Location.Barrier,seq(0.3,-0.2,length.out=39),
         col=viridis(39))
dev.off()

ticks=which(vals %% 1 == 0)
labelvals = vals[ticks]

barcols=viridis(max(counts)+1)[counts+1]
png("proportion_within_range_cfb_nolines.png")
bp=barplot(propcounts,col=barcols,border=barcols,xlab="Longitude",
           ylab="Proportion of Species Overlapping")
axis(1,at=bp[ticks],labels=labelvals,las=2)
dev.off()


## dispersal types
disp = read.table("/Users/kprovost/Dropbox (AMNH)/Dissertation/CHAPTER1_REVIEW/cfb_ch1_dispersaltype.txt",
                  sep="\t",
                  header=T)
loc_str = table(disp[,c(1,2)])
loc_div = table(disp[,c(1,4)])

loc_div_stronly = table(disp[disp$Structure!="No",c(1,4)])
prop.table(loc_str,margin=1)

png("locomotion_type_structure.png")
barplot(t(loc_str),col=c("darkblue","blue","cyan"),
        ylab="Number Species",
        xlab="Locomotion",ylim=c(0,30))
legend("topleft",legend=c("Yes","No","Unclear"),
       fill=c("cyan","blue","darkblue"),bty="n",
       title="Structure Present")
box()
dev.off()

png("locomotion_type_divergence_all.png")
barplot(t(loc_div[,c(1,2,3,5,6,4)]),col=c("darkblue","red","orange","yellow","magenta","purple"),
        ylab="Number Species",
        xlab="Locomotion",ylim=c(0,30))
legend("topleft",legend=c("Unclear","Miocene","Mio-Pliocene",
                          "Pliocene","Plio-Pleistocene","Pleistocene"),
       fill=c("darkblue","red","orange","yellow","magenta","purple"),bty="n",
       title="Divergence")
box()
dev.off()

png("locomotion_type_divergence_onlystructured.png")
barplot(t(loc_div_stronly[,c(1,2,3,5,6,4)]),col=c("darkblue","red","orange","yellow","magenta","purple"),
        ylab="Number Species",
        xlab="Locomotion",ylim=c(0,30))
legend("topleft",legend=c("Unclear","Miocene","Mio-Pliocene",
                          "Pliocene","Plio-Pleistocene","Pleistocene"),
       fill=c("darkblue","red","orange","yellow","magenta","purple"),bty="n",
       title="Divergence (Str Only)")
box()
dev.off()

png("locomotion_type_widthcfb.png")
boxplot(disp$Width~disp$Locomotion.Dispersal,
        varwidth=T,ylab="Longitudinal Width of CFB",
        xlab="Locomotion Type")
dev.off()



png("locomotion_type_structure_plus_divergence_2plot.png",width=600,height=300)
par(mfrow=c(1,2),mar=c(5,4,0.5,0))
barplot(t(loc_str),col=c("darkblue","blue","cyan"),
        ylab="Number Species",
        xlab="",ylim=c(0,30),las=2)
legend("topleft",legend=c("Yes","No","Unclear"),
       fill=c("cyan","blue","darkblue"),bty="n",
       title="Structure Present")
box()
barplot(t(loc_div_stronly[,c(1,2,3,5,6,4)]),col=c("darkred","red","orange","yellow","magenta","purple"),
        ylab="Number Species",
        xlab="",ylim=c(0,30),las=2)
legend("topleft",legend=rev(c("Unclear","Miocene","Mio-Pliocene",
                          "Pliocene","Plio-Pleistocene","Pleistocene")),
       fill=rev(c("darkred","red","orange","yellow","magenta","purple")),bty="n",
       title="Divergence")
box()
dev.off()

## mult things at once
df = read.table("/Users/kprovost/Dropbox (AMNH)/Dissertation/CHAPTER1_REVIEW/cfb_ch1_multidata.txt",
                sep="\t",header=T)
## Can you group by div time and locomotion and position?
## Or time and locomotion
## and time and position
unitimes = unique(df$Divergence.Time.Epoch)
vals=seq(-119,-98,0.01)
histdf = c()
timelocodf = c()
namescol=c("Time","Locomotion",vals)

for(time in unitimes){
  temp1 = df[df$Divergence.Time.Epoch==time,]
  unilocos = unique(temp1$Locomotion.Dispersal)
  
  for(loco in unilocos) {
    print(time)
    print(loco)
    temp2=temp1[temp1$Locomotion.Dispersal==loco,]
    
    counts=sapply(vals,FUN=function(x){
      sum((temp2$W.Location.Barrier <= x) & (temp2$E.Location.Barrier >= x),na.rm = T)
    })
    
    counts[is.na(counts)]=0
    
    timlocadd=c(time,loco)
    
    if(sum(counts) > 0) {
      
      if(is.null(histdf)) {
        histdf=counts
      } else {
        histdf=rbind(histdf,counts)
      }
      
      if(is.null(timelocodf)) {
        timelocodf=timlocadd
      } else {
        timelocodf=rbind(timelocodf,timlocadd)
      }
    }
  }
}
#colnames(histdf) = namescol
rownames(histdf) = NULL
colnames(histdf) = NULL

class(histdf)
z=as.table(histdf)
#colnames(z)=vals
colnames(z) = NULL
rownames(z)=paste(timelocodf[,1],timelocodf[,2],sep="-")

library(RColorBrewer)
ticks=which(vals %% 1 == 0)
labelvals = vals[ticks]

## set up colors

fullrange = brewer.pal(12,"Paired")
blues=colorRampPalette(fullrange[1:2])
greens=colorRampPalette(fullrange[3:4])
reds=colorRampPalette(fullrange[5:6])
oranges=colorRampPalette(fullrange[7:8])
purples=colorRampPalette(fullrange[9:10])
browns=colorRampPalette(fullrange[11:12])
#orgbrwn=fullrange[c(8,12)]

# 5, 2, 2, 2, 3, 2
listcolors=c(blues(5),greens(2),purples(2),browns(2),reds(3),oranges(2))
# 5, 3, 3, 2, 5, 2
#listcolors=c(blues(5),greens(3),purples(3),browns(2),reds(5),oranges(2))


png("number_within_range_cfb_timelocomotion.png",width=1000,height=500)
#pdf("number_within_range_cfb_timelocomotion.pdf",width=10,height=5)
par(mar=c(4,4,0,0))
bp=barplot(z,col=listcolors,
           border=listcolors,xlab="Longitude",space=0,ylim=c(0,26),
           ylab="Proportion of Species Overlapping",beside=F)
axis(1,at=bp[ticks],labels=labelvals,las=2)
legend("topleft",legend=rownames(z),fill=listcolors,bty="n",cex=0.75)
dev.off()

png("number_within_range_cfb_timelocomotion_separate.png",width=1000,height=500)
#pdf("number_within_range_cfb_timelocomotion_separate.pdf",width=10,height=5)
par(mfrow=c(2,3))
par(mar=c(4,4,0,0))
for(time in unitimes) {
  subsetrows=as.numeric(which(timelocodf[,1] == time))
  newz=z[subsetrows,]
  bp=barplot(newz,col=listcolors[subsetrows],
             border=listcolors[subsetrows],xlab="Longitude",space=0,ylim=c(0,16),
             ylab="Proportion of Species Overlapping",beside=F)
  axis(1,at=bp[ticks],labels=labelvals,las=2)
  legend("topleft",legend=rownames(newz),fill=listcolors[subsetrows],bty="n",cex=0.75)
}
dev.off()

png("number_within_range_cfb_timelocomotion_separateloco.png",width=1000,height=500)
#pdf("number_within_range_cfb_timelocomotion_separateloco.pdf",width=10,height=5)
par(mfrow=c(2,3))
par(mar=c(4,4,0,0))
for(time in unique(timelocodf[,2])) {
  subsetrows=as.numeric(which(timelocodf[,2] == time))
  newz=z[subsetrows,]
  bp=barplot(newz,col=listcolors[subsetrows],
             border=listcolors[subsetrows],xlab="Longitude",space=0,ylim=c(0,13),
             ylab="Proportion of Species Overlapping",beside=F)
  axis(1,at=bp[ticks],labels=labelvals,las=2)
  legend("topleft",legend=rownames(z)[subsetrows],fill=listcolors[subsetrows],bty="n",cex=0.75)
}
dev.off()

png("locomotion_time_widthcfb.png",width=900)
par(mar=c(4,4,0,0))
boxplot(df$Width~df$Divergence.Time.Epoch+df$Locomotion.Dispersal,
        las=2,cex.axis=0.5)
dev.off()




##### endo/ecto
df=read.csv("/Users/kprovost/Dropbox (AMNH)/Dissertation/CHAPTER1_REVIEW/cfb_ch1_multidata2.csv",
            header=T)
table(df[,c("ENDO.ECTO","WIDTH")])
#par(mar=c(2,4,0,0))

png("all_thermo.png",width=600,height=600)
#png("thermoregulation_vs_width.png",width=600,height=300)
par(mar=c(3,4,0,0))
par(mfrow=c(2,2))
boxplot(df$WIDTH~df$ENDO.ECTO,varWidth=T,notch=T,col=c("lightblue","darkred"),
        xlab="",ylab="Barrier Width (Longitude)",
        names=c("Ectotherm","Endotherm"))
#dev.off()
#png("thermoregulation_vs_locomotion.png",width=600,height=300)
#par(mar=c(4,4,0,0))
barplot(table(df[,c("ENDO.ECTO","LOCOMOTION.DISPERSAL")]),
        col=c("lightblue","darkred"),ylab="Number of Taxa",
        las=1,cex.names=1,
        names=c("Crawl","Fly","Jump",
                "Sessile","Swim","Walk"))
legend("topleft",legend=c("Ectotherm","Endotherm"),
       fill=c("lightblue","darkred"),bty="n",cex=1)
#dev.off()
#png("thermoregulation_vs_structure.png",width=600,height=300)
#par(mar=c(4,4,0,0))
# barplot(table(df[,c("STRUCTURE","ENDO.ECTO")]),
#         col=c("darkblue","blue","cyan"),ylab="Number of Taxa",
#         las=1,cex.names=1,
#         names=c("Ectotherm","Endotherm"))
barplot(t(table(df[,c("STRUCTURE","ENDO.ECTO")])),
        col=c("lightblue","darkred"),ylab="Number of Taxa",
        las=1,cex.names=1,names=c("No","Unclear","Yes"),ylim=c(0,42))
legend("topleft",legend=c("Ectotherm","Endotherm"),
       fill=c("lightblue","darkred"),bty="n",cex=1)
# legend("topright",title="Structure",
#        legend=c("Yes","Unclear","No"),
#        fill=c("cyan","blue","darkblue"),bty="n",cex=1)
#dev.off()
#png("thermoregulation_vs_divergence.png",width=600,height=300)
#par(mar=c(4,4,0,0))
div=table(df[,c("DIVERGENCE.TIME.EPOCH","ENDO.ECTO")])
barplot(t(div[rev(c(6,1,2,4,5,3)),]),
        #col=c("darkblue","red","orange","yellow","magenta","purple"),
        col=c("lightblue","darkred"),
        las=1,cex.names=0.9,ylim=c(0,27),ylab="Number of Taxa",
        names=c("Pleist","PlioPleist","Plio","MioPlio","Mio","Unclear"))
#legend("topright",legend=rev(c("Unclear","Miocene","Mio-Pliocene",
#                                  "Pliocene","Plio-Pleistocene","Pleistocene")),
#       fill=rev(c("darkblue","red","orange","yellow","magenta","purple")),bty="n",cex=0.75,
#       ncol=1)
legend("topright",legend=c("Ectotherm","Endotherm"),
       fill=c("lightblue","darkred"),bty="n",cex=1)
dev.off()

library(ggplot2)
library(devtools)
install_github("kassambara/easyGgplot2")
library(easyGgplot2)
ggplot2.violinplot(data=df, xName='ENDO.ECTO',yName='WIDTH',
                   addDot=TRUE, dotSize=1, dotPosition="center",
                   backgroundColor=rgb(1,1,1),
                   gridColor="grey")


