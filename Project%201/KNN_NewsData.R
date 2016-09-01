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
#Apply KNN function to calculate accuracy
knn<- knn3(shares~.,train)
#57.04% Accuracy
knn<- knn3(shares~n_tokens_content+num_hrefs+num_self_hrefs+average_token_length+num_keywords+data_channel_is_entertainment+data_channel_is_socmed+data_channel_is_tech+kw_min_min+kw_max_min+kw_avg_min+kw_min_max+kw_max_max+kw_avg_max+kw_min_avg+kw_max_avg+self_reference_min_shares+weekday_is_monday+weekday_is_tuesday+weekday_is_wednesday+kw_avg_avg+weekday_is_thursday+weekday_is_friday+weekday_is_saturday+weekday_is_sunday+is_weekend+global_subjectivity+global_rate_positive_words+global_rate_negative_words+min_positive_polarity+title_sentiment_polarity+abs_title_subjectivity,train)
#57.67% Accuracy
knn<- knn3(shares~n_tokens_title+num_hrefs+num_imgs+num_videos+average_token_length+num_keywords+data_channel_is_entertainment+data_channel_is_world+weekday_is_saturday+weekday_is_sunday+is_weekend+LDA_02+LDA_01+LDA_03+global_subjectivity+min_negative_polarity+title_subjectivity+abs_title_sentiment_polarity,train)
#58.34% Accuracy
knn<- knn3(shares~n_tokens_content+num_hrefs+num_self_hrefs+average_token_length+num_keywords+data_channel_is_entertainment+data_channel_is_socmed+data_channel_is_tech+kw_min_min+kw_min_avg+kw_max_avg+self_reference_min_shares+weekday_is_monday+weekday_is_tuesday+weekday_is_wednesday+kw_avg_avg+weekday_is_thursday+weekday_is_friday+weekday_is_saturday+global_subjectivity+global_rate_negative_words+min_positive_polarity+title_sentiment_polarity+weekday_is_sunday+is_weekend+kw_max_max+kw_min_max+abs_title_subjectivity,train)
#58.36% Accuracy
knn<- knn3(shares~n_tokens_content+num_hrefs+num_self_hrefs+average_token_length+num_keywords+data_channel_is_entertainment+data_channel_is_socmed+data_channel_is_tech+kw_min_min+kw_min_avg+kw_max_avg+self_reference_min_shares+weekday_is_monday+weekday_is_tuesday+weekday_is_wednesday+kw_avg_avg+weekday_is_thursday+weekday_is_friday+weekday_is_saturday+global_subjectivity+global_rate_negative_words+min_positive_polarity+title_sentiment_polarity+weekday_is_sunday+is_weekend+kw_max_max+kw_min_max,train)
#58.42% Accuracy
knn<- knn3(shares~n_tokens_content+num_hrefs+num_self_hrefs+average_token_length+num_keywords+data_channel_is_entertainment+data_channel_is_socmed+data_channel_is_tech+kw_min_min+kw_min_avg+kw_max_avg+self_reference_min_shares+weekday_is_monday+weekday_is_tuesday+weekday_is_wednesday+kw_avg_avg+weekday_is_thursday+weekday_is_friday+weekday_is_saturday+global_subjectivity+global_rate_negative_words+min_positive_polarity+title_sentiment_polarity+weekday_is_sunday+is_weekend+kw_max_max,train)
predict1 <-predict(knn,test,type="class")
# plot the confusion matrix to discover the error rate
confusionMatrix(predict1,test$shares)
