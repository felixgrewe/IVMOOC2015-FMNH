setwd("/Users/Richard/Documents/TextAnalysisWithR")
library(dplyr)

#Attach csv file
aucatalogFile <- read.csv(file="aucatalogFile.csv", head=TRUE, sep=",")
data.frame(aucatalogFile)

#Create data/month columns
datetxt <- as.Date(aucatalogFile$AudDate)
df <- data.frame(date = datetxt,
                 year = as.numeric(format(datetxt, format = "%Y")),
                 month = as.numeric(format(datetxt, format = "%m")))
auditMerged <- cbind(df,aucatalogFile)
tbl_df(auditMerged)
write.csv(auditMerged, file = "auditMerged.csv")

#Count cumulative sums with SQL query
df <- read.csv(file="auditMerged.csv", head=TRUE, sep=",")
cumulData <- df %>% 
  group_by(year, month, AudKey, CAT_SecDepartment_tab) %>% 
  summarise(freqall = n())

#Write to file
write.csv(cumulData, file = "cumulData.csv")


#Relative frequency
library(dplyr)
library(tidyr)
cumulData <- read.csv(file="cumulData.csv", head=TRUE, sep=",")
freq <- cumulData %>%
  group_by(AudKey, year, month) %>%
  summarise (n = n()) %>%
  mutate(freq = n / sum(n) * 100)

write.csv(freq, file = "freq.csv")

#Sort by highest cumulative
sortTop <- arrange(cumulData, desc(freqall))
sortTop$X <- NULL


sort2 <- data.frame(cumulData) %>%
  group_by(AudKey, freqall, year, month, CAT_SecDepartment_tab) %>%
  arrange(freqall, desc=TRUE) 

write.csv(topN, file = "topN.csv")


