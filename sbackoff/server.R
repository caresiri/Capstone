
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#setwd("/Users/carlossiri/Documents/Coursera/Capstone")
suppressPackageStartupMessages(c(
  library(tm),
  library(dplyr),
  library(shiny)))

#unigram_levels <- readRDS("unigram_levels.rds")
#model <- readRDS("tri_naiveBayes.rds")
data_unigram <- readRDS("df_unigram.rds")
data_bigram <- readRDS("df_bigram.rds")
data_trigram <- readRDS("df_trigram.rds")
source("SBackoff.R")
#load('SBackoff.RData')
#load("df_trigram.RData")


shinyServer(function(input, output) {
  wordPred <- reactive({
    rawtext <- { input$rawtext }
  #  CleanText <- CleanText(rawtext)
   # wordPred <- WordPrediction(CleanText)
    wordPred <- predict0(rawtext, f_unigram = data_unigram, df_bigram = data_bigram, df_trigram = data_trigram)})
  
  output$placeholder <- renderText({ input$txt })
  output$value1 <- renderPrint(wordPred()[1])
  output$value2 <- renderPrint(wordPred()[2])
  output$value3 <- renderPrint(wordPred()[3])
  
})
