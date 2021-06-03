## ---- echo = FALSE, message = FALSE, warning = FALSE----
library(tidyverse)
library(haven)
library(knitr)
library(RSQLite)
library(methods)
options(dplyr.print_min = 5)
options(tibble.print_min = 5)
opts_chunk$set(message = FALSE, cache = FALSE)


## ---- eval = FALSE------------------------
## {
##   {
##     "name": "Barry Sanders"
##     "games" : 153
##     "position": "RB"
##   },
##   {
##     "name": "Joe Montana"
##     "games": 192
##     "position": "QB"
##   }
## }


## ---- fig.align = 'center', echo = FALSE, out.width="800px"----
knitr::include_graphics("../img/HPAPI.png")


## -----------------------------------------
baseURL <- "https://www.potterapi.com/v1/"
value <- "spells?"
key <- "key=$2a$10$UMvDCH.93fa2KOjKbJYkOOPMNzdzQpJ0gMnVEtcHzW5Ic04HUmcsa"
URL <- paste0(baseURL, value, key)
spellData <- RCurl::getURL(URL)


## ---- eval = FALSE------------------------
## spellData

## ---- echo = FALSE------------------------
substr(spellData, 1, 100) 


## ---- warning = FALSE, message = FALSE----
spellDataDF <- jsonlite::fromJSON(spellData)
tbl_df(spellDataDF)


## ----eval=F-------------------------------
## <roster>
##   <player>
##     <name>Barry Sanders</name>
##     <games>153</games>
##     <position>RB</position>
##   </player>
##   <player>
##     <name>Joe Montana</name>
##     <games>192</games>
##     <position>QB</position>
##   </player>
## </roster>


## ---- fig.align = 'center', echo = FALSE, out.width = "600px", fig.cap="Source: mysamplecode.com"----
knitr::include_graphics("../img/xmlDiagram.jpg")


## ---- eval = FALSE------------------------
## parseZillow <- function(street) {
## 		#one call to zillowR function
## 		x <- ZillowR::GetDeepSearchResults(address = street,
## 		                                   citystatezip = "Los Angeles, CA", zws_id = "...")
## 		
## 		#now how to parse?
## 		if (x$message$code == "0") { #keep these
## 			x2 <- xmlChildren(xmlChildren(xmlChildren(x$response)$results)$result)
## 			x2unlist <- unlist(sapply(xmlToList, X = x2))
## 			vals <- x2unlist[c("address.street", "address.zipcode", "address.city",
## 			                   "useCode", "taxAssessmentYear", "more here...")]
## 			dfRow <- as.data.frame(t(as.data.frame(vals)))
## 			return(dfRow)
## 		} else {
## 			return(NULL)
## 		}
## }

