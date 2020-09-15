auratus=read.table("/Users/kprovost/Downloads/OccurrenceDatabase_Colaptes auratus_auratus chrysocaulosus gundlachi luteus.occ",
                   sep="\t",header=T)
auratus = auratus[auratus$subspecies %in% c("auratus","chrysocaulosus","gundlachi","luteus"),]
cafer=read.table("/Users/kprovost/Downloads/OccurrenceDatabase_Colaptes cafer_cafer collaris mexicanus nanus rufipileus.occ",
                 sep="\t",header=T)
cafer = cafer[cafer$subspecies %in% c("cafer","collaris","mexicanus","nanus","rufipileus"),]
chrysoides=read.table("/Users/kprovost/Downloads/OccurrenceDatabase_Colaptes chrysoides_brunnescens chrysoides mearnsi tenebrosus.occ",
                      sep="\t",header=T)
chrysoides = chrysoides[chrysoides$subspecies %in% c("brunnescens","chrysoides","mearnsi","tenebrosus"),]

plot(auratus$longitude,auratus$latitude,col=as.numeric(as.factor(auratus$subspecies)))
plot(cafer$longitude,cafer$latitude,col=as.numeric(as.factor(cafer$subspecies)))
plot(chrysoides$longitude,chrysoides$latitude,col=as.numeric(as.factor(chrysoides$subspecies)))
