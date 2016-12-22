#~~~Data input
print("Data input")

#queue data
laukiantys <- read.csv(file="data/laukianciuju_eileje_ataskaita.csv",sep = ";",encoding="UTF-8",na.strings=c("","NA"))

#current groups
lankantys_grupes <- read.csv(file="data/lankanciu_vaiku_ataskaita_pagal_grupes.csv",sep = ";",encoding="UTF-8",na.strings=c("","NA"))

#queue prior to 2015-12-15 (for old prioritisation algorithm)
laukiantys$application_date <- substr(laukiantys$Prašymo.pateikimo.data,1,10)
laukiantys$application_date <- as.Date( as.character(laukiantys$application_date), "%Y-%m-%d")
laukiantys_seni <- subset(laukiantys, application_date < as.Date("2015-12-15") )

#queue from 2015-12-15 (for new prioritisation algorithm)
laukiantys_nauji <- subset(laukiantys, application_date > as.Date("2015-12-14") )


# darzeliai <- read.csv(file="data/darzeliai.csv",encoding="UTF-8",na.strings=c("","NA"))
# grupes <- read.csv(file="data/grupes.csv",encoding="UTF-8",na.strings=c("","NA"))
# istaigos <- read.csv(file="data/istaigos.csv",sep = ";", encoding="UTF-8",na.strings=c("","NA"))
# vaikai_grup <- read.csv(file="data/lankanciu_vaiku_ataskaita_pagal_grupes.csv",sep = ";", encoding="UTF-8",na.strings=c("","NA"))
# lankomumas <- read.csv(file="data/lankomumo_ziniarasciai_2016-07-01-2016-07-31.csv",sep = ";", encoding="UTF-8",na.strings=c("","NA"))
# prasymai <- read.csv(file="data/visi_prasymai.csv", encoding="UTF-8",na.strings=c("","NA"))
# laukiantys_raw <- laukiantys

print("Data input done")