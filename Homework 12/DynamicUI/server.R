library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output, session) {
    
    getData <- reactive({
        newData <- msleep %>% filter(vore == input$vore)
    })
    
    #create plot
    output$sleepPlot <- renderPlot({
        #get filtered data
        newData <- getData()
        
        #create plot
        g <- ggplot(newData, aes(x = bodywt, y = sleep_total))
        
        if (input$conservation && input$rem) {
            #update min size to 3 if rem is checked
            updateSliderInput(session, 'size', min=3)
            g + geom_point(size = input$size, 
                           aes(col = conservation, alpha = sleep_rem))
        } else if (input$conservation) {
            #update min size to 1 if rem is not checked
            updateSliderInput(session, 'size', min=1)
            g + geom_point(size = input$size, aes(col = conservation))
        } else {
            #update min size to 1 if rem is not checked
            updateSliderInput(session, 'size', min=1)
            g + geom_point(size = input$size)
            
        }

    })
    
    #create text info
    output$info <- renderText({
        #get filtered data
        newData <- getData()
        
        paste("The average body weight for order", input$vore, "is", round(mean(newData$bodywt, na.rm = TRUE), 2), "and the average total sleep time is", round(mean(newData$sleep_total, na.rm = TRUE), 2), sep = " ")
    })
    
    #create output of observations    
    output$table <- renderTable({
        getData()
    })
    
    output$vore <- renderUI({
        vore_type = ''
        if (input$vore == 'carni') {
            vore_type = 'Carnivore'
        } else if (input$vore == 'herbi') {
            vore_type = 'Herbivore'
        } else if (input$vore == 'insecti') {
            vore_type = 'Insectivore'
        } else if (input$vore == 'omni') {
            vore_type = 'Omnivore'
        }
        html_title <- paste0('Investigation of ', 
                             vore_type, 
                             ' Mammal Sleep Data')
        html_title
    })
    
})