## ---- echo = FALSE, message = FALSE, warning = FALSE---------------------
library(tidyverse)
library(haven)
library(knitr)
options(dplyr.print_min = 5)
options(tibble.print_min = 5)
opts_chunk$set(message = FALSE, cache = TRUE)

## ----eval=FALSE----------------------------------------------------------
## g <- ggplot(CO2, aes(x = uptake))
## g + geom_histogram()

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g <- ggplot(CO2, aes(x = uptake))
g + geom_histogram()

## ----eval=FALSE,echo=TRUE------------------------------------------------
## g + geom_histogram(color = "blue", fill = "red",
## 									 size = 2, binwidth = 3)

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g + geom_histogram(color = "blue", fill = "red", 
									 size = 2, binwidth = 3)

## ----eval=FALSE----------------------------------------------------------
## g + geom_density()

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g + geom_density()

## ----eval=FALSE,echo=TRUE------------------------------------------------
## g + geom_density(adjust = 0.5, alpha = 0.5, aes(fill = Treatment))

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g + geom_density(adjust = 0.5, alpha = 0.5, aes(fill = Treatment))

## ----eval=FALSE,echo=TRUE------------------------------------------------
## g + geom_density(adjust = 0.5, alpha = 0.5, aes(fill = Treatment), position = "stack")

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g + geom_density(adjust = 0.5, alpha = 0.5, aes(fill = Treatment), position = "stack")

## ----eval=FALSE,echo=TRUE------------------------------------------------
## g + geom_histogram(aes(y = ..density.., fill = Treatment)) +
##   geom_density(adjust = 0.25, alpha = 0.5, aes(fill = Treatment), position = "stack")

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g + geom_histogram(aes(y = ..density.., fill = Treatment)) +
  geom_density(adjust = 0.25, alpha = 0.5, aes(fill = Treatment), position = "stack")

## ----eval=FALSE,echo=TRUE,message=FALSE----------------------------------
## ggplot(CO2, aes(x = update, fill = Treatment)) + geom_histogram(aes(y = ..density..)) +
##   geom_density(adjust = 0.25, alpha = 0.5)

## ----eval=FALSE----------------------------------------------------------
## g + stat_ecdf(geom = "step")

## ----echo=FALSE,message=FALSE--------------------------------------------
g + stat_ecdf(geom="step")

## ----eval=FALSE----------------------------------------------------------
## g + stat_ecdf(geom = "step", aes(color = Treatment)) +
##   ylab("ECDF")

## ----echo=FALSE,message=FALSE--------------------------------------------
g + stat_ecdf(geom = "step", aes(color = Treatment)) +
  ylab("ECDF")

## ------------------------------------------------------------------------
scoresFull <- read_csv("datasets/scoresFull.csv")
scoresFull

## ----eval=FALSE----------------------------------------------------------
## g <- ggplot(scoresFull, aes(x = homeRushYds, y = HFinal))
## g + geom_point()

## ----echo=FALSE,message=FALSE--------------------------------------------
g<-ggplot(scoresFull,aes(x=homeRushYds,y=HFinal))
g + geom_point()

## ----echo=TRUE,eval=FALSE------------------------------------------------
## g + geom_point() +
##     geom_smooth() +
##     geom_smooth(method = lm, col = "Red")

## ----echo=FALSE,message=FALSE--------------------------------------------
g + geom_point() +
    geom_smooth() +
    geom_smooth(method = lm, col = "Red") 

## ------------------------------------------------------------------------
paste("Hi", "What", "Is", "Going", "On", "?", sep = " ")
paste("Hi", "What", "Is", "Going", "On", "?", sep = ".")

## ----eval=FALSE----------------------------------------------------------
## correlation <- cor(scoresFull$homeRushYds, scoresFull$HFinal)
## 
## g + geom_point() +
##     geom_smooth() +
##     geom_smooth(method = lm, col = "Red") +
##     geom_text(x = 315, y = 10, size = 5, label = paste0("Correlation = ",
##                                              round(correlation, 2)))

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
correlation <- cor(scoresFull$homeRushYds, scoresFull$HFinal)

g + geom_point() +
    geom_smooth() +
    geom_smooth(method = lm, col = "Red") + 
    geom_text(x = 315, y = 10, size = 5, label = paste0("Correlation = ", 
                                             round(correlation, 2)))

## ----eval=FALSE,echo=TRUE,message=FALSE----------------------------------
## scores2 <- filter(scoresFull, homeTeam == "Pittsburgh Steelers")
## g2 <- ggplot(scores2, aes(x = homeRushYds, y = HFinal))
## g2 + geom_text(aes(label = season))

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
scores2 <- filter(scoresFull, homeTeam == "Pittsburgh Steelers")
g2 <- ggplot(scores2, aes(x = homeRushYds, y = HFinal))
g2 + geom_text(aes(label = season))

## ----eval=FALSE----------------------------------------------------------
## g + geom_point() +
##     facet_wrap(~ surface)

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g + geom_point() +
    facet_wrap(~ surface)

## ----eval=FALSE----------------------------------------------------------
## g + geom_point() +
##     facet_grid(roof ~ surface)

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g + geom_point() +  
    facet_grid(roof ~ surface)

## ----eval=FALSE----------------------------------------------------------
## g + geom_point(aes(col = homeSpread), alpha = 0.6, size = 0.8, position = "jitter") +
##     facet_wrap(~ roof)

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g + geom_point(aes(col = homeSpread), alpha = 0.6, size = 0.8, position = "jitter") +  
    facet_wrap(~ roof) 

## ------------------------------------------------------------------------
Correlation <- cor(select(scoresFull, Hturnovers, homeRushYds,
                        homePassYds, HFinal), method = "spearman")
#install corrplot library
library(corrplot)

## ----eval=FALSE----------------------------------------------------------
## corrplot(Correlation, type = "upper",
##          tl.pos = "lt")
## corrplot(Correlation, type = "lower", method = "number",
##          add = TRUE, diag = FALSE, tl.pos = "n")

## ----eval=TRUE,echo=FALSE------------------------------------------------
corrplot(Correlation,type="upper",tl.pos="lt")
corrplot(Correlation,type="lower",method="number",add=TRUE,diag=FALSE,tl.pos="n")

## ---- out.width = "400px",echo=FALSE-------------------------------------
knitr::include_graphics("../img/corr.png")

## ----message=FALSE-------------------------------------------------------
#install GGally
library(GGally)

## ----eval=FALSE----------------------------------------------------------
## ggpairs(iris, aes(colour = Species, alpha = 0.4))

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
ggpairs(iris, aes(colour = Species, alpha = 0.4))

## ----eval=FALSE,echo=TRUE,message=FALSE----------------------------------
## g <- ggplot(scoresFull, aes(x = surface, y = homePassYds))
## g + geom_boxplot(fill = "grey")

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g <- ggplot(scoresFull, aes(x = surface, y = homePassYds))
g + geom_boxplot(fill="grey")

## ----eval=FALSE,echo=TRUE,message=FALSE----------------------------------
## g + geom_boxplot(fill = "grey") +
##     stat_summary(fun.y = mean, geom = "line",
##                  lwd = 1.5, aes(group = roof, col = roof))

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g + geom_boxplot(fill = "grey") +
    stat_summary(fun.y = mean, geom = "line", 
                 lwd = 1.5, aes(group = roof, col = roof))

## ------------------------------------------------------------------------
oneDate <- paste(scoresFull$date[1], scoresFull$season[1], sep = "-"); oneDate
unite(scoresFull, Date, sep = "-", date, season, remove = FALSE) %>% select(Date, everything())

## ----message=FALSE-------------------------------------------------------
library(lubridate)
as.Date(oneDate,"%d-%b-%Y")
as.Date(oneDate,"%d-%b-%Y") + 1

## ------------------------------------------------------------------------
scoresFull <- unite(scoresFull, Date, sep = "-", date, season, remove = FALSE)
scoresFull$Date <- as.Date(scoresFull$Date, "%d-%b-%Y")

subScores <- scoresFull %>% 
  filter(homeTeam %in% c("Pittsburgh Steelers", "Cleveland Browns",
                         "Baltimore Ravens", "Cincinnati Bengals")) %>% 
  group_by(season, homeTeam) %>%
  summarise(homeAvgYds = mean(homePassYds + homeRushYds))

## ------------------------------------------------------------------------
subScores

## ----eval=FALSE,echo=TRUE,message=FALSE----------------------------------
## g <- ggplot(subScores, aes(x = season, y = homeAvgYds, color = homeTeam))
## g + geom_line(lwd = 1.5)

## ----eval=TRUE,echo=FALSE,message=FALSE----------------------------------
g <- ggplot(subScores, aes(x = season, y = homeAvgYds, color = homeTeam))
g + geom_line(lwd = 1.5)

