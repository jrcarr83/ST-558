## ----echo=FALSE,message=FALSE, warning = FALSE---------------------------
library(tidyverse)
library(haven)
library(knitr)
options(dplyr.print_min = 5)
options(tibble.print_min = 5)
opts_chunk$set(message = FALSE, cache = TRUE)

## ------------------------------------------------------------------------
#Use of ==, !=, >=, <=, >, <
"hi" == " hi"
"hi" == "hi"
4 == 1

## ------------------------------------------------------------------------
4 != 1
sqrt(3)^2  == 3
dplyr::near(sqrt(3)^2, 3)

## ------------------------------------------------------------------------
#use of is. functions
is.numeric("Word")
is.numeric(10)

## ------------------------------------------------------------------------
is.character("10")
is.na(c(1:2, NA, 3))

## ------------------------------------------------------------------------
iris <- tbl_df(iris)
iris

## ----eval=FALSE----------------------------------------------------------
## iris[iris$Species == "setosa", ]

## ------------------------------------------------------------------------
##Obtain a vector that indicates which rows are "setosa" species
iris$Species == "setosa"

## ------------------------------------------------------------------------
iris[iris$Species == "setosa", ]

## ------------------------------------------------------------------------
subset(iris, Species == "setosa")

## ------------------------------------------------------------------------
filter(iris, Species == "setosa")

## ------------------------------------------------------------------------
#coerce numeric to string
c("hi", 10)
#coerce TRUE/FALSE to numeric
c(TRUE, FALSE) + 0

## ------------------------------------------------------------------------
#logical to character
c(TRUE, "hi")

## ------------------------------------------------------------------------
as.numeric(c(TRUE, FALSE, TRUE))
mean(c(TRUE, FALSE, TRUE))

## ------------------------------------------------------------------------
as.character(c(1, 2, 3.5, TRUE))

## ------------------------------------------------------------------------
set.seed(3)
x <- runif(n = 10, min = 0, max = 1); x
(x < 0.25) | (x > 0.75)
(x < 0.25) || (x > 0.75)

## ------------------------------------------------------------------------
filter(iris, (Petal.Length > 1.5) & (Petal.Width > 0.3) & 
         (Species == "setosa"))

## ---- eval = FALSE-------------------------------------------------------
## iris[(iris$Petal.Length > 1.5) & (iris$Petal.Width > 0.3) &
##          (iris$Species == "setosa"), ]

