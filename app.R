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
                        #### Day Calculator 
                        menuItem("Calculate Days", tabName = "calcdays", icon = icon("calendar")),
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
                      tags$img(src="https://github.com/McCartneyAC/honor/blob/master/files/image.jpg", width = "99%")  
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
                        
                        tabItem(tabName = "calcdays",
                                h2("Calculate Date Ranges with UVA Holidays"),
                                box(
                                  dateRangeInput("dates", h2("Date range"),
                                                 min = "2016-08-23" ,
                                                 max = "2022-05-13"),
                                  textOutput(outputId = "dateRangeText"),
                                  tags$br(),
                                  tags$br(),
                                  tags$h3("About"),
                                  tags$p("This application calculates the number of days (inlcuding weekends) between two selected dates.
                                         Times when UVA is not in session (summer and winter breaks between semesters) are excluded, as are
                                         Spring Break and Thanksgiving break."),
                                  tags$p("Timelines are currently limited to Fall 2016 - Spring 2022 semesters.")
                                )
                                ), # calc days tab
                 
                        
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
  
  # Holidays List -------------------------------------------------------------------------------
  # 2016-2017
  thanksgiving= c(  "2016-11-23", "2016-11-24", "2016-11-25", "2016-11-26", "2016-11-27")
  spring_break= c(  "2016-03-04", "2016-03-05", "2016-03-06", "2016-03-07", "2016-03-08", "2016-03-09", "2016-03-10", "2016-03-11", "2016-03-12")
  h2016 <-c(thanksgiving, spring_break )
  # 2017-2018
  thanksgiving= c(  "2017-11-22", "2017-11-23", "2017-11-24", "2017-11-25", "2017-11-26" )
  spring_break= c(  "2018-03-03", "2018-03-04", "2018-03-05", "2018-03-06", "2018-03-07", "2018-03-08", "2018-03-09", "2018-03-10", "2018-03-11")
  h2017 <-c(thanksgiving, spring_break )
  # 2018-2019
  thanksgiving= c(  "2018-11-21", "2018-11-22", "2018-11-23", "2018-11-24", "2018-11-25")
  spring_break= c(  "2019-03-09", "2019-03-10", "2019-03-11", "2019-03-12", "2019-03-13", "2019-03-14", "2019-03-15", "2019-03-16", "2019-03-17")
  h2018 <-c(thanksgiving, spring_break )
  # 2019-2020
  thanksgiving= c(  "2019-11-27", "2019-11-28", "2019-11-29", "2019-11-30", "2019-12-01")
  spring_break= c(  "2020-03-07", "2020-03-08", "2020-03-09", "2020-03-10", "2020-03-11", "2020-03-12", "2020-03-13", "2020-03-14", "2020-03-15")
  h2019 <-c(thanksgiving, spring_break )
  # 2020-2021
  thanksgiving= c(  "2020-11-25", "2020-11-26", "2020-11-27", "2020-11-28", "2020-11-29")
  spring_break= c(  "2020-03-06", "2020-03-07", "2020-03-08", "2020-03-09", "2020-03-10", "2020-03-11", "2020-03-12", "2020-03-13", "2020-03-14")
  h2020 <-c(thanksgiving, spring_break )
  # 2021-2022
  thanksgiving= c(  "2021-11-24", "2021-11-25", "2021-11-26", "2021-11-27", "2021-11-28")
  spring_break= c(  "2022-03-05", "2022-03-06", "2022-03-07", "2022-03-08", "2022-03-09", "2022-03-10", "2022-03-11", "2022-03-12", "2022-03-13")
  h2021 <-c(thanksgiving, spring_break )
  # full list: 
  holidays<-c(h2016,h2017,h2018,h2019,h2020,h2021)
  holidays<-as.Date(holidays, "%Y-%m-%d")
  holidays
  
  # Semesters List --------------------------------------------------------------------------------
  fall2016    <- seq(as.Date("2016-08-23"), as.Date("2016-12-16"), by="days")
  spring2017  <- seq(as.Date("2017-01-18"), as.Date("2017-05-12"), by="days")
  fall2017    <- seq(as.Date("2017-08-22"), as.Date("2017-12-15"), by="days")
  spring2018  <- seq(as.Date("2018-01-17"), as.Date("2018-05-11"), by="days")
  fall2018    <- seq(as.Date("2018-08-28"), as.Date("2018-12-18"), by="days")
  spring2019  <- seq(as.Date("2019-01-14"), as.Date("2019-05-10"), by="days")
  fall2019    <- seq(as.Date("2019-08-27"), as.Date("2019-12-17"), by="days")
  spring2020  <- seq(as.Date("2020-01-13"), as.Date("2020-05-08"), by="days")
  fall2020    <- seq(as.Date("2020-08-25"), as.Date("2020-12-18"), by="days")
  spring2021  <- seq(as.Date("2021-01-21"), as.Date("2021-05-14"), by="days")
  fall2021    <- seq(as.Date("2021-08-24"), as.Date("2021-12-17"), by="days")
  spring2022  <- seq(as.Date("2022-01-19"), as.Date("2022-05-13"), by="days")
  semesters <-c(fall2016, spring2017, fall2017, spring2018, fall2018, spring2019, fall2019, spring2020, fall2020, spring2021, fall2021, spring2022)
  semesters<-as.Date(semesters, "%Y-%m-%d")
  
  
  
  
  
  # calculations --------------- 
  a <- reactive({input$dates[1]})
  b <- reactive({input$dates[2]})
  
  date_range <- reactive({seq.Date(a(), b(),1)})
  
  tspan <- reactive({
    length(date_range()[date_range() %in% semesters & !date_range() %in% holidays])
  })
  output$dateRangeText  <- renderText({
    paste("Number of Days Between", 
          paste(as.character(input$dates), collapse = " to "), 
          "excluding school holidays is: ",
          tspan()
    )
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}

shinyApp(ui, server)
