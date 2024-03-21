library(tidytext)
library(janeaustenr)
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(wordcloud)
library(reshape2)

setwd('C:/Users/nicol/OneDrive/Augustana College/3 year/Spring term/DATA 332/Data')
Complaints <- read.csv('Consumer_Complaints.csv')

get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")

Complaints<- Complaints() %>%
  group_by(product) %>%
  mutate(
    linenumber = row_number(),
    chapter = cumsum(str_detect(text, 
                                regex("^chapter [\\divxlc]", 
                                      ignore_case = TRUE)))) %>%
  ungroup() %>%
  unnest_tokens(word, text)


##1

#This will transform your text data into a tidy format where each word is in its own row along with its corresponding line number from the original dataset.
tidy_complaints <- Complaints %>%
  mutate(linenumber = row_number()) %>%  #Assuming each row is a separate line/narrative
  unnest_tokens(word, Consumer.complaint.narrative)  #Unnest tokens on the narrative


#proceed with sentiment analysis by joining this with a sentiment lexicon
#Get the sentiment from the Bing lexicon
bing_sentiments <- get_sentiments("bing")

#Here I am joining with the tidy data to get the sentiment of each word
tidy_complaints_with_sentiment <- tidy_complaints %>%
  inner_join(bing_sentiments, by = "word")




##2 Now let's do sentiment analysis but with NRC lexicon 

nrc_sentiments <- get_sentiments("nrc")

# Join with the tidy data to get the sentiment of each word
tidy_complaints_with_sentiment <- tidy_complaints %>%
  inner_join(nrc_sentiments, by = "word")

##Graph 1: Sentiment count

  #Count the number of each sentiment
  sentiment_count <- tidy_complaints_with_sentiment %>%
    count(sentiment, sort = TRUE)
  
  #Bar plot of sentiment counts
  ggplot(sentiment_count, aes(x = sentiment, y = n, fill = sentiment)) +
    geom_col(show.legend = FALSE) +
    xlab("Sentiment") +
    ylab("Count") +
    ggtitle("Sentiment Counts from Consumer Complaints") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  
##Graph 2: Wordcloud for Positive and Negative Sentiments
  
  #Let's filter for positive sentiments
  positive_words <- tidy_complaints_with_sentiment %>%
    filter(sentiment == "positive") %>%
    count(word, sort = TRUE)
  
  #Let's filter for negative sentiments
  negative_words <- tidy_complaints_with_sentiment %>%
    filter(sentiment == "negative") %>%
    count(word, sort = TRUE)  

  #Creating a wordcloud for positive sentiment words
  wordcloud(words = positive_words$word, freq = positive_words$n, max.words = 100, colors = "blue")
  
  #Creating a wordcloud for negative sentiment words
  wordcloud(words = negative_words$word, freq = negative_words$n, max.words = 100, colors = "red")  
  
