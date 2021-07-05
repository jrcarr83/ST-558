## ---- echo = FALSE, message = FALSE, warning = FALSE---------------------
library(tidyverse)
library(haven)
library(knitr)
options(dplyr.print_min = 5)
options(tibble.print_min = 5)
opts_chunk$set(message = FALSE, cache = TRUE)
titanicData <- read_csv("https://www4.stat.ncsu.edu/~post/558/datasets/titanic.csv")

## ----eval=FALSE----------------------------------------------------------
## g <- ggplot(dataframe, aes(x = , y = , ...)) #Define global properties
## g + geom_type(...) + #Can define local aes as well
##   geom_type2(...) +
##   labs(...)

## ------------------------------------------------------------------------
titanicData

## ----eval=FALSE----------------------------------------------------------
## ggplot(data = titanicData, aes(x = embarked))

## ----eval=TRUE,echo=FALSE------------------------------------------------
ggplot(data=titanicData,aes(x=embarked))

## ----eval=FALSE----------------------------------------------------------
## g <- ggplot(data = titanicData, aes(x = embarked))
## g + geom_bar()

## ----eval=TRUE, echo=FALSE-----------------------------------------------
g<-ggplot(data=titanicData,aes(x=embarked))
g + geom_bar()

## ----eval=FALSE----------------------------------------------------------
## titanicData <- titanicData %>% drop_na(embarked)
## g <- ggplot(data = titanicData, aes(x = embarked))
## g + geom_bar()

## ----eval=TRUE,echo=FALSE------------------------------------------------
#remove NA category
titanicData <- titanicData %>% drop_na(embarked)
g <- ggplot(data = titanicData, aes(x = embarked))
g + geom_bar()

## ----eval=FALSE----------------------------------------------------------
## #Fix x axis, x axis label and give title
## g + geom_bar() +
##   ### <b>
##   labs(x = "City Embarked", title = "Bar Plot of Embarked City
##        for Titanic Passengers") +
##   ### </b>
##   scale_x_discrete(labels = c("Cherbourg","Queenstown","Southampton"))

## ----eval=TRUE,echo=FALSE------------------------------------------------
#Fix x axis, x axis label and give title
g + geom_bar() + labs(x="City Embarked",title="Bar Plot of Embarked City for Titanic Passengers") + scale_x_discrete(labels=c("Cherbourg","Queenstown","Southampton"))

## ----eval=FALSE----------------------------------------------------------
## 
## g + geom_bar(aes(fill = as.factor(survived)))

## ----eval=TRUE,echo=FALSE------------------------------------------------
g + geom_bar(aes(fill=as.factor(survived)))

## ----eval=FALSE----------------------------------------------------------
## g + geom_bar(aes(fill = as.factor(survived))) +
##   labs(x = "City Embarked",
##        title = "Bar Plot of Embarked City for Titanic Passengers") +
##   scale_x_discrete(labels = c("Cherbourg", "Queenstown", "Southampton")) +
##   ###<b>
##   scale_fill_discrete(name = "Surived", labels = c("No","Yes"))
##   ###</b>

## ----eval=TRUE,echo=FALSE------------------------------------------------
g + geom_bar(aes(fill=as.factor(survived))) +
  labs(x="City Embarked", title="Bar Plot of Embarked City for Titanic Passengers") + 
  scale_x_discrete(labels=c("Cherbourg","Queenstown","Southampton")) + 
  scale_fill_discrete(name="Surived",labels=c("No","Yes"))

## ----eval=FALSE----------------------------------------------------------
## g + geom_bar(aes(fill = as.factor(survived))) +
##   labs(x = "City Embarked",
##        title = "Bar Plot of Embarked City for Titanic Passengers") +
##   scale_x_discrete(labels = c("Cherbourg", "Queenstown", "Southampton")) +
##   scale_fill_discrete(name = "Surived",labels = c("No","Yes")) +
##   ### <b>
##   coord_flip()
##   ### </b>

## ----eval=TRUE,echo=FALSE------------------------------------------------
g + geom_bar(aes(fill=as.factor(survived))) +
  labs(x="City Embarked", title="Bar Plot of Embarked City \n for Titanic Passengers") + 
  scale_x_discrete(labels=c("Cherbourg","Queenstown","Southampton")) + 
  scale_fill_discrete(name="Surived",labels=c("No","Yes")) +
  coord_flip()

## ----eval=FALSE,echo=TRUE------------------------------------------------
## g + geom_bar(aes(fill = as.factor(survived)))
## g + stat_count(aes(fill = as.factor(survived))) #equivalent call

## ----eval=FALSE,echo=TRUE------------------------------------------------
## sumData <- titanicData %>% group_by(embarked, survived) %>% summarize(count = n())
## g2 <- ggplot(sumData, aes(x = embarked, y = count))
## g2 + geom_bar(aes(fill = as.factor(survived)), stat = "identity")

## ---- echo = TRUE, eval = FALSE------------------------------------------
## g + geom_bar(aes(fill = as.factor(survived)), position = "dodge")

## ---- echo = FALSE, eval = TRUE------------------------------------------
g + geom_bar(aes(fill = as.factor(survived)), position = "dodge")

## ---- echo = TRUE, eval = FALSE------------------------------------------
## g + geom_bar(aes(fill = as.factor(survived)), position = "fill")

## ---- echo = FALSE, eval = TRUE------------------------------------------
g + geom_bar(aes(fill = as.factor(survived)), position = "fill")

## ----eval=FALSE----------------------------------------------------------
## tab <- tbl_df(table(titanicData$embarked, titanicData$survived))
## 
## names(tab) <- c("Embarked", "Survived", "Count")
## 
## write_csv(x = tab, path = "titanicTable.csv", col_names = TRUE)

## ----eval=FALSE----------------------------------------------------------
## #by default ggsave saves last plot
## #guesses file type by extension
## ggsave(filename = "output/titanicBarPlot.png")
## ggsave(filename = "output/titanicBarPlot.pdf")

## ---- out.width = "800px",echo=FALSE-------------------------------------
knitr::include_graphics("../img/export.png")

