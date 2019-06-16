
library(shiny)
library(shinythemes)  


# Define server logic required to draw a histogram
server <- (function(input, output) {
  
  output$Cal <- renderText({
    if(input$age < 15){
      "Enter an age of at least 15."
    } else if (input$weight < 50){
      "Enter a weight of at least 50 pounds."
    } else if (input$time < 15){
      "Enter a time of at least 15 minutes."
    } else if (input$fitness == "Yes" & !(input$VO2 >=0 & input$VO2 <= 100)){
      "VO2 Max entry is out of range.  Enter a valid VO2 Max value."  
    } else {
      switch(input$fitness,
             "Yes" = (
               switch(input$gender,
                      "Male"   = round((input$age*0.2713 + input$weight*0.3942/2.20462 + input$slider_bpm*0.6344 + input$VO2*0.4044-95.7735)*input$time/4.184,2),
                      "Female" = round((input$age*0.2735 + input$weight*0.1032/2.20462 + input$slider_bpm*0.4498 + input$VO2*0.3802-59.3954)*input$time/4.184,2)
               )
             ),
             "No" = (
               switch(input$gender,
                      "Male"   = round((input$age*0.2017 + input$weight*0.1988/2.20462 + input$slider_bpm*0.6309-55.0969)*input$time/4.184,2),
                      "Female" = round((input$age*0.0740 - input$weight*0.1263/2.20462 + input$slider_bpm*0.4472-20.4022)*input$time/4.184,2)
               )                
             )
      )
    } 
    
  })
})

