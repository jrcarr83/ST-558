## ----echo=FALSE,message=FALSE, warning = FALSE---------------------------
library(tidyverse)
library(haven)
library(knitr)
options(dplyr.print_min = 5)
options(tibble.print_min = 5)
opts_chunk$set(message = FALSE, cache = TRUE)

## ----eval=TRUE-----------------------------------------------------------
library(fivethirtyeight)
fandango

## ------------------------------------------------------------------------
##Create an average rottentomatoes score variable
fandango %>% mutate(avgRotten = (rottentomatoes + rottentomatoes_user)/2)

## ------------------------------------------------------------------------
#can't see it!
fandango %>% mutate(avgRotten = (rottentomatoes+rottentomatoes_user)/2) %>% select(avgRotten)

## ------------------------------------------------------------------------
#transmute will keep the new variable only
fandango %>% transmute(avgRotten = (rottentomatoes + rottentomatoes_user)/2)

## ------------------------------------------------------------------------
fandango %>% summarise(avgStars = mean(fandango_stars), sdStars = sd(fandango_stars))

## ------------------------------------------------------------------------
fandango %>% group_by(year) %>% summarise(avgStars = mean(fandango_stars), 
                                          sdStars = sd(fandango_stars))

## ----eval=FALSE----------------------------------------------------------
## if (condition) {
##   then execute code
## }
## 
## #if then else
## if (condition) {
##   execute this code
## } else {
##   execute this code
## }

## ----eval=FALSE----------------------------------------------------------
## #Or more if statements
## if (condition) {
##   execute this code
## } else if (condition2) {
##   execute this code
## } else if (condition3) {
##   execute this code
## } else {
##   #if no conditions met
##   execute this code
## }

## ----error=TRUE----------------------------------------------------------
if ((iris$Petal.Length > 1.5) & (iris$Petal.Width > 0.3) &
      (iris$Species == "setosa")) {
   "Large Setosa"
}

## ----eval=FALSE----------------------------------------------------------
## #syntax
## ifelse(vector_condition, if_true_do_this, if_false_do_this)

## ----error=TRUE----------------------------------------------------------
ifelse((iris$Petal.Length > 1.5) & (iris$Petal.Width > 0.3) & 
         (iris$Species == "setosa"), "L-S", "NotL-S")

## ------------------------------------------------------------------------
mutate(iris, Size = ifelse(
	(Petal.Length > 1.5) & (Petal.Width > 0.3) & (Species == "setosa"), "LS", "NotLS")
	)

## ------------------------------------------------------------------------
tempsData <- read_delim(file = "https://www4.stat.ncsu.edu/~post/558/datasets/cityTemps.txt", 
												delim = " ")
tempsData

## ------------------------------------------------------------------------
tempsData %>% gather(key = day, value = temp, 2:8)

## ------------------------------------------------------------------------
newTempsData <- tempsData %>% gather(key = day, value = temp, sun:sat)
newTempsData

## ------------------------------------------------------------------------
newTempsData %>% spread(key = day, value = temp)

## ------------------------------------------------------------------------
chicagoData <- read_csv("https://www4.stat.ncsu.edu/~post/558/datasets/Chicago.csv")
chicagoData

## ------------------------------------------------------------------------
chicagoData %>% separate(date, c("Day", "Month", "Year"), sep = "/")

## ------------------------------------------------------------------------
chicagoData %>% separate(date, c("Day", "Month", "Year"), sep = "/", 
												 convert = TRUE, remove = FALSE)

