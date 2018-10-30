#Annina Haverinen
#30.10.2018
#Data wrangling, excersice 2: IODS-project

#First read the data from URL, separator = "\t", and data includes header

learning_2014 <-read.table ("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header = TRUE)

#learning_2014 is the name given to the dataset

str(learning_2014)
dim(learning_2014)

# dim() gives the dimensions of the dataframe. This dataframe consists of 183 observations of 60 different variables
# str(), gives the structure and the first 10 observations/variable, names of the variables and type (factoral(levels), intervall, numeral)

#create an analysis dataset: w gender, age, attitude, deep, stra, surf and points by combining questions

# combination of questions into vectors according to type of question

deep_questions <- c ("D03","D06","D07","D11","D14","D15","D19","D22","D23","D27","D30","D31")
stra_questions<- c("ST01","ST04","ST09","ST12","ST17","ST20","ST25","ST28")
surf_questions<- c("SU02","SU05","SU08","SU10","SU13","SU18","SU21","SU24","SU26","SU29","SU32")

# installing packages to have functions rowMeans(df),colMeans(df),colSums(df) and rowSums(df), select(), one_of() and filter () available
install.packages("dplyr") #installs the package ( needs to be done just once)
library(dplyr) # access to the package every time it is used

#Make s new column by averageing the questions. 
deep_columns <- select (learning_2014, one_of(deep_questions))
learning_2014$deep<-rowMeans(deep_columns)
stra_columns <- select (learning_2014, one_of(stra_questions))
learning_2014$stra <- rowMeans(stra_columns)
surf_columns <- select(learning_2014, one_of(surf_questions))
learning_2014$surf <- rowMeans(surf_columns)

#exclude points < 0, using filter() to override the learning_2014 data
learning_2014 <- filter(learning_2014, Points>0)

#new dataset, columns to keep, use of select(), one_of(), first create vector of the columns to keep

keep_columns <-  c ("surf","stra","deep","Age","Attitude","gender","Points")
learning2014 <- select(learning_2014, one_of(keep_columns))

#looking at the new data set for analysis, named learning2014
str(learning2014)
dim(learning2014)
head(learning2014)

#Remember R is case sensitive
#Task compleated, new analysis dataset learning2014 with 7 variables and 166 observations

#saving the dataset on my computer, in github/iods/data

write.table(learning2014,file="learning2014.txt")

#show current working directory
getwd()
# current directory: "/Users/Annina/Documents/GitHub/IODS-project/Data"

# funny order so

learn2014<-learning2014[,c(6,4,7,5,2,3,1)]
str(learn2014)
learn2014<-learn2014[,c(1,5,2,3,4,6,7)]
str(learn2014)

write.table(learning2014, file="learn2014.txt")
