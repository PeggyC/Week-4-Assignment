COOKBOOK: assignment for week4

Variables containing uploaded files:
train_data: "UCI HAR Dataset/train/X_train.txt"
test_data: "UCI HAR Dataset/test/X_test.txt"
features: "UCI HAR Dataset/features.txt"
activities: "UCI HAR Dataset/activity_labels.txt"
train_activities: "UCI HAR Dataset/train/y_train.txt"
test_activities: "UCI HAR Dataset/test/y_test.txt"
train_subjects: "UCI HAR Dataset/train/subject_train.txt"
test_subjects: "UCI HAR Dataset/test/subject_test.txt"

Variables:
ind: indices containing all variables of features with "mean" and "std"

Data frame:
merged_data: merged data from train_data and test_data
new_df: subset of merged_data based on variables with "mean" and "std"
merged_activities: merged data from train_activities and test_activities
tidy_df: final data frame containing the average of each variable for each activity and each subject.

