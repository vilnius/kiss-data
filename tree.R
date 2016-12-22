#pridedam reiktingo stulpelį
laukiantys["reitingas"] <- sample(1:20, nrow(laukiantys),replace = T)

for_tree <- subset(laukiantys, select = c(Prioritetas..deklaruotas.mieste.,
                                              Prioritetas..šeimoje.3.ir.daugiau.vaikų.,
                                              Prioritetas..žemas.darbingumo.lygis.,
                                              Prioritetas..augina.tik.vienas.iš.tėvų.,
                                              reitingas, kiek.laukia, amzius))

ctreez <- ctree(reitingas ~ . , data = for_tree)
