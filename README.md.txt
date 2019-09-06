# Coursera assignment for Getting and Cleaning Data

### jaredh9

This repository contains my submission for the Getting and Cleaning Data peer-graded project. The data used in this project are available at the following link: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A description of these data are available at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Files in repository:

* `Codebook.md` contains all table and variable names and describes the functions and steps used to clean the provided data.
* `run_analysis.R` executes the data import and cleaning in accordance with the goals of the present project, namely:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* `Tidy_aggregated.txt` contains the final output file described in step 5 above.
  
  
