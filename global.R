library(shiny)
library(shinydashboard)
library(shinythemes)
library(readxl)
library(ggplot2)
library(ggalluvial)
library(ggmosaic)
library(ggthemes)
library(lubridate)
library(anicon)
library(wired)
library(dplyr) 

colors<-c("blue", "black", "purple", "green", "red", "yellow") # shinyDashboard available colors.
# app will choose one of these at random to display as header bar color.

uvapal<-c("#E57200", #orange
          "#232D4B", #navy
          "#007681",
          "#F2CD00",
          "#692A7E", 
          "#84BD00",
          "#A5ACAF", #gray
          "#5C7F92",
          "#857363",
          "#CAC0B6"  #ten total colors
)
