library(scales)
library(rgl)

#read in file here
#filename="D://desertbirdtest/FolderWithRedBirds/Image Analysis Results Nikon D80 Nikkor AF 60mm D65 to Bluetit D65.csv"
filename="/Users/kprovost/Dropbox (AMNH)/Dissertation/DesertBirdDataForKaiya.csv"
colorSet2 <- read.delim(file = filename, header = T, sep = ",")
## species designations are completely wrong 

pcaCols <- prcomp(x = colorSet2[, c("swMean", "mwMean", "lwMean")], retx = T, center = T, scale. = T)
rgl::plot3d(pcaCols$x, col = rgb(red = rescale(to = c(0, 1), colorSet2$lwMean), green = rescale(to = c(0, 1), colorSet2$mwMean), blue = rescale(to = c(0, 1), colorSet2$swMean), alpha = 1), pch = 16, size = 10)
pcaCols <- prcomp(x = colorSet2[, c("swMean", "mwMean", "lwMean")], retx = T, center = T, scale. = T)

spplist = 

par(mfrow=c(2,3))
for ( spp in unique(colorSet2$species)) {
  print(spp)
  subset1 = pcaCols$x[colorSet2$species==spp,]
  subset2 = colorSet2[colorSet2$species==spp,]
  
  plot(pcaCols$x[,c(1,2)], type="n",main=spp)
  points(pch = 16, subset1[,c(1,2)], 
       col = rgb(red = rescale(to = c(0, .9), subset2$lwMean),
                 green = rescale(to = c(0, .9), subset2$mwMean), 
                 blue = rescale(to = c(0, .9), subset2$swMean), alpha = .8), 
       cex = 1)
  
}

png("test.colors.png")
plot(pch = 16, pcaCols$x[,c(1,2)], 
     col = rgb(red = rescale(to = c(0, .9), colorSet2$lwMean),
               green = rescale(to = c(0, .9), colorSet2$mwMean), 
               blue = rescale(to = c(0, .9), colorSet2$swMean), alpha = .8), 
     cex = 1)
dev.off()

z=(lapply(as.character(colorSet2$wavelength),FUN=function(x){
  y=c(strsplit(x,split="_")[[1]][2:3])
  ind = y[1]
  pix = y[2]
  pix2 = strsplit(pix,"-")[[1]]
  lat=pix2[1]
  lon=pix2[2]
  toret=c(ind,lat,lon)
  return(toret)
  }))
zz=as.data.frame(do.call(rbind, z))
colnames(zz) = c("ind","lat","lon")

colorSet3 = cbind(colorSet2,zz)

#for(ind in "0067") {
#for(ind in unique(colorSet3$ind)) {
  par(ask=F)
oneind = colorSet3[colorSet3$ind=="0067",]
oneind = oneind[as.numeric(oneind$lat)>=1000,]
plot(
  as.numeric(oneind$lat),
  -1*as.numeric(oneind$lon),pch=16,cex=3,
  col = rgb(
    red = rescale(to = c(0.0, 1), oneind$lwMean),
    green = rescale(to = c(0.0, 1), oneind$mwMean),
    blue = rescale(to = c(0.0, 1), oneind$swMean),
    alpha = .8
  )
)
#}

