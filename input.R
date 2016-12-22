#~~~Data input
print("Data input")


# input -------------------------------------------------------------------

laukiantys <- read.csv(file = "data/laukianciuju_eileje_ataskaita.csv",
                       sep = ";", encoding = "UTF-8", na.strings = c("", "NA"), 
                       check.names = F, stringsAsFactors = F)

rename.matrix.laukiantys <- read.csv(file = "rename_matrix_laukiantys.csv", check.names = F, stringsAsFactors = F)

#current groups
lankantys_grupes <- read.csv(file = "data/lankanciu_vaiku_ataskaita_pagal_grupes.csv",
                             sep = ";", encoding = "UTF-8", na.strings = c("", "NA"),
                             check.names = F, stringsAsFactors = F)

rename.matrix.lankantys <- read.csv(file = "rename_matrix_lankantys.csv", check.names = F, stringsAsFactors = F)


# renaming ----------------------------------------------------------------

names(laukiantys) <- rename.matrix.laukiantys$changed.names
names(lankantys_grupes) <- rename.matrix.lankantys$changed.names


#queue prior to 2015-12-15 (for old prioritisation algorithm)
laukiantys$application.date <- substr(laukiantys$application.date,1,10)
laukiantys$application.date <- as.Date(laukiantys$application.date, "%Y-%m-%d")

laukiantys_seni <- subset(laukiantys, application.date < as.Date("2015-12-15") )

#queue from 2015-12-15 (for new prioritisation algorithm)
laukiantys_nauji <- subset(laukiantys, application.date > as.Date("2015-12-14") )


print("Data input done")