# OVERVIEW ##################
source("tabs.R")
# DOWNLOAD ##################

# PAGE LAYOUT ##########
dashboardPage(header = 
                dashboardHeader(title = "tsviewR",
                                titleWidth = 280),
              dashboardSidebar(disable = TRUE),
              body = dashboardBody(
                tags$head(
                  tags$link(rel = "stylesheet",
                            type = "text/css", href = "custom.css")),
                fluidRow(
                  box(title = "Graph",
                      width = 10, solidHeader = T,
                      status = "primary"),
                  box(title = "info",
                      width = 2, solidHeader = T,
                      status = "primary")
                ),
                fluidRow(
                  tabBox(
                    # The id lets us use input$tabset1 on the server to find the current tab
                    id = "tabset1", height = "250px",
                    tabPanel("Data", 
                             selectInput("select_source","select source",
                                         choices = list("demo dataset" = "demo",
                                                        "upload csv" = "csv",
                                                        "KOF Datenservice" = "api",
                                                        "random time series" = "random")),
                             uiOutput("read_data_ui")),
                    tabPanel("Select", "Select time series"),
                    tabPanel("Plot properties", "all the switches and buttons of tsplot"),
                    tabPanel("Export image", "png, pdf and so on"),
                    tabPanel("Export data", "long format wide format and so on"),
                    width = 12
                  )
                )
              )
)
