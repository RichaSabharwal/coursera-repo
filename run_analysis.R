library(data.table)
library(dplyr)

##load training data
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

##load test data
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

##load names of the columns
features <- read.table("./features.txt")


## Activity names from activity_labels.txt
activity_labels <- read.table("./activity_labels.txt")

## Assign column names to the 2 X data tables
names(x_test) <- features$V2
names(x_train) <- features$V2
names(subject_test) <- c("subject_ID")
names(subject_train) <- c("subject_ID")
names(y_test) <- c("Activity")
names(y_train) <- c("Activity")

## Assign Activity description to numbers indicating activity
Activity_test_vect <- activity_labels$V2[y_test[,1]]
Activity_train_vect <- activity_labels$V2[y_train[,1]]

## Add the subject ID and Activity columns to other columns of test and train data tables 
x_test_temp <- cbind(subject_test, Activity_test_vect, x_test)
x_train_temp <- cbind(subject_train, Activity_train_vect, x_train)

##Change the names of the 2nd column in both the test and the train data tables to make them same before rbind()
names(x_test_temp)[2] <- "Activity"
names(x_train_temp)[2] <- "Activity"

## rbind all the rows of both the data sets to get data of all the subjects in one data table.
all_subjects <- rbind(x_test_temp,x_train_temp)

## create a vector with column indices of the columns needed. 
## These will be 68 columns, i.e., 1st column: subject_id, 2nd columns: Activity and all the columns with means and standard deviations.
columns_reqd <- c(1:2,grep("mean\\(\\)",names(all_subjects)),grep("std\\(\\)",names(all_subjects)))

## Extract only the columns required
data_reqd <- all_subjects[columns_reqd]

##summarise the data using group_by for each subject and Activity

tidyData <- data_reqd %>% group_by(subject_ID,Activity) %>% summarise_each(funs(mean))

##Write the tidy data table to a file
write.table(x = tidyData,file = ".\\tidyData.txt",sep = ",", row.names = FALSE)
