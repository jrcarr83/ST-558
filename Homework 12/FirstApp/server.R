library(shiny) #this is a shiny app
library(DT) #data tables 
library(caret) #contains data that we will use
data('GermanCredit')
GermanCredit <- tibble(GermanCredit) %>% 
    mutate(employed = if_else(EmploymentDuration.Unemployed == 1,
                              'Unemployed', 'Employed')) %>%
    mutate(foreign = if_else(ForeignWorker == 1,
                             'Foreign', 'German'))
GermanCredit$employed <- factor(GermanCredit$employed)
GermanCredit$foreign <- factor(GermanCredit$foreign, 
                                  levels= c('German', 'Foreign'))

shinyServer(function(input, output){
    
    
    #create plot
    output$german_plot <- renderPlot({
        if (input$plot_type == 'class_only') {
            p<-ggplot(data = GermanCredit,
                      aes(x = Class)) + 
               geom_bar()
            p  
        } else if (input$plot_type == 'class_emp') {
            p<-ggplot(data = GermanCredit,
                      aes(x = Class, fill = employed)) + 
                geom_bar(position = 'dodge') + 
                labs(fill = "Employment Status")
            p 
        } else {
            p<-ggplot(data = GermanCredit,
                      aes(x = Class, fill = foreign)) + 
                geom_bar(position = 'dodge') + 
                labs(fill = "Status")
            p
        }
    })

    dataSet<-reactive({
        var <- input$variable
        GermanCreditSub <- GermanCredit[, c("Class", 
                                            "InstallmentRatePercentage", 
                                            var),
                                        drop = FALSE]
        tab <- aggregate(GermanCreditSub[[var]] ~ Class + InstallmentRatePercentage,
                         data = GermanCreditSub, FUN = mean)
        
        tab[,3] <- round(tab[,3], input$Digits)
        col_names <- c('Class', 
                       'InstallmentRatePercentage',
                       paste0('Average ', var))
        datatable(tab, colnames=col_names)
    })
    
    output$german_data <- renderDataTable(dataSet())
    
}) #function #shinyServer