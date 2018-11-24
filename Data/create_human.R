#create_human

#Reading data

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
# http://hdr.undp.org/en/content/human-development-index-hdi
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
# http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

library(tidyr)
library(dplyr)

dim(hd)
str(hd)
summary(hd)
colnames(hd)
colnames(hd)[1] <- "HDI_rank"
colnames(hd)[2]<- "country"
colnames(hd)[3]<- "HDI"
colnames(hd)[4]<- "expect"
colnames(hd)[5] <- "edu"
colnames(hd)[6] <- "medu"
colnames(hd)[7] <- "GNIpc"
colnames(hd)[8] <- "GNIHDIrank"
colnames(hd)

dim(gii)
str(gii)
summary(gii)
colnames(gii)

colnames(gii)[1]<- "GII_rank"
colnames(gii)[2]<- "country"
colnames(gii)[3]<- "GII"
colnames(gii)[4]<- "mort_rate"
colnames(gii)[5]<-"ado_birth"         
colnames(gii)[6]<- "rep_par"
colnames(gii)[7]<-"edu_F"
colnames(gii)[8]<- "edu_M"
colnames(gii)[9]<- "lab_F"
colnames(gii)[10]<-"lab_M"

colnames(gii)

edu_ratio <- gii$edu_F/gii$edu_M
lab_ratio <- gii$lab_F/gii$lab_M

gii_new <- mutate(gii, edu_ratio)
gii_new <- mutate(gii_new, lab_ratio)
colnames(gii_new)[2]<-"country"

library(dplyr)
join_by <- c("country")
HDI_GII <- inner_join(hd, gii_new, by = join_by)

colnames(HDI_GII)
dim(HDI_GII)
str(HDI_GII)
human <- HDI_GII
class(human)
dim(human)
