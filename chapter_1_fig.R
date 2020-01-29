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
