dataset<-read.csv("OnlineNewsPopularity.csv")
#View(dataset)
newdataset<-dataset[complete.cases(dataset), ]
str(newdataset)
newdataset<-na.omit(dataset)
newdataset$url<- NULL
newdataset$shares<-as.factor(ifelse(newdataset$shares<1400,0,1))
View(newdataset)
summary(newdataset)
size <- floor(0.80 * nrow(newdataset))
set.seed(101)
train_ind <- sample(seq_len(nrow(newdataset)),size = size)
train <- newdataset[train_ind, ]
test <- newdataset[-train_ind, ]
pcacalc <- prcomp(test[ ,2:60],center =TRUE,scale. = TRUE)
print(pcacalc)
plot(pcacalc,type = "l")
summary(pcacalc)
install.packages("devtools")
library("devtools", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
install_github("ggbiplot", "vqv")
library(ggbiplot)
biplotpca<-ggbiplot(pcacalc,obs.scale = 1,var.scale = 1, groups =NULL,ellipse =TRUE,circle = TRUE)
biplotpca<-biplotpca+scale_color_discrete(name ='')
biplotpca<-biplotpca+theme(legend.direction = 'horizontal', legend.position ='top')
print(biplotpca)
biplotpca2<-biplot(pcacalc)

predictmodel <- glm(shares~.,data = train, family = 'binomial')

predictmodel <- glm(shares~n_tokens_content+num_hrefs+num_self_hrefs+average_token_length+num_keywords+data_channel_is_entertainment+data_channel_is_socmed+data_channel_is_tech+kw_min_min+kw_max_min+kw_avg_min+kw_min_max+kw_max_max+kw_avg_max+kw_min_avg+kw_max_avg+self_reference_min_shares+weekday_is_monday+weekday_is_tuesday+weekday_is_wednesday+kw_avg_avg+weekday_is_thursday+weekday_is_friday+weekday_is_saturday+weekday_is_sunday+is_weekend+global_subjectivity+global_rate_positive_words+global_rate_negative_words+min_positive_polarity+title_sentiment_polarity+abs_title_subjectivity,data = train, family = 'binomial')
predictmodel <- glm(shares~n_tokens_title+num_hrefs+num_imgs+num_videos+average_token_length+num_keywords+data_channel_is_entertainment+data_channel_is_world+weekday_is_saturday+weekday_is_sunday+is_weekend+LDA_02+LDA_01+LDA_03+global_subjectivity+min_negative_polarity+title_subjectivity+abs_title_sentiment_polarity,data = train, family = 'binomial') # 62.7

predictmodel <- glm(shares~n_tokens_title+n_unique_tokens+num_hrefs+num_imgs+num_videos+average_token_length+num_keywords+data_channel_is_entertainment+data_channel_is_world+kw_avg_avg+weekday_is_thursday+weekday_is_saturday+weekday_is_sunday+is_weekend+LDA_02+LDA_01+LDA_03+global_subjectivity+avg_negative_polarity+min_negative_polarity+title_subjectivity+abs_title_sentiment_polarity,data = train, family = 'binomial') # 63.
summary(predictmodel)

anova(predictmodel, test="Chisq")
install.packages("pscl")
library("pscl", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
pR2(predictmodel)
predict1<-predict(predictmodel,test,type='response')
predict1 <- ifelse(predict1 > 0.5,1,0)

misClasificError <- mean(predict1 != test$shares)
print(paste('Accuracy',1-misClasificError))

