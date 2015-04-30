setwd("/N/home/r/s/rshiggin/Karst")
library(dplyr)

#Attach csv files
eaudit01 <- read.csv(file="MOOCeaudit03.csv", head=TRUE, sep=",")
catalog <- read.csv(file="ChinaHall_masterRev.csv", head=TRUE, sep=",")

#Select table variables
eaudit02 <- eaudit01[,c(3, 4, 6, 7, 8)]
aucatalog <- catalog[,c(3, 5)]

#Join tables
merged <- merge(eaudit02, aucatalog)

#Filter admininstrative user
aucatalogVars <- merged[merged$AudUser != "emu", ]
summary(aucatalogVars)

#Write to file
write.csv(aucatalogVars, file = "aucatalogVars.csv")



