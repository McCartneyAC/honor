# setwd("C:\\Users\\Andrew\\Desktop\\honor-master")
library(shiny)
library(shinydashboard)
library(shinythemes)
library(readxl)
library(tidyverse) # TIDYVERSE ALWAYS COMES LAST.

colors<-c("blue", "black", "purple", "green", "red", "yellow") # I am a child

# source(metrics.R)
# source(graph_functions.R)

ui <- dashboardPage(skin = sample(colors, 1), # and this amuses me. 
  dashboardHeader(title = "UVAHonor Data Tracking"),
  

  dashboardSidebar(
    sidebarMenu(
      ## Part One:
      ## Select: 
      tags$h4("Select To Analyze"),
      menuItem("Home", tabName = "home", icon = icon("home")),
      #### Case Processing
      menuItem("Support Officers", tabName = "support_tab", icon = icon("address-card")),
      #### Support Officers
      menuItem("Cases", tabName = "cases_tab", icon = icon("id-card")),
      #### Other? 
      tags$hr()
      # semi-collapse:
      # https://antoineguillot.wordpress.com/2017/02/21/three-r-shiny-tricks-to-make-your-shiny-app-shines-23-semi-collapsible-sidebar/?utm_content=buffer88135&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer
    ),
    ## Part two:
    #### input for dataset (support officers)
    fileInput("support", "Upload SO Data"),
    #### input for dataset (Case Processing)
    fileInput("cases", "Upload Case Data"), 
    tags$hr(), 
    tags$img(src="")
  ),

  
  dashboardBody(

    tabItems(
      tabItem(tabName = "home",
              h2("Home"),
              tags$h3("Analyze Honor Committee Data"),
              tags$p("This app exists to provide a dashboard for the analysis of Honor Committee Data. All case processing data are strictly confidential; therefore, it is not feasible to regularly transfer them from Executive Board members to data tracking subcommittee members for analysis. The goal of this environment is to enable exec members to upload data from OCP and to output analyses, metrics, and graphs with ease."),
              tags$p("To use, upload Support Officer or Case Processing data in the navigation pane on the left, then select which group you wish to analyze. Individual tabs may offer different metrics, so follow the instructions as you run your analysis. "),
              tags$p("Different metrics may require data to be structured in variable ways. Look out for instructions on how to structure your data to get the most out of this application."),
              tags$p("This application is under development. Report any and all problems, questions, or ideas to:", tags$a(href="mailto:acm9q@virginia.edu", "Andrew McCartney."))
              ), # Home Tab
      tabItem(tabName = "support_tab",
              h2("Support Officers Analyses"),
              tags$p("These analyses have data needs. See data tab."),
              fluidRow(
                tabBox(
                  title = "Metrics",
                  # The id lets us use input$tabset1 on the server to find the current tab
                  id = "tabMetrics", height = "500px",
                  tabPanel("RDCI", "Relative Difference In Composition Index: How over-represented and under-represented are racial groups?"),
                  tabPanel("EI", "Equity Index: How many are needed from each group to satisfy 80% equity?"),
                  tabPanel("Data", "data must be structured as follows....")
                ), # Metrics
                tabBox(
                  title = "Graphs",
                  side = "right", height = "500px",
                  tabPanel("tabGraphs") #,
                  # tabPanel("Tab2", "Tab content 2"),
                  # tabPanel("Tab3", "Note that when side=right, the tab order is reversed.")
                ) #Mosaic
                
              ) #fluidRow
              ), # Support Officer Tab
      tabItem(tabName = "cases_tab",
              h2("Case Processing Analyses"),
              fluidRow(  
                tabBox(width = 12, height = "500px",
                  tabPanel("Time-to-Resolution", width = 11, 
                           tabBox(
                             tabPanel("valueBox mean TTR"),
                             tabPanel("TTR by Student Choice:"),
                             tabPanel("Survival Analysis")
                             ) #tabBox
                           ), # tabPanel (TTR)
                  tabPanel("Equity", "Case Equity Statistics Go Here")
                ) #tabBox
              ) # fluidRow
              ) #Cases Tab
      )
    )
  )

    
    

server <- function(input, output) {
  cases<-reactive({readxl(input$cases)})
  support<-reactive({readxl(input$support)})
  
  # rdci<-RDCI()
  # ei<-EI()
  

  
  
}

shinyApp(ui, server)
