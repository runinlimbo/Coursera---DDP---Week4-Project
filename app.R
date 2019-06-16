#
# Author: Jeremy Sidwell
# Date: June 15, 2019
#
# Shiny web app that calculates estimated calorie expenditure based on 
# heart rate levels (as published in the Journal of Sports Sciences)
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)  

# Define UI for application that draws a histogram
ui <- fluidPage(theme=shinytheme("superhero"),
   
   # Application title
   titlePanel("Carlorie Expenditure Calculator"),
   
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         
#         helpText("This app estimates calories burned based on average heart rate during a workout activity."),
         
         selectInput("gender",
                     label = "Enter your gender:",
                     choices=c("Female", "Male"), 
                     selected ="Female"),
         numericInput("age",
                      "Enter Age in Years:", 
                      value = 31),
         numericInput("weight",
                      "Enter Weight in lbs:", 
                      value = 137),
         numericInput("time", 
                     label = h6("Enter the length of the workout in Minutes:"), 
                     value = 60),
         sliderInput("slider_bpm", 
                     label = h6("Enter Average Heart Beats per minute:"),
                     min=80, max=220, value = 160),
         selectInput("fitness",label=h6("Include Fitness Level (VO2 Max)?"),
                     choices=list("Yes","No"),selected="Yes"),
         
         conditionalPanel(
           condition= "input.fitness =='Yes'",
            numericInput("VO2",
                         "Enter your VO2 Max level:",
                         value = 48)
         )
      ),
      # Show a plot of the generated distribution
      mainPanel(
         h2("Total calories burned:"),
         h2(textOutput("Cal")) 
      )
   )
)

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


# Run the application 
shinyApp(ui = ui, server = server)

