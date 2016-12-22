print("Laukiantys analysis")

#~~Kiek metų laukia savo eilės

laukiantys$date <- substr(laukiantys$Prašymo.pateikimo.data,1,10)

laukiantys$kiek.laukia <- (as.yearmon(Sys.Date()) - as.yearmon(laukiantys[,"date"]))

ggplot(laukiantys, aes(x = kiek.laukia, fill = Prioritetas..deklaruotas.mieste.))  +
  geom_histogram(binwidth = 1) +
  labs(x="Kiek metų laukia savo eilės",y="Vaikų skaičius",
       fill="Gyvenamoji vieta deklaruota mieste")

#~~Kiek metų laukia savo eilės pagal seniūnijas

ggplot(laukiantys, aes(x = kiek.laukia, fill = Prioritetas..deklaruotas.mieste.)) +
  geom_histogram(binwidth = 1) +
  facet_wrap(~Vaiko.seniunija) + 
  ggtitle("Vaiko seniūnija") +
  labs(x="Kiek metų laukia savo eilės",y="Vaikų skaičius",
       fill="Gyvenamoji vieta deklaruota mieste")

#~~Kokio amžiaus vaikai yra laukiančiųjų sąraše

laukiantys$amzius <- (as.yearmon(Sys.Date()) - as.yearmon(laukiantys[,"Vaiko.gimimo.data"]))

ggplot(laukiantys, aes(x = amzius, fill = Prioritetas..deklaruotas.mieste.))  +
  geom_histogram(binwidth = 1) +
  labs(x="Vaiko amžius",y="Vaikų skaičius",
       fill="Gyvenamoji vieta deklaruota mieste")

#~~Kokio amžiaus vaikai yra laukiančiųjų sąraše pagal seniūnijas

ggplot(laukiantys, aes(x = amzius, fill = Prioritetas..deklaruotas.mieste.)) +
  geom_histogram(binwidth = 0.5) +
  facet_wrap(~Vaiko.seniunija) + 
  ggtitle("Vaiko seniūnija") +
  labs(x="Vaiko amžius",y="Vaikų skaičius",
       fill="Gyvenamoji vieta deklaruota mieste")

print("Laukiantys analysis done")

#~~Prie lankomumo statistikos pridedu papildomą informaciją
#~~~Prie lankomumo statistikos pridedu papildomą informaciją apie darželius

print("Lankomumo analysis")

colnames(darzeliai)[which(names(darzeliai) == "LABEL")] <- "Darželio.pavadinimas"
lankomumas <- join(lankomumas, darzeliai, by = "Darželio.pavadinimas")

#~~~Prie lankomumo statistikos pridedu papildomą informaciją apie grupes
colnames(lankomumas)[which(names(lankomumas) == "X.U.FEFF.ID")] <- "SCHOOL_ID"
colnames(grupes)[which(names(grupes) == "LABEL")] <- "Grupės.pavadinimas"
lankomumas$raktas <- paste0(lankomumas$Grupės.pavadinimas,lankomumas$SCHOOL_ID)
grupes$raktas <- paste0(grupes$Grupės.pavadinimas,grupes$SCHOOL_ID)
lankomumas <- join(lankomumas,grupes, by = "raktas", type = "left", match = "first")

#~Vaikai pagal grupių amžių
ggplot(lankomumas, aes(x = TYPE)) +
  stat_count(width = 1) +
  ggtitle("Vaiko seniūnija") +
  xlab("Grupės amžiaus intervalas") +
  ylab("Vaikų skaičius")

#~Vaikai pagal amžių
#~~Susirandam iš prašymų vaikų amžių
lankomumas <- join(lankomumas,prasymai, by = "Vaiko.Identifikacinis.Nr.", type = "left", match = "first")

#gaunam tikslią datą prašymo pateikimo
lankomumas$pateikimo.data <- substr(lankomumas$Prašymo.pateikimo.data,1,10)

#gaunam kiek buvo laukta nuo prašymo pateikimo iki priėmimo į darželį
lankomumas$laukta.eileje <- (as.yearmon(lankomumas$Lankymo.data)
                                   - as.yearmon(lankomumas$pateikimo.data))

lankomumas$amzius <- (as.yearmon(Sys.Date()) - as.yearmon(lankomumas[,"Vaiko.gimimo.data"]))

lankomumas$amzius.pareiskiant <- (as.yearmon(lankomumas$pateikimo.data) - as.yearmon(lankomumas[,"Vaiko.gimimo.data"]))

ggplot(lankomumas, aes(x = amzius)) +
  geom_histogram(binwidth = 1) +
  labs(x="Vaiko amžius",y="Vaikų skaičius")

ggplot(lankomumas, aes(x = amzius)) +
  geom_histogram(binwidth = 1) +
  facet_wrap(~Vaiko.seniunija) + 
  ggtitle("Vaiko seniūnija") +
  labs(x="Vaiko amžius",y="Vaikų skaičius")

print("Lankomumo analysis done")