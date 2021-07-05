## ---- echo = FALSE, message = FALSE, warning = FALSE---------------------
library(tidyverse)
library(haven)
library(knitr)
options(dplyr.print_min = 5)
options(tibble.print_min = 5)
opts_chunk$set(message = FALSE, cache = TRUE)

## ----echo=FALSE----------------------------------------------------------
titanicData <- read_csv("https://www4.stat.ncsu.edu/~post/558/datasets/titanic.csv")
titanicData

## ------------------------------------------------------------------------
table(titanicData$embarked)
table(titanicData$survived)

## ------------------------------------------------------------------------
table(titanicData$sex)

## ------------------------------------------------------------------------
table(titanicData$survived,
      titanicData$sex)

## ------------------------------------------------------------------------
table(titanicData$survived,
      titanicData$embarked)
table(titanicData$sex,
      titanicData$embarked)

## ------------------------------------------------------------------------
table(titanicData$sex, titanicData$embarked, titanicData$survived)

## ------------------------------------------------------------------------
tab <- table(titanicData$sex, titanicData$embarked, titanicData$survived)

str(tab)

## ----echo=FALSE----------------------------------------------------------
str(tab)

## ------------------------------------------------------------------------
#returns embarked vs survived table for females
tab[1, , ]

## ----echo=FALSE----------------------------------------------------------
str(tab)

## ------------------------------------------------------------------------
#returns embarked vs survived table for males
tab[2, , ]

## ----echo=FALSE----------------------------------------------------------
str(tab)

## ------------------------------------------------------------------------
#returns survived vs sex table for embarked "C"
tab[, 1, ]

## ----echo=FALSE----------------------------------------------------------
str(tab)

## ------------------------------------------------------------------------
#Survived status for males that embarked at "Q"
tab[2, 2, ]

