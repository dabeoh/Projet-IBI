#R script pour faire des distributions
#!/usr/bin/env Rscript
library(lattice)

# LECTURE DU FICHIER
annot.file = "myfile"
annotations = read.table(annot.file, h=TRUE,na.strings=".")

# INITIALISATION DES SEUILS
lim.QD = 2
lim.FS = 60
lim.MQ = 50
lim.MQRankSum = -2.5
lim.ReadPosRankSum = -8.0
lim.SOR = 3.0

# CREATION DES FIGURES
pdf(paste(annot.file,"Filtres.pdf",sep="_"))
## FIGURE DE QD
  prop.QD=length( which(annotations$QD >lim.QD)) / nrow(annotations)
  plot(density(annotations$QD,na.rm=T),main="QD", sub = paste("Filtre: QD >",lim.QD,"( = ", signif(prop.QD,3),"% des SNP) " ,sep="") ) 
  abline(v=lim.QD, col="red")

dev.off()

# DIAGRAMME DE VENN
qd.pass = which(annotations$QD>lim.QD)
fs.pass = which(annotations$FS>lim.FS)
sor.pass = which(annotations$SOR > lim.SOR)
mq.pass = which(annotations$MQ < lim.MQ)
mqrs.pass= which(annotations$MQRankSum < lim.MQRankSum)
rprs.pass= which(annotations$ReadPosRankSum < lim.ReadPosRankSum)

venn.diagram(
  x=list(qd.pass, fs.pass,mq.pass,sor.pass,mqrs.pqss,rprs.pass),
  category.names = c("QD" , "FS" , "MQ", "SOR","MQRanksSum", "ReadPosRankSum"),
  fill = c("blue","darkgreen","orange","yellow","red","purple"),
  output=TRUE,
  filename = "MondiagrammedeVenn"
  )


