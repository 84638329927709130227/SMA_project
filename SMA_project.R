library(twitteR)
library(ROAuth)
library(plyr)
library(dplyr)
library(stringr)
library(ggplot2)
library(rtweet)
library(SnowballC)
library(tm)
library(syuzhet)
consumer_key <- 'Pi9ALzjZbuysh0qUVRF7in8Ay'
consumer_secret <- 'F5DfSv0Skh9UoEAP2h6w6d4myAnhxNe0tLiD1RdkL8y3rfLnkF'
access_token <- '868879323872219137-rVBaR2tgvQ8rjrET12Mll6uN5W1hD2h'
access_secret <- 'ym7VIFpApeYE7GirEI4IAKIGHjQe5zShNWBeT4RQ7xRCo'

create_token(app = "mytwitterapp", 'Pi9ALzjZbuysh0qUVRF7in8Ay', 'F5DfSv0Skh9UoEAP2h6w6d4myAnhxNe0tLiD1RdkL8y3rfLnkF', '868879323872219137-rVBaR2tgvQ8rjrET12Mll6uN5W1hD2h','ym7VIFpApeYE7GirEI4IAKIGHjQe5zShNWBeT4RQ7xRCo')

tweets <- userTimeline("gautam_adani", n=200)

head(tweets)
library(rtweet)
#get friends (NETWORK)
Friends = get_friends("gautam_adani" , n = 200)
Friends
Followers = get_followers("gautam_adani", n = 200)
Followers


#Retweets (ACTION)
Retweets = get_retweets("1085083959288098816", n = 20)
Retweets
r = Retweets$retweet_count #retweet count
r
#network
rf = Retweets$followers_count #followers count of the retweeters
rf



#Location
RetLocn = Retweets$retweet_location
Loc= Retweets$location
Loc

L = iconv(Loc, to = 'utf-8')



################################################################################

#text analysis
#Cleaning data
tweets.df <- twListToDF(tweets) 

#clean up the characters from text and gives lat and long of the tweets
d=plain_tweets(tweets.df)
str(d)
head(tweets.df)
#remove https , http , and @
tweets.df2 <- gsub("http.*","",tweets.df$text)

tweets.df2 <- gsub("https.*","",tweets.df2)

tweets.df2 <- gsub("#.*","",tweets.df2)

tweets.df2 <- gsub("@.*","",tweets.df2)
corpus <- Corpus(VectorSource(tweets.df2))

corpus <- tm_map(corpus, tolower)
inspect(corpus[1:5])
corpus <- tm_map(corpus, removePunctuation)
inspect(corpus[1:5])
corpus <- tm_map(corpus, removeNumbers)
inspect(corpus[1:5])
cleanset <- tm_map(corpus, removeWords, stopwords('english'))
inspect(cleanset[1:5])
cleanset <- tm_map(cleanset, stripWhitespace)
inspect(cleanset[1:5])
tdm <- TermDocumentMatrix(cleanset)
tdm
tdm <- as.matrix(tdm)
tdm[1:10, 1:20]
distMatrix <- dist(tdm, method = 'euclidean')
head(distMatrix)



#sentiment analysis
library(syuzhet)

senti <- iconv(tweets$text, to = 'utf-8')
# obtain sentiment scores
s <- get_nrc_sentiment(senti)
head(s)









