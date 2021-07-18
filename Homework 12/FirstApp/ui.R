library(shiny) #this is a shiny app
library(DT) #data tables 
library(tidyverse)

shinyUI(fluidPage(
    titlePanel('Summaries for German Credit Data'),
    sidebarLayout(
        sidebarPanel(
            #info about the data
            fluidRow(h3('This data set comes from the ',
                tags$a(href="https://cran.r-project.org/web/packages/caret/vignettes/caret.html",
                "caret package", target="_blank"),
                ' - originally from the UCI machine learning repository')),
            #spacing
            br(),
            
            #describe buttons
            fluidRow(h4('You can create a few bar plots using the radio
                     buttons below')),
            
            #radio buttons to select plot type
            radioButtons("plot_type", "Select the Plot Type",
                         c("Just Classification" = "class_only",
                           "Classification and Unemployed" = "class_emp",
                           "Classificiation and Foreign" = "class_for")
                         ), #radio buttons close
    
            #this section is for to change the table
            fluidRow(h4(HTML(
                "You can find the <b>sample mean</b> for a few variables below:"
            ))),
            
            selectInput("variable", "Variables to Summarize:",
                        c("Duration" = "Duration",
                          "Amount" = "Amount",
                          "Age" = "Age")),
            numericInput("Digits",
                         label="Select the number of digits for rounding",
                         value=2,
                         min=0, 
                         max=10)
            
            
        ),
        mainPanel(
            plotOutput("german_plot"), #radio buttons change plot output
            
            dataTableOutput("german_data") # drop down menus update this table
        )
    )#sidebarLayout
))#fluid page #shinyUI