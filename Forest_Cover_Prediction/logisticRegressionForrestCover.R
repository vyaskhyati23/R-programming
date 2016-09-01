#loading the data
setwd("C:/Users/Khyati/Desktop/Summer'16/Programming Assignments/Assignment 5&6")
cov<-read.csv("covCSV1.csv")

#cov$Cover_Type<-factor(cov$Cover_Type)



#testing and training dataset.
size <- floor(0.70 * nrow(cov))
set.seed(101)
train_ind <- sample(seq_len(nrow(cov)),size = size)
train <- cov[train_ind, ]
test <-cov[-train_ind, ]


#cchoosing the important attributes
model <- glm(train$Cover_Type ~.,data=train)
summary(model)


library(MASS)

#model to fit
fit<-lda(train$Cover_Type ~., data=train)
summary(fit)


#predicting the result using testing data
prediction_cov<-predict(fit,newdata=test[,-56])
confusionMatrix(train$Cover_Type,test$Cover_Type)


par(mfrow=c(3,4))
plot(trainCover$Cover_Type,trainCover$Elevation)
plot(trainCover$Cover_Type,trainCover$ )


