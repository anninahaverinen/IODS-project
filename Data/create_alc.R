#Annina Haverinen
#IODS-Project
#1.11.2018
#Excercise 3: Logistic regression, data wrangling
#Data source:https://archive.ics.uci.edu/ml/datasets/Student+Performance
getwd() #get directory
#read dataframe, include separator sep = ; and data includes headers. 
student_mat<-read.csv("/Users/Annina/Documents/GitHub/IODS-project/Data/student-mat.csv",sep=";",header=TRUE)
student_por <-read.csv("/Users/Annina/Documents/GitHub/IODS-project/Data/student-por.csv", sep=";",header=TRUE)

dim(student_mat)
str(student_mat)
head(student_mat)

dim(student_por)
str(student_por)
head(student_por)
colnames(student_mat)
colnames(student_por)
library(dplyr)

join_by<- c("school", "sex", "age", "address", "famsize", "Pstatus","Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
join_by # vector "join_by" with the variables that we want to keep. 

mat_por<- inner_join(student_mat,student_por, by=join_by,suffix=c(".mat", ".por"))

colnames(mat_por)
dim(mat_por)
str(mat_por)
head(mat_por)
glimpse(mat_por)

alc<-select(mat_por, one_of(join_by)) # datafram with the joined columns
str(alc) 
colnames(alc)
not_joined <- colnames(student_mat)[!colnames(student_mat) %in% join_by]
not_joined

# for every column name not used for joining...
for(column_name in not_joined) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}
dim(alc)
glimpse(alc)

alc$Dalc # 1-5 
alc$Walc # 1-5 

alc <- mutate(alc, alc_use = (Dalc+Walc)/2) 
alc <- mutate(alc, high_use = alc_use >2)

dim(alc)
str(alc)

getwd()
write.table (alc, "alc.txt", sep = ";")
