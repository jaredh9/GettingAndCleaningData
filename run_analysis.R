#The assignment as provided has five criteria for the code:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Part (1) is to merge the training and test sets. 
     #x_train and x_test contain the movement data of interest for the training and testing participants.
     #y_train and y_test label the activity for each observation. 
     #subject_train and subject_test identify the subject for each observation.
     #features will list the "variables" comprising the observations.
     #activity_labels will link the activities in y_train and y_test to descriptive labels ("WALKING" etc.)

#Prior to running, working directory is set to the "/UCI HAR Dataset" folder.

library(dplyr)

x_train         <- read.table("train/X_train.txt",header = F)
x_test          <- read.table("test/X_test.txt",header = F)
y_train         <- read.table("train/y_train.txt",header = F,col.names = "activity")
y_test          <- read.table("test/y_test.txt",header = F,col.names = "activity")
subject_train   <- read.table("train/subject_train.txt",header = F,col.names = "subject_id")
subject_test    <- read.table("test/subject_test.txt",header = F, col.names = "subject_id")
features        <- read.table("features.txt",header = F, col.names = c("x","movement_feat"))
activity_labels <- read.table("activity_labels.txt", header = F, col.names = c("x","activity_label"))

#Use the movement variables to identify columns for participant data
names(x_train) = features$movement_feat 
names(x_test)  = features$movement_feat

#Merge the training and testing datasets (same order for each binding):
x_all       <- rbind(x_train,x_test)
y_all       <- rbind(y_train,y_test)
subject_all <- rbind(subject_train,subject_test)
merge_train_test <- cbind(subject_all,y_all,x_all) #Leftmost column = subject id, then activity info

#Part (2) is to extract data on mean and SD for each measurement.

merge_train_test <- merge_train_test[!duplicated(lapply(merge_train_test, summary))] #removes duplicated columns

Tidy_mean_sd <- merge_train_test %>% select(subject_id,activity,contains("mean"),contains("std"))

#Part (3) is to use the "descriptive" activity labels, found in "activity_labels"
#m_sd$activity currently returns an integer:

Tidy_mean_sd$activity <- activity_labels[Tidy_mean_sd$activity,2] 

#Part (4) is to make the variable names readable. The file "features_info" contains a data dictionary for this purpose. 
#The gsub() function is useful here.

names(Tidy_mean_sd) <- names(Tidy_mean_sd) %>% 
        gsub(pattern = "tBody", replacement = "Time.body_") %>%
        gsub(pattern = "tGravity", replacement = "Time.gravity_") %>%
        gsub(pattern = "fBody", replacement = "Frequency.body_") %>%
        gsub(pattern = "Mag", replacement = "_Magnitude") %>%
        gsub(pattern = "Acc", replacement = "Accelerometer") %>%
        gsub(pattern = "Gyro", replacement = "Gyroscope") %>%
        gsub(pattern = "-mean", replacement = "_Mean") %>%
        gsub(pattern = "-", replacement = "_") %>%
        gsub(pattern = "Jerk", replacement = "_Jerk") %>%
        gsub(pattern = "std", replacement = "STDev") 

# Part (5): From the data set in step 4, create a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

#This call to "summarise_all" will provide mean values for each subject by activity, i.e. the group_by() levels.
#The format "~mean(.)" overrides variable renaming for all variables.

Tidy_aggregated <- Tidy_mean_sd %>% group_by(subject_id,activity) %>% summarise_all(list(~mean(.)))

#Submission generated with: write.table(Tidy_aggregated,"Tidy_aggregated.txt",row.names = F)




