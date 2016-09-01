#Feature selection and analysis using logistic regression and Random forest
#Read the dataset
dataset<-read.csv("NewsPopularity.csv")
#Display the data
View(dataset)
#Remove missing data and infinite data
newdataset<-dataset[complete.cases(dataset), ]
str(newdataset)
newdataset<-na.omit(dataset)
#Eliminate unwanted columns
newdataset$url<- NULL
#Classify the shares attribute data into two classes using 1400 as the threshold
newdataset$shares<-as.factor(ifelse(newdataset$shares<1400,0,1))
View(newdataset)
summary(newdataset)
#Split the data into 80% trainig and 20% testing data
size <- floor(0.80 * nrow(newdataset))
set.seed(101)
train_ind <- sample(seq_len(nrow(newdataset)),size = size)
train <- newdataset[train_ind, ]
test <- newdataset[-train_ind, ]
# using logistic regression to select important features
predictmodel <- glm(shares~.,data = train, family = 'binomial')
summary(predictmodel)
# applying logistic regression on the selected features and finding accuracy
predictmodel <- glm(shares~n_tokens_content+num_hrefs+num_self_hrefs+average_token_length+num_keywords+data_channel_is_entertainment+data_channel_is_socmed+data_channel_is_tech+kw_min_min+kw_max_min+kw_avg_min+kw_min_max+kw_max_max+kw_avg_max+kw_min_avg+kw_max_avg+self_reference_min_shares+weekday_is_monday+weekday_is_tuesday+weekday_is_wednesday+kw_avg_avg+weekday_is_thursday+weekday_is_friday+weekday_is_saturday+weekday_is_sunday+is_weekend+global_subjectivity+global_rate_positive_words+global_rate_negative_words+min_positive_polarity+title_sentiment_polarity+abs_title_subjectivity,data = train, family = 'binomial')
summary(predictmodel)
anova(predictmodel, test="Chisq")
install.packages("pscl")
library("pscl", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
pR2(predictmodel)
#Generate the prediction model to determine the accuracy. Testing on the test dataset
predict1<-predict(predictmodel,test,type='response')
predict1 <- ifelse(predict1 > 0.5,1,0)
misClasificError <- mean(predict1 != test$shares)
print(paste('Accuracy',1-misClasificError))

#RandomForest
install.packages("QuantPsyc")
library("QuantPsyc", lib.loc="~/R/win-library/3.3")
#read the file
mydata <- read.csv("NewsPopularity.csv")
#remove the non predicting parameter
mydatasubset <- subset( mydata, select = -c(url, timedelta ) )
newsclass <-mydatasubset
#Standardize the data
for(i in ncol(newsclass)-1){ 
  newsclass[,i]<-scale(newsclass[,i], center = TRUE, scale = TRUE)
}
#classify the dataset according to mean shares
newsclass$shares <- as.factor(ifelse(newsclass$shares > 1400,1,0))
#Split the data into 60% as training and 40% as testing
ind<-sample(2,nrow(newsclass),replace=TRUE,prob=c(0.7,0.3))
installed.packages("randomForest")
library("randomForest", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
#apply random forest analysis
rf<-randomForest(shares ~.,newsclass[ind==1,],ntree=100,nPerm=10,mtry=3,proximity=TRUE,importance=TRUE)
#plot the error vs. number of trees graph
plot(rf)
#view the important attributes
importance(rf)
varImpPlot(rf)
#predict the outcome on testing dataset
pred<-predict( rf,newsclass[ind==2,], type="class")
library("caret", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
#find the accuracy
confusionMatrix(pred, newsclass[ind==2,]$shares)
