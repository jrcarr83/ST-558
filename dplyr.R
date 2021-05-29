## ----echo=FALSE,message=FALSE, warning = FALSE---------------------------
library(tidyverse)
library(haven)
library(knitr)
options(dplyr.print_min = 5)
options(tibble.print_min = 5)
opts_chunk$set(message = FALSE, cache = TRUE)

## ----eval=FALSE----------------------------------------------------------
## #install.packages("Lahman")
## library(Lahman)
## head(Batting, n = 4) #look at just first 4 observations

## ----eval=TRUE,echo=FALSE------------------------------------------------
library(Lahman)

## ------------------------------------------------------------------------
head(Batting, n = 4) #look at just first 4 observations

## ------------------------------------------------------------------------
Batting <- tbl_df(Batting)
Batting

## ------------------------------------------------------------------------
filter(Batting, teamID == "PIT")

## ------------------------------------------------------------------------
filter(Batting, teamID == "PIT" & yearID == 2000)

## ------------------------------------------------------------------------
#reorder by teamID
arrange(Batting, teamID)

## ------------------------------------------------------------------------
#get secondary arrangement as well
arrange(Batting, teamID, G)

## ------------------------------------------------------------------------
#descending instead
arrange(Batting, teamID, desc(G))

## ------------------------------------------------------------------------
#Choose a single column by name
select(Batting, X2B)

## ------------------------------------------------------------------------
#Choose a single column by name
select(Batting, playerID, X2B)

## ------------------------------------------------------------------------
arrange(select(filter(Batting, teamID == "PIT"), playerID, G, X2B), desc(X2B))

## ------------------------------------------------------------------------
Batting %>% filter(teamID == "PIT") %>% select(playerID, G, X2B) %>% arrange(desc(X2B)) 

## ------------------------------------------------------------------------
#all columns between
Batting %>% select(X2B:HR)

## ------------------------------------------------------------------------
#all columns containing
Batting %>% select(contains("X"))

## ------------------------------------------------------------------------
#all columns starting with
Batting %>% select(starts_with("X"))

## ------------------------------------------------------------------------
#multiple selections
Batting %>% select(starts_with("X"), ends_with("ID"), G)

## ------------------------------------------------------------------------
#rename our previous
Batting %>% 
	select(starts_with("X"), ends_with("ID"), G) %>% 
	rename("Doubles" = X2B, "Triples" = X3B)

## ------------------------------------------------------------------------
#reorder
Batting %>% select(playerID, HR, everything())

