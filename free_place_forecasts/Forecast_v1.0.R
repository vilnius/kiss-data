library(lubridate)
library(plyr)

groups <- read.csv2('GROUP_AGE_TYPE.csv', sep = ",",stringsAsFactors = F)
raw <- read.csv2('lankanciu_vaiku_ataskaita_pagal_grupes.csv',sep = ",",stringsAsFactors = F)

check_year <- "2017"

raw <- raw[,c(2,3,8,9,11,17,18)]

work <- raw

work[,"Vaiko.gimimo.data"] <- as.Date(work[,"Vaiko.gimimo.data"])
work[, "age_jan"] <-as.integer(ymd(paste0(check_year,"-01-01"))-ymd(work[,"Vaiko.gimimo.data"]))/365
work[, "age_sep"] <-as.integer(ymd(paste0(check_year,"-09-01"))-ymd(work[,"Vaiko.gimimo.data"]))/365

gr <- groups[,c("LABEL","AGEFROM","AGETO")]
gr[,"LABEL"] <- substr(gr[,"LABEL"],1,nchar(gr[,"LABEL"])-1)
names(work)[5] <- "LABEL"
work[,"LABEL"] <- substr(work[,"LABEL"],1,nchar(work[,"LABEL"])-1)
work <- merge(gr,work)
work[, "stays"] <- work[,"age_jan"] < work[,"AGETO"]
names(work)[7] <- "LANG"
work[,"AGETO"] <- as.numeric(work[,"AGETO"])
work[,"LANG"] <- substr(work[,"LANG"],1,3)

drz <- unique(work[,c("SCH","LANG","NEEDS")])
final <- cbind(drz,"slots.from.1.to.3","slots.from.3.to.inf","all.from.1.to.3","all.from.3.to.inf")
final <- final[-(1:nrow(final)),]

work[is.na(work[,"stays"]),"stays"] <- F

for(i in 1:nrow(drz)){
  tmp <- work[work[,"SCH"]==drz[i,1]& work[,"LANG"]==drz[i,2]& work[,"NEEDS"]==drz[i,3],]
  # tmp <- merge(tmp,groups)[,-c(1)]
  tmp <- tmp[,-c(4)]
  fin <- count(tmp$AGETO)
  names(fin) <- c("AGETO","SPACE")
  fin2 <- ddply(tmp,~AGETO,function(xframe){
    sum(xframe$stay==F)})
  names(fin2) <- c("AGETO","LEAVE")
  fin <- merge(fin,fin2)

  slots.from.1.to.3 <- fin[fin[,"AGETO"]==3,"LEAVE"]
  if(length(slots.from.1.to.3)==0) slots.from.1.to.3 <-0
  all.from.1.to.3 <- sum(fin[fin[,"AGETO"]<=3,"SPACE"])
  slots.from.3.to.inf <- fin[fin[,"AGETO"]==max(fin[,"AGETO"]),"LEAVE"] - slots.from.1.to.3
  if(slots.from.3.to.inf<0) slots.from.3.to.inf <-0
  all.from.3.to.inf <- sum(fin[fin[,"AGETO"]>3,"SPACE"])

  final <- rbind(final,cbind(drz[i,],all.from.1.to.3,all.from.3.to.inf,slots.from.1.to.3,slots.from.3.to.inf))

  }

write.csv2(final,'vietos.csv',row.names = F)

# made by Karolis Jasas and Raminta Velickaite from "Euromonitor International"
# 2017-01-24
