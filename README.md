This README file describes how run_analysis.R works.

First, all previous variables are discarded (line 2).

Second, the data related to the assignment are loaded (lines 5 and 6) in two different variables (train_data and test_data).

Question 1:
Line 9: the data are merged with rbind (merged_data: 10299x561).

Question 2:
The mean and std are extracted using grep (line 13) and put into a new data frame new_df (line 14). The dimentions are 10299x66.

Question 3: 
The names for each variable of new_df are described (line 17).

Question 4:
The activities label from the file "activity_labels.txt" (line 20) is used to label the new data frame new_df, 10299x67 (line 26).

Question 5:
The subjects label is used to label the new data frame new_df, 10299x68 (line 34).
Then, we declare the new tidy data frame tidy_df and its variables (lines 37-39).
The for loop contains the calculation of the mean and the different groups (activity and subject) (lines 40-49).

Line 51 writes the data frame tidy_df into a text file "tidy_data.txt".

