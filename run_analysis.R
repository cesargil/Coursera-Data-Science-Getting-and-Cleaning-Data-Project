# Coursera Data Science - Module 3 (Getting and Cleaning Data) - Course Project
#
# Assumptions for this script to run correctly:
# - The folder containing the data is under current directory and is called 'UCI HAR Dataset'

library(plyr)

# ------------------------------------
# Part 1 - Merges the training and the test sets to create one data set.
# ------------------------------------
# Reads training data, corresponding subject number and activity number, binds columns
train_data    <- read.table("c:/temp/UCI HAR Dataset/train/X_train.txt")
train_subject  <- read.table("c:/temp/UCI HAR Dataset/train/subject_train.txt")
train_activity <- read.table("c:/temp/UCI HAR Dataset/train/y_train.txt")

# Reads test data, corresponding subject number and activity number, binds columns
test_data     <- read.table("c:/temp/UCI HAR Dataset/test/X_test.txt")
test_subject  <- read.table("c:/temp/UCI HAR Dataset/test/subject_test.txt")
test_activity <- read.table("c:/temp/UCI HAR Dataset/test/y_test.txt")

# Merges train and test datasets
measurements <- rbind(train_data, test_data)
subjects     <- rbind(train_subject, test_subject)
activities   <- rbind(train_activity, test_activity)

# Removes no more needed variables
rm(train_data, test_data, train_subject, test_subject, train_activity, test_activity)

# ------------------------------------
# Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
# ------------------------------------

# Reads feature labels
feature <- read.table("c:/temp/UCI HAR Dataset/features.txt", header=F, sep="", col.names=c("FeatureID", "FeatureName"))

# Identifies the features that pertain to mean or standard deviation
desired_features <- grep("(mean|std)\\(\\)", feature$FeatureName)

# Extracts only those from data
measurements <- measurements[, desired_features]

# ------------------------------------
# Part 3 - Uses descriptive activity names to name the activities in the data set
# ------------------------------------

# Reads activity labels
activity_labels <- read.table("c:/temp/UCI HAR Dataset/activity_labels.txt", header=F, sep=" ", col.names=c("ActivityID", "ActivityName"))

# Replaces activity numbers with their corresponding description
activities <- activity_labels$ActivityName[ activities[,1] ]

# ------------------------------------
# Part 4 - Appropriately labels the data set with descriptive variable names. 
# ------------------------------------

# Binds subject, activity and measurements
tidy <- cbind(subjects, activities, measurements)

# Improves names of columns of measurements
desiredFeatureNames <- feature$FeatureName[desired_features]
desiredFeatureNames <- gsub("-mean\\(\\)", "Mean", desiredFeatureNames)
desiredFeatureNames <- gsub("-std\\(\\)", "StDev", desiredFeatureNames)
desiredFeatureNames <- gsub("-", "", desiredFeatureNames)

colnames(tidy) <- c("Subject", "Activity", desiredFeatureNames)

# ------------------------------------
# Part 5 - From the data set in step 4, creates a second, independent tidy data set
#          with the average of each variable for each activity and each subject.
# ------------------------------------
# Calculates average for all measurements, grouping by subject and activity
tidyAverages <- ddply(tidy, .(Subject, Activity), function(x) colMeans(x[, -c(1,2)]))

# Writes result to file
write.table(tidyAverages, "tidy_averages.txt", row.name=FALSE)

# end of script