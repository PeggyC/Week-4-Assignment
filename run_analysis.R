# Clean previous variables if needed:
rm(list=ls())

# Load the data:
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
test_data  <- read.table("UCI HAR Dataset/test/X_test.txt")

# 1. Merges the training and the test sets to create one data set.
merged_data <- rbind(train_data,test_data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")
ind <- grep('(mean\\(\\)|std\\(\\))', features[,2], value = FALSE)
new_df <- merged_data[,ind]

# 3. Uses descriptive activity names to name the activities in the data set.
names(new_df) <- features[ind,2]

# 4. Appropriately labels the data set with descriptive variable names.
activities        <- read.table("UCI HAR Dataset/activity_labels.txt")
train_activities  <- read.table("UCI HAR Dataset/train/y_train.txt")
test_activities   <- read.table("UCI HAR Dataset/test/y_test.txt")
merged_activities <- rbind(train_activities,test_activities)

new_df$activity <- factor(merged_activities$V1, labels = activities$V2)


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
train_subjects  <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_subjects   <- read.table("UCI HAR Dataset/test/subject_test.txt")
merged_subjects <- rbind(train_subjects,test_subjects)

new_df$subject <- factor(merged_subjects$V1, labels = c(1:30))


ijk <- 0
tidy_df <- data.frame(mean=0*vector(length = 180))# activity = character(length = 180), subject = character(length = 180))#,stringsAsFactors = TRUE)
temp_activity <- character(length = 180)
temp_subject  <- character(length = 180)
for(act in activities$V2){
  for(sub in c(1:30)){
    ijk <- ijk+1
    tidy_df$mean[ijk] <- mean(new_df$`tBodyAcc-mean()-X`[new_df$activity == act | new_df$subject == as.character(sub)])
    temp_activity[ijk] <- act
    temp_subject[ijk]  <- sub
  }
}
tidy_df$activity <- factor(temp_activity)
tidy_df$subject  <- factor(temp_subject)

write.table(tidy_df,file = "tidy_data.txt", row.name=FALSE)

# FINAL DATASET: tidy_df
#str(tidy_df)
#'data.frame':	180 obs. of  3 variables:
#  $ mean    : num  0.274 0.276 0.276 0.276 0.277 ...
#  $ activity: Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...
#  $ subject : Factor w/ 30 levels "1","10","11",..: 1 12 23 25 26 27 28 29 30 2 ...


