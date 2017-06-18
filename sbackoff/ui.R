
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
setwd("/Users/carlossiri/Documents/Coursera/Capstone")
suppressPackageStartupMessages(c(
  library(tm),
  library(dplyr),
  library(shiny)))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  textInput("rawtext", "Next Word Prediction", "Type text here"),
  verbatimTextOutput("value1"),
  verbatimTextOutput("value2"),
  verbatimTextOutput("value3"),
  verbatimTextOutput("placeholder", placeholder = TRUE))
)


