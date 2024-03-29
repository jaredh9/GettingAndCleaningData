## Code Book

### jaredh9

Use the file `run_analysis.R` to execute data cleaning and assembly into a tidy dataset. This assumes that the folder `UCI HAR Dataset` is present in the working directory.

The cleaning steps are as follows:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The tables and corresponding data (*.txt file) as imported are as follows:

Table   | txt file | Description
--- | --- | ---
`x_train` | 'X_train.txt' | features data for training group subjects
`x_test`  | 'X_test.txt'  | features data for test group subjects
`y_train` | 'y_train.txt' | activity code labels for training group
`y_test`  | 'y_test.txt'  | activity code lables for test group
`subject_train`   | 'subject_train.txt'   | identifies subjects (21) in training group
`subject_test`    | 'subject_test.txt'    | identifies subjects (9) in testing group
`features`        | 'features.txt'        | lists all features (accelerometer & gyroscope signals)
`activity_labels` | 'activity_labels.txt' | matches activity code labels to text identifiers

### 1. Merges the training and the test sets to create one data set.

Used `rbind()` to create merged tables for:

* features data (`x_train`, `x_test`) into new table `X` 
* activity code labels (`y_train`, `y_test`) into new table `Y`
* subject data (`subject_train`, `subject_test`) into new table `subject_all`

Used `cbind()` to merge these tables into the new table, `merge_train_test`
 
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

* Removed duplicate columns by using `lapply()` and `duplicated()` in the merged table.
* Created new tidy dataset `Tidy_mean_sd` with only mean and SD for each measurement by subsetting the merged table and selecting only `subject_id`, `activity`, and all features containing either "mean" or "std" text.

### 3. Use descriptive activity names to name the activities in the data set

* Replaced integer values of `activity` column with the factor variable (second column) in table `activity_labels` to rename with descriptive values.

### 4. Appropriately labels the data set with descriptive variable names.

* Used `gsub()` to rename each feature variable to replace abbreviations, e.g. "`Acc`" into "`Accelerometer`".

### 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

* The new, final tidy data set table `Tidy_aggregated` was created by using `group_by()` and `summarize_all()` functions. The `mean()` function is called in the latter to generate the mean value for each variable for each subject, grouped at the second level by their activity.
* `Tidy_aggregated` is exported as `Tidy_aggregated.txt`.