---
title: "Codebook"
author: "Student Coursera"
date: "September 11, 2016"
output: html_document
---

## About the Project R script

"run_analysis_.R" perform 5 following steps as required by project.

For the project to run, ensure all files are in your current working directory.

1. Merging the training and the test sets to create one data set.
1.1 Reading files
   1.1.1 Reading trainings tables
   1.1.2 Reading testing tables
  1.1.3 Reading feature vector
  1.1.4 Reading activity labels
  1.2 Assigning column names
  1.3 Merging all data in one set
2. Extracting only the measurements on the mean and standard deviation for each measurement
  2.1 Reading column names
  2.2 Create vector for defining ID, mean and standard deviation
  2.3 Making nessesary subset from setAllInOne
3. Using descriptive activity names to name the activities in the data set
4. Appropriately labeling the data set with descriptive variable names
5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject
  5.1 Making second tidy data set
  5.2 Writing second tidy data set in txt file

## ABout the Variables

No changes made to downloaded datasets, thus:
1. x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files
2. x_data, y_data and subject_data merge the previous datasets for further analysis
3. features contains the correct names for the x_data dataset, which are applied to the column names are stored in

