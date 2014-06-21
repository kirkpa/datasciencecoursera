### Introduction
===================

This file provides information about the analysis that was done in run_analysis.R script to produce tidy data as per requirements.

###run_analysis.R
This script must be run from the directory that contains "UCI HAR Dataset" folder under which all the data files must exist.
The script first reads test data files "CI HAR Dataset/test/X_test.txt", "UCI HAR Dataset/test/y_test.txt" and "UCI HAR Dataset/test/subject_test.txt".
After all the test files are read the data is combined in one data frame testDataSet.

The script then reads train data files "UCI HAR Dataset/train/X_train.txt", "UCI HAR Dataset/train/y_train.txt" and 
"UCI HAR Dataset/train/subject_train.txt".
After all the train files are read the data is combined in one data frame trainDataSet.

The testDataSet and trainDataSet is them combined into one data frame combinedDS.
Features names are extracted from "UCI HAR Dataset/features.txt" file. Subject and Activity columns are added as 1st and 2nd elements to the features vector.
These feature names will become column names of combinedDS. 

The activity numbers are replaced by descriptive activity name.
Only columns that have mean() and std() in the name are extracted from the column names of combinedDS using grep.
The subset columns are extracted from the combined data frame.
split functions is used to split the subset data frame by Subject and Activity.
sapply function is used to calculate mean using the split data.
The output of sapply is the tidy data which is written to a comma separated file UCI HAR Dataset/tidyData.csv.