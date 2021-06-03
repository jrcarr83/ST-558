## ---- echo = FALSE, message = FALSE, warning = FALSE---------------------
library(tidyverse)
library(haven)
library(knitr)
options(dplyr.print_min = 5)
options(tibble.print_min = 5)
opts_chunk$set(message = FALSE, cache = TRUE)

## ---- message = FALSE----------------------------------------------------
library(censusapi)
apis <- listCensusApis()
head(apis)

## ------------------------------------------------------------------------
sahie_vars <- listCensusMetadata(name = "timeseries/healthins/sahie", type = "variables")

## ---- echo = FALSE, out.width = "800px"----------------------------------
knitr::include_graphics("../img/censusAPI.png")

## ------------------------------------------------------------------------
listCensusMetadata(name = "timeseries/healthins/sahie", type = "geography")

## ---- eval = FALSE-------------------------------------------------------
## getCensus(name = "timeseries/healthins/sahie",
##     vars = c("NAME", "IPRCAT", "IPR_DESC", "PCTUI_PT"),
##     region = "us:*",
##     time = 2016, key = "your_key_here")

## ---- echo = FALSE-------------------------------------------------------
getCensus(name = "timeseries/healthins/sahie",
    vars = c("NAME", "IPRCAT", "IPR_DESC", "PCTUI_PT"), 
    region = "us:*", 
    time = 2016, key = "e267f117801b2ef741e54620602b0903c5f4d3c8")

## ------------------------------------------------------------------------
sahie_states <- getCensus(name = "timeseries/healthins/sahie",
    vars = c("NAME", "IPRCAT", "IPR_DESC", "PCTUI_PT"), 
    region = "state:*", 
    time = 2016, key = "e267f117801b2ef741e54620602b0903c5f4d3c8")
head(sahie_states)

