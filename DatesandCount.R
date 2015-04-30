setwd("/N/home/r/s/rshiggin/Karst")
library(dplyr)


#Attach csv file
aucatalogVars <- read.csv(file="aucatalogVars.csv", head=TRUE, sep=",")
data.frame(aucatalogVars)

#Create data/month columns
datetxt <- as.Date(aucatalogVars$AudDate)
df <- data.frame(date = datetxt,
                 year = as.numeric(format(datetxt, format = "%Y")),
                 month = as.numeric(format(datetxt, format = "%m")))
auditMerged <- cbind(df,aucatalogVars)

#Count cumulative sums
cumuldata <- sapply(1:length(auditMerged$AudKey),function(i) 
                   sum(auditMerged$AudKey[i]==auditMerged$AudKey[1:i]))
cumulfile <- cbind(auditMerged, cumuldata)

#Write to file
write.csv(catalog03, file = "catalogPrep.csv")
                 