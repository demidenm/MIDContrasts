rm(list=ls())
# This script makes forest plots for the MID task
# relationships with phenotypic covariates

# load data
sum.dat<-read.csv("pheno_bayes_cor.csv")

# replace name of first variable for consisitency with the rest 
sum.dat$ROI<-as.character(sum.dat$ROI)
sum.dat[sum.dat$ROI=="ACC1","ROI"]<-"ACC.1"


# RE-ORDER FOR NEW PLOTS
# seperate bilateral regions

order.vec<-c(sum.dat$ROI[1:20],
             sum.dat$ROI[seq(21,39,2)],
             sum.dat$ROI[seq(22,40,2)],
             sum.dat$ROI[seq(41,59,2)],
             sum.dat$ROI[seq(42,60,2)],
             sum.dat$ROI[seq(61,79,2)],
             sum.dat$ROI[seq(62,80,2)])

sum.dat.o<-sum.dat
sum.dat.o$ROI<-as.character(sum.dat.o$ROI)
sum.dat.o$ROI<-rep(order.vec,5)
sum.dat.o$ROI<-as.character(sum.dat.o$ROI)

for (r in unique(sum.dat.o$ROI)){
  for(p in sum.dat.o$Pheno){
  sum.dat.o[sum.dat.o$ROI==r & sum.dat.o$Pheno==p,3:5]<-sum.dat[sum.dat$ROI==r & sum.dat$Pheno==p,3:5]
}}



jpeg(filename = "MID_forest_plot2.jpg",width = 14,height = 7,
     units = "in",res = 600)

par(mfrow=c(1,5))

for (p in unique(sum.dat.o$Pheno)){

tmp.dat<-sum.dat.o[sum.dat.o$Pheno==p,]

#plot skeleton and initial parameters
plot(tmp.dat$Med.r,80:1,yaxt='n',xlim=c(-.6,.6),ylim=c(3,78),
     ylab="",xlab=expression(paste("Effect Size (",italic("r"),")",sep="")),
     pch=18,cex=1.2,main=p,cex.main=1.5,cex.lab=1.5)
abline(v=0,col="black",lty=1,lwd=1.5)
abline(v=.10,col="red",lty=1,lwd=1.5)
abline(v=-.10,col="red",lty=1,lwd=1.5)
abline(v=.30,col="blue",lty=1,lwd=1.5)
abline(v=-.30,col="blue",lty=1,lwd=1.5)
abline(v=.50,col="green",lty=1,lwd=1.5)
abline(v=-.50,col="green",lty=1,lwd=1.5)
abline(h=10.5,col="black",lty=2)
abline(h=20.5,col="black",lty=2)
abline(h=30.5,col="black",lty=2)
abline(h=40.5,col="black",lty=2)
abline(h=50.5,col="black",lty=2)
abline(h=60.5,col="black",lty=2)
abline(h=70.5,col="black",lty=2)
# ROI labels
mtext('ACC', side=2, line=2, font=2, at=75)
mtext('vmPFC', side=2, line=2, font=2, at=65)
mtext('L Ins', side=2, line=2, font=2, at=55)
mtext('R Ins', side=2, line=2, font=2, at=45)
mtext('L OFC', side=2, line=2, font=2, at=35)
mtext('R OFC', side=2, line=2, font=2, at=25)
mtext('L VS', side=2, line=2, font=2, at=15)
mtext('R VS', side=2, line=2, font=2, at=5)
#labels
axis(2, at=80:1, rep(1:10,8),las=1,cex.axis=.6)
#points above reference lines
points(tmp.dat$Med.r,80:1,yaxt='n',xlim=c(-.6,.6),
     ylab="",xlab=expression(paste("Effect Size (",italic("r"),")",sep="")),
     pch=18,cex=1.2)
# add error bars
for (r in 1:length(tmp.dat$Med.r)){
  lines(tmp.dat[r,4:5],rep(81-r,2),lwd=2)}

}

dev.off()

