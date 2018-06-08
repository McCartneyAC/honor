library(shiny)
library(shinydashboard)
library(tidyverse)
library(magrittr)
library(shinythemes)
library(readxl)




ui <- dashboardPage(skin = "yellow",
  dashboardHeader(title = "UVAHonor Data Tracking"),
  

  dashboardSidebar(
    ## Part one:
    #### input for dataset (support officers)
    fileInput("support", "Upload SO Data"),
    #### input for dataset (Case Processing)
    fileInput("cases", "Upload Case Data"), 
    tags$hr(),

    sidebarMenu(
      ## Part Two:
      ## Select: 
      tags$h4("   Select To Analyze"),
      #### Case Processing
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Support Officers", tabName = "support_tab", icon = icon("address-card")),
      #### Support Officers
      menuItem("Cases", tabName = "cases_tab", icon = icon("id-card")),
      #### Other? 
      tags$hr(), 
      tags$img(src="")
    )

  ),
  

  
  dashboardBody(
    ## TABBED
    ## PAGES
    ## FOR
    ## VARIOUS
    ## METRICS
    ## AND
    ## FIGURES
    tabItems(
      tabItem(tabName = "home",
              h2("Home")
              ),
      tabItem(tabName = "support_tab",
              h2("Support Officers Analyses")
              ),
      tabItem(tabName = "cases_tab",
              h2("Case Processing Analyses")
              )
      )
    )
  )

    
    

server <- function(input, output) {
  cases<-reactive({readxl(input$cases)})
  support<-reactive({readxl(input$support)})
}

shinyApp(ui, server)
