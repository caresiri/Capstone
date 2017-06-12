#
# This is a Shiny web application. You can run the application by clicking # the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
suppressPackageStartupMessages(c(
  library(tm),
  library(shiny),
  library(e1071)))


# User Interface
ui <- fluidPage(
  textInput("rawtext", "RawText", "Data Summary"),
  verbatimTextOutput("value"))


# Server

source("predict.R")
load("tri_naiveBayes.RData")
#load("df_trigram.RData")

server <- function(input, output) {

  wordPred <- reactive({
    rawtext <- { input$rawtext }
    CleanText <- CleanText(rawtext)
    wordPred <- WordPrediction(CleanText)})

  output$value <- renderPrint(wordPred())

}
# Run the application
shinyApp(ui = ui, server = server)
#shinyApp(ui = ui, server = server, enableBookmarking = "server")

