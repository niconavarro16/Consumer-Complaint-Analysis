# Consumer-Complaint-Analysis
In this project I used a sentiment analysis on consumer complaints.

###Data Tidying
The first step to do was to get the data tidy so it was easier to analyze, and these were the steps:

1.Tokens: splitting the teext into individual words
2.Line Numbers: assigning a unique line number to each complaint narrative to keep track of the text's location


###Sentiment Analysis
For this analysis, bing and nrc lexicons were specifically used to classify words into different emotions.
1.Bing lexicon: I joined the tokenized words with the bing lexicon because it classifies words into positive and negative sentiments 
2.Nrc lexicon: I joined the tokenized words with the nrc lexicon because it includes a range of emotions.

###Graphs
1.Sentiment counts from consumer complaints
