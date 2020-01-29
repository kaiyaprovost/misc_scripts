cakes = "/Users/kprovost/Dropbox (AMNH)/Dissertation/caktes.txt"

library(phangorn)
rawdata <- read.table(cakes, sep="\t", stringsAsFactors = FALSE)
rownames(rawdata) = rawdata[,1]
colnames(rawdata) = rawdata[1,]
rawdata = rawdata[-1,-1]
rawdata = as.matrix(rawdata)
dat = phyDat(rawdata, type = "USER", levels = c("0", "1", "2", "3"))
dm = dist.hamming(dat)
tree=NJ(dm)
plot(tree,type="radial")
parsimony(tree, dat)
tree2 = optim.parsimony(tree, dat)
plot(tree2,type="radial")
parsimony(tree2,dat)

plot(trer2)

trer = root(tree,"ANCIENT CAKES")
trer2 = root(tree2,c("TOPLESS PIES","TRUE PIES"))
plot(trer2)
ape::cophyloplot(trer,trer2,space=5,cex=0.1)
