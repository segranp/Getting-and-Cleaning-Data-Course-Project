packages <- c("data.table", "reshape2")
library(data.table)
sapply(packages, require, character.only = TRUE, quietly = TRUE)

path <- "C:/USERS/segran.pillay/MY DOCUMENTS/Cleaning Data/Project"

#Download Data
library(data.table)
if(!file.exists("./project")){dir.create("./project")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile = "./project/dataset.zip")
dataFile <- "./project/dataset.zip"
unzip(zipfile = dataFile,exdir = "./project")


# 1. Merging the training and the test sets to create one data set:
  # 1.1 Reading files
    # 1.1.1 Reading trainings tables:
trainXFile <- read.table("./project/UCI HAR Dataset/train/X_train.txt")
trainLabels <- read.table("./project/UCI HAR Dataset/train/y_train.txt")
trainSubjectFile <- read.table("./project/UCI HAR Dataset/train/subject_train.txt")

   # 1.1.2 Reading testing tables:
testXFile <- read.table("./project/UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("./project/UCI HAR Dataset/test/y_test.txt")
testSubjectFile <- read.table("./project/UCI HAR Dataset/test/subject_test.txt")

   # 1.1.3 Reading feature vector:
features <- read.table('./project/UCI HAR Dataset/features.txt')
features[,2] <- as.character(features[,2])

   # 1.1.3 Reading activities labels:
activityLabels <- read.table("./project/UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])


#2. Extract only the data on mean and standard deviation

featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

#3. Load the datasets
train <- read.table("./project/UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("./project/UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("./project/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("./project/UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("./project/UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("./project/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

#4. Merge train and test data sets and add thier labels
combinedData <- rbind(train, test)
colnames(combinedData) <- c("subject", "activity", featuresWanted.names)

combinedData$activity <- factor(combinedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
combinedData$subject <- as.factor(combinedData$subject)

library(reshape2)
combinedData.melted <- melt(combinedData, id = c("subject", "activity"))
combinedData.mean <- dcast(combinedData.melted, subject + activity ~ variable, mean)

write.table(combinedData.mean, "tidy.txt", row.names=FALSE, quote=FALSE, sep="\t")

dtTidy=read.csv("Tidy.txt",sep="\t",header=TRUE )
str(dtTidy)
head(dtTidy,2)
