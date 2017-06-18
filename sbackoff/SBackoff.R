load('sbackoff.RData')


predict0 <-function(rawtext,df_unigram,df_bigram,df_trigram) {
  sw <- stopwords(kind = "en")
  rawtext <- removePunctuation(rawtext)
  rawtext <- removeNumbers(rawtext)
  rawtext <- rev(unlist(strsplit(rawtext," ")))
  rawtext <- setdiff(rawtext,sw)
  rawtext <- rawtext[grepl('[[:alpha:]]',rawtext)]
  rawtext <- paste(rawtext[2],rawtext[1],sep = ' ')
  rawtext <- tolower(rawtext) 
  if(rawtext == ''|rawtext == "na na") return('Warning: Just input something')
  
  
  seektri <- grepl(paste0("^",rawtext,"$"), df_trigram$bigram)
  subtri<- df_trigram[seektri,]
  input2 <- unlist(strsplit(rawtext," "))[2]
  seekbi <- grepl(paste0("^",input2,"$"),df_bigram$unigram)
  subbi <- df_bigram[seekbi,]
  df_unigram <- mutate(df_unigram, fracfreq = freq/nrow(df_unigram)*.16)
  useuni <- df_unigram[order(df_unigram$fracfreq,decreasing = T),]
  useunia <- useuni[1:3,]
  
  
  if (sum(seektri) == 0) {
    if(sum(seekbi)==0){
      return(head(df_unigram[order(df_unigram$freq,decreasing = T),1],
                  3))
    }
    subbi$s <- 0.4*subbi$freq/sum(seekbi)
    names <- c(subbi$name,useunia$unigram)
    score <- c(subbi$s,useunia$fracfreq)
    predictWord <- data.frame(next_word=names,score=score,stringsAsFactors = F)
    predictWord <- predictWord[order(predictWord$score,decreasing = T),]
    # in case replicated
    final <- unique(predictWord$next_word)
    #final <- setdiff(final,badwords)
    final <- final[grepl('[[:alpha:]]',final)]
    return(final[1:3])
  } 
  subbi$s <- 0.4*subbi$freq/sum(seekbi)
  subtri$s <- subtri$freq/sum(subtri$freq)
  names <- c(subtri$name,subbi$name,useunia$unigram)
  score <- c(subtri$s,subbi$s,useunia$fracfreq)
  predictWord <- data.frame(next_word=names,score=score,stringsAsFactors = F)
  predictWord <- predictWord[order(predictWord$score,decreasing = T),]
  # in case replicated
  final <- unique(predictWord$next_word)
  final <- final[1:3]
  #final <- setdiff(final,badwords)
  final <- final[grepl('[[:alpha:]]',final)]        
  return(final)
}

#predict0(rawtext, df_unigram = df_unigram, df_bigram = df_bigram, df_trigram = df_trigram)
