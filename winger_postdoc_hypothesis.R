## hypotheses for plumage color

## hyp1A and 1B -- glogers rule clim vs non clim

points = seq(0,100,1)
revpoints = rev(points)
zeropoints = rep(mean(points),length(points))

# par(mfrow=c(2,4),mar=c(2,2,0,0))
# plot(points,points,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
#      xlab="",ylab="Plumage Color",ylim=c(0,max(revpoints+5)))
# mtext(side=2,text="Plumage Color")
# points(points,points+5,type="l",lty=2,lwd=3,col="red")
# #axis(1,at=c(10,90),labels=c("Cold","Hot"))
# plot(points,points,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
#      xlab="",ylab="",ylim=c(0,max(revpoints+5)))
# points(points,revpoints,type="l",lty=2,lwd=3,col="red")
# #axis(1,at=c(10,90),labels=c("Dry","Wet"))
# plot(points,zeropoints,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
#      xlab="",ylab="",ylim=c(0,max(revpoints+5)))
# plot(points,zeropoints,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
#      xlab="",ylab="",ylim=c(0,max(revpoints+5)))
# plot(points,zeropoints+2.5,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
#      xlab="Temperature",ylab="Plumage Color",ylim=c(0,max(revpoints+5)))
# mtext(side=2,text="Plumage Color")
# mtext(side=1,text="Temperature")
# points(points,zeropoints-2.5,type="l",lty=2,lwd=3,col="red")
# #axis(1,at=c(10,90),labels=c("Cold","Hot"))
# plot(points,zeropoints+2.5,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
#      xlab="Precipitation",ylab="",ylim=c(0,max(revpoints+5)))
# mtext(side=1,text="Precipitation")
# points(points,zeropoints-2.5,type="l",lty=2,lwd=3,col="red")
# #axis(1,at=c(10,90),labels=c("Dry","Wet"))
# plot(points,points,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
#      xlab="Soil Color",ylab="",ylim=c(0,max(revpoints+5)))
# mtext(side=1,text="Soil Color")
# plot(points,points,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
#      xlab="Vegetation",ylab="",ylim=c(0,max(revpoints+5)))
# mtext(side=1,text="Vegetation")


#png("winger_hypotheses_everyone.png")
layout(matrix(c(1,1,1,2,2,2,3,3,3,4,4,4,5,5,6,6,7,7), 3, 6, byrow = TRUE))
par(mar=c(1,1.5,1,1))
png("winger_hypotheses_1A_1B.png",width=340,height=160)
par(mfrow=c(1,2),mar=c(1,1,1,1))
plot(points,points+5,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="",ylim=c(0,max(revpoints+5)))
points(points,zeropoints-2.5,type="l",lty=3,lwd=3,col="red")
mtext(side=1,text="Environmental Variable")
mtext(side=2,text="Proportion Eu:Pheo")
legend("bottomright",legend=c("Non-Climate","Climate"),
       lty=c(3,1),col=c("red","black"),lwd=3,bty="n")
legend("topleft",legend="Hyp. 1A",bty="n",cex=1.5)
plot(points,zeropoints,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="",ylim=c(0,max(revpoints+5)))
points(points,points+5,type="l",lty=3,lwd=3,col="red")
mtext(side=1,text="Environmental Variable")
mtext(side=2,text="Proportion Eu:Pheo")
legend("bottomright",legend=c("Non-Climate","Climate"),
       lty=c(3,1),col=c("red","black"),lwd=3,bty="n")
legend("topleft",legend="Hyp. 1B",bty="n",cex=1.5)
dev.off()


## hyp 2a vs 2b, glogers rule and large vs small scale
png("winger_hypotheses_2A_2B.png",width=340,height=160)
par(mfrow=c(1,2),mar=c(1,1,1,1))
two_corr = c(seq(0,50),seq(75,125))
corr1 = c(seq(0,50))
corr2 = c(seq(75,125))
nocorr1 = rep(mean(corr1),length(corr1))
nocorr2 = rep(mean(corr2),length(corr2))
#par(mfrow=c(1,2),mar=c(1,1,1,1))
plot(two_corr,two_corr,type="n",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="")
mtext(side=1,text="Environmental Variable")
mtext(side=2,text="Plumage Color")
#text(x=mean(corr1),y=min(corr1),labels="Non-Desert")
#text(x=mean(corr2),y=min(corr2),labels="Desert",col="red")
points(corr1,corr1,type="l",lty=1,lwd=3,col="black")
points(corr2,corr2,type="l",lty=3,lwd=3,col="red")
legend("bottomright",legend=c("Desert","Non-Desert"),
       lty=c(3,1),col=c("red","black"),lwd=3,bty="n")
legend("topleft",legend="Hyp. 2A",bty="n",cex=1.5)

plot(two_corr,two_corr,type="n",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="")
points(corr1,nocorr1+10,type="l",lty=1,lwd=3,col="black")
points(corr2,nocorr2-10,type="l",lty=3,lwd=3,col="red")
mtext(side=1,text="Environmental Variable")
mtext(side=2,text="Plumage Color")
#text(x=mean(corr1),y=mean(corr1)-5,labels="Non-Desert")
#text(x=mean(corr2),y=mean(corr2)-5,labels="Desert",col="red")
legend("bottomright",legend=c("Desert","Non-Desert"),
       lty=c(3,1),col=c("red","black"),lwd=3,bty="n")
legend("topleft",legend="Hyp. 2B",bty="n",cex=1.5)

dev.off()

## hyp 3a-3c, nat sel vs sex sel vs stoch/gen
png("winger_hypotheses_3A_3B_3C.png",height=160)
par(mfrow=c(1,3),mar=c(1,1.2,1,1))
plot(points,points,type="l",lwd=3,lty=1,col="black",xaxt="n",yaxt="n")
#legend("topleft",legend="Hyp. 3",bty="n",cex=1.5)

points(points,zeropoints-2.5,type='l',lwd=3,lty=3,col="red")
points(points,zeropoints+2.5,type='l',lwd=3,lty=2,col="cyan")
mtext(side=1,text="Environmental Variable")
mtext(side=2,text="Plumage")
legend("bottomright",legend=c("Hyp. 3A","Hyp. 3B", "Hyp. 3C"),
       col=c("black","red","cyan"),lty=c(1,3,2),lwd=3)

plot(points,points,type="l",lwd=3,lty=3,col="red",xaxt="n",yaxt="n")
legend("bottomright",legend=c("Hyp. 3A","Hyp. 3B", "Hyp. 3C"),
       col=c("black","red","cyan"),lty=c(1,3,2),lwd=3)

points(points,zeropoints-2.5,type='l',lwd=3,lty=2,col="cyan")
points(points,zeropoints+2.5,type='l',lwd=3,lty=1,col="black")
mtext(side=1,text="Genetic Similarity")
mtext(side=2,text="Plumage Similarity") 
barstoplot = c(10,10,90)
g = barplot(barstoplot,col=c("black","red","cyan"),ylim=c(0,100),border="black",xaxt="n",yaxt="n")
box()
mtext(side=1,text="Hypothesis")
mtext(side=2,text="Sexual Dimorphism")
text(x = g, y = barstoplot, label = c("Hyp. 3A","Hyp. 3B", "Hyp. 3C"),pos=3)

dev.off()

