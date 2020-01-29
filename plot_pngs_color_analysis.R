library("png")
library("grid")
library("gridExtra")

pngfolder = "~/Downloads/dropbox/crops/"
setwd(pngfolder)
pngs = list.files(path=pngfolder,pattern="001",full.names = F)

for(pngfile in pngs) {
print(pngfile)
png1 = readPNG(pngfile)
dim(png1)
#plot(png1)

#grid.raster(png1)

# copy the image three times
#png1.R = png1
#png1.G = png1
#png1.B = png1
#png1.A = png1

# zero out the non-contributing channels for each image copy
#png1.R[,,2:3] = 0
#png1.G[,,1]=0
#png1.G[,,3]=0
#png1.B[,,1:2]=0

# build the image grid
#img1 = rasterGrob(png1.R)
#img2 = rasterGrob(png1.G)
#img3 = rasterGrob(png1.B)
#grid.arrange(img1, img2, img3, nrow=1)

df = data.frame(
  red = matrix(png1[,,1], ncol=1),
  green = matrix(png1[,,2], ncol=1),
  blue = matrix(png1[,,3], ncol=1),
  alpha= matrix(png1[,,4],ncol=1)
)
nrow(df)

df$alpha[df$alpha!=1] = 0
nrow(df)

# df2 = data.frame(
#   red  = matrix(png1[,,1], ncol=1),
#   green= matrix(png1[,,2], ncol=1),
#   blue = matrix(png1[,,3], ncol=1),
#   alpha= matrix(png1[,,4], ncol=1)
# )
# df2 = df2[df2$alpha==1,]
# summary(df2)
# df2 <- df2[order(df2$blue, df2$green, df2$red),]
# ## image of 537*899
# df2.R = matrix(df2$red,nrow=537,ncol=899)
# df2.G = matrix(df2$green,nrow=537,ncol=899)
# df2.B = matrix(df2$blue,nrow=537,ncol=899)
# 
# arr = array(c(df2.R,df2.G,df2.B),dim=c(537,899,3))
# writePNG(arr,target="~/Downloads/dropbox/test.png")

K = kmeans(df[df$alpha!=0,],12)
df$label = 0
df$label[df$alpha!=0] = K$cluster
df$label[df$alpha==0] = 0
nrow(df)

colors = data.frame(
  label = c(1:nrow(K$centers),0),
  R = c(K$centers[,"red"],0),
  G = c(K$centers[,"green"],0),
  B = c(K$centers[,"blue"],0),
  A = c(rep(1,nrow(K$centers)),0)
)
nrow(colors)
colors = colors[order(colors$label),]

df$order = 1:nrow(df)
df2 = merge(df, colors)
df = df2[order(df2$order),]
df$order = NULL
nrow(df)

R = matrix(df$R, nrow=dim(png1)[1])
G = matrix(df$G, nrow=dim(png1)[1])
B = matrix(df$B, nrow=dim(png1)[1])
A = matrix(df$A, nrow=dim(png1)[1])

png1.segmented = array(dim=dim(png1))
png1.segmented[,,1] = R
png1.segmented[,,2] = G
png1.segmented[,,3] = B
png1.segmented[,,4] = png1[,,4]

Rs = matrix(df2$R, nrow=dim(png1)[1])
Gs = matrix(df2$G, nrow=dim(png1)[1])
Bs = matrix(df2$B, nrow=dim(png1)[1])
As = matrix(df2$A, nrow=dim(png1)[1])

png1.sort = array(dim=dim(png1))
png1.sort[,,1] = Rs
png1.sort[,,2] = Gs
png1.sort[,,3] = Bs
png1.sort[,,4] = As

badcols = which(colSums(png1.sort[,,4]) == 0)
#badrows = which(rowSums(png1.sort[,,4]) == 0)

png1.small = png1.sort[,-badcols,]

## get data where alpha is not zero 

writePNG(png1.segmented,
         target=paste("~/Downloads/dropbox/",pngfile,".SEGMENTED.png",sep=""))
writePNG(png1.small,
         target=paste("~/Downloads/dropbox/",pngfile,".SEGSORT.png",sep=""))

#grid.raster(mandrill.segmented)

}
