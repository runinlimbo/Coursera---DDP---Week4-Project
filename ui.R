
library(shiny)
library(shinythemes)  

# Define UI for application 
ui <- fluidPage(theme=shinytheme("superhero"),
                
                # Application title
                titlePanel("Calorie Expenditure Calculator"),
                
                
                # Sidebar with user input 
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
                  # Show tabs with output
                  mainPanel(
                    tabsetPanel(type="tabs",
                                tabPanel(h2("Calories Burned"),
                                         h2(textOutput("Cal"))),
                                tabPanel(h2("Description"),
                                         h2(verbatimTextOutput("description")))
                    )
                    # h2("Total calories burned:"),
                    # h2(textOutput("Cal")) 
                  )
                )
)
