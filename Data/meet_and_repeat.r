library(dplyr)
library(tidyr)
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "\t", header = T)                   

#BPRS wide data form
dim(BPRS)
str(BPRS)
colnames(BPRS)
summary(BPRS)

#RATS wide data form
dim(RATS)
str(RATS)
colnames(RATS)
summary(RATS)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject) # categorial variable, as factor
RATS$Group <- factor(RATS$Group) 
RATS$ID <- factor(RATS$ID) # categorial variable, as factor

#BPRS to long form <- week 0-8
BPRSL<- BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
glimpse(BPRSL)

#RATS to long form <- WD1-64
RATSL <- RATS%>% gather(key = WD, value = Weight, -ID, -Group)%>%
  mutate(Time = as.integer(substr(WD,3,4))) 
glimpse(RATSL)


