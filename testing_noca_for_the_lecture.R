file="/Users/kprovost/Documents/Github/whole_genome_pipeline/BAM Creation/Parrots/testnoca.txt"
df=read.table(file,sep="\t",header=T)

son = df[df$Desert.Population.Tested=="Sonoran Desert",]
chi = df[df$Desert.Population.Tested=="Chihuahuan Desert",]

table(son[,c("Distance.to.Speaker.Before.Trial","Song.Type.Played")])


par(mfrow=c(1,2))
boxplot(son$Distance.to.Speaker.Before.Trial~son$Song.Type.Played,ylim=c(0,24))
boxplot(son$Distance.to.Speaker.After.Trial ~son$Song.Type.Played,ylim=c(0,24))

boxplot(chi$Distance.to.Speaker.Before.Trial~chi$Song.Type.Played,ylim=c(0,24))
boxplot(chi$Distance.to.Speaker.After.Trial ~chi$Song.Type.Played,ylim=c(0,24))

boxplot(son$Attacks.on.Speaker.Before.Trial~son$Song.Type.Played,ylim=c(0,24))
boxplot(son$Attacks.on.Speaker.After.Trial ~son$Song.Type.Played,ylim=c(0,24))

boxplot(chi$Attacks.on.Speaker.Before.Trial~chi$Song.Type.Played,ylim=c(0,24))
boxplot(chi$Attacks.on.Speaker.After.Trial ~chi$Song.Type.Played,ylim=c(0,24))

boxplot(son$Songs.Sung.Before.Trial~son$Song.Type.Played,ylim=c(0,52))
boxplot(son$Songs.Sung.After.Trial ~son$Song.Type.Played,ylim=c(0,52))

boxplot(chi$Songs.Sung.Before.Trial~chi$Song.Type.Played,ylim=c(0,52))
boxplot(chi$Songs.Sung.After.Trial ~chi$Song.Type.Played,ylim=c(0,52))

boxplot(son$Aggression.Index.Before.Trial~son$Song.Type.Played,ylim=c(-1.2,6.6))
boxplot(son$Aggression.Index.After.Trial ~son$Song.Type.Played,ylim=c(-1.2,6.6))

boxplot(chi$Aggression.Index.Before.Trial~chi$Song.Type.Played,ylim=c(-1.2,6.6))
boxplot(chi$Aggression.Index.After.Trial ~chi$Song.Type.Played,ylim=c(-1.2,6.6))
