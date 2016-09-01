dataset<-read.csv("NewsPopularity.csv")
newdataset<-dataset[complete.cases(dataset), ]
str(newdataset)
newdataset<-na.omit(dataset)
newdataset$url<- NULL
newdataset$shares<-as.factor(ifelse(newdataset$shares<1400,0,1))
size <- floor(0.80 * nrow(newdataset))
set.seed(101)
train_ind <- sample(seq_len(nrow(newdataset)),size = size)
train <- newdataset[train_ind, ]
test <- newdataset[-train_ind, ]
library(C50)
newsDataC50<-C5.0(shares ~.,data = train,trials=3)
summary(newsDataC50)

library("pscl", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
pR2(newsDataC50)
predict1<-predict(newsDataC50,test,type='prob')
predict1 <- ifelse(predict1 > 0.5,1,0)

misClasificError <- mean(predict1 != test$shares)
print(paste('Accuracy',1-misClasificError))
