# Clean previous variables if needed:
rm(list=ls())

# 1. Merges the training and the test sets to create one data set.

# Load and merge the data:
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
test_data  <- read.table("UCI HAR Dataset/test/X_test.txt")
merged_data <- rbind(train_data,test_data)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")
ind <- grep('(mean\\(\\)|std\\(\\))', features[,2], value = FALSE)
new_df <- merged_data[,ind]


# 3. Uses descriptive activity names to name the activities in the data set.
names(new_df) <- features[ind,2]


# 4. Appropriately labels the data set with descriptive variable names.
names(new_df) <- gsub("\\(\\)","",names(new_df))
names(new_df) <- gsub("^t","time",names(new_df))
names(new_df) <- gsub("^f","fourier",names(new_df))
names(new_df) <- gsub("-",".",names(new_df))


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Activities:
activities        <- read.table("UCI HAR Dataset/activity_labels.txt")
train_activities  <- read.table("UCI HAR Dataset/train/y_train.txt")
test_activities   <- read.table("UCI HAR Dataset/test/y_test.txt")
merged_activities <- rbind(train_activities,test_activities)
new_df$activity <- factor(merged_activities$V1, labels = activities$V2)

# Subjects:
train_subjects  <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_subjects   <- read.table("UCI HAR Dataset/test/subject_test.txt")
merged_subjects <- rbind(train_subjects,test_subjects)
new_df$subject <- factor(merged_subjects$V1, labels = c(1:30))

ijk <- 0
tidy_df <- data.frame(row.names = c(1:180)) #(names(new_df))#=0*vector(length = 180))
temp_activity <- character(length = 180)
temp_subject  <- character(length = 180)
for(act in activities$V2){
  for(sub in c(1:30)){
    ijk <- ijk+1
    for(var in c(1:66)){
      var_name <- names(new_df)[var]
      temp <- subset(new_df[var_name], new_df$activity == act & new_df$subject == as.character(sub))
      tidy_df[ijk,var] <- mean(temp[[var_name]])
      temp_activity[ijk]  <- act
      temp_subject[ijk]  <- sub
    }
  }
}
tidy_df$activity <- factor(temp_activity)
tidy_df$subject  <- factor(temp_subject)
names(tidy_df)   <- names(new_df)
write.table(tidy_df,file = "tidy_data.txt", row.name=FALSE)


