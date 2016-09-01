dataset<-read.csv("covtype.csv")
summary(dataset)
View(dataset)
newdataset<-dataset[complete.cases(dataset), ]
str(newdataset)
newdataset<-na.omit(dataset)
size <- floor(0.70 * nrow(newdataset))
set.seed(101)
train_ind <- sample(seq_len(nrow(newdataset)),size = size)
train <- newdataset[train_ind, ]
test <- newdataset[-train_ind, ]

predictmodel <- glm(X5~.,data = train)
summary(predictmodel)
predict1<-predict(predictmodel,test)

postResample(predict1, test$X5)


