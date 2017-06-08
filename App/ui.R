#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

suppressPackageStartupMessages(c(
  library(tm),
  library(shiny),
  library(e1071)))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  textInput("rawtext", "RawText", "Data Summary"),
  verbatimTextOutput("value"))
)

