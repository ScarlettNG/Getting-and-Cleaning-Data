# Getting and Cleaning Data Project Coursera
# Author: Scarlett Ng

# This script will follow these criteria as follow:

# 1.Merges the training and the test sets to create one data set.

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

# 3.Uses descriptive activity names to name the activities in the data set

# 4.Appropriately labels the data set with descriptive variable names. 

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Let's start with reading the data files

library(tidyr)
library(dplyr)

features <- read.table('UCI HAR Dataset/features.txt', col.names = c('name', 'func'))
label <- read.table('UCI HAR Dataset/activity_labels.txt', col.names = c('n', 'activity'))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "sub")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$func)
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "n")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "sub")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$func)
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "n")

# Merge the training and testing data into one dataset.
X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)

subject <- rbind(subject_train, subject_test)
mergedDT <- cbind(subject, Y, X)

# head(mergedDT)
# names(mergedDT)

# we will only take the mean and standard deviation for each measurement (please check
# the features.txt or features_info.txt file to see how they have chosen the variable name)

extract_data <- mergedDT %>% select(sub, n , matches('(mean|std)'))

# We will use the 'n' column to name the activities in the dataset

extract_data$n <- label[extract_data$n, 2]

# Appropriately labels the data set with a correct variables.
library(stringr)
names(extract_data)[2] <- 'activity'
names(extract_data) <- str_replace_all(names(extract_data), c("Acc" = "Accelerometer", 
                                                              "Gyro" = "Gyroscope", 
                                                              "BodyBody" = "Body", 
                                                              "Mag" = "Magnitude", 
                                                              "^t" = "Time", 
                                                              "^f" = "Frequency", 
                                                              "tBody" = "TimeBody", 
                                                              "-mean\\(\\)" = "Mean", ## '\\(\\)' is used to escape parentheses
                                                              "-std\\(\\)" = "STD", 
                                                              "-freq\\(\\)" = "Frequency"))

# Let's create another independent data set with the average of each variable for each
# activity and subject
tidy_data <- extract_data %>% 
        group_by(sub, activity) %>%
        summarise_all(mean)

head(tidy_data, 2)

write.table(tidy_data, "tidydata.txt", row.name=FALSE)
