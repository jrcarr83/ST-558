## ----widget-app,echo=FALSE,message=FALSE, warning = FALSE----
library(shiny)
library(rvest)

#function to get help file and format
helpFile<-function(site){
    code<-read_html(site)
    title<-html_node(code,"body") %>% html_node("h1") %>% html_text()
    rcode<-html_node(code,"body") %>% html_node("pre")
    args<-html_node(code,"body") %>% html_node("table")
    as.character(paste(paste0("<h3>",title,"</h3>"),"<h4>Usage</h4>",rcode,"<h4>Arguments</h4>",args,sep=" "))
}

# Define UI for application that draws a histogram
shinyApp(
    # Define UI for application that draws a histogram
    ui <- fluidPage(
        # Application title
        titlePanel(h1("Shiny Widgets for the UI")),
        
        # Sidebar with a slider input for number of bins 
        fluidRow(
            column(6,
                   fluidRow(
                       column(6,selectizeInput("widget", label = h2("Widget"),
                                               choices = c("Button","Check Box","Check Box Group","Date Input","Date Range","File Input","Numeric Input","Radio Button","Select Box","Slider","Text Input"), selected = "Button")
                       ),
                       column(6,
                              conditionalPanel(condition="input.widget == 'Button'",actionButton("B",h3("Click Here!"))),
                              conditionalPanel(condition="input.widget == 'Check Box'",checkboxInput("CB",label=h3("Add Element"),value=FALSE,width='100%')),
                              conditionalPanel(condition="input.widget == 'Check Box Group'",checkboxGroupInput("CBG",h3("Select From the Choices Below"),choices=list("Option A","Option B","Option C","Option D"),width='100%')),
                              conditionalPanel(condition="input.widget == 'Date Input'",dateInput("DI",h3("Input a Date Here",style="border-style:outset"),value='2016-11-122')),
                              conditionalPanel(condition="input.widget == 'Date Range'",dateRangeInput("DR",h3("Input Dates Here",style="border-style:inset"),start='1983-11-14')),
                              conditionalPanel(condition="input.widget == 'File Input'",fileInput("FI",h3("Select File to Input"))),
                              conditionalPanel(condition="input.widget == 'Numeric Input'",numericInput("NI",h3("Enter a Number Between 0 and 1000"),value=0,min=0,max=1000,step=5)),
                              conditionalPanel(condition="input.widget == 'Radio Button'",radioButtons("RB",h3("Select a Choice Below",style="background-color:lightblue;border-style:dotted"),choices=list("Option A","Option B","Option C","Option D"))),
                              conditionalPanel(condition="input.widget == 'Select Box'",selectInput("SB",h3("Select From the Group Below"),choices=list("Option A","Option B","Option C","Option D"),multiple=TRUE)),
                              conditionalPanel(condition="input.widget == 'Slider'",sliderInput("S",h3("Use the Slider to Select a Range",style="font-family: Courier New"),min=0, max=1000,value=100,animate=TRUE,step=5)),
                              conditionalPanel(condition="input.widget == 'Text Input'",textInput("TI",h3("Write Your Text Below",style="color:blue")))
                       )
                   ),
                   tags$hr(),
                   fluidRow(
                       column(12,h2("Code Used for Widget Above"),
                              verbatimTextOutput("userInput")
                       )
                   ),
                   fluidRow(
                       column(12,h2("What does Shiny return for use?"),
                              verbatimTextOutput("widgetValue")
                       )
                   )
            ),
            column(6,h2("Help Information for Widget"),
                   uiOutput("widgetInfo")
            )
        )
    ),
    
    
    # Define server logic required to draw a histogram
    server <- function(input, output,session) {
        
        output$widgetValue<-renderPrint({
            if(input$widget=="Button"){
                list(input$B)
            } else if(input$widget=="Check Box"){
                list(input$CB)
            } else if(input$widget=="Check Box Group"){
                list(input$CBG)
            } else if(input$widget=="Date Input"){
                list(input$DI)
            } else if(input$widget=="Date Range"){
                list(input$DR)
            } else if(input$widget=="File Input"){
                list(input$FI)
            } else if(input$widget=="Numeric Input"){
                list(input$NI)
            } else if(input$widget=="Radio Button"){
                list(input$RB)
            } else if(input$widget=="Select Box"){
                list(input$SB)
            } else if(input$widget=="Slider"){
                list(input$S)
            } else if(input$widget=="Text Input"){
                list(input$TI)
            }
        })
        
        
        output$widgetInfo<-renderText({
            if(input$widget=="Button"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/actionButton.html")
            } else if(input$widget=="Check Box"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/checkboxInput.html")
            } else if(input$widget=="Check Box Group"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/checkboxGroupInput.html")
            } else if(input$widget=="Date Input"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/dateInput.html")
            } else if(input$widget=="Date Range"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/dateRangeInput.html")
            } else if(input$widget=="File Input"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/fileInput.html")
            } else if(input$widget=="Numeric Input"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/numericInput.html")
            } else if(input$widget=="Radio Button"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/radioButtons.html")
            } else if(input$widget=="Select Box"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/selectInput.html")
            } else if(input$widget=="Slider"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/sliderInput.html")
            } else if(input$widget=="Text Input"){
                helpFile("https://shiny.rstudio.com/reference/shiny/latest/textInput.html")
            }
        })
        
        output$userInput<-renderText({
            if(input$widget=="Button"){
                'actionButton("B",h3("Click Here!"))'
            } else if(input$widget=="Check Box"){
                'checkboxInput("CB",label=h3("Add Element"),value=FALSE,width="100%")'
            } else if(input$widget == 'Check Box Group'){
                'checkboxGroupInput("CBG",h3("Select From the Choices Below"),choices=list("Option A","Option B","Option C","Option D"),width="100%"))'
            } else if(input$widget == 'Date Input'){
                'dateInput("DI",h3("Input a Date Here",style="border-style:outset"),value="2016-11-122"))'
            } else if(input$widget == 'Date Range'){
                'dateRangeInput("DR",h3("Input Dates Here",style="border-style:inset"),start="1983-11-14"))'
            } else if(input$widget == 'File Input'){
                'fileInput("FI",h3("Select File to Input")))'
            } else if(input$widget == 'Numeric Input'){
                'numericInput("NI",h3("Enter a Number Between 0 and 1000"),value=0,min=0,max=1000,step=5))'
            } else if(input$widget == 'Radio Button'){
                'radioButtons("RB",h3("Select a Choice Below",style="background-color:lightblue;border-style:dotted"),choices=list("Option A","Option B","Option C","Option D")))'
            } else if(input$widget ==  'Select Box'){
                'selectInput("SB",h3("Select From the Group Below"),choices=list("Option A","Option B","Option C","Option D"),multiple=TRUE))'
            } else if(input$widget == 'Slider'){
                'sliderInput("S",h3("Use the Slider to Select a Range",style="font-family: Courier New"),min=0, max=1000,value=100,animate=TRUE,step=5))'
            } else if(input$widget == 'Text Input'){
                'textInput("TI",h3("Write Your Text Below",style="color:blue"))'
            }
        })
    }
)

