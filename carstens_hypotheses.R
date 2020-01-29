setwd("~/Dropbox (AMNH)/")

highval = rnorm(n=1000000,mean=0.8,sd=0.02)
highval2 = highval-0.1
fullval = rnorm(n=1000000,mean=0.5,sd=0.2)

png("carstens_objective1_hypotheses.png",height=300)
par(mar=c(1,1,0.2,0.2),mfrow=c(1,2))
plot(density(highval),xlim=c(0,1),lwd=3,xlab="",ylab="",type="l",
     xaxt="n",yaxt="n",main="")
mtext(text = "Difference Across Suture Zone",side = 1)
mtext(text = "Number of Species",side = 2)
lines(density(highval2),col="red",ylim=c(0,30),lwd=3,lty=3)

plot(density(highval),xlim=c(0,0.86),lwd=3,xlab="",ylab="",
     xaxt="n",yaxt="n",main="")
lines(density(fullval),col="red",ylim=c(0,30),lwd=3,lty=3)
mtext(text = "Difference Across Suture Zone",side = 1)
mtext(text = "Number of Species",side = 2)
dev.off()

png("carstens_objective1_hypotheses2.png",height=300)
par(mar=c(1,1,0.2,0.2),mfrow=c(1,2))
plot(density(highval),yaxt="n",xaxt="n",xlab="",
     ylab="",lwd=3,main="")
#abline(v=0.8)
mtext(text = "Community Similarity",side = 1)
mtext(text = "Frequency",side = 2)
abline(v=0.8,lwd=3,lty=3,col="red")
plot(density(highval),yaxt="n",xaxt="n",xlab="",
     ylab="",lwd=3,main="")
mtext(text = "Community Similarity",side = 1)
mtext(text = "Frequency",side = 2)
abline(v=0.9,lwd=3,lty=3,col="red")
dev.off()

points = seq(0,100,1)
revpoints = rev(points)
zeropoints = rep(mean(points),length(points))

png("carstens_objective1_hypotheses4.png",height=300)
par(mar=c(1,1,0.2,0.2),mfrow=c(1,2))
plot(points,points+5,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="",ylim=c(0,max(revpoints+5)))
mtext(text = "Genetic Difference",side = 1)
mtext(text = "Vocal Difference",side = 2)

plot(points,zeropoints,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="",ylim=c(0,max(revpoints+5)))
mtext(text = "Genetic Difference",side = 1)
mtext(text = "Vocal Difference",side = 2)
dev.off()

logistic=sort(rlogis(10000,location=30,scale=1))
straightlogit = scales::rescale(1:11000,to=c(18.5,43.3))
logitplotx = c(logistic,rep(41,1000))
logitploty = c(1:10000,rep(10000,1000))
straightplotx = straightlogit[1:10000]
straightploty = 1:10000
squishedlogit = sort(rlogis(10000,location=30,scale=2))
squishedlogitx = c(squishedlogit,rep(41,1000))
squishedlogity = logitploty[squishedlogitx > min(logitplotx)]
squishedlogitx = squishedlogitx[squishedlogitx > min(logitplotx)]
squishedlogity = squishedlogity[squishedlogitx < max(logitplotx)]
squishedlogitx = squishedlogitx[1:length(squishedlogity)]

png("carstens_objective1_hypotheses5.png",height=300,width=900)
par(mar=c(1,1,0.2,0.2),mfrow=c(1,4))
plot(logitplotx,
     logitploty,
     type="n",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="")
mtext(text = "Geographic Distance",side = 1)
mtext(text = "Cline",side = 2)
#abline(v=30,lwd=3,col="red",lty=3)
#abline(v=26,lwd=3,col="grey",lty=2)
#abline(v=34,lwd=3,col="grey",lty=2)
polygon(c(26,34,34,26), c(-1000,-1000,11000,11000),
        col = "grey", border = NA)
text(30,10000,"Suture Zone")
points(logitplotx,
       logitploty,type="l",
       lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
       xlab="",ylab="")
points(squishedlogitx[seq(1, length(squishedlogitx), 15)],
       squishedlogity[seq(1, length(squishedlogity), 15)],
       type="l",lty=3,lwd=3,col="red",xaxt="n",yaxt="n",
       xlab="",ylab="")

plot(logitplotx,
     logitploty,
     type="n",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="")
mtext(text = "Geographic Distance",side = 1)
mtext(text = "Cline",side = 2)
#abline(v=30,lwd=3,col="red",lty=3)
#abline(v=26,lwd=3,col="grey",lty=2)
#abline(v=34,lwd=3,col="grey",lty=2)
polygon(c(26,34,34,26), c(-1000,-1000,11000,11000),
        col = "grey", border = NA)
text(30,10000,"Suture Zone")
points(logitplotx,
     logitploty,
     type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="")
points(straightplotx[seq(1, length(straightplotx), 15)],
       straightploty[seq(1, length(straightploty), 15)],
     type="l",lty=3,lwd=3,col="red",xaxt="n",yaxt="n",
     xlab="",ylab="")

plot(logitplotx,
     logitploty,
     type="n",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="")
mtext(text = "Geographic Distance",side = 1)
mtext(text = "Cline",side = 2)
#abline(v=30,lwd=3,col="red",lty=3)
#abline(v=26,lwd=3,col="grey",lty=2)
#abline(v=34,lwd=3,col="grey",lty=2)
polygon(c(26,34,34,26), c(-1000,-1000,11000,11000),
        col = "grey", border = NA)
text(30,10000,"Suture Zone")
points(straightplotx[seq(1, length(straightplotx), 15)]+1,
       straightploty[seq(1, length(straightploty), 15)],
       type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
       xlab="",ylab="")
points(straightplotx[seq(1, length(straightplotx), 15)],
       straightploty[seq(1, length(straightploty), 15)],
       type="l",lty=3,lwd=3,col="red",xaxt="n",yaxt="n",
       xlab="",ylab="")
plot(logitplotx,
     logitploty,
     type="n",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="")
mtext(text = "Geographic Distance",side = 1)
mtext(text = "Cline",side = 2)
#abline(v=30,lwd=3,col="red",lty=3)
#abline(v=26,lwd=3,col="grey",lty=2)
#abline(v=34,lwd=3,col="grey",lty=2)
polygon(c(26,34,34,26), c(-1000,-1000,11000,11000),
        col = "grey", border = NA)
text(30,10000,"Suture Zone")
points(logitplotx[seq(1, length(logitplotx), 15)],
       logitploty[seq(1, length(logitplotx), 15)],type="l",
       lty=3,lwd=3,col="red",xaxt="n",yaxt="n",
       xlab="",ylab="")
points(straightplotx[seq(1, length(straightplotx), 15)],
       straightploty[seq(1, length(straightploty), 15)],
       type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
       xlab="",ylab="")

dev.off()

revpointsvee = c(seq(100,55,-1),56:59,rep(60,10),seq(59,19,-1))

png("carstens_objective2_hypotheses1.png",height=300)
par(mar=c(1,1,0.2,0.2),mfrow=c(1,1))
plot(points,revpoints,type="l",lty=1,lwd=3,col="white",xaxt="n",yaxt="n",
     xlab="",ylab="",ylim=c(0,max(revpoints+5)))
polygon(c(51,60,60,51), c(-1000,-1000,11000,11000),
        col = "grey", border = NA)
text(55.5,80,"Suture Zone",las=2,srt=90)
points(points,revpoints-5,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="",ylim=c(0,max(revpoints+5)))
points(points,revpointsvee+5,type="l",lty=3,lwd=3,col="red",xaxt="n",yaxt="n",
     xlab="",ylab="",ylim=c(0,max(revpoints+5)))
points(points,revpoints,type="l",lty=2,lwd=3,col="cyan",xaxt="n",yaxt="n",
       xlab="",ylab="",ylim=c(0,max(revpoints+5)))
text(30,10000,"Suture Zone")
mtext(text = "Distance from Refugia",side = 1)
mtext(text = "Vocal Diversity",side = 2)
legend("topright",legend=c("Single","Double Reinf.","Double Adapt."),
       col=c("black","red","cyan"),lwd=3,lty=c(1,3,2),bty="n")
dev.off()

refA1 = sort(rnorm(1000,mean=-0.5,sd=0.5))
refA2 = rep(refA1[250:350],10)
refB1 = sort(rnorm(1000,mean=0,sd=0.5))
refB2 = rep(refB1[450:550],10)
refC1 = sort(rnorm(1000,mean=0.5,sd=0.5))
refC2 = rep(refC1[650:750],10)

par(mfrow=c(1,1))
hist(c(refA1,refA2,refB1,refB2,refC1,refC2),main="",
     xlim=c(-2,2),ylim=c(0,1300),border="grey",ylab="",xlab="",
     breaks=c(seq(-5,5,0.15)))
hist(refA1,add=T,col=rgb(0.75,0,0,0.3),breaks=c(seq(-5,5,0.15)))
hist(refA2,add=T,col=rgb(1,0,0,0.3),breaks=c(seq(-5,5,0.15)))
hist(refB1,add=T,col=rgb(0,0.75,0,0.3),breaks=c(seq(-5,5,0.15)))
hist(refB2,add=T,col=rgb(0,1,0,0.3),breaks=c(seq(-5,5,0.15)))
hist(refC1,add=T,col=rgb(0,0,0.75,0.3),breaks=c(seq(-5,5,0.15)))
hist(refC2,add=T,col=rgb(0,0,1,0.3),breaks=c(seq(-5,5,0.15)))

png("carstens_objective2_hypotheses2.png",height=300)
par(mar=c(1,1,0.2,0.2),mfrow=c(1,2))
plot(points,points+5,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="",ylim=c(0,max(revpoints+5)))
points(points,points,type="l",lty=3,lwd=3,col="red",xaxt="n",yaxt="n",
     xlab="",ylab="",ylim=c(0,max(revpoints+5)))
points(points,zeropoints,type="l",lty=2,lwd=3,col="cyan",xaxt="n",yaxt="n",
       xlab="",ylab="",ylim=c(0,max(revpoints+5)))
mtext(text = "Variable Distance",side = 1)
mtext(text = "Vocal Difference",side = 2)
legend("topleft",legend=c("Geographic","Genetic","Environmental"),
       col=c("black","red","cyan"),lwd=3,lty=c(1,3,2),bty="n")

plot(points,points+5,type="l",lty=1,lwd=3,col="black",xaxt="n",yaxt="n",
     xlab="",ylab="",ylim=c(0,max(revpoints+5)))
points(points,zeropoints,type="l",lty=3,lwd=3,col="red",xaxt="n",yaxt="n",
       xlab="",ylab="",ylim=c(0,max(revpoints+5)))
points(points,points,type="l",lty=2,lwd=3,col="cyan",xaxt="n",yaxt="n",
       xlab="",ylab="",ylim=c(0,max(revpoints+5)))
mtext(text = "Variable Distance",side = 1)
mtext(text = "Vocal Difference",side = 2)
legend("topleft",legend=c("Geographic","Genetic","Environmental"),
       col=c("black","red","cyan"),lwd=3,lty=c(1,3,2),bty="n")
dev.off()
