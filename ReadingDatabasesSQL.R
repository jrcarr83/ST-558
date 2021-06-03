## ---- echo = FALSE, message = FALSE, warning = FALSE---------------------
library(tidyverse)
library(haven)
library(knitr)
library(RSQLite)
library(methods)
options(dplyr.print_min = 5)
options(tibble.print_min = 5)
opts_chunk$set(message = FALSE, cache = FALSE)

## ---- out.width="1000px", echo = FALSE, fig.align='center'---------------
knitr::include_graphics("../img/dbDiagram.png")

## ---- out.width = "600px", echo = FALSE, fig.align='center'--------------
knitr::include_graphics("../img/lahman.jpg")

## ---- eval = FALSE-------------------------------------------------------
## con <- DBI::dbConnect(RMySQL::MySQL(),
##   host = "hostname.website",
##   user = "username",
##   password = rstudioapi::askForPassword("DB password")
## )

## ---- eval = FALSE-------------------------------------------------------
## new_data <- tbl(con, "name_of_table")

## ------------------------------------------------------------------------
#install.packages("RSQLite")
library(RSQLite)
my_db_file <- "lahman.sqlite"
my_db <- src_sqlite(my_db_file, create = TRUE)
my_db

## ------------------------------------------------------------------------
library(Lahman)
copy_to(my_db, Master)
copy_to(my_db, Pitching)
copy_to(my_db, Fielding)
copy_to(my_db, Batting)
copy_to(my_db, AwardsPlayers)
copy_to(my_db, AwardsSharePlayers)
my_db

## ---- eval = FALSE-------------------------------------------------------
## tbl(my_db, "Pitching") %>% select(ends_with("ID")) %>%
## 	filter(yearID == 2010) %>% show_query()

## ------------------------------------------------------------------------
temp <- tbl(my_db, "Pitching") %>% select(ends_with("ID")) %>%
	filter(yearID == 2010)
temp

## ------------------------------------------------------------------------
temp <- tbl(my_db, "Pitching") %>% select(ends_with("ID")) %>% 
	filter(yearID == 2010) %>% collect()
temp

## ---- eval = TRUE, echo = FALSE------------------------------------------
tbl(my_db, "Pitching") %>% select(ends_with("ID")) %>% 
	filter(yearID == 2010) %>% show_query()

## ---- eval = TRUE--------------------------------------------------------
tbl(my_db, sql(
"SELECT `playerID`, `yearID`, `teamID`, `lgID`
        FROM `Pitching`
WHERE (`yearID` = 2010.0)")) %>% collect()

## ---- echo = FALSE, fig.align='center', out.width="500px"----------------
knitr::include_graphics("../img/joins.PNG")

## ---- echo = FALSE, fig.align='center', out.width="500px"----------------
knitr::include_graphics("../img/joins2.PNG")

## ---- warning = FALSE----------------------------------------------------
# create two simple data frames
a <- data_frame(color = c("green", "yellow", "red"), num = 1:3)
b <- data_frame(color = c("green", "yellow", "pink"), size = c("S", "M", "L"))

## ------------------------------------------------------------------------
a

## ------------------------------------------------------------------------
b

## ------------------------------------------------------------------------
a

## ------------------------------------------------------------------------
b

## ------------------------------------------------------------------------
inner_join(a, b)

## ------------------------------------------------------------------------
a

## ------------------------------------------------------------------------
b

## ------------------------------------------------------------------------
full_join(a, b)

## ------------------------------------------------------------------------
a

## ------------------------------------------------------------------------
b

## ------------------------------------------------------------------------
left_join(a, b)

## ------------------------------------------------------------------------
a

## ------------------------------------------------------------------------
b

## ------------------------------------------------------------------------
right_join(a, b)

## ------------------------------------------------------------------------
right_join(a,b)

## ------------------------------------------------------------------------
left_join(b, a)

## ------------------------------------------------------------------------
a

## ------------------------------------------------------------------------
b

## ------------------------------------------------------------------------
semi_join(a, b)

## ------------------------------------------------------------------------
a

## ------------------------------------------------------------------------
b

## ------------------------------------------------------------------------
anti_join(a, b)

## ------------------------------------------------------------------------
b <- b %>% rename(col = color)
a

## ------------------------------------------------------------------------
b

## ------------------------------------------------------------------------
a

## ------------------------------------------------------------------------
b

## ------------------------------------------------------------------------
inner_join(a, b, 
	by = c("color" = "col"))

## ------------------------------------------------------------------------
inner_join(select(tbl(my_db, "Pitching"), "playerID", "yearID", "W"), 
             select(tbl(my_db, "AwardsPlayers"), "playerID", "yearID", "awardID")) %>% 
  filter(yearID > 2010) %>% collect()

## ------------------------------------------------------------------------
inner_join(select(tbl(my_db, "Pitching"), "playerID", "yearID", "W"), 
             select(tbl(my_db, "AwardsPlayers"), "playerID", "yearID", "awardID")) %>% 
  filter(yearID > 2010) %>% show_query()

## ------------------------------------------------------------------------
tbl(my_db, sql(
"SELECT `LHS`.`playerID` AS `playerID`, `LHS`.`yearID` AS `yearID`, `LHS`.`W` AS `W`, `RHS`.`awardID` AS `awardID`  
FROM (SELECT `playerID`, `yearID`, `W`
               FROM `Pitching`) AS `LHS`
INNER JOIN (SELECT `playerID`, `yearID`, `awardID`
               FROM `AwardsPlayers`) AS `RHS`
ON (`LHS`.`playerID` = `RHS`.`playerID` AND `LHS`.`yearID` = `RHS`.`yearID`)")) %>% collect()

#

