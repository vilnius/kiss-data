darzeliai1 <- lankantys_grupes$kg.name %>% unique
gimnazija <- darzeliai1 %>% grep("gimnazija", .)
mokykla <- darzeliai1 %>% grep("[Mm]okykla", .)
darzeliai2 <- darzeliai1[setdiff(seq_along(darzeliai1), c(mokykla, gimnazija))]
darzeliai4 <- darzeliai2[-c(1, 141)]
saveRDS(darzeliai4, file = "darzeliai.RDS")


