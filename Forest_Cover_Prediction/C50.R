
library(C50)
library(QuantPsyc)
library(randomForest) 

#loading the data
setwd("C:/Users/Khyati/Desktop/Summer'16/Programming Assignments/Assignment 5&6")
cov<-read.csv("covCSV.csv")
cov$Cover_Type<-factor(cov$Cover_Type)


## 75% of the sample size
smp_size <- floor(0.30* nrow(cov))

## set the seed to make your partition reproductible
set.seed(123)
train_ind <- sample(seq_len(nrow(cov)), size = smp_size)

train <- cov[train_ind, ]
#test <- cov[-train_ind, ]


#Applying C5.0 algorithm to the data.
covC50<-C5.0(train[-56],train$Cover_Type,trials=5)
summary(covC50)


