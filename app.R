library(shiny)
library(shinydashboard)
library(shinythemes)
library(readxl)
library(ggalluvial)
library(tidyverse) # TIDYVERSE ALWAYS COMES LAST.

colors<-c("blue", "black", "purple", "green", "red", "yellow") # I am a child

source("metrics.R")
source("graph_functions.R")

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
                      ), #Sidebar Menu
                      
                      
                      ## Part two:
                      #### input for dataset (support officers)
                      fileInput("support", "Upload SO Data"),
                      #### input for dataset (Case Processing)
                      fileInput("cases", "Upload Case Data"), 
                      tags$hr(), 
                      tags$img(src="") #Honor Logo Here? If we want it? 
                    ), #Dashboard Sidebar
                    
                    
                    dashboardBody(
                      
                      tabItems(
                        tabItem(tabName = "home",
                                h2("Home"),
                                box(width = 12,
                                  tags$h3("Analyze Honor Committee Data"),
                                  tags$p("This app exists to provide a dashboard for the analysis of Honor Committee Data. All case processing data are strictly confidential; therefore, it is not feasible to regularly transfer them from Executive Board members to data tracking subcommittee members for analysis. The goal of this environment is to enable exec members to upload data from OCP and to output analyses, metrics, and graphs with ease."),
                                  tags$p("To use, upload Support Officer or Case Processing data in the navigation pane on the left, then select which group you wish to analyze. Individual tabs may offer different metrics, so follow the instructions as you run your analysis. "),
                                  tags$p("Different metrics may require data to be structured in variable ways. Look out for instructions on how to structure your data to get the most out of this application."),
                                  tags$p("This application is under development. Report any and all problems, questions, or ideas to:", tags$a(href="mailto:acm9q@virginia.edu", "Andrew McCartney."))
                                ) #fluidRow
                        ), # Home Tab
                        tabItem(tabName = "support_tab",
                                h2("Support Officers Analyses"),
                                tags$p("These analyses have data needs. See data tab."),
                                fluidRow(
                                  tabBox(
                                    title = "Metrics",
                                    # The id lets us use input$tabset1 on the server to find the current tab
                                    id = "tabMetrics", height = "500px",
                                    tabPanel("RCDI", "Relative Difference In Composition Index: How over-represented and under-represented are racial groups?"),
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
                                         tabPanel("Time-to-Resolution", width = 12, 
                                                  tabBox(width = 12,
                                                         tabPanel("Median TTR",
                                                                  valueBoxOutput("median_ttr")
                                                         ), # Median accounts for CMD outliers.
                                                         tabPanel("TTR by Student Choice:"),
                                                         tabPanel("Survival Analysis"), # perhaps break these up into a second tabbox within the panel? 
                                                         tabPanel("Alluvial Diagram")   # as is the case with Support Officer Metrics... For cleanliness. 
                                                  ) #tabBox
                                         ), # tabPanel (TTR)
                                         tabPanel("Equity", width=12,
                                                  tabBox(width = 12,
                                                         tabPanel("Equity Indices"),
                                                         tabPanel("RCDI"),
                                                         tabPanel("EI")
                                                  ) #tabBox
                                         )#tabPanel - Equity
                                  ) #tabBox
                                ) # fluidRow
                        ) #Cases Tab
                      )
                    )
)




server <- function(input, output) {
  cases<-reactive({readxl(input$cases)})
  support<-reactive({readxl(input$support)})
  
  
  # ei<-EI()
  # rcdi<-RCDI()
  
  output$median_ttr<-renderValueBox({
    valueBox(
      "35 days", "Median TTR",
      icon = icon("calendar"),
      color = "yellow"
    )
  })
  
  
  
}

shinyApp(ui, server)
