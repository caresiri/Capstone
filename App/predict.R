library(e1071)
library(tm)
library(rdrop2)
#setwd("/Users/carlossiri/Documents/Coursera/Capstone")

#load("df_trigram.RData")

#tri_naiveBayes <- naiveBayes(Y ~ X1 + X2 , df_trigram)


load("tri_naiveBayes.RData")

CleanText <- function(rawtext){
CleanText <- tolower(rawtext)
CleanText <- removePunctuation(CleanText)
CleanText <- removeNumbers(CleanText)
CleanText <- stripWhitespace(CleanText)
#inputstring <- removeWords(inputstring, stopwords("SMART"))
#inputstring <- stemDocument(inputstring)
CleanText <- removeWords(CleanText, 'na')
CleanText <- stripWhitespace(CleanText)

return(CleanText)
}


WordPrediction <- function(CleanText) {
  
test_split <- strsplit(CleanText, split=" ")
test_factor <- factor(unlist(test_split), levels=unigram_levels)
test_factor <- test_factor[!is.na(test_factor)]
test_factor <- tail(test_factor, n=2)
test_df <- data.frame(X1 = test_factor[1], X2 = test_factor[2])
#estimate using the model
wordPred<- as.character(predict(tri_naiveBayes,test_df))

print(wordPred)
}
