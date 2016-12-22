print("Paieška kyšius imančių darželių")

#Išskiriam valstybinius darželius
lankomumas.valst <- lankomumas[which(lankomumas$SCHOOL_TYPE == "Valstybinis darželis"),]

#išimu išskirtis
lankomumas.valst <- lankomumas.valst[lankomumas.valst[,"laukta.eileje"] >= -3,]
lankomumas.valst <- lankomumas.valst[lankomumas.valst[,"laukta.eileje"] < 4,]

#pasižiūrim grafiškai kiek buvo laukta
ggplot(lankomumas.valst, aes(x = laukta.eileje))  +
  geom_histogram(binwidth = 1) +
  labs(x="Kiek metų laukė savo eilės",y="Vaikų skaičius") +
  facet_wrap(~Vaiko.seniunija)

#Sukuriu duomenų paketą modeliui
reikalingi.kint <- c("laukta.eileje","Prioritetas..deklaruotas.mieste.","X1.pasirinktas.darželis",
                     "amzius.pareiskiant","Vaiko.seniunija","Prioritetas..šeimoje.3.ir.daugiau.vaikų.",
                     "Prioritetas..žemas.darbingumo.lygis.","Prioritetas..augina.tik.vienas.iš.tėvų.",
                     "Atitinka.1.darželiui.priskirta.teritorija","Darželio.pavadinimas")

lankomumas.reg <- lankomumas.valst[reikalingi.kint]

#Žiūriu ar koreliuoja skaitiniai rodikliai su laukimo eilėje trukme

reikalingi.numeric <- c("laukta.eileje","amzius.pareiskiant")
lankomumas.reg.num <- lankomumas.valst[reikalingi.numeric]

cor(lankomumas.reg.num, use = "pairwise.complete.obs", method = "pearson")
p <- ggplot(lankomumas.reg.num, aes(laukta.eileje, amzius.pareiskiant))
p + geom_point()

#Keičiame iš NA į Darželis nepasirinktas
lankomumas.reg$X1.pasirinktas.darželis <- as.character(lankomumas.reg$X1.pasirinktas.darželis)
lankomumas.reg$X1.pasirinktas.darželis[which(is.na(lankomumas.reg$X1.pasirinktas.darželis))] <- "Darželis nepasirinktas"

lankomumas.reg$Atitinka.1.darželiui.priskirta.teritorija <- as.character(lankomumas.reg$Atitinka.1.darželiui.priskirta.teritorija)
lankomumas.reg$Atitinka.1.darželiui.priskirta.teritorija[which(is.na(lankomumas.reg$Atitinka.1.darželiui.priskirta.teritorija))] <- "Darželis nepasirinktas"

#Šaunam daugiamatę regresiją
#Įjungiu automatinį kintamųjų parinkimą
# regsubsets(laukta.eileje ~ X1.pasirinktas.darželis + Vaiko.seniunija + 
#              Prioritetas..žemas.darbingumo.lygis. + Atitinka.1.darželiui.priskirta.teritorija + 
#              Prioritetas..deklaruotas.mieste. + amzius.pareiskiant + 
#              Prioritetas..šeimoje.3.ir.daugiau.vaikų. + Prioritetas..augina.tik.vienas.iš.tėvų. ,
#            data = lankomumas.reg, nvmax = 5, really.big=T)
lankomumas.reg$Prioritetas..augina.tik.vienas.iš.tėvų. <- as.character(lankomumas.reg$Prioritetas..augina.tik.vienas.iš.tėvų.)
lankomumas.reg <- lankomumas.reg[complete.cases(lankomumas.reg),]

reg1 <- regsubsets(laukta.eileje ~ Prioritetas..deklaruotas.mieste. + amzius.pareiskiant +
                     Prioritetas..šeimoje.3.ir.daugiau.vaikų. + Prioritetas..augina.tik.vienas.iš.tėvų. +
                     Atitinka.1.darželiui.priskirta.teritorija,
                     data = lankomumas.reg, nvmax = 4, really.big=T)
summary(reg1)

z <- which.max(summary(reg1)$adjr2)
summary(reg1)$which[z,]

fit <- lm(laukta.eileje ~ amzius.pareiskiant + Prioritetas..deklaruotas.mieste. + 
            Prioritetas..šeimoje.3.ir.daugiau.vaikų. +
            Atitinka.1.darželiui.priskirta.teritorija, data=lankomumas.reg)

summary(fit)

res <- stack(data.frame(Observed = lankomumas.reg$laukta.eileje, Predicted = fitted(fit)))
res <- cbind(res, amzius.pareiskiant = rep(lankomumas.reg$amzius.pareiskiant, 2))
head(res)

p <- ggplot(res, aes(values, amzius.pareiskiant, fill = ind, colou=ind))
p + geom_point()

print("Paieška kyšius imančių darželių neužbaigta, bet nieko baisaus")
