#R Script file for Lab 2
sink("lab2output.txt", split=TRUE)
source("http://www.openintro.org/stat/data/cdc.R")
names(cdc)
bmi <- (cdc$weight / cdc$height^2) * 703
summary(bmi)
#hist(bmi)
#hist(bmi, breaks=40)
#hist(bmi, breaks=40, xlim=c(10,80))
#hist(bmi, breaks=40, xlim=c(10,80), ylim=c(0,5000))
#hist(bmi, breaks=40, xlim=c(10,80), ylim=c(0,5000), col="#000066")
#hist(bmi, breaks=40, xlim=c(10,80), ylim=c(0,5000), col="#000066", main="Distribution of People by Body Mass Index (BMI)")
hist(bmi, breaks=40, xlim=c(10,80), ylim=c(0,5000), col="#000066", main="Distribution of People by Body Mass Index (BMI)", xlab="Body Mass Index (BMI)")
table(cdc$smoke100)
smokers <- subset(cdc, smoke100==1)
bmi.s <- (smokers$weight / smokers$height^2) * 703
hist(bmi.s, breaks=40,xlim=c(10,80), ylim=c(0,2500), col="#000066", main="Distribution of Smokers by Body Mass Index (BMI)", xlab="Body Mass Index (BMI)")
nonsmokers <- subset(cdc, smoke100==0)
bmi.s <- (nonsmokers$weight / nonsmokers$height^2) * 703
#hist(bmi.s, breaks=40,xlim=c(10,80), ylim=c(0,2500), col="#000066", main="Distribution of Non-Smokers by Body Mass Index (BMI)", xlab="Body Mass Index (BMI)")
hist(bmi.s, breaks=20,xlim=c(10,80), ylim=c(0,2500), col="#000066", main="Distribution of Non-Smokers by Body Mass Index (BMI)", xlab="Body Mass Index (BMI)")
sink()