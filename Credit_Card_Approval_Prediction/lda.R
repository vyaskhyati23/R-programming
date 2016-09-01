setwd("C:/Users/Khyati/Desktop/Summer'16/Programming Assignments/Assignment 3&4")

library(caret)

dataset<-read.csv("label_card_data.csv")
#View(dataset)
newdataset<-dataset[complete.cases(dataset), ]
str(newdataset)
newdataset<-na.omit(dataset)
#summary(newdataset)
d1 <- model.matrix(~ A1 -1, data = newdataset)
d4 <- model.matrix(~ A4 -1, data = newdataset)
d5 <- model.matrix(~ A5 -1, data = newdataset)
d6 <- model.matrix(~ A6 -1, data = newdataset)
d7 <- model.matrix(~ A7 -1, data = newdataset)
d9 <- model.matrix(~ A9 -1, data = newdataset)
d10 <- model.matrix(~ A10 -1, data = newdataset)
d12 <- model.matrix(~ A12 -1, data = newdataset)
d13 <- model.matrix(~ A13 -1, data = newdataset)

#cchoosing the important attributes
pcadata<-data.frame(d1,newdataset$A2,newdataset$A3,d4,d5,d6,d7,newdataset$A8,d9,d10,newdataset$A11,d12,d13,newdataset$A14,newdataset$A15,newdataset$A16)

#testing and training dataset.
size <- floor(0.70 * nrow(pcadata))
set.seed(101)
train_ind <- sample(seq_len(nrow(pcadata)),size = size)
train <- pcadata[train_ind, ]
test <-pcadata[-train_ind, ]


library(MASS)

#model to fit
fit<-lda(newdataset$A16~., data=train)
summary(fit)

#predicting the result using testing data
prediction<-predict(fit,test)$class
table_predict<-table(prediction,test$newdataset.A16)

library(caret)
#confusion matrix
confusionMatrix(table_predict)
