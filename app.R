source("global.R")
source("metrics.R")
source("graph_functions.R")
ui <- dashboardPage(skin = sample(colors, 1), # When one of these colors finally speaks to me, I'll settle on it. 
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
                        menuItem("Cases", tabName = "cases_tab", icon = icon("id-card")), #icon("user-graduate")
                        #### James Hay, Jr. 
                        menuItem("Reflect", tabName = "reflect", icon = icon("leaf")), # icon("glasses") 
                        #### Other? 
                        # menuItem("other", tabName = "other", icon = icon("ot-her")),
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
                      tags$img(src="https://github.com/McCartneyAC/honor/blob/master/files/image.png", width = "99%")  
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
                                ) #box
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
                                                  tabBox(width = 12, height = "400px",
                                                         tabPanel("Median TTR",
                                                                  valueBoxOutput("median_ttr") # Median controls for CMD outliers.
                                                         ), 
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
                        ), #Cases Tab
                        
                        
                        
                        
                        
                        
                        
                        
                        tabItem( tabName = "reflect",
                                 tags$h3("The Honor Men"),
                                 box(
                                   tags$p("The University of Virginia writes her highest degree on the souls of her sons. The parchment page of scholarship- the colored ribbon of a society- the jeweled emblem of a fraternity- the orange symbol of athletic prowess- all these, a year hence, will be at the best the mementos of happy hours- like the withered flower a woman presses between the pages of a book for sentiment's sake.", tags$br(), 
                                          "But...", tags$br(), 
                                          "If you live a long, long time, and hold honesty of conscience above honesty of purse;", tags$br(), 
                                          "And turn aside without ostentation to aid the weak;", tags$br(), 
                                          "And treasure ideals more than raw ambition;", tags$br(), 
                                          "And track no man to his undeserved hurt;", tags$br(), 
                                          "And pursue no woman to her tears;", tags$br(), 
                                          "And love the beauty of noble music and mist-veiled mountains and blossoming valley and great monuments- ", tags$br(), 
                                          "If you live a long time and, keeping the faith in all these things hours by hour, still see that the sun gilds your path with real gold and that the moon floats in dream silver;", tags$br(), 
                                          "Then...", tags$br(), 
                                          "Remembering the purple shadows of the lawn, the majesty of the colonnades, and the dream of your youth, you may say in your reverence and thankfulness:", tags$br(), 
                                          "'I have worn the honors of Honor.", tags$br(), 
                                          "I graduated from Virginia.'"),
                                   tags$p("-James Hay, Jr., '03")
                                 ) #box
                        ) # reflect tab
                        
                        
                        
                        
                        
                        
                      ) #tabItems
                    ) #dashboardBody
) #ui




server <- function(input, output) {
  cases<-reactive({readxl(input$cases)})
  support<-reactive({readxl(input$support)})
  
  
  # ei<-EI()
  # rcdi<-RCDI()
  
  output$median_ttr<-renderValueBox({
    valueBox(
      "35 days", "Median TTR", # upon receipt of data structure, this will change to reflect some version of: 
                               # median(daysbetween(cases$end_date, cases$start_date))
                               # (but that will be a function in metrics.R by then)
      icon = icon("calendar"),
      color = "yellow"
    )
  })
  
  
  
}

shinyApp(ui, server)
