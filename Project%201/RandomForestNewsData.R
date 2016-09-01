library(randomForest)
library(QuantPsyc)
mydata <- read.csv("OnlineNewsPopularity.csv")
ind<-sample(2,nrow(mydata),replace=TRUE,prob=c(0.7,0.3))
mydatasubset <- subset( mydata, select = -c(url, timedelta ) )
split<-sample(2,nrow(newsDataC),replace=TRUE,prob=c(0.7,0.3))
newsclass <-mydatasubset
newsclass$shares <- as.factor(ifelse(newsclass$shares > 1400,1,0))
rf<-randomForest(shares ~.,newsclass[ind==1,],ntree=100,nPerm=10,mtry=3,proximity=TRUE,importance=TRUE)
plot(rf)
importance(rf)
varImpPlot(rf)
pred<-predict( rf,newsclass[ind==2,], type="class")
confusionMatrix(pred, newsclass[ind==2,]$shares)


