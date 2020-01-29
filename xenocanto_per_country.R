library(warbleR)
afr=c('cnt:Algeria','cnt:Angola','cnt:Benin','cnt:Botswana','cnt:Burkina','cnt:Burundi','cnt:Cameroon','cnt:"Cape Verde"','cnt:Central African Republic','cnt:Chad','cnt:Comoros','cnt:Congo','cnt:Congo, Democratic Republic of','cnt:Djibouti','cnt:Egypt','cnt:"Equatorial Guinea"','cnt:Eritrea','cnt:Ethiopia','cnt:Gabon','cnt:Gambia','cnt:Ghana','cnt:Guinea','cnt:Guinea-Bissau','cnt:"Ivory Coast"','cnt:Kenya','cnt:Lesotho','cnt:Liberia','cnt:Libya','cnt:Madagascar','cnt:Malawi','cnt:Mali','cnt:Mauritania','cnt:Mauritius','cnt:Morocco','cnt:Mozambique','cnt:Namibia','cnt:Niger','cnt:Nigeria','cnt:Rwanda','cnt:Sao Tome and Principe','cnt:Senegal','cnt:Seychelles','cnt:"Sierra Leone"','cnt:Somalia','cnt:"South Africa"','cnt:"South Sudan"','cnt:Sudan','cnt:Swaziland','cnt:Tanzania','cnt:Togo','cnt:Tunisia','cnt:Uganda','cnt:Zambia','cnt:Zimbabwe')
asi=c('cnt:Afghanistan','cnt:Bahrain','cnt:Bangladesh','cnt:Bhutan','cnt:Brunei','cnt:Burma (Myanmar)','cnt:Cambodia','cnt:China','cnt:"East Timor"','cnt:India','cnt:Indonesia','cnt:Iran','cnt:Iraq','cnt:Israel','cnt:Japan','cnt:Jordan','cnt:Kazakhstan','cnt:Korea, North','cnt:Korea, South','cnt:Kuwait','cnt:Kyrgyzstan','cnt:Laos','cnt:Lebanon','cnt:Malaysia','cnt:Maldives','cnt:Mongolia','cnt:Nepal','cnt:Oman','cnt:Pakistan','cnt:Philippines','cnt:Qatar','cnt:"Russian Federation"','cnt:"Saudi Arabia"','cnt:Singapore','cnt:"Sri Lanka"','cnt:Syria','cnt:Tajikistan','cnt:Thailand','cnt:Turkey','cnt:Turkmenistan','cnt:United Arab Emirates','cnt:Uzbekistan','cnt:Vietnam','cnt:Yemen')
eur=c('cnt:Albania','cnt:Andorra','cnt:Armenia','cnt:Austria','cnt:Azerbaijan','cnt:Belarus','cnt:Belgium','cnt:Bosnia and Herzegovina','cnt:Bulgaria','cnt:Croatia','cnt:Cyprus','cnt:"Czech Republic"','cnt:Denmark','cnt:Estonia','cnt:Finland','cnt:France','cnt:Georgia','cnt:Germany','cnt:Greece','cnt:Hungary','cnt:Iceland','cnt:Ireland','cnt:Italy','cnt:Latvia','cnt:Liechtenstein','cnt:Lithuania','cnt:Luxembourg','cnt:Macedonia','cnt:Malta','cnt:Moldova','cnt:Monaco','cnt:Montenegro','cnt:Netherlands','cnt:Norway','cnt:Poland','cnt:Portugal','cnt:Romania','cnt:"San Marino"','cnt:Serbia','cnt:Slovakia','cnt:Slovenia','cnt:Spain','cnt:Sweden','cnt:Switzerland','cnt:Ukraine','cnt:"United Kingdom"','cnt:"Vatican City"')
nam=c('cnt:Antigua and Barbuda','cnt:Bahamas','cnt:Barbados','cnt:Belize','cnt:Canada','cnt:"Costa Rica"','cnt:Cuba','cnt:Dominica','cnt:"Dominican Republic"','cnt:"El Salvador"','cnt:Grenada','cnt:Guatemala','cnt:Haiti','cnt:Honduras','cnt:Jamaica','cnt:Mexico','cnt:Nicaragua','cnt:Panama','cnt:Saint Kitts and Nevis','cnt:"Saint Lucia"','cnt:Saint Vincent and the Grenadines','cnt:Trinidad and Tobago','cnt:"United States"')
oce=c('cnt:Australia','cnt:Fiji','cnt:Kiribati','cnt:"Marshall Islands"','cnt:Micronesia','cnt:Nauru','cnt:"New Zealand"','cnt:Palau','cnt:Papua New Guinea','cnt:Samoa','cnt:"Solomon Islands"','cnt:Tonga','cnt:Tuvalu','cnt:Vanuatu')
sam=c('cnt:Argentina','cnt:Bolivia','cnt:Brazil','cnt:Chile','cnt:Colombia','cnt:Ecuador','cnt:Guyana','cnt:Paraguay','cnt:Peru','cnt:Suriname','cnt:Uruguay','cnt:Venezuela')

#all=c(afr,asi,eur,nam,oce,sam)
#all=c(nam)
all=c(afr,asi,eur,oce,sam)


#full = c()
#fullx = c()
for (country in all) {
  x = querxc(country)
  
  if(is.null(x)) {
    print("pass")
  } else {
  
    if(is.null(fullx)) {
      fullx = x
    } else {
      fullx = gtools::smartbind(fullx,x)
    }
    
    
  num_rec = nrow(x)
  sppdf = paste(x$Genus,x$Specific_epithet)
  spptb = as.data.frame(table(sppdf))
  num_spp = length(unique(sppdf))
  sppdf2=lapply(1:num_spp,FUN=function(i){ return(paste(as.character(spptb[i,"sppdf"]),as.character(spptb[i,"Freq"]),collapse="-",sep="-")) })
  
  all_spp = paste(unique(sppdf2),col=";",sep="")
  row = cbind(country,num_rec,num_spp,all_spp)
  
  if(is.null(full)) {
    full = row
  } else {
    full = rbind(full,row)
  }
  
  
  } 
}
#write.table(full,"xc-songs.txt")
#write.table(full,"xc-northamerica-songs.txt")
#full=read.table("~/Dropbox (AMNH)/Dissertation/xc-northamerica-songs.txt")

full = as.data.frame(full)
full$continent = 0

full$continent[which(full$country %in% afr)] = "AFRICA"
full$continent[which(full$country %in% asi)] = "ASIA"
full$continent[which(full$country %in% nam)] = "NORTHAMERICA"
full$continent[which(full$country %in% sam)] = "SOUTHAMERICA"
full$continent[which(full$country %in% eur)] = "EUROPE"
full$continent[which(full$country %in% oce)] = "OCEANIA"

full = full[,c(1:3,5)]
full = unique(full)

#write.table(full,"xc-songs.countries")
#write.table(full,"xc-northamerica-songs.countries")


## test figure 
y = querxc('cnt:"United States"')
#y = fullx
latlong = y[,c(10,9)]
latlong[,1] = as.numeric(latlong[,1])
latlong[,2] = as.numeric(latlong[,2])
latlong=latlong[complete.cases(latlong),]
Env = raster::stack('/Users/kprovost/Dropbox (AMNH)/Dissertation/CHAPTER3_TRAITS/ECOLOGY/enm_layers/bio_2-5m_bil/bio1.bil')
bg = Env[[1]]
ext = raster::extent(c(#min(latlong$Longitude,na.rm = T)-1, 
                       -180,
                       #max(latlong$Longitude,na.rm = T)+1, 
                       -50,
                       #min(latlong$Latitude,na.rm = T)-1,
                       -20,
                       #max(latlong$Latitude,na.rm = T)+1
                       90
                       )
                       )
#bg = raster::crop(bg, ext)
plot(bg)
points(latlong)

library(raster)
library(viridis)
#r <- raster(xmn=0, ymn=0, xmx=10, ymx=10, res=1)
#r[] <- 0
latlongcoor = SpatialPoints(coords = latlong)
bg2 = aggregate(bg,fact=20)
ras = rasterize(latlong, bg2,fun='count',background=10e-1,update=F,na.rm=T)
values(ras) = log(values(ras))
ras[is.na(bg2)] = NA
cuts=c(0,1,2,3,4,5,6,7,8) #set breaks
#png("usasongs.png")
#png("All_XC_songs.png")
par(mar=c(0,0,0,0))
plot(ras,breaks=cuts,col=c("#BBBBBBFF",plasma(7)),main="log USA songs per cell",
     #ylim=c(20,50),xlim=c(-150,-50),
     interpolate=F,bty="n",xaxt="n",yaxt="n",col.axis="white",ann=F
     )
dev.off()





##

namspp=c(773,755,683,607,595,590,549,529,464,457,451,435,428,415,382,380,377,371,370,352,349,342,332,329,322,318,307,306,303,296,287,284,284,278,273,272,267,266,264,260,260,257,253,247,246,244,242,236,235,234,233,233,228,224,223,223,223,220,220,217,216,215,214,214,214,214,212,210,210,209,208,208,208,206,206,206,206,204,203,202,202,200,199,198,198,198,197,196,195,194,193,191,191,189,186,183,181,181,179,178,175,173,173,172,170,170,169,167,166,164,164,164,162,162,162,161,160,159,159,158,158,157,157,157,157,156,156,155,155,155,155,152,152,151,150,150,150,149,148,148,148,148,147,147,146,146,146,146,146,145,145,143,143,143,142,142,141,139,139,138,137,137,137,136,136,136,136,136,135,135,135,135,134,134,133,133,133,133,133,133,132,132,130,130,130,129,129,128,127,126,126,125,125,124,123,123,122,122,120,119,118,118,118,117,117,117,117,116,115,115,115,114,114,114,114,114,113,113,112,112,112,111,110,110,109,109,109,109,108,108,108,107,107,106,106,106,105,104,104,104,103,103,102,102,102,102,102,102,101,101,101,101,100,100,99,99,99,98,98,98,98,98,98,98,98,97,97,97,97,97,97,96,96,95,95,94,94,94,94,92,91,91,91,91,90,90,90,90,89,89,89,88,88,88,88,88,88,88,88,87,87,87,87,87,87,87,87,87,87,86,86,86,85,85,84,84,84,84,84,83,83,83,83,83,82,82,82,81,81,81,80,80,80,80,80,80,80,80,80,79,79,79,79,79,79,78,77,77,77,77,77,77,76,76,76,76,76,75,75,75,75,75,75,75,75,75,74,74,73,73,73,72,72,72,72,72,72,72,72,71,71,71,71,70,70,70,70,69,69,69,69,69,69,69,69,68,68,68,68,
            68,68,67,67,67,67,66,66,66,65,65,65,65,65,65,65,65,65,64,64,64,64,64,64,64,63,63,63,63,63,63,62,62,62,62,62,62,62,62,61,61,61,61,60,60,60,60,60,59,59,59,59,59,58,58,58,58,58,57,57,57,57,57,57,57,57,57,56,56,56,56,56,55,55,55,55,55,55,55,55,54,54,54,54,54,54,54,54,53,53,53,53,53,52,52,52,52,52,52,52,52,52,52,52,52,51,51,51,51,51,50,50,50,50,50,
            50,50,50,50,50,49,49,49,49,49,49,49,49,49,49,49,49,49,49,48,48,48,48,48,48,48,48,48,48,48,48,48,47,47,47,47,47,46,46,46,46,46,46,46,45,45,45,45,45,45,45,45,45,45,45,44,44,44,44,44,44,44,44,44,44,44,43,43,43,43,43,43,43,43,43,42,42,42,42,42,42,42,42,42,42,41,41,41,41,41,40,40,40,40,40,40,40,40,40,40,40,39,39,39,39,39,39,39,39,38,38,38,38,38,38,38,38,38,38,37,37,37,37,37,37,37,37,37,36,36,36,36,36,36,36,36,36,36,36,36,35,35,35,35,35,35,35,35,35,35,35,35,35,35,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,32,32,32,32,32,32,32,32,32,32,32,31,31,31,31,31,31,31,31,31,31,31,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,28,28,28,28,28,28,28,28,28,28,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,26,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,23,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,19,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,17,
            17,17,17,17,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
           
namgenera=c(3793,2609,1881,1582,1353,1197,1191,1139,1127,1123,1068,963,943,942,940,929,846,829,774,758,719,708,689,683,679,665,638,636,625,598,590,572,569,563,562,552,541,541,538,527,509,504,504,500,479,473,464,457,444,436,436,426,423,421,418,415,404,403,400,
            398,391,391,385,382,381,380,370,364,361,344,344,338,327,325,294,294,288,285,279,278,273,268,266,261,257,257,243,237,236,230,229,227,225,223,220,215,214,211,209,209,207,207,203,198,195,195,191,191,191,189,184,183,181,179,177,177,176,176,176,165,164,164,162,162,160,160,159,158,157,157,157,157,156,155,155,152,152,152,151,151,151,150,149,149,148,147,147,146,144,142,140,136,136,135,133,131,126,126,126,124,123,122,122,122,122,120,117,117,116,116,115,114,114,113,112,112,112,112,111,111,110,110,110,109,109,109,108,106,106,105,104,104,103,102,102,102,102,102,101,101,100,100,99,98,98,97,97,95,95,95,95,95,94,94,93,91,91,91,90,89,88,88,87,87,87,86,86,86,85,84,84,83,83,83,82,81,81,81,80,80,80,79,79,79,77,77,76,75,75,75,74,74,74,73,73,70,70,69,69,68,68,68,67,66,
            66,65,65,64,64,63,63,62,62,62,62,61,61,60,60,60,60,59,59,59,59,59,59,59,59,58,58,57,54,54,53,53,53,53,52,52,52,52,52,52,51,51,50,50,50,50,50,50,49,49,49,48,48,48,47,46,46,
            46,46,46,46,45,45,45,45,44,44,43,43,43,43,42,42,41,41,41,41,40,40,40,40,40,40,39,39,39,39,38,38,38,38,38,38,37,37,37,37,36,36,36,36,36,35,35,35,35,35,34,34,34,34,33,33,33,33,33,33,33,33,33,32,32,32,32,32,31,31,31,31,30,30,30,29,29,29,29,29,29,28,28,28,27,27,27,
            27,27,27,27,27,27,27,27,27,27,27,27,26,26,26,26,26,26,25,24,24,24,23,23,23,23,23,23,22,22,22,22,22,22,22,21,21,21,20,20,20,20,20,20,20,20,19,19,19,19,19,19,19,19,19,18,18,18,18,18,18,18,17,17,17,17,17,17,17,17,16,16,16,16,16,16,16,16,16,16,15,15,15,15,15,15,15,14,14,14,14,14,14,13,13,13,13,13,13,13,13,13,12,12,12,12,12,12,12,12,12,12,12,11,11,11,11,11,11,11,11,11,11,11,11,11,10,10,10,10,10,10,10,10,10,10,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,7,7,7,7,7,7,7,7,7,7,7,
            6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,5,5,5,5,5,5,5,5,5,5,5,5,5,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1) 

hist((namspp),lwd=3,breaks=seq(0,4000,50),freq = F,col=rgb(0,0,1,0.3))
hist((namgenera),col=rgb(1,0,0,0.3),lwd=3,lty=3,breaks=seq(0,4000,50),add=T,freq = F)

boxplot(namspp)
