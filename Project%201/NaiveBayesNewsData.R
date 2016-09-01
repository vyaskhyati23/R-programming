install.packages("e1071")
install.packages("class")
install.packages("mlbench")
mydata<- read.csv("OnlineNewsPopularity.csv")
news <- subset(mydata, select = -c(url, timedelta))
newsclass <-news
newsclass$shares <- as.factor(ifelse(newsclass$shares>1400,1,0))
size <- floor(0.60* nrow(newsclass))
set.seed(101)
train_index <- sample(seq_len(nrow(newsclass)), size = size)
train_Data <- newsclass[train_index, ]
test <- newsclass[-train_index, ]
model1 <- naiveBayes(shares~., data = train_Data)


predict2 <- predict(model1,test[,-1])
table(pred=predict2,true=test$shares)
mean(predict2==test$shares)
