# OVERVIEW ##################
source("tabs.R")
# DOWNLOAD ##################

# PAGE LAYOUT ##########
dashboardPage(header = 
                dashboardHeader(title = "tstools viewr",
                                titleWidth = 280),
              dashboardSidebar(disable = TRUE),
              body = dashboardBody(
                tags$head(
                  tags$link(rel = "stylesheet",
                            type = "text/css", href = "custom.css")),
                fluidRow(
                  box(title = "Graph",
                      width = 10, solidHeader = T,
                      status = "primary",
                      plotOutput("tsPlot")),
                  box(title = "info",
                      width = 2, solidHeader = T,
                      status = "primary",
                      textOutput("hint"))
                ),
                fluidRow(
                  tabBox(
                    # The id lets us use input$tabset1 on the server to find the current tab
                    id = "tabset1", height = "250px",
                    tabInputSeries,
                    tabSelectSeries,
                    tabPanel("Plot properties", "all the switches and buttons of tsplot"),
                    tabPanel("Export image", "png, pdf and so on"),
                    tabPanel("Export data", "long format wide format and so on"),
                    width = 12
                  )
                )
              )
)
