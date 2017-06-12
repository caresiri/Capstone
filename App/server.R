#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

suppressPackageStartupMessages(c(
  library(tm),
  library(shiny),
  library(e1071)))

source("predict.R")
#load("tri_naiveBayes.RData")
load("df_trigram.RData")


shinyServer(function(input, output) {
  
  wordPred <- reactive({
    rawtext <- { input$rawtext }
    CleanText <- CleanText(rawtext)
    wordPred <- WordPrediction(CleanText)})
  
  output$value <- renderPrint(wordPred())

})
