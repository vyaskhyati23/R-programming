
setwd("C:/Users/Khyati/Desktop/Summer'16/Project/OnlineNewsPopularity")
newsData<-read.csv("OnlineNewsPopularity.csv")

par(mfrow=c(4,2))
boxplot(newsData$shares ~ newsData$weekday_is_monday , data=newsData,main="published on Monday" )
boxplot(newsData$shares ~ newsData$weekday_is_tuesday , data=newsData,main="published on Tuesday" )
boxplot(newsData$shares ~ newsData$weekday_is_wednesday , data=newsData,main="published on Wednesday" )
boxplot(newsData$shares ~ newsData$weekday_is_thursday , data=newsData,main="published on Thursday" )

boxplot(newsData$shares ~ newsData$weekday_is_friday , data=newsData,main="published on Friday" )

boxplot(newsData$shares ~ newsData$weekday_is_saturday , data=newsData,main="published on Saturday" )
boxplot(newsData$shares ~ newsData$weekday_is_sunday , data=newsData,main="published on Sunday" )
boxplot(newsData$shares ~ newsData$is_weekend , data=newsData,main="published on weekend" )








