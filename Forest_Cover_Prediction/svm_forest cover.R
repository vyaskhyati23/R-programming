#loading the data
setwd("C:/Users/Khyati/Desktop/Summer'16/Programming Assignments/Assignment 5&6")
cov<-read.csv("coverTrain.csv")

library("e1071")


svm_model <- svm(coverTrain$Cover_Type~. , data=cov)
summary(svm_model)

#svm_model1 <- svm(x,y)
#summary(svm_model1)

#pred <- predict(svm_model1,x)
#system.time(pred <- predict(svm_model1,x))


#table(pred,y)

#svm_tune <- tune(svm, train.x=x, train.y=y, kernel="radial", ranges=list(cost=10^(-1:2), gamma=c(.5,1,2)))

#print(svm_tune)

#svm_model_after_tune <- svm(Species ~ ., data=iris, kernel="radial", cost=1, gamma=0.5)
#summary(svm_model_after_tune)

#pred <- predict(svm_model_after_tune,x)
#system.time(predict(svm_model_after_tune,x))
#table(pred,y)

 
