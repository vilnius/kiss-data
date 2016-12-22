xx <- read.csv2("~/Downloads/priorities_latestx_priorities.csv",stringsAsFactors = FALSE,quote="")


conv <- function(x) {
  cv <- fromJSON(gsub("\"$","",gsub("^\"","",x)))
  res <- 0
  if(!("giveNumberBecousBothParentsAndChildLivesInCity" %in% names(cv))) {
    res <- 1000000
  } else {
    if(cv[["giveNumberBecousBothParentsAndChildLivesInCity"]]==1) res <- 10000
  }
  res
}

cv <- sapply(xx$X.CHECKED_PRIORITY,conv) 
prio_vz <- data.frame(ID=xx$X.ID,VZPR = cv)

prio <-read.csv2("~/Downloads/priorities_latestx_priorities.csv",stringsAsFactors = FALSE)

prio1 <- prio %>% inner_join(prio_vz)

prio2 <- prio1 %>% mutate(FINAL_PRIORITY = VZPR + RS_PRIO_COUNT)
