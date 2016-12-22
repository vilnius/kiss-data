zz <- readLines("data/priorities.json")

zz1 <- gsub("[}]\"","}",gsub("\"[{]","{",gsub("\t","",zz)))

zz2 <- fromJSON(zz1)

zz3 <- zz2$rows

cp <- cbind(zz2$rows[,"ID"],zz2$rows$CHECKED_PRIORITY)
colnames(cp)[1] <- "ID"
zz4 <- zz3[,setdiff(colnames(zz3),"CHECKED_PRIORITY")]

zz5 <- zz4 %>% inner_join(cp)
zz6 <- zz5 %>% mutate(FP0 = 1000 * giveNumberBecousBothParentsAndChildLivesInCity + RS_PRIO_COUNT,
                      FINAL_PRIORITY = ifelse(is.na(FP0),100000, FP0))

zz6 %>% write.csv("output/priority_from_json.csv", row.names=FALSE)
