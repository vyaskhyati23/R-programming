library(caret)
#loading the data
setwd("C:/Users/Khyati/Desktop/Summer'16/Programming Assignments/Assignment 5&6")
cov<-read.csv("covCSV.csv")


Train <- createDataPartition(cov$Cover_Type, p=0.6, list=FALSE)
training <- cov[ Train, ]
testing <- cov[ -Train, ]

mod_fit <- train(Cover_Type~.,  data=training, method="glm", family="binomial")
predict(mod_fit, newdata=testing)
predict(mod_fit, newdata=testing, type="prob")

mod_fit_one <- glm(Cover_Type~., data=training, family="binomial")
library(pscl)
pR2(mod_fit_one)

print("THIS ENDS HERE !!!!!!!!")


library(MKmisc)
HLgof.test(fit = fitted(mod_fit_one), obs = training$Class)

print("THIS ENDS HERE !!!!!!!!")


library(ResourceSelection)
hoslem.test(training$Class, fitted(mod_fit_one), g=10)

print("THIS ENDS HERE !!!!!!!!")
