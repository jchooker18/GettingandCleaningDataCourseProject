library(dplyr)

## Read in the features.txt and activity_labels.txt files
features <- read.table("./UCI HAR Dataset/features.txt", 
                       col.names = c("featureID", "featureName"), stringsAsFactors = FALSE)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                              col.names = c("activityID", "activity"))

## Read in the files from the "test" folder with descriptive variable names
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                     col.names = features$featureName)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                     col.names = "activityID")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subject")

## Combine all "test" files into one data frame
test <- cbind(subject_test, y_test, x_test)

## Read in the files from the "train" folder with descriptive variable names
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$featureName)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                      col.names = "activityID")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subject")

## Combine all "train" files into one data frame
train <- cbind(subject_train, y_train, x_train)

## Combine the test and train data frames
alldata <- rbind(test, train)

## Extract only the measurements including mean and std (excluding meanFreq) for each
## observation
alldata_meanstd <- select(alldata, subject:activityID, contains("mean"), contains("std"),
                  -contains("Freq"))

## Create first tidy data set: add descriptive names to the activities variable 
## and drop the activityID column
dataset1 <- merge(activity_labels, alldata_meanstd)
dataset1 <- dataset1[-1]

## Clean up variable names to make them more descriptive
names(dataset1) <- sub("\\.\\.\\.", "\\.", names(dataset1))
names(dataset1) <- sub("\\.\\.", "", names(dataset1))

## Create second tidy data set: group by subject and activity and summarize each variable
## with the mean function
dataset2 <- dataset1 %>% group_by(subject, activity) %>% summarize_all(mean)

## Write the second tidy data set to a text file, output
write.table(dataset2, "tidy_data.txt", row.names = FALSE)
