shinyServer(function(input,output){
  state <- reactiveValues(
    series = list(),
    theme = tstools::init_tsplot_theme(),
    leftRightSplit = character()
  )
  
  observeEvent(input$makeDummies, {
    n <- input$nDummies
    ns <- tstools::generate_random_ts(n)
    #names(ns) <- sapply(seq(n), function(x){paste(sample(c(letters, LETTERS), 10), collapse = "")})
    state$series <<- ns
  })
  
  output$tsSelection <- DT::renderDataTable(
    {
      seris <- names(state$series)
      df <- data.frame(
                       l = sprintf('<input type="radio" name="%s" value="l"/>', seris),
                       n = sprintf('<input type="radio" name="%s" value="n" checked/>', seris),
                       r = sprintf('<input type="radio" name="%s" value="r"/>', seris))
      row.names(df) <- seris
      df
    },
    escape = FALSE,
    selection = 'none', server = FALSE,
    options = list(dom = 't', paging = FALSE, ordering = FALSE),
    callback = JS("console.log(\"STOP! its callback time. Also ohai.\");
                   table.rows().every(function(i, tab, row) {
                      var $this = $(this.node());
                      $this.attr('id', this.data()[0]);
                      $this.addClass('shiny-input-radiogroup');
                    });
                    Shiny.unbindAll(table.table().node(), true);
                    Shiny.bindAll(table.table().node());")
  )
  
  output$tsPlot <- renderPlot({
    s <- state$series
    if(length(s) < 1) {
      splitSeries <- list(l = tstools::generate_random_ts(3))
    } else {
      # In case the tsSelection panel has not been selected yes we need to provide a default
      state$leftRightSplit <<- sapply(names(s), function(i) `if`(!is.null(input[[i]]), input[[i]], "n"))
      splitSeries <- split(s, state$leftRightSplit)
      if(length(splitSeries$l) < 1) {
        output$hint <- renderText("Please select at least 1 series to be plotted on the left!")
      } else {
        output$hint <- renderText("Good boy!")
      }
    }
    if(length(splitSeries$l) > 0) {
      tstools::tsplot(splitSeries$l, tsr = splitSeries$r, theme = state$theme)
    }
  })
})
