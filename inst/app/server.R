shinyServer(function(input,output){
  
  output$read_data_ui <- renderUI({
    if(input$select_source == "demo"){
      checkboxGroupInput("demo_datasets", "Demo datasets",
                         choices = list("KOF Barometer" = "kofbaro"),
                         selected = "kofbaro")
      
      
      
    } else if(input$select_source == "csv"){
      h2("csv")
    } else if(input$select_source == "api"){
      h2("api")
    } else if(input$select_source == "random"){
      h2("random")
    }
    })
  })
