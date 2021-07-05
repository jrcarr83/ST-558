## ---- echo = FALSE, message = FALSE, warning = FALSE---------------------
library(tidyverse)
library(haven)
library(knitr)
options(dplyr.print_min = 5)
options(tibble.print_min = 5)
opts_chunk$set(message = FALSE, cache = TRUE)

## ------------------------------------------------------------------------
CO2 <- tbl_df(CO2)
CO2

## ------------------------------------------------------------------------
mean(CO2$uptake)
#note you can easily get a trimmed mean
mean(CO2$uptake, trim = 0.05) #5% trimmed mean
median(CO2$uptake)

## ------------------------------------------------------------------------
#quartiles and mean
summary(CO2$uptake)

## ------------------------------------------------------------------------
var(CO2$uptake)
sd(CO2$uptake)

## ------------------------------------------------------------------------
IQR(CO2$uptake)
quantile(CO2$uptake, probs = c(0.1, 0.2))

## ------------------------------------------------------------------------
cov(CO2$conc, CO2$uptake)
cor(CO2$conc, CO2$uptake)

## ------------------------------------------------------------------------
CO2 %>% group_by(Treatment) %>% 
	summarise(avg = mean(uptake), med = median(uptake), var = var(uptake))

## ------------------------------------------------------------------------
CO2 %>% group_by(Treatment, Type) %>% 
		summarise(avg = mean(uptake), med = median(uptake), var = var(uptake))

## ---- eval = FALSE-------------------------------------------------------
## #same result, different formats
## aggregate(CO2$uptake ~ CO2$Treatment, FUN = function(x){(x - mean(x)) / sd(x)})
## tapply(X = CO2$uptake, INDEX = CO2$Treatment, FUN = function(x){(x - mean(x)) / sd(x)})

## ------------------------------------------------------------------------
aggregate(CO2$uptake ~ CO2$Treatment, FUN = function(x){(x - mean(x)) / sd(x)}) 
#weird data frame returned...

## ---- eval = TRUE--------------------------------------------------------
tapply(X = CO2$uptake, INDEX = CO2$Treatment, FUN = function(x){(x - mean(x)) / sd(x)}) 

