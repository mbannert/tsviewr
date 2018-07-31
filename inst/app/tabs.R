###############################################
# Tab for selecting which series to plot
###############################################

tabInputSeries <- tabPanel("Data", list(
  numericInput("nDummies", NULL, 5, 1, 10),
  actionButton("makeDummies", "Gimme dem shweet shweet dummies")
  ))

###############################################
# Tab for selecting which series to plot
###############################################

tabSelectSeries <- tabPanel("Select", DT::dataTableOutput("tsSelection"))