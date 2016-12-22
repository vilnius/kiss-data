#~Data checks & corrections
print("Data checks and corrections")
#~~If there are duplicates between lankomumas and laukiantys, the corresponding row is removed from laukiantys

seni.vaikai <- lankomumas[,c("Vaiko.Identifikacinis.Nr.","Darželio.pavadinimas")]
nauji.vaikai <- laukiantys[,c("Vaiko.Identifikacinis.Nr.","X1.pasirinktas.darželis")]
colnames(nauji.vaikai)[which(names(nauji.vaikai) == "X1.pasirinktas.darželis")] <- "Darželio.pavadinimas"
visi.vaikai <- rbind(seni.vaikai,nauji.vaikai)
jau.gave <- visi.vaikai[which(duplicated(visi.vaikai$Vaiko.Identifikacinis.Nr.)),]
jau.gave.id <- as.vector(jau.gave[,1])
laukiantys <- laukiantys[-which(laukiantys$Vaiko.Identifikacinis.Nr. %in% jau.gave.id),]

laukiantys$Vaiko.seniunija <- as.character(laukiantys$Vaiko.seniunija)
laukiantys$Vaiko.seniunija[laukiantys$Vaiko.seniunija == "visos"] <- "Visos seniūnijos"
laukiantys$Vaiko.seniunija[laukiantys$Vaiko.seniunija == ""] <- "Seniūnija nenurodyta"

print("Data checks and corrections done")