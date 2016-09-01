#install.packages("Boruta")
library(Boruta)

setwd("C:/Users/Khyati/Desktop/Summer'16/Programming Assignments/Assignment 3&4")

#read the data into csv files.
card_data<-read.csv("card_Data.txt")

#renaming the column names for convinience
names(card_data)<-c("A1","A2","A3","A4","A5","A6","A7","A8","A9","A10","A11","A12","A13","A14","A15","A16")
write.csv(card_data,file="label_card_data.csv")
label_card_data<-read.csv("label_card_data.csv")

#replacing missing values(?) with NA.
str(label_card_data)
label_card_data[label_card_data=="?"]<-NA
write.csv(label_card_data,file="cleared_train_data.csv")
summary(label_card_data)

#removing the rows containing missing data.
label_card_data<-label_card_data[complete.cases(label_card_data),]

#converting the categorical data into factors data type.
convert<-c(2,5:8,10:11,13:14,17)
label_card_data[,convert]<-data.frame(apply(label_card_data[convert],2,as.factor))

#testing Boruta for feature selection.
set.seed(123)
#boruta_features<-Boruta(label_card_data$A16~.-label_card_data$X,data=label_card_data,doTrace=2,getImp = getImpRfZ)

boruta_features<-Boruta(label_card_data$A16~.,data=label_card_data,doTrace=2,getImp = getImpRfZ)
print(boruta_features)

#testing tentaive features for selection.
final<-TentativeRoughFix(boruta_features)
print(final)

#printing final results.
getSelectedAttributes(final,withTentative = F)
final_Dataframe<-attStats(final)
class(final_Dataframe)
print(final_Dataframe)

library(MASS)
#fit model

fit<-lda(label_card_data$A16~label_card_data$A2+label_card_data$A3+label_card_data$A4+label_card_data$A5+label_card_data$A6+label_card_data$A7+label_card_data$A8+label_card_data$A8+label_card_data$A10+label_card_data$A11+label_card_data$A14+label_card_data$A15,data=label_card_data)

#summarize
summary(fit)


